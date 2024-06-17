Return-Path: <linux-fsdevel+bounces-21846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A190B8E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 20:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9121C23FA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F467198A3E;
	Mon, 17 Jun 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3c+VCaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368818FC96;
	Mon, 17 Jun 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647242; cv=none; b=aYwa/p2sUGOCjD0UBqDK9F2WYMVSYYizHcupr6ZZNmQXDKHGNrx5Mae5k1MMSnvXbopBN/vvI+yapnHpIvo2p11JL7aw7PQSQ1KT+dPRmcZIXxcfq5qTEJGX8mxCjfmd37dvLj3bFsQ+0hKxNnIenL/PtEH3kzpjQs0ZhCoVfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647242; c=relaxed/simple;
	bh=FRtiDaxxMejA06FwpNDi/tXRJBK8oG9fBmcgOXjXrjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUDHSFkeKC7jLTe+S4Z5mYLaUL90N/UzNGejrPQTF6LVyf+BPR8i/WFabYLrx25MNdBlkvD+Gjur4GvZJuHHRqKBuDyopxfcXjrrxGvMj4UdPYqTtRGB2Lyn7O9l1wTwvMEYuIGXVGCg8q+E5wQyKs1e8c8xLm1f00StZD9ufeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3c+VCaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35357C3277B;
	Mon, 17 Jun 2024 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718647242;
	bh=FRtiDaxxMejA06FwpNDi/tXRJBK8oG9fBmcgOXjXrjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3c+VCaCm7uktH3MkDTSrduP3eVIEukZMS7z8TQoFan6sghTFm96bw01Ujg1bBKEP
	 NQJUWPzgAiusAbwC73hQSjE3itqVICpRZq/+5wlza6mhvvJXlg7RPyuhhRr/5XZfou
	 BNk5aYbRXgdG/ri5NewBZFsB0znlDtTFvXA6OdFTMDooynZcJc6x/eLMTUrwv3X760
	 KOqO29pvWUsZEbfw9So3Em9hBC9qztS9CkqFXnhUT+DI+N+mzOu/ZbZInlCVcMq2xw
	 4fNTPMOU3PrHURF8Lqb5Zor+nhlJQXQ6WtU+RRVRQYY8MJoLplrR01jasQ0F0tQQOY
	 T/3i0wbmBNC0w==
Date: Mon, 17 Jun 2024 11:00:41 -0700
From: Kees Cook <kees@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com,
	ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com,
	jorgelo@chromium.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Xu <jeffxu@google.com>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v6 2/2] proc: restrict /proc/pid/mem
Message-ID: <202406171100.B0A8095@keescook>
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
 <20240613133937.2352724-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613133937.2352724-2-adrian.ratiu@collabora.com>

On Thu, Jun 13, 2024 at 04:39:37PM +0300, Adrian Ratiu wrote:
> Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> after which it got allowed in commit 198214a7ee50 ("proc: enable
> writing to /proc/pid/mem"). Famous last words from that patch:
> "no longer a security hazard". :)

This version looks great! Thanks for all the changes. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

