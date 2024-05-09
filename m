Return-Path: <linux-fsdevel+bounces-19197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0D8C1224
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24EE1F2206E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DD16F27F;
	Thu,  9 May 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEnjTcis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717112FF9B;
	Thu,  9 May 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269405; cv=none; b=FfisGE6dFN1CsiO2jiQHJvKwIXztQ680RDkogHCOpz15J3427RfjXDgWeB9idpDzSuPQ2YCiW9OuMLj3PR/Wz0IJvYLNdhAKZBxDaSf3Ez39DSXI5XIKQy39kB6jBvWC20ac8q2E/P0yuL0wMGNEvXlXv2qkerMI9+1W0el5X4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269405; c=relaxed/simple;
	bh=207D5gedUS0H7dOrIEonnPzjDRf/Z+vBpczF3w0EEjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXyAskgSdIJAdRyxEca0DUw+zMHKj6D+lE6mzu+mB3JnvTbeCrffUT4bW/ZNEOWc3L+SZFxRpT9GMdr/CMtijw6qS/fKwB4unbE2P0jgMmkjgxT725wKJR2e0fRUbmxQzyyRvtDhvkhLNxcYVoRvJMxHEizOabyqSenRYu3eIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEnjTcis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E10EC116B1;
	Thu,  9 May 2024 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269404;
	bh=207D5gedUS0H7dOrIEonnPzjDRf/Z+vBpczF3w0EEjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEnjTcisbonIWJXJPbBuslJmKmyDhwtp3BuV0PYOxLqK8pb2YG70xFQYZBRQJ9aSQ
	 H0vQf8qzNfD0DeSf0WLArQnOoNxRPQOpsLbHI1Dk1zL1fkkChd3EhSqTP9NtvLj82p
	 FPJPGYfvinQtzf5r0Im4rv/yhAcBilugNumN4BlBqqHTjIkgoDrSKrEFZ+D6kZuC7q
	 80p3ZMcqY5PqS08ZlNFTBXhisi1bv1ptmiLRlpSoaLfPqQ9UjDtTusmMODQPEpAbuE
	 LCbPFT6FGHmI4pvMvzOaEG/D8BBO3m3jkFdVxAhqHF0ZDdJtD0hqvQ9Q3TD7f5keIJ
	 5GWhYBSzzOtAQ==
Date: Thu, 9 May 2024 08:43:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <20240509154323.GM360919@frogsfrogsfrogs>
References: <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
 <ZjxZRShZLTb7SS3d@infradead.org>
 <20240509144542.GJ360919@frogsfrogsfrogs>
 <Zjzmho9jm2wisUPj@infradead.org>
 <20240509150955.GL360919@frogsfrogsfrogs>
 <ZjzoLKev1WqnsBx-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzoLKev1WqnsBx-@infradead.org>

On Thu, May 09, 2024 at 08:13:48AM -0700, Christoph Hellwig wrote:
> On Thu, May 09, 2024 at 08:09:55AM -0700, Darrick J. Wong wrote:
> > xfs doesn't do data block checksums.
> > 
> > I already have a dumb python program that basically duplicates fsverity
> > style merkle trees but I was looking forward to sunsetting it... :P
> 
> Well, fsverity as-is is intended for use cases where you care about
> integrity of the file.  For that disabling it really doesn't make
> sense.  If we have other use cases we can probably add a variant
> of fsverity that clearly deals with non-integrity checksums.
> Although just disabling them if they mismatch still feels like a
> somewhat odd usage model.

Yeah, it definitely exists in the same weird grey area of turning off
metadata checksum validation to extract as many files from a busted fs
as can be done.

--D

