Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D23CCFE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhGSIXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 04:23:10 -0400
Received: from mail.synology.com ([211.23.38.101]:32806 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235498AbhGSIXJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:23:09 -0400
Subject: Re: [RESEND PATCH v2] hfsplus: prevent negative dentries when
 casefolded
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1626685428; bh=nrLeIo3KdjKJ3knzH46N/b/L2z/5UVOq0EeQ1Fo8DU0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P/+x438MJ0hx/dzk6G6PB75DxBzAzn4P/QnJWOY1jTGjHRDDvcPxBC0B80YiZSuzL
         KiP/a3GgRsXI+BY3bryY1szsYl2nk5AwPcfaWZhXbE9HN1DJiInDlLHyPvZZDnq/19
         WGggKzqDt5FvIreyh8/qvLLICGvyxhOAZ8L30QUE=
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        gustavoars@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, mszeredi@redhat.com, shepjeng@gmail.com
References: <20210716073635.1613671-1-cccheng@synology.com>
 <02B9566C-A78E-42FB-924B-A503E4BC6D2F@dubeyko.com>
From:   Chung-Chiang Cheng <cccheng@synology.com>
Message-ID: <a2c84cfa-b6ed-c86c-0bb1-d05087c141d7@synology.com>
Date:   Mon, 19 Jul 2021 17:03:45 +0800
MIME-Version: 1.0
In-Reply-To: <02B9566C-A78E-42FB-924B-A503E4BC6D2F@dubeyko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function revalidates dentries without blocking and storing to the
dentry. As the document mentioned [1], I think it's safe in rcu-walk
mode. I also found jfs_ci_revalidate() takes the same approach.

         d_revalidate may be called in rcu-walk mode (flags & LOOKUP_RCU).
         If in rcu-walk mode, the filesystem must revalidate the dentry 
without
         blocking or storing to the dentry, d_parent and d_inode should 
not be
         used without care (because they can change and, in d_inode 
case, even
         become NULL under us


[1] https://www.kernel.org/doc/Documentation/filesystems/vfs.txt

Thanks,
C.C.Cheng

>> +
>> +int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int flags)
>> +{
> What’s about this code?
>
> If (flags & LOOKUP_RCU)
>     return -ECHILD;
>
> Do we really need to miss it here?
>
> Thanks,
> Slava.
>
>
>> +	/*
>> +	 * dentries are always valid when disabling casefold.
>> +	 */
>> +	if (!test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(dentry->d_sb)->flags))
>> +		return 1;
>> +
>> +	/*
>> +	 * Positive dentries are valid when enabling casefold.
>> +	 *
>> +	 * Note, rename() to existing directory entry will have ->d_inode, and
>> +	 * will use existing name which isn't specified name by user.
>> +	 *
>> +	 * We may be able to drop this positive dentry here. But dropping
>> +	 * positive dentry isn't good idea. So it's unsupported like
>> +	 * rename("filename", "FILENAME") for now.
>> +	 */
>> +	if (d_really_is_positive(dentry))
>> +		return 1;
>> +
>> +	/*
>> +	 * Drop the negative dentry, in order to make sure to use the case
>> +	 * sensitive name which is specified by user if this is for creation.
>> +	 */
>> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> -- 
>> 2.25.1
>>
