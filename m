Return-Path: <linux-fsdevel+bounces-18379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D88B7C16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E341F215C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D4174ED7;
	Tue, 30 Apr 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llqJPRiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466F171E71;
	Tue, 30 Apr 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492184; cv=none; b=GNcG1UNglZhTsIWEjG31uyg1Od67VxUCz2c6dcg20IgPLxgQAWQiV0xHCp60LA9r8CS+Zyxoa7NkU2sFEcp7T30wQHtRapkhTzI6dbw3B9BAMUlaS0TIVmHTYCs4vhhXkKTyHVkDa13A1mXGifloUEBo/xO2A7GN2G5pxIHXJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492184; c=relaxed/simple;
	bh=3gbWhRsG+Xg32poFwLk/OffykPSizogunyd76sMn5gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLr6XiG2cmqqMqOdzNBeO4X+w0gQ+PN6SlFfSxLiVa5mhszhmbUucnkg92La2NuZThEh91dy9B1kwtAj0yBEGZOxaf2o3ovN71RDr+ha0xMtYqa3o91Pye3+Gmi8wwmEKNOyEoDaDLg7PmrgE9ywxaA42srshK7ceLuFsiILE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llqJPRiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02120C4AF18;
	Tue, 30 Apr 2024 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714492184;
	bh=3gbWhRsG+Xg32poFwLk/OffykPSizogunyd76sMn5gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llqJPRiPmEzDjiPJ6t5NNg7qPe/H2I8BPytG3dE3RmlwueHTPVD1ioCN65Xeyg42a
	 3EHQpiRaONk1AVjUkeFVnXwXGFCZcwvUzkrjYzklc3CUne/9du0sjLmPXfeI2HXrBl
	 uwXa2phEvayeId7v/D0u23XSsvug6IfGhwKHKn6daxB+fsEMwDsQNr26Xa2qFxs3gk
	 I2YitE/JrscolKsBIi9jU+iBW2sCp53ogwLWDx3rkLeGFWC0mubvXtHVHEn/VqU3Qk
	 7YNxMvB0+PQOTM4xCJobWlp/z+gsnAan9HdKXNOxIfuYgNS34pu0QTJsORm5Ku0VCZ
	 yuCkQfEpb7VcQ==
Date: Tue, 30 Apr 2024 08:49:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, guan@eryu.me,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 6/6] common/populate: add verity files to populate xfs
 images
Message-ID: <20240430154943.GN360919@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688070.962488.15915265664424203708.stgit@frogsfrogsfrogs>
 <jalepm6lu3nwy4bext62pj2fii6s2iknkgbsh5p3ltz65yeqcs@5z4s72utnopv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jalepm6lu3nwy4bext62pj2fii6s2iknkgbsh5p3ltz65yeqcs@5z4s72utnopv>

On Tue, Apr 30, 2024 at 03:22:50PM +0200, Andrey Albershteyn wrote:
> On 2024-04-29 20:42:21, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > If verity is enabled on a filesystem, we should create some sample
> > verity files.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  common/populate |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > 
> > diff --git a/common/populate b/common/populate
> > index 35071f4210..ab9495e739 100644
> > --- a/common/populate
> > +++ b/common/populate
> > @@ -520,6 +520,30 @@ _scratch_xfs_populate() {
> >  		done
> >  	fi
> >  
> > +	# verity merkle trees
> > +	is_verity="$(_xfs_has_feature "$SCRATCH_MNT" verity -v)"
> > +	if [ $is_verity -gt 0 ]; then
> > +		echo "+ fsverity"
> > +
> > +		# Create a biggish file with all zeroes, because metadump
> > +		# won't preserve data blocks and we don't want the hashes to
> > +		# stop working for our sample fs.
> 
> Hashes of the data blocks in the merkle tree? All zeros to use
> .zero_digest in fs-verity? Not sure if got this comment right

Oooh, yeah, I need to go check that.  The block elision code might be
neutralizing this.

--D

> > +		for ((pos = 0, i = 88; pos < 23456789; pos += 234567, i++)); do
> > +			$XFS_IO_PROG -f -c "pwrite -S 0 $pos 234567" "$SCRATCH_MNT/verity"
> > +		done
> > +
> > +		fsverity enable "$SCRATCH_MNT/verity"
> > +
> > +		# Create a sparse file
> > +		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/sparse_verity"
> > +		fsverity enable "$SCRATCH_MNT/sparse_verity"
> > +
> > +		# Create a salted sparse file
> > +		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/salted_verity"
> > +		local salt="5846532066696e616c6c7920686173206461746120636865636b73756d732121"	# XFS finally has data checksums!!
> > +		fsverity enable --salt="$salt" "$SCRATCH_MNT/salted_verity"
> > +	fi
> > +
> >  	# Copy some real files (xfs tests, I guess...)
> >  	echo "+ real files"
> >  	test $fill -ne 0 && __populate_fill_fs "${SCRATCH_MNT}" 5
> > 
> 
> -- 
> - Andrey
> 
> 

