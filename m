Return-Path: <linux-fsdevel+bounces-18542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3648BA3D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 01:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76268B23DE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312F1CFBE;
	Thu,  2 May 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nLUBYPMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB257C8D;
	Thu,  2 May 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691556; cv=none; b=BnPO6MoUISALxjZP+L0TupndpHZQb/O6QAxMIrcg1mAk50BnAK4yVv56hhmTRwGvF3a+Sz4XbheOaolzXPQm01FwGlJ4+eQO+IGa5nDFyC39vW2/zf+a3hykuNlpGiT1ZSo2ygiRa7P+2vNKokKOvjS5633ZcGqZZ715N1xts5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691556; c=relaxed/simple;
	bh=OHJgZc/CMoZ0g/v11+eBa6RC+qi9mLY2VwKjaQ/LrEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubGuRoAvCK4qlLdIa+Ya8bj6uqT1qHXFcNDSz+Rym5co2NJ6TdeH50G9VZuHn5/VWgV4apZqPKPiILCCl38kb7vdLFLKse+g3TqHfNXzZsZcJWbldoEF9+pviZ40IYOqcQ0+GnVi/zvagb+M4z284tQA/GwD+6cW2QEGBoR0ZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nLUBYPMO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O+ovtRI+qjFoRKgW6PbWKtfCDqZHsyNloCpeAE5jAfE=; b=nLUBYPMOxAkFlz7J3+shxAx8uh
	9sx8gN2/C/59+EGGOXikIkpjCG85w8YVO5UrIBPF6YZxW18luIXpfopq1JRvQO9oRKMhCPdFbUqCy
	AG2C+Q/fTic5lf6IymQNB/RBRnQWBiiEbFiUv+p8WPpggILEUV4isEa76TxgHiClmGqQqy+vUV+98
	GY2WS1jkLAYEjOUUH1CuxEjTwvyVy6AYdg5Ad/AYDlpxql0gyNAyDNfPyKQDxYI7xb49Y+7QRiubk
	GJzJusN31jWemm9+PTjKpw09m+qztnOzgZXzOsxUo7cj6ndTvtPQWu/RCxI5dzesVbQ4Z/azyCNWR
	OtxWt1fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2fbI-009qeI-1T;
	Thu, 02 May 2024 23:12:28 +0000
Date: Fri, 3 May 2024 00:12:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <20240502231228.GN2118490@ZenIV>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405021548.040579B1C@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 03:52:21PM -0700, Kees Cook wrote:

> As for semantics, what do you mean? Detecting dec-below-zero means we
> catch underflow, and detected inc-from-zero means we catch resurrection
> attempts. In both cases we avoid double-free, but we have already lost
> to a potential dangling reference to a freed struct file. But just
> letting f_count go bad seems dangerous.

Detected inc-from-zero can also mean an RCU lookup detecting a descriptor
in the middle of getting closed.  And it's more subtle than that, actually,
thanks to SLAB_TYPESAFE_BY_RCU for struct file.

