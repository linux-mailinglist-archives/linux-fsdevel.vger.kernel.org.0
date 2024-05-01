Return-Path: <linux-fsdevel+bounces-18453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700FA8B91B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B84283260
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090031304A1;
	Wed,  1 May 2024 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnTrAT6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B641C72;
	Wed,  1 May 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603452; cv=none; b=hSQoRXpDwcz15i3/bZGQbh2UXEWi1CXCfFK+Ry9wGNNueb0fKnj9Vlw/xygK8lW0Seo+KEMED9YFBWNVj4fugYhn97oQbGQKRjifGkeSBfvqeV/I+haMR/jE//Y/BgnCLZeNYRL8tIpJGhUsaNye1DyQ8zGixridHn24WweRWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603452; c=relaxed/simple;
	bh=TKUvSSXsWS5zMUcu5OOtqpokgCKF2aW1Ohd7O4rztig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fffoXEIlaHCVWTSuRTs0TaVam7PVFjFL/140otyq12vp7VqxJFEd7ofXmXOAmeCUVLIuK4BAvbx2AdX3i/bRvqp/qp9IO95XOkDgKFkYSiBwQ/a43MrTAn+zvCkrR8m1UjpyVwkPdlwTHgWFdYjktke00ZPl29QRVAEPT96W6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnTrAT6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB5C113CC;
	Wed,  1 May 2024 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714603451;
	bh=TKUvSSXsWS5zMUcu5OOtqpokgCKF2aW1Ohd7O4rztig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnTrAT6hEm4fZhRznVzJj1Hsh7jkXc91s6fjnnc8O1O2oxWxKmUYuqBBoFsbNTLtX
	 vL+QL+hiC4tNDUbFNadXDXzhgV+54j6trZgDK0vDKcmvB55EuBeo8W/3s2sVNmvgE5
	 4mlPdJSj6rMqRx3VNF5IChEh0PXXEJTrp/H70NTd1hYkKG3nICBqmAigRYYCcCJVdi
	 fAeytEYx8G2P9T0anQhvmBkHPDwWbwHlrG9YJtA2DCUpi+4d0YRa/CW6OfWAEdHkxZ
	 Ae3mjafjYsgIAuHuLOjppgcFZdoID3M9YMd3qNAyiGwyUwJdX1V989vqVJfD/qgNek
	 MyAL8tYJTj2DQ==
Date: Wed, 1 May 2024 15:44:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/26] xfs: widen flags argument to the xfs_iflags_*
 helpers
Message-ID: <20240501224411.GK360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680584.957659.3744585033664433370.stgit@frogsfrogsfrogs>
 <ZjHnJpG5MOQU6WYP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHnJpG5MOQU6WYP@infradead.org>

On Tue, Apr 30, 2024 at 11:54:30PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 29, 2024 at 08:27:29PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > xfs_inode.i_flags is an unsigned long, so make these helpers take that
> > as the flags argument instead of unsigned short.  This is needed for the
> > next patch.
> > 
> > While we're at it, remove the iflags variable from xfs_iget_cache_miss
> > because we no longer need it.
> 
> I just reinvented this for another flag in work in progress code.
> Can we just get included in the current for-next tree?

Chandan?  Any thoughts on pushing this for 6.10?

--D

