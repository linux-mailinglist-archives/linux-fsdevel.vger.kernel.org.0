Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1741CAB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbhI2Q46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 12:56:58 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:57487 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245276AbhI2Q45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:56:57 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 34BE58230F;
        Wed, 29 Sep 2021 19:55:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632934515;
        bh=G7Wdg9mT0Ns3YgyIT6a7j3pJ2ql5Pkil3NxCMgX2PUY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bZDHKNLK0RwZuWiV2SSec8AvXv/aZUBdQwHdsTIUbxV55nqeJ73Bbzehl+5s+nVGa
         Rrzt/FOjBcJm7KX4hTd+jCzQ1wwndTaY5PWU88V8hn7k5UdgzPMYVuQ3EYaBAbjivy
         3opOWrCO7rEto/BLTMuBnq3XHgTPpnJTKyHvccV0=
Received: from [192.168.211.131] (192.168.211.131) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 29 Sep 2021 19:55:14 +0300
Message-ID: <9b37cc1a-2951-77fa-9932-6052555ceca9@paragon-software.com>
Date:   Wed, 29 Sep 2021 19:55:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 1/3] fs/ntfs3: Fix memory leak if fill_super failed
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
 <5ee2a090-1709-5ca0-1e78-8db1f3ded973@paragon-software.com>
 <20210928174423.z7a6chrjmmyezlsp@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210928174423.z7a6chrjmmyezlsp@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.131]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 28.09.2021 20:44, Kari Argillander wrote:
> On Tue, Sep 28, 2021 at 08:17:29PM +0300, Konstantin Komarov wrote:
>> Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context.
>>
>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> ---
>>  fs/ntfs3/super.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
>> index 800897777eb0..aff90f70e7bf 100644
>> --- a/fs/ntfs3/super.c
>> +++ b/fs/ntfs3/super.c
>> @@ -1242,6 +1242,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>  	return 0;
>>  out:
>>  	iput(inode);
>> +
>> +	/* Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context. */
>> +	fc->s_fs_info = sbi;
>> +
> 
> Nack. fc->s_fs_info is already pointing to sbi. We null this just before
> we exit so it is impossible to be anything else in failure case.
> 

We have seen memory leak once, but looking at the code of function
I can't point where it was caused. Will try to reproduce again.
For now will commit only 
"Reject mount if boot's cluster size < media sector size" and
"Refactoring of ntfs_init_from_boot".

> 	fc->fs_private = NULL;
> 	fc->s_fs_info = NULL;
> 
> 	return 0;
> out:
> 	iput(inode);
> 
>>  	return err;
>>  }
>>  
>> -- 
>> 2.33.0
>>
>>
