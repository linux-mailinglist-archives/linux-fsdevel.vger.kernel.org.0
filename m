Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97C1D9D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgESRDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 13:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRDt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 13:03:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01F120708;
        Tue, 19 May 2020 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907828;
        bh=xbj4MKDaCQ/uq8PfAJ4JLhs4zm+BOFwwLkxXtJGNpRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4PuJalfL2SwbUTdnUodUzcp+f41a2ge99eJTrO6kfYTyLHJWF96dQSI/a8xRkwMs
         1Q6o4brIC0ng5v2SQMyLhTNO/JSB63X6UOWT52Wl60j/hmtTpCts5SHLjID4FZF8gq
         qE4tcCxgB9RfvgwyMA8VtkKqCGOQSXBexbE9Ytw4=
Date:   Tue, 19 May 2020 19:03:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200519170346.GB1064707@kroah.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519144408.GA737365@kroah.com>
 <20200519155210.GU11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519155210.GU11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 03:52:10PM +0000, Luis Chamberlain wrote:
> On Tue, May 19, 2020 at 04:44:08PM +0200, Greg KH wrote:
> > On Sat, May 16, 2020 at 03:19:54AM +0000, Luis Chamberlain wrote:
> > >  struct dentry *blk_debugfs_root;
> > > +struct dentry *blk_debugfs_bsg = NULL;
> > 
> > checkpatch didn't complain about "= NULL;"?
> 
> Will remove.
> 
> > > +static void queue_debugfs_register_type(struct request_queue *q,
> > > +					const char *name,
> > > +					enum blk_debugfs_dir_type type)
> > > +{
> > > +	struct dentry *base_dir = queue_get_base_dir(type);
> > 
> > And it could be a simple if statement instead.
> > 
> > Oh well, I don't have to maintain this :)
> 
> I'll just use that, but yeah I think its a matter of preference.
> 
> > > +/**
> > > + * blk_queue_debugfs_register - register the debugfs_dir for the block device
> > > + * @q: the associated request_queue of the block device
> > > + * @name: the name of the block device exposed
> > > + *
> > > + * This is used to create the debugfs_dir used by the block layer and blktrace.
> > > + * Drivers which use any of the *add_disk*() calls or variants have this called
> > > + * automatically for them. This directory is removed automatically on
> > > + * blk_release_queue() once the request_queue reference count reaches 0.
> > > + */
> > > +void blk_queue_debugfs_register(struct request_queue *q, const char *name)
> > > +{
> > > +	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BASE);
> > > +}
> > > +EXPORT_SYMBOL_GPL(blk_queue_debugfs_register);
> > > +
> > > +/**
> > > + * blk_queue_debugfs_unregister - remove the debugfs_dir for the block device
> > > + * @q: the associated request_queue of the block device
> > > + *
> > > + * Removes the debugfs_dir for the request_queue on the associated block device.
> > > + * This is handled for you on blk_release_queue(), and that should only be
> > > + * called once.
> > > + *
> > > + * Since we don't care where the debugfs_dir was created this is used for all
> > > + * types of of enum blk_debugfs_dir_type.
> > > + */
> > > +void blk_queue_debugfs_unregister(struct request_queue *q)
> > > +{
> > > +	debugfs_remove_recursive(q->debugfs_dir);
> > > +}
> > 
> > Why is register needed to be exported, but unregister does not?  Does
> > some driver not properly clean things up?
> 
> Is the comment on blk_queue_debugfs_register() not sufficient?

Ah, hm, ok, I guess so.

> I thought I was going overboard with how clear this was.  Should I also
> add a note here on unregister?

Not really, it's fine, thanks.

greg k-h
