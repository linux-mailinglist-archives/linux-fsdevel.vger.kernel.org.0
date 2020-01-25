Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5208814931B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 04:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgAYDfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 22:35:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37004 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387685AbgAYDfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 22:35:51 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P3ZNia013355
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 22:35:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DA14842014A; Fri, 24 Jan 2020 22:35:22 -0500 (EST)
Date:   Fri, 24 Jan 2020 22:35:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200125033522.GM147870@mit.edu>
References: <20200124041234.159740-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124041234.159740-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 08:12:34PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since ->d_compare() and ->d_hash() can be called in RCU-walk mode,
> ->d_parent and ->d_inode can be concurrently modified, and in
> particular, ->d_inode may be changed to NULL.  For ext4_d_hash() this
> resulted in a reproducible NULL dereference if a lookup is done in a
> directory being deleted, e.g. with:
> 
> 	int main()
> 	{
> 		if (fork()) {
> 			for (;;) {
> 				mkdir("subdir", 0700);
> 				rmdir("subdir");
> 			}
> 		} else {
> 			for (;;)
> 				access("subdir/file", 0);
> 		}
> 	}
> 
> ... or by running the 't_encrypted_d_revalidate' program from xfstests.
> Both repros work in any directory on a filesystem with the encoding
> feature, even if the directory doesn't actually have the casefold flag.
> 
> I couldn't reproduce a crash in ext4_d_compare(), but it appears that a
> similar crash is possible there.
> 
> Fix these bugs by reading ->d_parent and ->d_inode using READ_ONCE() and
> falling back to the case sensitive behavior if the inode is NULL.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
> Cc: <stable@vger.kernel.org> # v5.2+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
