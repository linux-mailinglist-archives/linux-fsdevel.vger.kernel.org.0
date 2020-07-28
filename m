Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5D231679
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 01:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgG1XzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 19:55:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36164 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgG1XzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:55:06 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id E32EF20B4908;
        Tue, 28 Jul 2020 16:55:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E32EF20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595980505;
        bh=AGZy2KfQ1YALTZXiqjCNdqcL15U8KOhpnfQZjMgxtis=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=cik4rnPwoJUGzO/fE1jBNTbrMqe8eOzeSbw9UVuj1EjxT17Pbnm0tgjcMSsn28BcV
         Me5/fEI/FcxWDNtLLOT35g97lt8COAiIHjTaHwIgxXUtaZFXy/uh4R59INRHHQkImO
         +PBuaI//CfiP0i9PnTsZXSJGFCFq47QMKJ/VkNnI=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [RFC PATCH v5 06/11] dm-verity: move signature check after tree
 validation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200728213614.586312-7-deven.desai@linux.microsoft.com>
 <20200728215041.GF4053562@gmail.com>
Message-ID: <a5534f1c-8979-0cfd-3989-2567f4a29dbc@linux.microsoft.com>
Date:   Tue, 28 Jul 2020 16:55:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728215041.GF4053562@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/28/2020 2:50 PM, Eric Biggers wrote:
> On Tue, Jul 28, 2020 at 02:36:06PM -0700, Deven Bowers wrote:
>> The CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG introduced by Jaskaran was
>> intended to be used to allow an LSM to enforce verifications for all
>> dm-verity volumes.
>>
>> However, with it's current implementation, this signature verification
>> occurs after the merkel-tree is validated, as a result the signature can
>> pass initial verification by passing a matching root-hash and signature.
>> This results in an unreadable block_device, but that has passed signature
>> validation (and subsequently, would be marked as verified).
>>
>> This change moves the signature verification to after the merkel-tree has
>> finished validation.
>>
>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
>> ---
>>   drivers/md/dm-verity-target.c     |  44 ++++------
>>   drivers/md/dm-verity-verify-sig.c | 140 ++++++++++++++++++++++--------
>>   drivers/md/dm-verity-verify-sig.h |  24 +++--
>>   drivers/md/dm-verity.h            |   2 +-
>>   4 files changed, 134 insertions(+), 76 deletions(-)
>>
>> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>> index eec9f252e935..fabc173aa7b3 100644
>> --- a/drivers/md/dm-verity-target.c
>> +++ b/drivers/md/dm-verity-target.c
>> @@ -471,9 +471,9 @@ static int verity_verify_io(struct dm_verity_io *io)
>>   	struct bvec_iter start;
>>   	unsigned b;
>>   	struct crypto_wait wait;
>> +	int r;
>>   
>>   	for (b = 0; b < io->n_blocks; b++) {
>> -		int r;
>>   		sector_t cur_block = io->block + b;
>>   		struct ahash_request *req = verity_io_hash_req(v, io);
>>   
>> @@ -530,6 +530,16 @@ static int verity_verify_io(struct dm_verity_io *io)
>>   			return -EIO;
>>   	}
>>   
>> +	/*
>> +	 * At this point, the merkel tree has finished validating.
>> +	 * if signature was specified, validate the signature here.
>> +	 */
>> +	r = verity_verify_root_hash(v);
>> +	if (r < 0) {
>> +		DMERR_LIMIT("signature mismatch");
>> +		return r;
>> +	}
>> +
>>   	return 0;
>>   }
> 
> This doesn't make any sense.
> 
> This just moves the signature verification to some random I/O.
> 
> The whole point of dm-verity is that data is verified on demand.  You can't know
> whether any particular data or hash block is consistent with the root hash or
> not until it is read and verified.
> 
> When the first I/O completes it might have just checked one block of a billion.
> 
> Not to mention that you didn't consider locking at all.
> 
> - Eric
> 

I appear to have dangerously misunderstood how dm-verity works under the
covers. What I thought was happening here was that *this* would be where
the first I/O that completes validation and has been verified - the root
hash signature could then be checked against the root hash, and then
no-op for remaining blocks, provided the signature validates.

The reason why I was proposing moving the signature check, is that I was 
afraid of the block_device being created in dm-verity with a root-hash 
that belongs to a different device + a signature that verifies that
root-hash, would get past verity_ctr, as despite the root hash not
matching the hash tree, the signature and the root hash will be 
verified. At this point, a block_device structure would be resident in
the kernel with the security attributes I propose in the next patch in 
the series. This device would never be read successfully, but the
structure with the attribute would exist.

This felt odd because there would be a structure in the kernel with an
attribute that says it passed a security check, but the block_device is
effectively invalid.

I realize now that that's a pretty ridiculous situation because the 
theoretical attack with access to manipulate the kernel memory in such a 
way to make it viable could just override whatever is needed to make the 
exploit work, and isn't unique to dm-verity.

I'm going to drop this patch in the next iteration of this series.


