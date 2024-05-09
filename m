Return-Path: <linux-fsdevel+bounces-19182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE28C1131
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958C62840DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421915D5B3;
	Thu,  9 May 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cawJGNe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25115E5C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264897; cv=none; b=EqS3AOLhW5ab2qZP/nsCYXiJ6Ch/+62D7wokgJrnyyt7y0CJB2qV2jiSElzAe06qfgtEy2+Fvp9ogUSis5TNHle9Us6xb61JllROx3PpszxbopiPMVYfNvkKPbYr3Z+2w2lQcfvSf/pDyxy7IUAJ7mEaaszSvwADUh2J1fdhd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264897; c=relaxed/simple;
	bh=+YPP9+BggJFoYB3OD65EZx6HjxZ1o2jxBDWw0R+cqj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kevR3TnbbBi84g+wbPDKtGSP5i2PPQ7ipUbOM/HMdAs8xbokxN5ZHOJpUd1aNFu4aTWz3O/qgEnrel9GK0YMvOovFOM46xLa8RDMgmolNSKVxHrGBCfKsYEmn3U2mMIpra2nEpxNqM3JffFiVIqnoQxtFf+nISfuK4BMq+5pxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cawJGNe+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449ERwoB009927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715264880; bh=jq0TZsLOmYSoh8JU0VF8GO2rVGj9OrG945KmZdEE1S0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cawJGNe+z/IfsOLNwFcgyS8ipx4KDElwEt9kw+xuqgMqCrQohCvrQanuHF2/zZkQ6
	 9n9vN2q/VCEfnCl2ex8XgqOxBrZZNL02MYTGhCco/eWvNMCqngXYlAnysWIK4pqX1y
	 map4HFbDzZDV98i+Y1aG/wqMvhJIH8MTJy7sZPyW866DVJ3ikzgLBd9PTRwBG5Ad6K
	 Rni94ZWtJcJjNnr2799gE0lUl1LnU0kR4zC/8xVGYAfRJgssJkvhnYZOdrnmS8iJZv
	 Ah2oHqEbAbtKamUHbchimfQAzocxKGuyi1H2CdEttp/3a92J2N82xFWBldrnww40fm
	 LaZMYhb2BANXw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1F5D815C026D; Thu, 09 May 2024 10:27:58 -0400 (EDT)
Date: Thu, 9 May 2024 10:27:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>,
        Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>,
        Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL
 support
Message-ID: <20240509142758.GG3620298@mit.edu>
References: <1553599.1715262072@warthog.procyon.org.uk>
 <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>

On Thu, May 09, 2024 at 03:47:27PM +0200, Miklos Szeredi wrote:
> On Thu, 9 May 2024 at 15:41, David Howells <dhowells@redhat.com> wrote:
> 
> > diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> > index ef4c19e5f570..566625286442 100644
> > --- a/fs/ext4/acl.h
> > +++ b/fs/ext4/acl.h
> > @@ -71,7 +71,8 @@ ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
> >         /* usually, the umask is applied by posix_acl_create(), but if
> >            ext4 ACL support is disabled at compile time, we need to do
> >            it here, because posix_acl_create() will never be called */
> > -       inode->i_mode &= ~current_umask();
> > +       if (!S_ISLNK(inode->i_mode))
> > +               inode->i_mode &= ~current_umask();
> 
> I think this should just be removed unconditionally, since the VFS now
> takes care of mode masking in vfs_prepare_mode().

The following is in the ext4 tree:

commit c77194965dd0dcc26f9c1671d2e74e4eb1248af5
Author: Max Kellermann <max.kellermann@ionos.com>
Date:   Fri Mar 15 15:29:56 2024 +0100

    Revert "ext4: apply umask if ACL support is disabled"
    
    This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
    commit caused a regression because now the umask was applied to
    symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
    has been fixed somewhere else already.
    
    Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
    Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
    Reviewed-by: Christian Brauner <brauner@kernel.org>
    Tested-by: Michael Forney <mforney@mforney.org>
    Link: https://lore.kernel.org/r/20240315142956.2420360-1-max.kellermann@ionos.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>


