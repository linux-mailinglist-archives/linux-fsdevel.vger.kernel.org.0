Return-Path: <linux-fsdevel+bounces-50581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D2ACD74B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0D617673E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9322261594;
	Wed,  4 Jun 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RgqwkNIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF32F22;
	Wed,  4 Jun 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749012441; cv=none; b=lSKPtU08RpY0pfD2Lnb84g/vQ4If+Kp41nueMHNErjwZPRuDn6NTlw6knx3YcrI831/GUQYvCxARHTS4rEdS6IA33UyehGwC5kN052LDp3fO4pMQ+hJlZnN+AJl//XkQYt57fCvFv6V4giI6PQwaJb/Bw5v9KBZFqhIJJ90OAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749012441; c=relaxed/simple;
	bh=T8IUytwcYo6HzHETf036N9eJF6R692NS2kscIZZrpWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0XpKguGTGDoJ5zRDFKmV5prsx/Fpz8CQ1chIZLE3nDU6GegaYg18gpxxvdIWzU5NVWjIUhly4+Jqyb/aCcGz7hEI98vKDkQMtBG52yFpncczkcZNSdUCEBTuIR7t8k8zIdUFIOnm6jHXXcWrLzu2Qd7rIFzEATGobaDSToBetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RgqwkNIc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T8IUytwcYo6HzHETf036N9eJF6R692NS2kscIZZrpWQ=; b=RgqwkNIcQytJNHU/PsgBFfrAa1
	TQ1JbXw3kzcyJ8zP5WUU9ewshDfmkX+9g3sBOGbT+137GdJtt4LAyu+BDAgCUIAK/D3G8dtP3WZgR
	QWVhN1ZYXS6Y2OQQRLk9ZehmfuNPLFyetDf4fOpFaYw7rmSUFttrlAWqlaQK4MrAYv9NfbjOCGnD1
	lReDwpO2nakqRmcEXFXjjlLFQZIs+cxSZ+C5wkp7BeU+KsaOZ3XgaJ9TpHsfyFW4e2A1CnqPPAog8
	Kl2DUvdlEGDKrhSWUvCUj9FWKboIst6XjKDPUWArvz+hoEqM5UlJbLAWWCslzf7c8hoWwpBeXjJxN
	tPDGJdqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMg21-000000035qj-31rk;
	Wed, 04 Jun 2025 04:47:17 +0000
Date: Wed, 4 Jun 2025 05:47:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Luka <luka.2016.cs@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING in simple_rmdir in Linux kernel v6.12
Message-ID: <20250604044717.GH299672@ZenIV>
References: <CALm_T+3-6MGiNKRdMedJFTtspM=U+gsgOXy9Mn3pD5jc0shD0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm_T+3-6MGiNKRdMedJFTtspM=U+gsgOXy9Mn3pD5jc0shD0w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 04, 2025 at 12:45:41PM +0800, Luka wrote:
> Dear Kernel Maintainers,

Misbegotten Spamming Turd,

*plonk*

