Return-Path: <linux-fsdevel+bounces-42591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A8A4487A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5A416C4A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6C1A0B08;
	Tue, 25 Feb 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyyPMrdm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055A17B418;
	Tue, 25 Feb 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504567; cv=none; b=jbLYuiRu00EOsi7iqg+gLlm8d1za2cZKUx7LmKAm2emKl8QDDq/WL68IJkEW1IvYgudKjs3SiL6/i52r49p5p/UA6//4JkVvLmGBDmTcrWM4K4G6YC1TuqYjSwq+X3CjcDOqsyXTg30XJAss9wW51VIEPxbp0vc4FPtLCoLklng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504567; c=relaxed/simple;
	bh=3Rqh7c0axEAODu64/2c4AI+tEiP1L/g+oD+X2VodFyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWgIHw5dwRdkaTlaqO/SDJ4L3xKSvPqRBnzOgtxT2TEDggL9JSG4vCHGaAYOgrQvs+Dx9vqI1vxTF5cpe45Mk8r5WkVz2hJEApgIn4tVcPHSn1a7wFoVk4H64SzhHpQzrOIq09ca3W+QCAbCWtfDe50CW/XUfHqii+WfGLyws88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyyPMrdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DEFC4CEDD;
	Tue, 25 Feb 2025 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740504566;
	bh=3Rqh7c0axEAODu64/2c4AI+tEiP1L/g+oD+X2VodFyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyyPMrdmLYXOoyCK6Ho8lTd+kBax1fiwRnTClqOfh5z7d64bPUvjpp51ZjfiftmR2
	 bw0i/O5KepNu2eYOah45rrdeLhRyPdFqHbWg/baVucYGxuXGezg4VqSY2Bu9QiAp63
	 gtROThv0H8KaX+g0a8oFW45hdcDc1598ao9AtyKxch9a/i0pxz7EH84YCVNHX162Z7
	 R9yJGyY3RLhbmINz7z2vD927jJwM11JAL45fLzmOf50D+PTCVjyWkgd3a8qGJsE5c2
	 /QlT6OsByvuHdw2ilwq7Yn6khcJtW09bdylBx+kNROUXvGWV7mL1/VPOw8ILPtEaNH
	 shyFWkWqEXZig==
Date: Tue, 25 Feb 2025 09:29:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 03/11] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250225172926.GC6242@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-4-john.g.garry@oracle.com>
 <20250224202609.GH21808@frogsfrogsfrogs>
 <0c8ba9d8-5a52-4658-abc8-00c05ba84585@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c8ba9d8-5a52-4658-abc8-00c05ba84585@oracle.com>

On Tue, Feb 25, 2025 at 10:01:32AM +0000, John Garry wrote:
> On 24/02/2025 20:26, Darrick J. Wong wrote:
> > > +	if (error)
> > > +		return error;
> > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_ijoin(tp, ip, 0);
> > > +
> > > +	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
> > Overly long line, but otherwise looks fine.
> 
> The limit is 80, right? That line fills out to 80.

Ah, right, forgot that I have vim set up to display the right margin at
72 for emails.

--D

> > With that fixed,
> > Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>
> > 
> 
> cheers
> 
> 

