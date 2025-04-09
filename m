Return-Path: <linux-fsdevel+bounces-46125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B179A82D95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936D51B65AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84027605E;
	Wed,  9 Apr 2025 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioasz/4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036326770C;
	Wed,  9 Apr 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219690; cv=none; b=OyWHzB0suPa/UWzpM8Obx6JjZD7xvPqAuNQmEMcpO4XSguGbReaoTmOxIhyrUiQKwh6tMAeIrZ+t3it9yKILCgJzeCyha3R+IpXeTcRvwFG9W7RKEukLL/EWdxqNhzwwkmmDRV7Q32cFY+0Ds9x1J1luShGYil0MnHVM9h2VC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219690; c=relaxed/simple;
	bh=QW6PTF1fclJwcVK1Q3Vyy26yBqsg7uy+AXEteXGYKvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrW052xLDB0TsRWW81x+D1/GK8DZ6i2xsLL5VYvmXeA2FPpoqC/bZbgPRzFdg9rfaoP3TQXj5rpcOn7OHeyPpo2uDrjAgB9r/nPRYMAqHDBJAkTxQZtlO8oFhe0k4EITSPQI3gPGfU7rSF0yI2xS2a0rCB2AvRTg66hn853/lNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioasz/4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71954C4CEE2;
	Wed,  9 Apr 2025 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219689;
	bh=QW6PTF1fclJwcVK1Q3Vyy26yBqsg7uy+AXEteXGYKvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ioasz/4Q0E1RQrUsEMPq5Ee9BPX7tOlHYnHgtvZiScUI2JqjEZmhSGhpb4MAEs07M
	 2P+j+W41xutEE+768ypRXOIMAgQmPdvrxdIXGeq1ooBgJTueuKIjUCNi6mdF2ftjv4
	 bw/VRyPa/OR8yoq5jrlFxJMjk6xber+V4MEdX5jwJEj3o9FKdxz+1ct9QHpCDE9GWE
	 x55Y4zTK2rwq46vPA6xtWi/7v/Hn9kOZv73WYEt1Yw74u3QkwXXJ+zMq1PQb+ik89j
	 fssyQbPGXuHYBSB3zrNXMw2jCE1WpAIZZ96S2/EB3tC+v+2wtm1Kaf9htua39sTopp
	 8yZyp08S88oCg==
Date: Wed, 9 Apr 2025 10:28:06 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] sysctl: call sysctl tests with a for loop
Message-ID: <202504091028.798E1EA2@keescook>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
 <20250321-jag-test_extra_val-v1-3-a01b3b17dc66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-jag-test_extra_val-v1-3-a01b3b17dc66@kernel.org>

On Fri, Mar 21, 2025 at 01:47:26PM +0100, Joel Granados wrote:
> As we add more test functions in lib/tests_sysctl the main test function
> (test_sysctl_init) grows. Condense the logic to make it easier to
> add/remove tests.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Nice cleanup!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

