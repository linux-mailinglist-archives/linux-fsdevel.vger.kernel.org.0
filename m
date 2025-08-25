Return-Path: <linux-fsdevel+bounces-59030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A251AB33F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A0188E17B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD322275B0E;
	Mon, 25 Aug 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJkuFbgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAF27511C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125221; cv=none; b=eb9v16cUUsXJbAkXD4K7J/l53WavIVe14RELYAJGvLQV6uvqace8OxqeDLqod26+5TK6spGW2J9a2/IuqSvdjP39Tvq412veq5JyFE/f8+sYl/+bAHTb4IjJmgyMpYJUAtOl1jiqQcA9hbNGQWlCsqzYnjnGiheSl76KGqkXZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125221; c=relaxed/simple;
	bh=rlo2ujwXSo0fGzSxw0hy+l6FtaS1StVfFBkauUlzwuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIEI+PlFVaran8aZOkaZasqXrK8Uy/gmNevxChbEFE54/7NUQ0l2E1ZjrgOY04PnfY4XnsqcRP/sfR9o06bamVmal751VMb6Y1lgu02xq9CubmHP91tsmG0PAyiA0AsMnRM1rbhsYVBEHVFi0sB8ZgH4TTjdUpRv/dq3TmhV39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJkuFbgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B501C4CEED;
	Mon, 25 Aug 2025 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125220;
	bh=rlo2ujwXSo0fGzSxw0hy+l6FtaS1StVfFBkauUlzwuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJkuFbgpTC81L3DUHz2d4wZ3eYb/1klkzdXDJaCB1tZoqhGoUQoj5YqA7K9LF+8zB
	 iYMzP7cxXEPAU1o9Y5p6vtG1tjFU3n33sHLS3/4L79wB1EmVOYVorlQxhTABZ4fNtg
	 xGvf2lbc6R0GYg3v1Isbnlb/mh2f/Qt0Np03uH1rw5OQTVSC+Xmemb+e10mZvqneCP
	 3Wm1iyZ3ZbPT2MdKsgW1V3G/eFY05Dl8X2w+ZYMScqYD4CPlIj7xiPJEjjK2GJUWEi
	 6dtJUPsGWfakluJnSROlzs5o27Ft6ffJWhMeVBz3+2xuOq99jcDImkWGZghWeW0+wt
	 3lgHV/zy4zxOg==
Date: Mon, 25 Aug 2025 14:33:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 05/52] __is_local_mountpoint(): use guards
Message-ID: <20250825-austragen-abwandern-2829a6c20edf@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-5-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:08AM +0100, Al Viro wrote:
> clean fit; namespace_shared due to iterating through ns->mounts.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

