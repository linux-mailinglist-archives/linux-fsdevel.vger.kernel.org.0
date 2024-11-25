Return-Path: <linux-fsdevel+bounces-35774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD79D847D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936EB162EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4D187555;
	Mon, 25 Nov 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVBWqhOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2A10F7;
	Mon, 25 Nov 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534250; cv=none; b=ELKSprdAxmXKc8EwEhCPXmVmgUFs3f0RylPXP+/LOinFUZtNiAxpsYVGRNOdsdgB90TPrtV6/9Dpurf3wM4xi8oqjoE0RFzoeYLyfIUlkKT0VyLV6+/yqIGpJXimz5InQ21KqtIsfVsGeZJd0sQTZmT2HM5rFvLOZsYntOzyjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534250; c=relaxed/simple;
	bh=5I7iOk6jgZYd0vq9ViLDLDnXfCsbptXPDnwrVU4rLko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOqsyI+2UrqDWx4590fLMtnd8oFk+Ru+R4dRlTkooc/ifCa1CXy+6a7xHc/r1wTtGwxBeBGlyE5P4oa6olp1ZQMPJN5UcFSE5IGtkebSfOWmZHQfizHLHZ303MchDTp4JF4cJf8n+6R/2ncrQ4hB2H+JaThEKep3GssxW+eewxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVBWqhOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AABCC4CECE;
	Mon, 25 Nov 2024 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732534250;
	bh=5I7iOk6jgZYd0vq9ViLDLDnXfCsbptXPDnwrVU4rLko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVBWqhOfL4LZDVYIImXYBZc/b0smEHHfBl4N+u9iiRtQEUOWNjm64oeN2+JhmhS2s
	 tDEjm70MZ+tubVQ1GBN8B4uXP2NRHoETUEmW8ELkCMUMq1TvlvK9DgHWlBlSGjv9PW
	 Jmtk4dHEYtk8H6Bga4eIwaX6XEL+5QmliIgZC4VliFkvSJmy8BbN7/lWZ5Rcgz4qnS
	 TWJdce/AORnrj8vWvz6zjTkEdFLkkISuU4+Y/l5tczjSDvXmNfc9o+YybbgGzIdAM6
	 G1Ku3jPoMro3w55uIwsjJtV9NgV5C4Z0Zokrkx1Z2VMXec6f55m4KjQtpV7+Shk9Gv
	 MJngs702k12cw==
Date: Mon, 25 Nov 2024 12:30:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] ovl: avoid pointless cred reference count bump
Message-ID: <20241125-pfand-lawinen-b1f6acd98342@brauner>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-18-f352241c3970@kernel.org>
 <CAOQ4uxhmzShcqBjY-HhHH7JhSpxJ9BVGe1H6C3w-=FcH_fUJQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhmzShcqBjY-HhHH7JhSpxJ9BVGe1H6C3w-=FcH_fUJQg@mail.gmail.com>

On Sun, Nov 24, 2024 at 03:59:40PM +0100, Amir Goldstein wrote:
> On Sun, Nov 24, 2024 at 2:44 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > No need for the extra reference count bump.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/copy_up.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 439bd9a5ceecc4d2f4dc5dfda7cea14c3d9411ba..39f08531abc7e99c32e709a46988939f072a9abe 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -741,17 +741,15 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
> >                 return err;
> >
> >         if (cc->new)
> > -               cc->old = override_creds(get_new_cred(cc->new));
> > +               cc->old = override_creds(cc->new);
> >
> >         return 0;
> >  }
> >
> >  static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
> >  {
> > -       if (cc->new) {
> > +       if (cc->new)
> >                 put_cred(revert_creds(cc->old));
> > -               put_cred(cc->new);
> > -       }
> 
> Same comment here, I think this will read more clearly as
>                revert_creds(cc->old));
>                put_cred(cc->new);
> 
> and better reflects the counterpart of ovl_prep_cu_creds().

Ok, done.

