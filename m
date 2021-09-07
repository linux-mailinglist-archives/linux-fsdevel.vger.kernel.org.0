Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74250402CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbhIGQPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 12:15:37 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:35338 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244135AbhIGQPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:15:37 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 96512415;
        Tue,  7 Sep 2021 19:14:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631031267;
        bh=/677Cv3P5bvchgyfuP6mrlK0Dsgo2NNOnd1aDEVqAAo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QjktKAFowwn+q8Y00od4uRHxYS8XFM7RFHPLlw9LNKN4Jx3i+SFrwalJqrRLHBrSF
         B7RO9TQG1kDipw7g2cjd1yirJUzVIqq5vkd8P06f6mrrIqv2FcYXyUCo/N/4MhZpjA
         FkHVw4lHqOr3TW2ZEXRTYdtQraAO059R4syB/aVI=
Received: from [192.168.211.115] (192.168.211.115) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 7 Sep 2021 19:14:27 +0300
Subject: Re: [PATCH v3 0/9] fs/ntfs3: Use new mount api and change some opts
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210907073618.bpz3fmu7jcx5mlqh@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <69c8ab24-9443-59ad-d48d-7765b29f28f9@paragon-software.com>
Date:   Tue, 7 Sep 2021 19:14:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907073618.bpz3fmu7jcx5mlqh@kari-VirtualBox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.115]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 07.09.2021 10:36, Kari Argillander wrote:
> On Sun, Aug 29, 2021 at 12:56:05PM +0300, Kari Argillander wrote:
>> See V2 if you want:
>> lore.kernel.org/ntfs3/20210819002633.689831-1-kari.argillander@gmail.com
>>
>> NLS change is now blocked when remounting. Christoph also suggest that
>> we block all other mount options, but I have tested a couple and they
>> seem to work. I wish that we do not block any other than NLS because
>> in theory they should work. Also Konstantin can comment about this.
>>
>> I have not include reviewed/acked to patch "Use new api for mounting"
>> because it change so much. I have also included three new patch to this
>> series:
>> 	- Convert mount options to pointer in sbi
>> 		So that we do not need to initiliaze whole spi in 
>> 		remount.
>> 	- Init spi more in init_fs_context than fill_super
>> 		This is just refactoring. (Series does not depend on this)
>> 	- Show uid/gid always in show_options()
>> 		Christian Brauner kinda ask this. (Series does not depend
>> 		on this)
>>
>> Series is ones again tested with kvm-xfstests. Every commit is build
>> tested.
> 
> I will send v4 within couple of days. It will address issues what Pali
> says in patch 8/9. Everything else should be same at least for now. Is
> everything else looking ok?
> 

Yes, everything else seems good. 
We tested patches locally - no regression was found.

>>
>> v3:
>> 	- Add patch "Convert mount options to pointer in sbi"
>> 	- Add patch "Init spi more in init_fs_context than fill_super"
>> 	- Add patch "Show uid/gid always in show_options"
>> 	- Patch "Use new api for mounting" has make over
>> 	- NLS loading is not anymore possible when remounting
>> 	- show_options() iocharset printing is fixed
>> 	- Delete comment that testing should be done with other
>> 	  mount options.
>> 	- Add reviewed/acked-tags to 1,2,6,8 
>> 	- Rewrite this cover
>> v2:
>> 	- Rewrite this cover leter
>> 	- Reorder noatime to first patch
>> 	- NLS loading with string
>> 	- Delete default_options function
>> 	- Remove remount flags
>> 	- Rename no_acl_rules mount option
>> 	- Making code cleaner
>> 	- Add comment that mount options should be tested
>>
>> Kari Argillander (9):
>>   fs/ntfs3: Remove unnecesarry mount option noatime
>>   fs/ntfs3: Remove unnecesarry remount flag handling
>>   fs/ntfs3: Convert mount options to pointer in sbi
>>   fs/ntfs3: Use new api for mounting
>>   fs/ntfs3: Init spi more in init_fs_context than fill_super
>>   fs/ntfs3: Make mount option nohidden more universal
>>   fs/ntfs3: Add iocharset= mount option as alias for nls=
>>   fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules
>>   fs/ntfs3: Show uid/gid always in show_options()
>>
>>  Documentation/filesystems/ntfs3.rst |  10 +-
>>  fs/ntfs3/attrib.c                   |   2 +-
>>  fs/ntfs3/dir.c                      |   8 +-
>>  fs/ntfs3/file.c                     |   4 +-
>>  fs/ntfs3/inode.c                    |  12 +-
>>  fs/ntfs3/ntfs_fs.h                  |  26 +-
>>  fs/ntfs3/super.c                    | 486 +++++++++++++++-------------
>>  fs/ntfs3/xattr.c                    |   2 +-
>>  8 files changed, 284 insertions(+), 266 deletions(-)
>>
>> -- 
>> 2.25.1
>>
>>
