Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1157D4508F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 16:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhKOPzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 10:55:17 -0500
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:38052 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232479AbhKOPxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:53:32 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id B268F821D9;
        Mon, 15 Nov 2021 18:50:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1636991417;
        bh=qD3HKvrsZCU1PXTGecu+drDpYLl62caCO8M8BtKuoPg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cAIMFjsumCl22bvvmlJkb53uXjM+mYIuLw7DuGZjgb5snYLQPLLPzbMSHhk1tzipU
         do+RcBh1iFp2InlBrxPwHLENIn8xHmDYMY0Ss0m6+fAGXj7NHkgmiMzEB4LvR4Cjwt
         zzLs73bs6EeMyUYS1kuZTcCv6A0hCOrpREoTcIYs=
Received: from [192.168.211.139] (192.168.211.139) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 Nov 2021 18:50:17 +0300
Message-ID: <2a86fac1-5363-96c0-7132-dc8b33853a16@paragon-software.com>
Date:   Mon, 15 Nov 2021 18:50:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/4] fs/ntfs3: Update i_ctime when xattr is added
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
 <d5482090-67d1-3a54-c351-b756b757a647@paragon-software.com>
 <20211026204132.kyez7uu4qhv7q2wl@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20211026204132.kyez7uu4qhv7q2wl@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.139]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26.10.2021 23:41, Kari Argillander wrote:
> On Tue, Oct 26, 2021 at 07:41:50PM +0300, Konstantin Komarov wrote:
>> Ctime wasn't updated after setfacl command.
>> This commit fixes xfstest generic/307
> 
> When I run xfstest I get
> 
> generic/307		[20:37:41][   21.436315] run fstests generic/307 at 2021-10-26 20:37:41
> [   23.362544]  vdc:
> [failed, exit status 1] [20:37:45]- output mismatch (see /results/ntfs3/results-default/generic/307.out.bad)
>     --- tests/generic/307.out	2021-08-03 00:08:10.000000000 +0000
>     +++ /results/ntfs3/results-default/generic/307.out.bad	2021-10-26 20:37:45.172171949 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 307
>      Silence is golden
>     +setfacl: symbol lookup error: setfacl: undefined symbol: walk_tree
>     +error: ctime not updated after setfacl
>     ...
>     (Run 'diff -u /root/xfstests/tests/generic/307.out /results/ntfs3/results-default/generic/307.out.bad'  to see the entire diff)
> 
> any ideas you get different result?
> 

What are mount options for this test?
generic/307 passes with "acl" and "sparse,acl".
Can you try to locate where is "undefined symbol: walk_tree" coming from?

>> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
>>
>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> ---
>>  fs/ntfs3/xattr.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
>> index 3ccdb8c2ac0b..157b70aecb4f 100644
>> --- a/fs/ntfs3/xattr.c
>> +++ b/fs/ntfs3/xattr.c
>> @@ -992,6 +992,9 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>>  	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
>>  
>>  out:
>> +	inode->i_ctime = current_time(inode);
>> +	mark_inode_dirty(inode);
>> +
>>  	return err;
>>  }
>>  
>> -- 
>> 2.33.0
>>
>>
