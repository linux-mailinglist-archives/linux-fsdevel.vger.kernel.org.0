Return-Path: <linux-fsdevel+bounces-18375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C08B7BDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39311F2624A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DB17164D;
	Tue, 30 Apr 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCIuBI5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A95143749;
	Tue, 30 Apr 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491458; cv=none; b=pOa1aVxM9fYt8Jv3WOP01Bv4RLmV++JYGzV2OoIv0VZm2NHwV1v3I/E92iFEbwiLGR7oU0TuIb6xiW6RlOUmyJ80XUeVKY5iU4oPqlKEJV6lfqeZ9SEWTZFljDMwK9EgzvCs23GTPG6AgEHM7UOhjN8eHuaJQKT4iH9IW0iCj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491458; c=relaxed/simple;
	bh=xORt9UOknaSFIomTBlaOlmxJ4xrvI1EdljKTZ8SCzps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB1nsprJW7LKvp/u8N/LbZcRPm1zoy7kIwAcr1jo414dDnx/duuu1PW2gPwPo4W/XDYnkinNfE6nRuZuDG+v0BIJ8A/EhM/jxYfonZOLdQ846MC+OQXiTUvyi1cgcQvNttI5C8oIMruFDF/GbesrHlY9hjRWpY/puGEhBscbfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCIuBI5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF2CC2BBFC;
	Tue, 30 Apr 2024 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714491457;
	bh=xORt9UOknaSFIomTBlaOlmxJ4xrvI1EdljKTZ8SCzps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCIuBI5zLW1M4I9Y0u4VEmf9EcXCNdCBejkynkCh2yDAmvOgKliFQ6E5grkY9AHMT
	 1M3zWuByF5/hpiABu/wdyntQ0Cz+swqCQ6EgksFb5vkY+p3jeFFxeviX39iSl1fyKL
	 0fKWv+MAp2zq1zB7g65yzfv+OT0uLJRhf85Nz/PhDSPCF4PXEK1oElrF9wAdl6LIO6
	 B3Wz/uFeoulc4QXSjLjLbsgwqroaSOKTdw0jOeuM0dg5Mdqv7d+OJu9ao3hlQH1Y4v
	 RXGX6/yeSzcy1oFCjVi9/O2MpkFvKvLFW7omcccFcP+JihhR9osKCVb4IkxZ39CXQC
	 Mn9VCvYnleBqA==
Date: Tue, 30 Apr 2024 08:37:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, guan@eryu.me,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/6] xfs/122: adapt to fsverity
Message-ID: <20240430153737.GK360919@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688024.962488.13214660928692324111.stgit@frogsfrogsfrogs>
 <wrxpj5cduflmsthmgrlbdewpis5mkpz6rnrcsmgapybtznavxp@dryj5f364uxa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrxpj5cduflmsthmgrlbdewpis5mkpz6rnrcsmgapybtznavxp@dryj5f364uxa>

On Tue, Apr 30, 2024 at 02:45:29PM +0200, Andrey Albershteyn wrote:
> On 2024-04-29 20:41:34, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add fields for fsverity ondisk structures.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  tests/xfs/122.out |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > 
> > diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> > index 019fe7545f..22f36c0311 100644
> > --- a/tests/xfs/122.out
> > +++ b/tests/xfs/122.out
> > @@ -65,6 +65,7 @@ sizeof(struct xfs_agfl) = 36
> >  sizeof(struct xfs_attr3_leaf_hdr) = 80
> >  sizeof(struct xfs_attr3_leafblock) = 88
> >  sizeof(struct xfs_attr3_rmt_hdr) = 56
> > +sizeof(struct xfs_attr3_rmtverity_hdr) = 36
> >  sizeof(struct xfs_attr_sf_entry) = 3
> >  sizeof(struct xfs_attr_sf_hdr) = 4
> >  sizeof(struct xfs_attr_shortform) = 8
> > @@ -120,6 +121,7 @@ sizeof(struct xfs_log_dinode) = 176
> >  sizeof(struct xfs_log_legacy_timestamp) = 8
> >  sizeof(struct xfs_map_extent) = 32
> >  sizeof(struct xfs_map_freesp) = 32
> > +sizeof(struct xfs_merkle_key) = 8
> >  sizeof(struct xfs_parent_rec) = 12
> >  sizeof(struct xfs_phys_extent) = 16
> >  sizeof(struct xfs_refcount_key) = 4
> > 
> > 
> 
> Shouldn't this patch be squashed with previous one?

Actualy, the 122.out change in the previous patch is now wrong and can
go away.  These two changes are still relevant though.

--D

> -- 
> - Andrey
> 
> 

