Return-Path: <linux-fsdevel+bounces-61344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FEB579DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7463A0750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0730216B;
	Mon, 15 Sep 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLtSR+1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139683009D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937913; cv=none; b=J+M8yzYCxH3bZvnimWiEskwHc5/6fwLv1EqKqrwYO1ZHLRhhMQk/CaYWnwMpCAE8qIFmCt4jJ6gk6xXRcNU8vJyB2vy+RKzsGVBM6SaGNXGO8JNZDFYl3iLvXenzONJ6kKhp4CucoCRLjGIkUCpaoPNyxuLCEFYAS3kRSyigiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937913; c=relaxed/simple;
	bh=blDTbysCCVMPGzMonsZQ6B5ODmgfLbzo5XgFGVfRmaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqejiNGFe4pqquuDHTMHXC54gx/m/m5hPlEw+QgqjMmUg9dGjBJMjns6ws7k666rhugsrMlP7EwxVpZvgqJkYSRuYC1K2/SvZbKL91fSAAnsEN3Bz12gjE3CN6CsXlS00uTsEwNuuf2Y96uvaVRQiLqn4zmOGQ4UjYMmvqOUMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLtSR+1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18CEC4CEF1;
	Mon, 15 Sep 2025 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937911;
	bh=blDTbysCCVMPGzMonsZQ6B5ODmgfLbzo5XgFGVfRmaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLtSR+1BS/GQ50x28jJVhqqEKMjNJjnJKw5AA9toeP/ntclQy1BgyRe6eUfFLeJ31
	 S5jBbL44511xoJzsSJSYFCUmm/TH8WO1K9KAbFiwg1SHSTVNwBLsu3XnJm0ATLkhKl
	 DkSAVA+df+E2hoxx0BNMPTZVBMXBjjadyuvxJMdDTnL0wtaRCs2YEX1+JeCVvdF+6Z
	 b8W/+H7M3MhFI3t5SyCcHtGNGZBGQhNbvPSWCF+00NmuGwFpTboxHAbwhjP+Wd3bdY
	 7pZA7QR6/MDL7nOWhSNQDpXNwH99s8k53QPVW5b6NXqjA50w/pXrK0Mhp2gT6Kn9cd
	 ADQx9Hayywmaw==
Date: Mon, 15 Sep 2025 14:05:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 15/21] ovl_validate_verity(): constify {meta,data}path
 arguments
Message-ID: <20250915-dreikampf-hingen-ee84cf7e69da@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-15-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-15-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:31AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

