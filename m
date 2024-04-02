Return-Path: <linux-fsdevel+bounces-15944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD3896014
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 01:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573A01F25164
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944558236;
	Tue,  2 Apr 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQiIkTpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E55645B;
	Tue,  2 Apr 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100313; cv=none; b=eDc+WxHp3y5Hxrvm2eNghTk0DA6Yksc5ikVe/OLkRq71zCBIQP5VOA7/Z6Qqio1c/LtKKMAYtmXztfLwtrhiL/nbLDAwJm8YtlnmekyPjzByiTetrmcCWdI4OWOveAaPCLl/0ieb1e9qfrFMf2ay7OQe+eU/0eRb3f2YMwdaJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100313; c=relaxed/simple;
	bh=o62Y6KT/GNhqT3XaTDqaCHAapR+Q7yON6QcGkl4nI5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwFPa9rcbRDDqvYatFCEZ6VPF5GwUOz/B+rajJscZjrXCGgOsrvW696pg5+sZv75//rLtVxDl2KUDJ+U6IDYVXgBmBgajbiltaReGIVnMLCCE6p/7bsUDuf1IXzO9IKGLKDLENdo7UBYhC+9pLgU1ajBZq+HL49GFVoDlzICfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQiIkTpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A38C433C7;
	Tue,  2 Apr 2024 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712100312;
	bh=o62Y6KT/GNhqT3XaTDqaCHAapR+Q7yON6QcGkl4nI5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQiIkTpENWRbepJwcO3GrQizFs/zCh7BxYOetmitt/njHwsgYT1BWLTrRpGHGanU7
	 J3mPOYkdDmgvx/C9mGzfYEk00yOWTvF1wXt1MtR80NlSrJ9wrSLyld5xt4vWmx+aR5
	 Ia0aK2As4pfBj6B5WPyacU0Id9soWQ2jP6ywUM9Q3V9atE8TrAUsDZbb4qXjndNxhT
	 1bCqQhdL2JIxile2uItDqOwtwej96dAoRElJxx4Kd7UPjUtKYopn3vr5hE2xNRnbf+
	 URy68Zq9/S0E1F5ZHP42CvlsIyKmVL7Qb4S6w69fzG4REKh3Do1iKRpq4j3jlFublk
	 8qExiL6Kx2qhQ==
Date: Tue, 2 Apr 2024 16:25:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 27/29] xfs: make it possible to disable fsverity
Message-ID: <20240402232510.GA2576@sol.localdomain>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869006.1988170.17755870506078239341.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175869006.1988170.17755870506078239341.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:43:06PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create an experimental ioctl so that we can turn off fsverity.

The concept of "experimental ioctls" seems problematic.  What if people start
relying on them?  Linux tends not to have "experimental" system calls, and
probably for good reason...

Also, what is the use case for this ioctl?  Is it necessary to have this when
userspace can already just replace a verity file with a copy that has verity
disabled?  That's less efficient, but it does not require any kernel support and
does not require CAP_SYS_ADMIN.

And of course, if do we add this ioctl it shouldn't be XFS-specific.

- Eric

