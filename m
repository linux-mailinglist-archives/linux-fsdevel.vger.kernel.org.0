Return-Path: <linux-fsdevel+bounces-61327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555CB5799E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3BE1686EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE430499A;
	Mon, 15 Sep 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPdEqNPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816592FC015
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937589; cv=none; b=hCfhCF7risbuYDhHvDQknAX5CwA6g6YZunHUUjYbzZEOxE0n2kquKCXeddGqBO59UFEveqsxtFniv84sZUa9kZ247vyTE6fZazoDfg1bfa9JzaiLD4z0ZmM9Gn1Ni63pu+Pc3aea/eF65OWonBa3EkMio8eq0djA2XMHxSx3ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937589; c=relaxed/simple;
	bh=KzBzti9toAh24H4FbCZuschRS4BzZ5w9pPjbyhl2dU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJEjNmSSpJgoI36jXsqtwSn/ecgduLLQpmUucuU0LXcCpJl2EIUbjEjQxVbQfUx1cgfOqpDbwhRXRwo6VFXZv6jXEldbAh9T6V9hYBO4AvembMtdoHYa7Eyxa7qt7jE0VDd1UkHmX/5BvTJMuLSaEnYedGh0O/i2MjdJU4ZGfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPdEqNPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB98CC2BC87;
	Mon, 15 Sep 2025 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937589;
	bh=KzBzti9toAh24H4FbCZuschRS4BzZ5w9pPjbyhl2dU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPdEqNPvJos6ROo9Qm2JwYAziF/8lQ5z98YBxzFmhZhYc5uNf6M7Tq5gXYl+Th4IF
	 jLrhJF0tzs/vP7cvPJw5IEGu1lXFPl5OfjSrzTL4Uk5d/NSLZYnO1yR5Olyohx/TPu
	 vGQWXPi9blo0U5hssLikWsfswu3dlWXSdmygGXMSJbJQUDOVKCaU8nrqLEzHE8esdm
	 eeFb4ch2Zm8B0QEU1cplq/tQ3DuzUJWu4C1zQMPpdY6XMqVoPSPlhtDpa2ThizZrwY
	 FZbtm2F6zBkxBvMa/yoXL4Qnbqucuuatz2BGUHLntt8JOZdIx9PjBx/c4SZOOproDo
	 /OMRRhja6QPow==
Date: Mon, 15 Sep 2025 13:59:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 01/21] backing_file_user_path(): constify struct path *
Message-ID: <20250915-osterblume-jahrtausend-af9dd689f3b7@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:17AM +0100, Al Viro wrote:
> Callers never use the resulting pointer to modify the struct path it
> points to (nor should they).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

