Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542AD142464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 08:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATHqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 02:46:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44828 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATHqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:46:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itRl0-00Btkf-JV; Mon, 20 Jan 2020 07:45:58 +0000
Date:   Mon, 20 Jan 2020 07:45:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120074558.GA8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120073040.GZ8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 07:30:40AM +0000, Al Viro wrote:

> <checks ext4>
> Yup, that bug is there as well, all right.  Look:
> #ifdef CONFIG_UNICODE
> static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
>                           const char *str, const struct qstr *name)
> {
>         struct qstr qstr = {.name = str, .len = len };
>         struct inode *inode = dentry->d_parent->d_inode;
> 
>         if (!IS_CASEFOLDED(inode) || !EXT4_SB(inode->i_sb)->s_encoding) {
> 
> Guess what happens if your (lockless) call of ->d_compare() runs
> into the following sequence:
> CPU1:	ext4_d_compare() fetches ->d_parent
> CPU1:	takes a hardware interrupt
> CPU2:	dentry gets evicted by memory pressure; so is its parent, since
> it was the only thing that used to keep it pinned.  Eviction of the parent
> calls dentry_unlink_inode() on the parent, which zeroes its ->d_inode.
> CPU1:	comes back
> CPU1:	fetches parent's ->d_inode and gets NULL
> CPU1:	oopses on null pointer dereference.
> 
> It's not impossible to hit.  Note that e.g. vfat_cmpi() is not vulnerable
> to that problem - ->d_sb is stable and both the superblock and ->nls_io
> freeing is RCU-delayed.
> 
> I hadn't checked ->d_compare() instances for a while; somebody needs to
> do that again, by the look of it.  The above definitely is broken;
> no idea how many other instaces had grown such bugs...

f2fs one also has the same bug.  Anyway, I'm going down right now, will
check the rest tomorrow morning...
