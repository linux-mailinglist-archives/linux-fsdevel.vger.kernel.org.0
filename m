Return-Path: <linux-fsdevel+bounces-68262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938BC57A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3F742602B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F910351FC2;
	Thu, 13 Nov 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XozB/ZWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786572D7DD3;
	Thu, 13 Nov 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040112; cv=none; b=BZYNSgonQD52cSY8FhZHv9pZzAoRe+iLSntz9AeS9FhHnsdkJJcoJ69m2u6N0SW3xX6MpSe5O1LUi38hY/2YUC2wRf0f8ZDG2EcdHoramOQg0Z4KNymMHC8hFSmqtVG2alMSc4kYUJJufIGhp3V3cEDzv6VgG+yccxdf6EujWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040112; c=relaxed/simple;
	bh=/ePmSwD5mRzIMVO6D3H1Yp9aPct1X/STGaetx2ENVvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvVZw4SruZnovR5+MzmI26kmYTftPkh9AgJeIwQCtKNPoeEUOKQHTpgP3vw4R/wxkUmT8dppUdOFjS36ijbjPvSjrBB1O3mhroiy3dx0OkQ8VJng6NLhwgiiWBgqvVIEJq/eF2poq0vOPXJtviitImg3SWSzC+/zamD3p6ipPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XozB/ZWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1FCC113D0;
	Thu, 13 Nov 2025 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040112;
	bh=/ePmSwD5mRzIMVO6D3H1Yp9aPct1X/STGaetx2ENVvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XozB/ZWfK31rqfQDHk6kaEsZWzPuZtO2VwGW5dsBB9dukUZh5JMAbTf1XdaMvRK6n
	 aLxrZmupf4YhgNHYdJKl8XHggdgJ6OXjQbQFu122/cRQe/u2EOMihv11gF4aCv/Ug4
	 +tdRuSliPr+RWgHzosxI6XxRIuYTkVHBtLmN8oJ+4Xl0qdEyj9SzpysUrXbAGJUFn5
	 PvPf188/9MRdcdLXu73xytqH0csAn/r7dXH+047ImYa77jooHMP8niAyPcwF9syb13
	 G7B+PYZeyFnZpU57LMtfkl0s21nCgNc/GBwh9ce6GJJfdbf7jVLTb1ZfedgArtnRpM
	 nWpmpah2O0zDg==
Date: Thu, 13 Nov 2025 14:21:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: jlayton@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] filelock: use a consume fence in
 locks_inode_context()
Message-ID: <20251113-dekorativ-wachdienst-5430074100a3@brauner>
References: <20251112104432.1785404-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112104432.1785404-1-mjguzik@gmail.com>

On Wed, Nov 12, 2025 at 11:44:31AM +0100, Mateusz Guzik wrote:
> Matches the idiom of storing a pointer with a release fence and safely
> getting the content with a consume fence after.
> 
> Eliminates an actual fence on some archs.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Can you do me a favor please and redo and resend this on top of:

vfs-6.19.directory.delegations

which has Jeff's changes for this cycle that affect the code you're
changing? Otherwise we get ugly merge conflicts...

