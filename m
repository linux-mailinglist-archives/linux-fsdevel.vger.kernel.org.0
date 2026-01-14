Return-Path: <linux-fsdevel+bounces-73770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85867D20070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86CB30AA996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61E3A0E9D;
	Wed, 14 Jan 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwVS0HOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6136C593;
	Wed, 14 Jan 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406177; cv=none; b=XAnykgbOHu4NZmN4ZUgrHkXCHvDdGpPrOa3oUldwRXXNCcSpHpCqoVTu4dCp1oFiFhzOJI+qWbJsaIEyNy95CAon8w1/n+a5/yW0ytvCXeT2TABNAic+DhO6uokze3viSVPCVEjh+CD5gWJO860k0sv3ebteSharw02fiZfl/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406177; c=relaxed/simple;
	bh=62MydwnFoyl6K/1vyy6myR5sXfZfKfKU/DgEXywU4z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqVLpfoEMSFQmKzK097j+E6BEypXdHsL44SRUXKqXtgXPUi62jtCfRX541nfZ7aNDVMsnxitzvg3QgonGPF41ivdA+EgeHzf1shU2bpxTG6vTQbQSNHr5YOgw2fGlGbdnzx1+jsgU43HD2R2/PiMmbjuhNBG+iHI24TDlMfpggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwVS0HOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE77C4CEF7;
	Wed, 14 Jan 2026 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406177;
	bh=62MydwnFoyl6K/1vyy6myR5sXfZfKfKU/DgEXywU4z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwVS0HOFaRdrOvpYb0W51X1U7Zss1tXJZRG+h0zxdWiqsAXGEwxRLievMJuMrx7Fh
	 ZEiXyaM2RRrWL14RkY77fqr+0ATaMxDIKRCnK2F/1BMzSMSKQUw32o/xL/etmh4FwQ
	 C6LC/kFXU3Kw28nE4V4xjc/MrExbgfKGdANLnGJtuOGBeOvF6HvPS2i/3xhBgJtppT
	 kgDQPBMaWpNU/BZmsoDhY4WZqC/5I0PX7aBrLcAWVrXEqcqmJDmwxdTNlRUOgvJsrX
	 ke6gFbB7eyV+7k0uNbhjk/RUWfGl+YOURS4HUDysVfaL55kIFa6eax9QjGM9zYEdQp
	 rSmIr1ywUGwag==
Date: Wed, 14 Jan 2026 16:56:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, yi1.lai@linux.intel.com
Subject: Re: [PATCH v2] fs: make insert_inode_locked() wait for inode
 destruction
Message-ID: <20260114-rennpferd-knabe-5ebb9e0b7ec3@brauner>
References: <20260114094717.236202-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114094717.236202-1-mjguzik@gmail.com>

On Wed, Jan 14, 2026 at 10:47:16AM +0100, Mateusz Guzik wrote:
> This is the only routine which instead skipped instead of waiting.
> 
> The current behavior is arguably a bug as it results in a corner case
> where the inode hash can have *two* matching inodes, one of which is on
> its way out.
> 
> Ironing out this difference is an incremental step towards sanitizing
> the API.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Still reviewing but if ok I'll replace the buggy version.

