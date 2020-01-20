Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F87142441
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 08:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgATHas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 02:30:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44652 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgATHas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:30:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itRWC-00BtNz-7S; Mon, 20 Jan 2020 07:30:40 +0000
Date:   Mon, 20 Jan 2020 07:30:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120073040.GZ8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgkan57p.fsf@mail.parknet.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 01:04:42PM +0900, OGAWA Hirofumi wrote:

> Also, not directly same issue though. There is related issue for
> case-insensitive. Even if we use some sort of internal wide char
> (e.g. in nls, 16bits), dcache is holding name in user's encode
> (e.g. utf8). So inefficient to convert cached name to wide char for each
> access.
> 
> Relatively recent EXT4 case-insensitive may tackled this though, I'm not
> checking it yet.

What's more, comparisons in dcache lookups have to be very careful about
the rename-related issues.  You can give false negatives if the name
changes under you; it's not a problem.  You can even give a false positive
in case of name change happening in the middle of comparison; ->d_seq
mismatch will get caught and it will have the result discarded before it
causes problems.  However, you can't e.g. assume that the string you are
trying to convert from utf8 to 16bit won't be changing right under you.
Again, the wrong result of comparison in such situation is not a problem;
wrong return value is not the worst thing that can happen to a string
function mistakenly assuming that the string is not changing under it.

And you very much need to be careful about the things you can access
there.  E.g. something like "oh, I'll just look at the flags in the
inode of the parent of potential match" (as in the recently posted
series) is a bloody bad idea on many levels.  Starting with "your
potential match is getting moved right now, and what used to be its
parent becomes negative by the time you get around to fetching its
->d_inode.  Dereferencing the resulting NULL to get inode flags
is not pretty".

<checks ext4>
Yup, that bug is there as well, all right.  Look:
#ifdef CONFIG_UNICODE
static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
                          const char *str, const struct qstr *name)
{
        struct qstr qstr = {.name = str, .len = len };
        struct inode *inode = dentry->d_parent->d_inode;

        if (!IS_CASEFOLDED(inode) || !EXT4_SB(inode->i_sb)->s_encoding) {

Guess what happens if your (lockless) call of ->d_compare() runs
into the following sequence:
CPU1:	ext4_d_compare() fetches ->d_parent
CPU1:	takes a hardware interrupt
CPU2:	dentry gets evicted by memory pressure; so is its parent, since
it was the only thing that used to keep it pinned.  Eviction of the parent
calls dentry_unlink_inode() on the parent, which zeroes its ->d_inode.
CPU1:	comes back
CPU1:	fetches parent's ->d_inode and gets NULL
CPU1:	oopses on null pointer dereference.

It's not impossible to hit.  Note that e.g. vfat_cmpi() is not vulnerable
to that problem - ->d_sb is stable and both the superblock and ->nls_io
freeing is RCU-delayed.

I hadn't checked ->d_compare() instances for a while; somebody needs to
do that again, by the look of it.  The above definitely is broken;
no idea how many other instaces had grown such bugs...
