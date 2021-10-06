Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3004042407B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhJFOxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 10:53:50 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:55712 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238226AbhJFOxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:53:49 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 066D38233B;
        Wed,  6 Oct 2021 17:51:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633531916;
        bh=8Cm0RDs9t4KpPStU4gb2pzuvks/jqPKMp43U3hN9DG0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Vu0gGwIAqX+mcKg+xZ0oQEnJKoX7I6cDi5zsJNZo7ifC9e04VYRQo+xQdWstlIBZh
         AWm9+Srxz3YFdtH47W9C/9fe0OVA7XKyhGNjEBwkz9Rlb9lycHUUR8aQkRk3NMmOE0
         zSssYSGu8FB1JKB+DGjteE9TD7BMtG3FMPGhU5Mo=
Received: from [192.168.211.53] (192.168.211.53) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 6 Oct 2021 17:51:55 +0300
Message-ID: <debcf00f-c155-868f-9a49-f5595c550edb@paragon-software.com>
Date:   Wed, 6 Oct 2021 17:51:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        Mohammad Rasim <mohammad.rasim96@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
 <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.53]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 03.10.2021 20:50, Kari Argillander wrote:
> On Wed, Sep 29, 2021 at 07:35:43PM +0300, Konstantin Komarov wrote:
>> This can be reason for reported panic.
>> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> 
> I see that you have include this to devel branch but you did not send V2
> [1]. 

From patch thread:
"Is this public panic? If it is then put link here. If you have report
from panic you can put it here also. Patch itself looks correct."

I was thinking, that after adding link / Reported-by the patch is
good to commit.

> I also included Mohammad Rasim to this thread. Maybe they can test
> this patch. Rasim can you test [2] if your problem will be fixed with
> this tree. Or just test this patch if you prefer that way.
> 
> [1]: github.com/Paragon-Software-Group/linux-ntfs3/commit/35afb70dcfe4eb445060dd955e5b67d962869ce5
> [2]: github.com/Paragon-Software-Group/linux-ntfs3/tree/devel
> 
>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> ---
>>  fs/ntfs3/frecord.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>> index 9a53f809576d..007602badd90 100644
>> --- a/fs/ntfs3/frecord.c
>> +++ b/fs/ntfs3/frecord.c
>> @@ -3080,7 +3080,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>>                         const struct EA_INFO *info;
>>  
>>                         info = resident_data_ex(attr, sizeof(struct EA_INFO));
>> -                       dup->ea_size = info->size_pack;
>> +                       /* If ATTR_EA_INFO exists 'info' can't be NULL. */
>> +                       if (info)
>> +                               dup->ea_size = info->size_pack;
>>                 }
>>         }
>>  
>> -- 
>> 2.33.0
>>
