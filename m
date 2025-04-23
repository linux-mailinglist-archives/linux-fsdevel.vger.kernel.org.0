Return-Path: <linux-fsdevel+bounces-47060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9034A98353
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40B01B64CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746827BF9E;
	Wed, 23 Apr 2025 08:19:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17E27935D;
	Wed, 23 Apr 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396350; cv=none; b=AaKx4xsFHY67R5bzkzvHEteSX5Hfe+9PlKa100POk4dpM9wSKfmukZwK0qpbc812xDa0rit/jI/NGG25KLc6H9BdGe3LiIv310dzi6hQH6YQCJbeMh+PRiIgwPy4IwL5iYokx5GtqGbOwbUvWUs9N78JDW7Cjfe5168BH5Yx3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396350; c=relaxed/simple;
	bh=lgSGQleS8nlGKrOWWS9LmY+nF3u22Ri85AHSqBlXTyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elxLpuQ9Q0f/ba4Mi3O3gxjPLu0TNeEvB/hRBG8qY2dkV1EqjTloKBxBBHEvTs+nN8DOmsnFYHNXKSO5B4hnhamY1NnNkhh7a2rQDIdCBpIhBy9S3T+kdUlMOEoTy/+cT6Nl/yJ+em2OLN6SFVxwVjk68Ejikn4OllmhcgfQK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 15CED68C4E; Wed, 23 Apr 2025 10:19:03 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:19:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250423081902.GD28307@lst.de>
References: <20250415121425.4146847-1-john.g.garry@oracle.com> <20250415121425.4146847-12-john.g.garry@oracle.com> <20250421040002.GU25675@frogsfrogsfrogs> <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com> <20250421164241.GD25700@frogsfrogsfrogs> <20250423054251.GA23087@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423054251.GA23087@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 07:42:51AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 21, 2025 at 09:42:41AM -0700, Darrick J. Wong wrote:
> > Well it turns out that was a stupid question -- zoned=1 can't be enabled
> > with reflink, which means there's no cow fallback so atomic writes just
> > plain don't work:
> 
> Exactly.  It is still on my todo list to support it, but there are a
> few higher priority items on it as well, in addition to constant
> interruptions for patch reviews :)

Actually, for zoned we don't need reflink support - as we always write
out place only the stuffing of multiple remaps into a single transaction
is needed.  Still no need to force John to do this work, I can look into
this (probably fairly trivial) work once we have good enough test cases
in xfstests that I can trust them to verify I got things right.

