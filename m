Return-Path: <linux-fsdevel+bounces-59070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16106B340CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA04017E64E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44FD2D94B2;
	Mon, 25 Aug 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb/hoS3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB64278170
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128768; cv=none; b=BeIm1n+WMNqz7Tba0UepZMarprSlBbqZ57u/Ul6DJtVcMUHv8vQCWpuDZGF34Ba4AAcefILBU9NC7At0brBc5FDk2yStImdHTSmpVP4leAQLy8e1xKzgVT4kA80YCSKlHFBp75H0kqSKKqhcNktSt6HV0H7iRIe/d5e2o7HlYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128768; c=relaxed/simple;
	bh=KYy6bwNx/oo3GNnIKdN5NnuqK9IE4pF46nf3agEYaVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAyadONOfJKcQqaPN5FIgfxXbzF3iceY0EAtOhtnjIzm3timBXc4rMiy7J2J+XE2jwOc6Rzsv/QZ2qjuPztAEPbGrrvMS3M/+/ZslwvlNC2he+Gw37dZmvsBQLwdT9JBH3fmuAzksPF31knDbcwB39h5YGDFsj9cV1en8deIv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb/hoS3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4197C4CEF4;
	Mon, 25 Aug 2025 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128767;
	bh=KYy6bwNx/oo3GNnIKdN5NnuqK9IE4pF46nf3agEYaVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bb/hoS3v9B2NhG+/yYTcT1mPIxRsqxKWoSM85lvd8dvR09S0t2j0FbWXduK40o1+A
	 xfccBHXKbWzc8b/cGuG2ZdWZB4VnrnZXhXVFYU0e99lXmn7JhQ3SkQF7GB8GTh+czc
	 RQddc2RQ5TBadWQbQTfx+90qDoyIzvZ1MFj+myitGomCNMcrViHY5q71rVgCorh9+s
	 9wBJLoytg+s5rKotHO97Zbt4uS9VpdHb67xqACw6z8B54yAr9c3SYpSLaPi3qAuDvB
	 ykERZsWbGbMaPrzFMCBDReHko4AifndvSUfXTKbBhpg8TGs/gLh4uFLZq/8qy0Yo9n
	 0nrt9JnwtpDfw==
Date: Mon, 25 Aug 2025 15:32:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 49/52] do_mount(): use __free(path_put)
Message-ID: <20250825-knieprobleme-ergaunern-d4f1771ee9f9@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-49-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-49-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:52AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

