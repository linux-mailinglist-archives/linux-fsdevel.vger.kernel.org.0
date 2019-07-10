Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF41A63E9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 02:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfGJAbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 20:31:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52794 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGJAbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 20:31:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hl0Vt-0006xX-8J; Wed, 10 Jul 2019 00:31:13 +0000
Date:   Wed, 10 Jul 2019 01:31:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20190710003113.GC17978@ZenIV.linux.org.uk>
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
 <20190613084728.GA32129@miu.piliscsaba.redhat.com>
 <20190709230029.GO641@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709230029.GO641@sol.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 04:00:29PM -0700, Eric Biggers wrote:

> > index 49a058c73e4c..26f74e092bd9 100644
> > --- a/fs/pnode.h
> > +++ b/fs/pnode.h
> > @@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
> >  void propagate_mount_unlock(struct mount *);
> >  void mnt_release_group_id(struct mount *);
> >  int get_dominating_id(struct mount *mnt, const struct path *root);
> > -unsigned int mnt_get_count(struct mount *mnt);
> > +int mnt_get_count(struct mount *mnt);
> >  void mnt_set_mountpoint(struct mount *, struct mountpoint *,
> >  			struct mount *);
> >  void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
> 
> Miklos, are you planning to send this as a formal patch?

Hold it for a while, OK?  There's an unpleasant issue (a very long-standing
one) with boxen that have an obscene amount of RAM.  Some of the counters
involved will need to become long.  This is the coming cycle fodder (mounts
and inodes are relatively easy; it's dentry->d_count that brings arseloads
of fun) and I'd rather deal with that sanity check as part of the same series.
It's not forgotten...  Patch series re limiting the number of negative
dentries is also getting into the same mix.  Watch #work.dcache - what's
in there is basically prep work for the big pile for the next cycle; it'll
be interesting...
