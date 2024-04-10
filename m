Return-Path: <linux-fsdevel+bounces-16618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29C89FFEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 20:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20C51F28B2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69401DA4E;
	Wed, 10 Apr 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGySrAye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F65C8FF;
	Wed, 10 Apr 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774373; cv=none; b=uo/EXP0QOdV/2cfM5atVQNIavv6Xq0E4W1JqcNjs19I6wQHZx1WXnZmPekn37qA/DoXRN0H3d5EpFrbzTOHp0Apsw0G4aIPcf7cvIFzGu655qvZ0fc0Jgxgry2Di1RpCV7Vup5ZP04451SJexWAa27Hcv5RIsPKeNM1mtDfx7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774373; c=relaxed/simple;
	bh=bt9nE+uqm+xn3ie0EuHeXa3SkfN+5KGQxLMVr4pfyIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpRwHg6EytbHgNn1QsR5gsN3aAdY6m+wBxBiZr1ToIEy/FYk75gqYN6YemNaflfkXuBO2tOixB81OcCZTgRNFgMUpP52lkXmJP4lIlyVjnN3rrTSPWq+7otuG+7jL0AH3v8SWbRBj2ItdW1HlGH0Bhaew4adrNSMiMsDu3qTrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGySrAye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B483DC433C7;
	Wed, 10 Apr 2024 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712774371;
	bh=bt9nE+uqm+xn3ie0EuHeXa3SkfN+5KGQxLMVr4pfyIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGySrAye9kFUxQolgsBjkXQ07/pV0jjs52gIUSm6kQd1VS63ndnY1KRsAxYD9Kf0x
	 8YXU768JeaAFZFC4wbBtXy7VTSu5nMeacpR1nUJwaRMb1gXFdvTIRoSqj5ewrF46hs
	 2eRR0t8RDNfodMoVpTPper52F4tNmVtgACDCisa5S0iA+3bz8L9HbLwwVVMT9izx2m
	 gG4B+4L2lZfSGTlSdpEKdn5eGRplLwXEw7XiJyUKVZyU3Ah/40y4v1XNMSj1zczRTX
	 hqgJMMxqlh8H85r1ZB29pdJrdSv93mBhwDit+02NtHMbf+W3tErQMLZBCa0L51PD5N
	 ZcGaouzzJoKew==
Date: Wed, 10 Apr 2024 11:39:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/14] xfs: capture inode generation numbers in the
 ondisk exchmaps log item
Message-ID: <20240410183931.GX6390@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
 <20240410000528.GR6390@frogsfrogsfrogs>
 <20240410040058.GA1883@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410040058.GA1883@lst.de>

On Wed, Apr 10, 2024 at 06:00:58AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 09, 2024 at 05:05:28PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Per some very late review comments, capture the generation numbers of
> > both inodes involved in a file content exchange operation so that we
> > don't accidentally target files with have been reallocated.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> > I'm throwing this one on the pile since I guess it's not so hard to add
> > the generation number to a brand new log item.
> 
> It does looks fine to me, but it leaves the question open:  why here
> and not elsewhere.  And the answer based on the previous discussions
> is that this is the first new log item after the problem was known
> and we'll need to eventually rev the other ino based items as well.
> Maybe capture this in a comment?

	/*
	 * This log intent item targets inodes, which means that it effectively
	 * contains a file handle.  Check that the generation numbers match the
	 * intent item like we do for other file handles.  This is the first
	 * new log intent item to be defined after this validation weakness was
	 * identified, which is why recovery for other items do not check this.
	 */

How about that?

--D

