Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054CD1C37BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgEDLJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:09:41 -0400
Received: from mailhub.9livesdata.com ([194.181.36.210]:44402 "EHLO
        mailhub.9livesdata.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDLJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:09:41 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 07:09:39 EDT
Received: from [192.168.6.101] (icore-01 [192.168.6.101])
        by mailhub.9livesdata.com (Postfix) with ESMTP id 241653465BD9;
        Mon,  4 May 2020 13:00:21 +0200 (CEST)
From:   Krzysztof Rusek <rusek@9livesdata.com>
Subject: fuse_notify_inval_inode() may be ineffective when getattr request is
 in progress
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Message-ID: <846ae13f-acd9-9791-3f1b-855e4945012a@9livesdata.com>
Date:   Mon, 4 May 2020 13:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------52CD8B03056B0F92CAC5F765"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------52CD8B03056B0F92CAC5F765
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm working on a user-space file system implementation utilizing fuse 
kernel module (and libfuse user-space library). This file system 
implementation provides a custom ioctl operation that uses 
fuse_lowlevel_notify_inval_inode() function (which translates to 
fuse_notify_inval_inode() in kernel) to notify the kernel that the file 
was changed by the ioctl. However, under certain circumstances, 
fuse_notify_inval_inode() call is ineffective, resulting in incorrect 
file attributes being cached by the kernel. The problem occurs when 
ioctl() is executed in parallel with getattr().

I noticed this problem on RedHat 7.7 (3.10.0-1062.el7.x86_64), but I 
believe mainline kernel is affected as well.

I think there is a bug in the way fuse_notify_inval_inode() invalidates 
file attributes. If getattr() started before fuse_notify_inval_inode() 
was called, then the attributes returned by user-space process may be 
out of date, and should not be cached. But fuse_notify_inval_inode() 
only clears attribute validity time, which does not prevent getattr() 
result from being cached.

More precisely, this bug occurs in the following scenario:

1. kernel starts handling ioctl
2. file system process receives ioctl request
3. kernel starts handling getattr
4. file system process receives getattr request
5. file system process executes getattr
6. file system process executes ioctl, changing file state
7. file system process invokes fuse_lowlevel_notify_inval_inode(), which 
invalidates file attributes in kernel
8. file system process sends ioctl reply, ioctl handling ends
9. file system process sends getattr reply, attributes are incorrectly 
cached in the kernel

(Note that this scenario assumes that file system implementation is 
multi-threaded, therefore allowing ioctl() and getattr() to be handled 
in parallel.)

I'm attaching an archive with a reproduction test for this problem. The 
archive contains a README file explaining how to compile/run it.

By the way, to avoid a somehow similar race when write() is executed in 
parallel with getattr(), there is a special FUSE_I_SIZE_UNSTABLE bit set 
for the duration of write() operation.

Best regards,
Krzysztof Rusek

--------------52CD8B03056B0F92CAC5F765
Content-Type: application/gzip;
 name="fusebug.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fusebug.tar.gz"

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
--------------52CD8B03056B0F92CAC5F765--
