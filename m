Return-Path: <linux-fsdevel+bounces-63006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EDBA8A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C01173F78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A71E1DE5;
	Mon, 29 Sep 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyhmXBhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44F27E1A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138437; cv=none; b=tXxBem/cdCpLNa4s8LeWrg7h3SRSdqSVfV6RjscsbTTUjE4SOrbu5q8P25PbetwlaXCcAlu9tHC/B/sdPlXO+9Rk1c02Poiue8SB6NTo6e8LPBWL/h2nZNE4A2iPQXJNefP+F8jKOMeKv/h5cGUFNriJFJbBoO07ZnwYonmdLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138437; c=relaxed/simple;
	bh=jHlKi0xNnEENtRIDTwl6ZcxAlBfjZDq3NN3ROVEyVlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lngkgON6wKKDS13amkGgyXiRaH+SWN0jU5fu4ru+v2pHc8q911EdklqU6ns+zCZ6DyBUMhBPH6sHuSW9K1FTJzXMuUZv0YONOC+RNo7QoeOgA9mqHiigc9wE+7H35hqd7Ekn5AT5sWpLQG/266WQ/+zw7y/2Hf6ZqEYCaDYdn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyhmXBhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849FFC4CEF4;
	Mon, 29 Sep 2025 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138437;
	bh=jHlKi0xNnEENtRIDTwl6ZcxAlBfjZDq3NN3ROVEyVlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyhmXBhKQVPPSzTwuwoYc71UqEO5WZiPg2C4iGGB1tiKyuRUZrLt0+s17ZLII7isl
	 3D2tOHD5OPNdzRTYvkBpelGkngRNVVJdgcOUNJr7BfTZC5SKrfoQCM7czNXnAVQr5I
	 HHqgPczHu3jqY7hYt0bClhVcGxhF9YaX8bEsWKNkFoMee2abp0zAyw60VsiguqBBaL
	 v/IjsUVpuevo4VfgeHDDc8SoekQEMZYDjgb+WwycuVIL8dDLzpZiG2UEIJegrryLf3
	 +qpNURmZcQrYAFbEPPYEN6WDgE2AlxbBflh9MzePuUgnZ8eF4hWw14OQCwMjDNQb51
	 /qLmwKuLT8YSg==
Date: Mon, 29 Sep 2025 11:33:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] listmount: don't call path_put() under namespace
 semaphore
Message-ID: <20250929-skeptiker-anrichten-335706882b55@brauner>
References: <aNU8RzeIADNri07A@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNU8RzeIADNri07A@stanley.mountain>

On Thu, Sep 25, 2025 at 03:57:43PM +0300, Dan Carpenter wrote:
> Hello Christian Brauner,
> 
> Commit 59bfb6681680 ("listmount: don't call path_put() under
> namespace semaphore") from Sep 19, 2025 (linux-next), leads to the
> following Smatch static checker warning:

Thank you, I will handle this.

