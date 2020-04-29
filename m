Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732031BDC02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD2MXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgD2MXk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:23:40 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DE32074A;
        Wed, 29 Apr 2020 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588163019;
        bh=8UVjfjYLGszO02O6LC1dL/zNdFw+wGY493Sm0aW1k/8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=0C6soHM81jnUAE4U4jlUBuZ4ELMO8fJ0pCjAQ9I8mBOpCNH54NdjMuHsOPbirucjs
         YnUy378pVY4KxyVtazh6sc0cghi3K745fzgcXqOQeVg1bhcFM0OkT9/Zv7gvGwsHbK
         i2Jj9RphnToZs/gurPxFur/r8vwU+++SYD1Al8j4=
Message-ID: <4f485a350db547fa7a9f5ef764a413b93564aef7.camel@kernel.org>
Subject: Re: [PATCH v6 RESEND 0/2] vfs: have syncfs() return error when
 there are writeback errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        andres@anarazel.de, willy@infradead.org, dhowells@redhat.com,
        hch@infradead.org, jack@suse.cz, david@fromorbit.com
Date:   Wed, 29 Apr 2020 08:23:37 -0400
In-Reply-To: <20200428164819.7b58666b755d2156aa46c56c@linux-foundation.org>
References: <20200428135155.19223-1-jlayton@kernel.org>
         <20200428164819.7b58666b755d2156aa46c56c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-04-28 at 16:48 -0700, Andrew Morton wrote:
> On Tue, 28 Apr 2020 09:51:53 -0400 Jeff Layton <jlayton@kernel.org> wrote:
> 
> > Just a resend since this hasn't been picked up yet. No real changes
> > from the last set (other than adding Jan's Reviewed-bys). Latest
> > cover letter follows:
> 
> I see no cover letter here.
> 
> > --------------------------8<----------------------------
> > 
> > v6:
> > - use READ_ONCE to ensure that compiler doesn't optimize away local var
> > 
> > The only difference from v5 is the change to use READ_ONCE to fetch the
> > bd_super pointer, to ensure that the compiler doesn't refetch it
> > afterward. Many thanks to Jan K. for the explanation!
> > 
> > Jeff Layton (2):
> >   vfs: track per-sb writeback errors and report them to syncfs
> >   buffer: record blockdev write errors in super_block that it backs
> 
> http://lkml.kernel.org/r/20200207170423.377931-1-jlayton@kernel.org
> 
> has suitable-looking words, but is it up to date?
> 

Thanks for picking this up, Andrew.

No, it's not. Since I wrote that, I dropped the ioctl and changed it
over to use a dedicated field in struct file instead of trying to
multiplex it for O_PATH descriptors. How about something like this?

---------------------------8<---------------------------

Currently, syncfs does not return errors when one of the inodes fails to
be written back. It will return errors based on the legacy AS_EIO and
AS_ENOSPC flags when syncing out the block device fails, but that's not
particularly helpful for filesystems that aren't backed by a blockdev.
It's also possible for a stray sync to lose those errors.

The basic idea in this set is to track writeback errors at the
superblock level, so that we can quickly and easily check whether
something bad happened without having to fsync each file individually.
syncfs is then changed to reliably report writeback errors after they
occur, much in the same fashion as fsync does now.

-- 
Jeff Layton <jlayton@kernel.org>

