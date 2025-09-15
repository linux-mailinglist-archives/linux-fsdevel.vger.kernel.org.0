Return-Path: <linux-fsdevel+bounces-61350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F1B579E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D1B169DF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68463002A1;
	Mon, 15 Sep 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAjuDrws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B772FABEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938001; cv=none; b=if09zRhytW1qBLAlw2tTcWk2JUun83+g31X70rDEm4fbVqvVSVte9EEgMIEXCyxkL3I4i0He4oU3TyfYhCK8jPovAAqqvfCDVFKKXf9EiwnYPfz9UUzvofJqPb0U4zUAq4kx2b7vNmmlp0ISiKcNAKFWuReCzjx8SPK1yOn1Fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938001; c=relaxed/simple;
	bh=QAFrQ/MYuhmZf+L9vJAB3DkjfRPeTmE5BKaHqa8ch6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of8pqk3F8Wm1IPJ09GmJXMWSYUBlwOlSjlMeSdmLY71EPDm+qT9NtrCXzNuxwRVzhn8nY41NfwTXvbA8itOvwYvROVOJNuWV3jwT4nzb/DA8GrzDb5B5oYq4QevGeZdotGbuX2eLE+DW8yrfNhB/KgBUn8qY46YlhI6SxJVzbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAjuDrws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486E3C4CEF5;
	Mon, 15 Sep 2025 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938001;
	bh=QAFrQ/MYuhmZf+L9vJAB3DkjfRPeTmE5BKaHqa8ch6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAjuDrwsqnjXhs200TkYqrIrgItx+S3bgM2jhSVhGh0iydHFkflZyd41y/cgAODzL
	 /0lKlEa9rcmwdjbA0my7jqkknzOhWDGGmMJgWouLBKdECREkoqjTm0TmE6LMPDHX6g
	 4+Ci4kcMJBGvdsMq6oRU9FJiT2dKK8MKVR6ygNTyE9UHRw8gog8P8Qe2oc/xu9uak6
	 Dok3sdFxuw3DenT5bTtmevzhyFP76FrVonqvw3yJgs3SXIDWxQRupCgf9L8ApAb1qv
	 wPWhH3Ga3H5X3tJqtWm02Ckr0cY7cb3QjPA+uq03RGILKAOtygY3syd2MPFnYaPedb
	 BDANOeuv7qOYg==
Date: Mon, 15 Sep 2025 14:06:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 20/21] apparmor/af_unix: constify struct path * arguments
Message-ID: <20250915-klebstoff-mitfliegen-d92f792c5876@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-20-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:36AM +0100, Al Viro wrote:
> unix_sk(sock)->path should never be modified, least of all by LSM...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

