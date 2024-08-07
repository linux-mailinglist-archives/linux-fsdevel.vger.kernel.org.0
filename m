Return-Path: <linux-fsdevel+bounces-25309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E812394AA17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845FBB25EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF974429;
	Wed,  7 Aug 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4fw2n1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E25914C;
	Wed,  7 Aug 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040913; cv=none; b=aP++lpuW3WGdP94QeW3veM9KCQLTO8X8PUc1rl1X8spjLtric0AETUzQxpFcE1Cn8WiTQkRwYh8joq63KTX/MOUDqhWOHFY0J8TcfLvJsW+/FZeiGOJjDlkSr5CngiZQ7WrgKa4LPKHqFg+5SCQ4g79XjIV/Wx+5pgX5jECDhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040913; c=relaxed/simple;
	bh=Rrm1590+jEvtlKote7AhGXCrQgAKS08g81BTMXyipog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOKb5UCHSy4yXe1+ZO5xsx7hDT8VtPVJ1r1vU4uvBGmSk81x3k5Yse1Sf03t714ZoN1CUmo54LnHitYHAFtjIVYfVCfR3zwpg4ka8Ot5lqQEfDvZ9wwg7D9+U8FaKvPrK7pwtGd82mS9TZ/QcIa0npaZHqfGlwSK1SrMmD1i9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4fw2n1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003E8C32781;
	Wed,  7 Aug 2024 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040913;
	bh=Rrm1590+jEvtlKote7AhGXCrQgAKS08g81BTMXyipog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4fw2n1qm6ofIXc3q+aOeap/pvrbPm/YeEe1zD3cFlyuZ0zSDcthBQXqmCQA7Rrkt
	 UfR3pln0XoKdxsTnKq1lENdX9aHK+gFUXpdlSWzAGKTac5iahwlqc84Mi/8m0eschC
	 kcNYI3WdAONibW33W4YhP8NAY1kSGjsCaO1DdNnXfNtLQefx0P/DnQyOEeu1y0GwUB
	 UsNRsdwPiVNQP+SXL1mUTRIpsF8SMhlUzZBjmofWfalX/dETrLWJUYgs3KoJIXM+hM
	 xQ2Ct80uL3Ec1OHj08QTqfmJ0oD/tWPw/oOwbDqd+SlFEuqvZYCz40y73NahEjTY/u
	 zXTLLHr2lcpfQ==
Date: Wed, 7 Aug 2024 16:28:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240807-abgeordnete-devotionalien-f95a7b997968@brauner>
References: <20240807-openfast-v3-1-040d132d2559@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807-openfast-v3-1-040d132d2559@kernel.org>

Ah, I was too late. Jeff, see my reply to your earlier v2 and let me
know how feasible this is in your opinion.

