Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294DE58FE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 03:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfF1Bt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 21:49:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53594 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1Bt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:49:59 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id 4A66B20B7194; Thu, 27 Jun 2019 18:49:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 2D89630056D6;
        Thu, 27 Jun 2019 18:49:58 -0700 (PDT)
Date:   Thu, 27 Jun 2019 18:49:58 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Eric Biggers <ebiggers@kernel.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <20190627234149.GA212823@gmail.com>
Message-ID: <alpine.LRH.2.21.1906271844470.22562@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com> <20190627234149.GA212823@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 27 Jun 2019, Eric Biggers wrote:

> Hi Jaskaran, one comment (I haven't reviewed this in detail):
>
> On Wed, Jun 19, 2019 at 12:10:48PM -0700, Jaskaran Khurana wrote:
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index db269a348b20..2d658a3512cb 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -475,6 +475,7 @@ config DM_VERITY
>>  	select CRYPTO
>>  	select CRYPTO_HASH
>>  	select DM_BUFIO
>> +	select SYSTEM_DATA_VERIFICATION
>>  	---help---
>>  	  This device-mapper target creates a read-only device that
>>  	  transparently validates the data on one underlying device against
>> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
>> index be7a6eb92abc..3b47b256b15e 100644
>> --- a/drivers/md/Makefile
>> +++ b/drivers/md/Makefile
>> @@ -18,7 +18,7 @@ dm-cache-y	+= dm-cache-target.o dm-cache-metadata.o dm-cache-policy.o \
>>  		    dm-cache-background-tracker.o
>>  dm-cache-smq-y   += dm-cache-policy-smq.o
>>  dm-era-y	+= dm-era-target.o
>> -dm-verity-y	+= dm-verity-target.o
>> +dm-verity-y	+= dm-verity-target.o dm-verity-verify-sig.o
>>  md-mod-y	+= md.o md-bitmap.o
>>  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
>>  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
>
> Perhaps this should be made optional and controlled by a kconfig option
> CONFIG_DM_VERITY_SIGNATURE_VERIFICATION, similar to CONFIG_DM_VERITY_FEC?
>
> CONFIG_SYSTEM_DATA_VERIFICATION brings in a lot of stuff, which might be
> unnecessary for some dm-verity users.  Also, you've already separated most of
> the code out into a separate .c file anyway.
>
> - Eric
>
Hello Eric,

This started with a config (see V4). We didnot want scripts that pass this 
parameter to suddenly stop working if for some reason the 
verification is turned off so the optional parameter was just 
parsed and no validation happened if the CONFIG was turned off. This was 
changed to a commandline parameter after feedback from the community, so I would prefer 
to keep it *now* as commandline parameter. Let me know if you are OK with 
this.

Regards,
JK
