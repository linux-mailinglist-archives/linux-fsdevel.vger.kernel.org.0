Return-Path: <linux-fsdevel+bounces-25285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98494A62C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1C51F24E54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71311DE868;
	Wed,  7 Aug 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUxShfgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2015B98F;
	Wed,  7 Aug 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027667; cv=none; b=GBIgKcBn7j9lrBdWxWtwdwoiLzzNo5ku5r2O/GOM09FWkc+Hr6n43uPSfPoiJDPK5AHoTvbetsoJTxJlcxIHZ+8a3M9bKurP95LPgnofuO6i7XIf0RC+pEEQJySrdFWef077UTR7GUsio0HVbXyFihB4On9mwnxsoNbPn1q+crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027667; c=relaxed/simple;
	bh=Q0KorxuyFX7v+v929Wgms41f60LuzQQ81w8okgKHFOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDpdYl8I8fBB2Na3GKETSQw0gAuOBgx0hHWypKPW3c1Yg+1Cu4LxaJ7/U1QOO7umonAeTso9/Yo+4/oUwGbClW9o3nUDcwo4nqBXWBN63djG6I6eNn5v3Yu7KN+skTC44+OnU16qRnFn9ozofFfJIZorNT2hvWbFEnQmSnExUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUxShfgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C00DC32782;
	Wed,  7 Aug 2024 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027666;
	bh=Q0KorxuyFX7v+v929Wgms41f60LuzQQ81w8okgKHFOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUxShfgy3cdVKWVI2TUrxVMp8h9bLR15kVyotqGVigZkHd5Zmzto2Tr4BWQNi8wVA
	 TNUpCcmaDc3lGbWID0v2z/i6aHH8aSqHxaukUPtY49llqpUja2qhZ6M06eQOZgaF+Q
	 lnRCP/gYW9YUxjPcKSCRxt2d6jraLriqZn9gjKEyHdduo8t4IpkNPhRPXAgSDHjmBQ
	 QVR85z4qkBnvS1CDSfiL7/bRZtIHlLAozGPoOu7x43HxzISlUogL0Ad2UW9ZwJpp6S
	 btZyiCzzPK+sreJSpbz6bAPR/aSBr+3brfAMYm+OqAsKzyXFhbiq+waa1GuWhyfKsl
	 tvjeLqU6L85zQ==
Date: Wed, 7 Aug 2024 12:47:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 38/39] css_set_fork(): switch to CLASS(fd_raw, ...)
Message-ID: <20240807-analog-verebben-efeef9feefb4@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-38-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-38-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:24AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> reference acquired there by fget_raw() is not stashed anywhere -
> we could as well borrow instead.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

