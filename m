Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB52E9DF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhADTJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADTJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:09:15 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69992C061574;
        Mon,  4 Jan 2021 11:08:35 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwVDU-006r5I-Ea; Mon, 04 Jan 2021 19:08:32 +0000
Date:   Mon, 4 Jan 2021 19:08:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Daeho Jeong <daeho43@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vfs: don't unnecessarily clone write access for
 writable fds
Message-ID: <20210104190832.GL3579531@ZenIV.linux.org.uk>
References: <20200922164418.119184-1-ebiggers@kernel.org>
 <X/Nkk4rlS43W90TV@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/Nkk4rlS43W90TV@sol.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 10:55:15AM -0800, Eric Biggers wrote:
> On Tue, Sep 22, 2020 at 09:44:18AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > There's no need for mnt_want_write_file() to increment mnt_writers when
> > the file is already open for writing, provided that
> > mnt_drop_write_file() is changed to conditionally decrement it.
> > 
> > We seem to have ended up in the current situation because
> > mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> > mnt_drop_write_file() not having been added yet.  So originally
> > mnt_want_write_file() had to always increment mnt_writers.
> > 
> > But later mnt_drop_write_file() was added, and all callers of
> > mnt_want_write_file() were paired with it.  This makes the compatibility
> > between mnt_want_write_file() and mnt_drop_write() no longer necessary.
> > 
> > Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() skip
> > incrementing mnt_writers on files already open for writing.  This
> > removes the only caller of mnt_clone_write(), so remove that too.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> > 
> > v3: added note to porting file.
> > v2: keep the check for emergency r/o remounts.
> > 
> >  Documentation/filesystems/porting.rst |  7 ++++
> >  fs/namespace.c                        | 53 ++++++++++-----------------
> >  include/linux/mount.h                 |  1 -
> >  3 files changed, 27 insertions(+), 34 deletions(-)
> 
> Ping.

Applied.
