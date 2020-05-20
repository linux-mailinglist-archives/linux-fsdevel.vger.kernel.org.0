Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB51DB321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETMYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 08:24:03 -0400
Received: from mailhub.9livesdata.com ([194.181.36.210]:44538 "EHLO
        mailhub.9livesdata.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 08:24:03 -0400
Received: from [192.168.6.101] (icore01.9livesdata.com [192.168.6.101])
        by mailhub.9livesdata.com (Postfix) with ESMTP id AF5B53464B9E;
        Wed, 20 May 2020 14:23:57 +0200 (CEST)
Subject: Re: fuse_notify_inval_inode() may be ineffective when getattr request
 is in progress
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
References: <846ae13f-acd9-9791-3f1b-855e4945012a@9livesdata.com>
 <CAJfpegs+auq0TQ4SaFiLb7w9E+ksWHCzgBoOhCCFGF6R9DMFdA@mail.gmail.com>
From:   Krzysztof Rusek <rusek@9livesdata.com>
Message-ID: <d9459e74-92b4-187b-4b73-bd807e79d813@9livesdata.com>
Date:   Wed, 20 May 2020 14:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegs+auq0TQ4SaFiLb7w9E+ksWHCzgBoOhCCFGF6R9DMFdA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------E3F359F253A6910F7E606C19"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E3F359F253A6910F7E606C19
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miklos,

I've checked that after applying the patch, the problem no longer occurs.

Since I'm running tests on RedHat 7.7, I had to slightly modify the 
patch, because on that kernel version locking around attr_version is 
done differently. I'm attaching modified patch, just in case.

Best regards,
Krzysztof Rusek

On 5/18/20 3:08 PM, Miklos Szeredi wrote:
> On Mon, May 4, 2020 at 1:00 PM Krzysztof Rusek <rusek@9livesdata.com> wrote:
>>
>> Hello,
>>
>> I'm working on a user-space file system implementation utilizing fuse
>> kernel module (and libfuse user-space library). This file system
>> implementation provides a custom ioctl operation that uses
>> fuse_lowlevel_notify_inval_inode() function (which translates to
>> fuse_notify_inval_inode() in kernel) to notify the kernel that the file
>> was changed by the ioctl. However, under certain circumstances,
>> fuse_notify_inval_inode() call is ineffective, resulting in incorrect
>> file attributes being cached by the kernel. The problem occurs when
>> ioctl() is executed in parallel with getattr().
>>
>> I noticed this problem on RedHat 7.7 (3.10.0-1062.el7.x86_64), but I
>> believe mainline kernel is affected as well.
>>
>> I think there is a bug in the way fuse_notify_inval_inode() invalidates
>> file attributes. If getattr() started before fuse_notify_inval_inode()
>> was called, then the attributes returned by user-space process may be
>> out of date, and should not be cached. But fuse_notify_inval_inode()
>> only clears attribute validity time, which does not prevent getattr()
>> result from being cached.
>>
>> More precisely, this bug occurs in the following scenario:
>>
>> 1. kernel starts handling ioctl
>> 2. file system process receives ioctl request
>> 3. kernel starts handling getattr
>> 4. file system process receives getattr request
>> 5. file system process executes getattr
>> 6. file system process executes ioctl, changing file state
>> 7. file system process invokes fuse_lowlevel_notify_inval_inode(), which
>> invalidates file attributes in kernel
>> 8. file system process sends ioctl reply, ioctl handling ends
>> 9. file system process sends getattr reply, attributes are incorrectly
>> cached in the kernel
>>
>> (Note that this scenario assumes that file system implementation is
>> multi-threaded, therefore allowing ioctl() and getattr() to be handled
>> in parallel.)
> 
> Can you please try the attached patch?
> 
> Thanks,
> Miklos
> 

--------------E3F359F253A6910F7E606C19
Content-Type: text/x-patch; charset=UTF-8;
 name="fuse-update-attr_version-counter-on-fuse_notify_inval_inode.patch.el7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="fuse-update-attr_version-counter-on-fuse_notify_inval_inode.";
 filename*1="patch.el7.diff"

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -332,6 +332,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 int fuse_reverse_inval_inode(struct super_block *sb, u64 nodeid,
 			     loff_t offset, loff_t len)
 {
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode *fi;
 	struct inode *inode;
 	pgoff_t pg_start;
 	pgoff_t pg_end;
@@ -340,6 +342,11 @@ int fuse_reverse_inval_inode(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return -ENOENT;
 
+	fi = get_fuse_inode(inode);
+	spin_lock(&fc->lock);
+	fi->attr_version = ++fc->attr_version;
+	spin_unlock(&fc->lock);
+
 	fuse_invalidate_attr(inode);
 	if (offset >= 0) {
 		pg_start = offset >> PAGE_CACHE_SHIFT;

--------------E3F359F253A6910F7E606C19--
