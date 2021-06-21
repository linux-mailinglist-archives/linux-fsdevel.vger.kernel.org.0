Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF83AF249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 19:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFURu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFURu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:50:28 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D1C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 10:48:13 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvO1s-00AuY6-F6; Mon, 21 Jun 2021 17:48:12 +0000
Date:   Mon, 21 Jun 2021 17:48:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] what the hell is ->f_mapping->host->i_mapping thing about?
Message-ID: <YNDQ3I043bbqLU5r@zeniv-ca.linux.org.uk>
References: <YM/EcUZqqJ3RRu57@zeniv-ca.linux.org.uk>
 <YNDQPTAn/vpC4gBq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNDQPTAn/vpC4gBq@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:45:33AM -0700, Eric Biggers wrote:
> On Sun, Jun 20, 2021 at 10:42:57PM +0000, Al Viro wrote:
> > 	In do_dentry_open() we have the following weirdness:
> > 
> >         file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
> > 
> > What is it about?  How and when can ->f_mapping->host->i_mapping be *NOT*
> > equal to ->f_mapping?
> > 
> > It came from
> > commit 1c211088833a27daa4512348bcae9890e8cf92d4
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Wed May 26 17:35:42 2004 -0700
> > 
> >     [PATCH] Fix the setting of file->f_ra on block-special files
> > 	
> >     We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
> >     points at the right thing.  And we need to get it from
> >     inode->i_mapping->host->i_mapping too, which represents the underlying device.
> > 
> >     Also, don't test for null file->f_mapping in the O_DIRECT checks.
> > 
> > Sure, we need to set ->f_ra after ->open(), since ->f_mapping might be
> > changed by ->open().  No arguments here - that call should've been moved.
> > But what the hell has the last bit come from?  What am I missing here?
> > IDGI...
> > 
> > And that gift keeps giving -
> > fs/nfs/nfs4file.c:388:  file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
> > is a copy of that thing.  Equally bogus, AFAICT...
> 
> FWIW, I came to the same conclusion that just ->f_mapping would be sufficient:
> https://lkml.kernel.org/linux-fsdevel/20170326032128.32721-1-ebiggers3@gmail.com

Sorry, missed it back then ;-/
