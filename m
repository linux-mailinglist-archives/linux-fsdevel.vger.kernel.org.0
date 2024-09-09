Return-Path: <linux-fsdevel+bounces-28946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A81971A37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 15:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14D82864A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD151B81C7;
	Mon,  9 Sep 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSkYCQVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE21F942;
	Mon,  9 Sep 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886871; cv=none; b=rbzQI1v4yElcm3ZowFpfj7VYcV9ICitMTtOq+0SVwGEPHejDQfZec25Z7F6/FgFGkQf9NHD2k0+u/TnOGOuyUwMTDRvLm66myco7ug391XOBbISlkp6QzkbR/omLBRKSCZ8cKRDwq4n9bKrRtN5LlVm0+RY1h67UdZVvt7r33Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886871; c=relaxed/simple;
	bh=LstzvHjrnqTCggL5xnNIDoAEnRl3AQ9Gx2qh2MrSAJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1vnb410hzWdKXKKkcDPmvD2gH+wFKpmKIkglulp+KUkl7rWhgPilcUQuo2wqD4yfzZUfeI9YsaAlNmi/fAsFlWaDspdLeixcOYVLTW/7HgFIXWlixl3EZ7KLnTcCEWjWbhvuXzDhAl/Pgm3THc6cigxjisUIOlFYH2N2Wj2LCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSkYCQVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F8FC4CEC5;
	Mon,  9 Sep 2024 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886869;
	bh=LstzvHjrnqTCggL5xnNIDoAEnRl3AQ9Gx2qh2MrSAJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSkYCQVb5GNvcIg0Ra+c8oDiO6iLkzV4bOW/eQfdH9mogvsAL/omTfXzWZx7aSRDJ
	 SKA4yaqNHnGgwjox94evLUQr15B8kbJHCJGIISpJc28/LBAqW9K1phD0wmxdtXjChv
	 lCx7wzV4kp1KxZ5HMYAoyoLn6O1dqa65Nb65DY+Iwi4xvOHpdRAi2DDDULpISxSQCM
	 M14rb24lYGi6schqoauiZ9txQH3nRVw8xoUrFVIxZttpDA4VQyoaDprx+1ianiyq+s
	 V3DtQlcx4ihsP3fw4E8TnRC+LKpKFObjgWUeph2mcGqEtrcA9EM6+IhMRA82F2oX+d
	 HkO+9l0Tr2trg==
Date: Mon, 9 Sep 2024 15:01:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Seth Forshee <sforshee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
Message-ID: <20240909-tugend-weiten-13e04fec5f48@brauner>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
 <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>
 <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>

On Mon, Sep 09, 2024 at 02:57:51PM GMT, Christian Brauner wrote:
> On Fri, Sep 06, 2024 at 04:34:52PM GMT, Alexander Mikhalitsyn wrote:
> > Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b3c1c49a2645@brauner/
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> >  fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
> >  include/linux/mnt_idmapping.h |  1 +
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index 3c60f1eaca61..cbca6500848e 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap = {
> >  };
> >  EXPORT_SYMBOL_GPL(nop_mnt_idmap);
> >  
> > +/*
> > + * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
> > + * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
> > + */
> > +struct mnt_idmap invalid_mnt_idmap = {
> > +	.count	= REFCOUNT_INIT(1),
> > +};
> > +EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
> > +
> >  /**
> >   * initial_idmapping - check whether this is the initial mapping
> >   * @ns: idmapping to check
> > @@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
> >  
> >  	if (idmap == &nop_mnt_idmap)
> >  		return VFSUIDT_INIT(kuid);
> > +	if (idmap == &invalid_mnt_idmap)
> > +		return INVALID_VFSUID;
> 
> Could possibly deserve an:
> 
> if (unlikely(idmap == &invalid_mnt_idmap))
> 	return INVALID_VFSUID;
> 
> and technically I guess we could also do:
> 
> if (likely(idmap == &nop_mnt_idmap))
> 	return VFSUIDT_INIT(kuid);
> 
> but not that relevant for this patch.

Forgot:

Reviewed-by: Christian Brauner <brauner@kernel.org>

