Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6D41B50A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhI1RXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:23:38 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:52656 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhI1RXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:23:37 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 9D754821D8;
        Tue, 28 Sep 2021 20:21:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632849716;
        bh=1eIU+Q66pTwxALS54M8jSJ/OOGHF+t7oZXoe1eQzNBY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cOLMthE/1M0+NvB7o1gxTLZ0327Y0jyS0xc5PxAtLfOqie21kiQJBsN5S7s6mC8lo
         FlKBxHCj5EgTpkbgm+r9vvvvvCBbwUno/lTROUtm2jwSlEO7YzPsHaQvuGFnXpBheM
         X9L3Y8Gu0Cw0PQbsBRH2cATbrR/5ePS25Xjenma8=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 20:21:55 +0300
Message-ID: <fbdcbb8f-380c-4da9-2860-a3729c75e04b@paragon-software.com>
Date:   Tue, 28 Sep 2021 20:21:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/3] fs/ntfs3: Reject mount if boot's cluster size < media
 sector size
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
 <6036b141-56e2-0d08-b9ff-641c3451f45a@paragon-software.com>
 <20210927185621.2wkznecc4jndja6b@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210927185621.2wkznecc4jndja6b@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.85]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 27.09.2021 21:56, Kari Argillander wrote:
> On Mon, Sep 27, 2021 at 06:48:00PM +0300, Konstantin Komarov wrote:
>> If we continue to work in this case, then we can corrupt fs.
>>
> 
> Should have fixes tag.
> 

The bug is in initial commit.
Do I need to write
Fixes: 82cae269cfa95 "fs/ntfs3: Add initialization of super block"
?

>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> ---
>>  fs/ntfs3/super.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
>> index 7099d9b1f3aa..193f9a98f6ab 100644
>> --- a/fs/ntfs3/super.c
>> +++ b/fs/ntfs3/super.c
>> @@ -763,9 +763,14 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>>  	sbi->mft.lbo = mlcn << sbi->cluster_bits;
>>  	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
>>  
>> +	/* Compare boot's cluster and sector. */
> 
> Pretty random obvious comment and I do not know what this does in this
> patch.
> 
>>  	if (sbi->cluster_size < sbi->sector_size)
>>  		goto out;
>>  
>> +	/* Compare boot's cluster and media sector. */
>> +	if (sbi->cluster_size < sector_size)
>> +		goto out; /* No way to use ntfs_get_block in this case. */
> 
> Usually comment should not go after line. If you take chunk from patch
> 3/3 then this is not issue.
> 
>> +
>>  	sbi->cluster_mask = sbi->cluster_size - 1;
>>  	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
>>  	sbi->record_size = record_size = boot->record_size < 0
>> -- 
>> 2.33.0
>>
>>
>>
