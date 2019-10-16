Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB7D8519
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbfJPAwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 20:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfJPAwe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:52:34 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBB62067B;
        Wed, 16 Oct 2019 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571187154;
        bh=A/u6kf+idGmi0psouuwo2uYEmwrcJV3/rAZxg91qHqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r19ysU3rAAeZjA20PGXZfcyCuNTanJ//ncuAzJyhWwBqaGSRbFW87Etnhh8gO5p44
         2UlV1lUL06p7snIdPhtRNozDVafNOXaOyFxXmQrpz71aQVNJAsm0+N+Z0ihPQBLn7y
         ekjRiYktKe+zcw1od2VAC5IRwSB1OUpLjQKSAPUo=
Date:   Tue, 15 Oct 2019 17:52:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20191016005232.GA726@sol.localdomain>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
 <20190613084728.GA32129@miu.piliscsaba.redhat.com>
 <20190709230029.GO641@sol.localdomain>
 <20190710003113.GC17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710003113.GC17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 10, 2019 at 01:31:13AM +0100, Al Viro wrote:
> On Tue, Jul 09, 2019 at 04:00:29PM -0700, Eric Biggers wrote:
> 
> > > index 49a058c73e4c..26f74e092bd9 100644
> > > --- a/fs/pnode.h
> > > +++ b/fs/pnode.h
> > > @@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
> > >  void propagate_mount_unlock(struct mount *);
> > >  void mnt_release_group_id(struct mount *);
> > >  int get_dominating_id(struct mount *mnt, const struct path *root);
> > > -unsigned int mnt_get_count(struct mount *mnt);
> > > +int mnt_get_count(struct mount *mnt);
> > >  void mnt_set_mountpoint(struct mount *, struct mountpoint *,
> > >  			struct mount *);
> > >  void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
> > 
> > Miklos, are you planning to send this as a formal patch?
> 
> Hold it for a while, OK?  There's an unpleasant issue (a very long-standing
> one) with boxen that have an obscene amount of RAM.  Some of the counters
> involved will need to become long.  This is the coming cycle fodder (mounts
> and inodes are relatively easy; it's dentry->d_count that brings arseloads
> of fun) and I'd rather deal with that sanity check as part of the same series.
> It's not forgotten...  Patch series re limiting the number of negative
> dentries is also getting into the same mix.  Watch #work.dcache - what's
> in there is basically prep work for the big pile for the next cycle; it'll
> be interesting...

Al, whatever happened to the refcounting patches you mentioned here?

- Eric
