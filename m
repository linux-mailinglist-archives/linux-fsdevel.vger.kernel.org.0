Return-Path: <linux-fsdevel+bounces-47889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259EAA69D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 06:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F431B63936
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 04:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5E1A2630;
	Fri,  2 May 2025 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OEyEgfhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFCB14883F;
	Fri,  2 May 2025 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746160320; cv=none; b=rnQgWC8X7KaRV++nWT7e92ROLbRB1Ai4y1pstpySk5P1NmebzsRsSV8P/SU6hNQUXplvaMTwP7dG24IR9w/EURq2m8WG4mhWerPoycC3qb2yjqb/e0DGZmiZSAqg5BEJu/O9Q6/rVpIRo8lM5Nt5/ug8t27WoAv+B0gal45ie1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746160320; c=relaxed/simple;
	bh=sJQdtme048fLLoeEILMSI+01YtYV965QaIGB8McWDpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAPQFj4kOGLW0Bg/KjRj4FPj8XuntlyWNX+8dEwKq5peCtIjUFaxBBoZ+jskqhQzZUoQug2UdH7zPJRUUPBruHxqVXJdC6kZDKTC8Ao9IkofpLNdPkBD4CwFLB68JaBUn8tRU5ta8BFq2f5MRZB/FWCjeOGYgg8t1uEonnwxjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OEyEgfhc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W75ohiwgzQ2b4Y0vvPNQDeN3F8noVVK8UMQcA0s5vW0=; b=OEyEgfhcNYmmukh/cCmF4Bur9J
	5TTFFRKRoVZ1LiLz7O7//pNumoM24E8Wx8vZhRuvwWy43xbSQ1eS6SC9bBM2caxDUEYVSFjT1w47X
	mfbtBNqT90EZBKa2Tyac93FtVBihVucsJvBfOxhUWHPXnBY6Nvwoyk+UvL56AafW1RcdBzneytf66
	DRycb8i1SmCr4CqHlBHS3uZrSpwmGdsCgf1L7xrgmOF2Dkc459bOOnSyKrTMS0coNy/1xpNjfRiP0
	EQr6KhDUW8txsF5hMzriQ+EklzGxzfLDABykVEeQQPWHcjB3f/0AYPCtViTNQcdxWWjyeTrlsh8iO
	AgVJ5zGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAi3x-0000000FpJU-2zcC;
	Fri, 02 May 2025 04:31:49 +0000
Date: Fri, 2 May 2025 05:31:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
Message-ID: <20250502043149.GW2023217@ZenIV>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
 <20250502023447.GV2023217@ZenIV>
 <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 01, 2025 at 09:26:25PM -0700, Matthew Brost wrote:

> I;m fairly certain is just aliasing... but I do understand a file cannot
> be embedded. Would comment help here indicating no other fields should
> be added to ttm_backup without struct file be converted to pointer or
> that just to risky?

What exactly are you trying to do there?  IOW, is that always supposed to
be a struct file, or something dependent upon something in struct ttm_tt
instance, or...?

And what is the lifecycle of that thing?  E.g. what is guaranteed about
ttm_backup_fini() vs. functions accessing the damn thing?  Are they
serialized on something/tied to lifecycle stages of struct ttm_tt?

