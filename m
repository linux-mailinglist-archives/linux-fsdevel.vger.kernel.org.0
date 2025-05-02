Return-Path: <linux-fsdevel+bounces-47893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA00AA6A35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 07:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2F1BC0A85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 05:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F31C3BEB;
	Fri,  2 May 2025 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nHiTyhPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF62F2F;
	Fri,  2 May 2025 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746163995; cv=none; b=f1nY1YwZNiyUDq7VNzN++WCiGxH41TZS43K2nl/R8xveoHd0gd5GluCaSTdWlc4OgsVas53dRqHPQ9FHDWxDO/Df4UOXXIHWAwvoSAOifuh6nQkaRtJrWn5e4o16U8LYmDXpYSB2zHfvCDJgn2emxLx+bdFsSYkGO+XsID41F/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746163995; c=relaxed/simple;
	bh=umLDRrYzZKjFaMcPxN6Vc5f7/+sv+06DxOZE88bDMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNELoLJ78Q2E+3+FQrFObs2UEcTUY0CGQBr7treDqqLMQF1YVKr9MCy6Y2mwkY+kS7GCtF2NnWwsb38Z17DzBODsySLAcdosD07Vy4tBD866SiXyN5WSzG8vemPgfTurbt7hA6pWpYLlqXClE5UrhxBPy8ev5NF6HXJ6HUcNufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nHiTyhPm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hzgdBBFVb2afs7rV1/nonnhn5rBLC4WuS1ohmWy9rS4=; b=nHiTyhPmVDGGP9m2sWl/Lr9UVR
	d/IfvdDgm84kuFzmT4ag21cNVTYWNxYCJXJC5SWb8Res4OqI2kkTb1LOgQ0/7yyyWz4laPYeKsZea
	aSnLtZMAQniv3cnXHMioDIcqj3cAJfQfXOeSQjn+MGME9qssELtNtlN7YQSMKD8A3IzMfj3G+BO3J
	9tPSyXg9y7FM39wR3kx4D1YA6BAIVtFh3g851GsZL7WwmZA5+qHvDZ+fuUQlCTO0tkQieLwtC5aVu
	r+sFESrff9cy145Q2qav74k0ATmjRw66bS/1Goqoq/+JJ2mvI60vomry1Y+wy6CITYzHrPrDGj/Ne
	Eoku8xYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAj1D-0000000G9G0-4AEJ;
	Fri, 02 May 2025 05:33:04 +0000
Date: Fri, 2 May 2025 06:33:03 +0100
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
Message-ID: <20250502053303.GX2023217@ZenIV>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
 <20250502023447.GV2023217@ZenIV>
 <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com>
 <20250502043149.GW2023217@ZenIV>
 <aBRPeLVgG5J5P8SL@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBRPeLVgG5J5P8SL@lstrano-desk.jf.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 01, 2025 at 09:52:08PM -0700, Matthew Brost wrote:
> On Fri, May 02, 2025 at 05:31:49AM +0100, Al Viro wrote:
> > On Thu, May 01, 2025 at 09:26:25PM -0700, Matthew Brost wrote:

> > And what is the lifecycle of that thing?  E.g. what is guaranteed about
> > ttm_backup_fini() vs. functions accessing the damn thing?  Are they
> > serialized on something/tied to lifecycle stages of struct ttm_tt?
> 
> I believe the life cycle is when ttm_tt is destroyed or api allows
> overriding the old backup with a new one (currently unused).

Umm...  So can ttm_tt_setup_backup() be called in the middle of
e.g. ttm_backup_drop() or ttm_backup_{copy,backup}_page(), etc.?

I mean, if they had been called by ttm_backup.c internals, it would
be an internal business of specific implementation, with all
serialization, etc. warranties being its responsibility;
but if it's called by other code that is supposed to be isolated
from details of what ->backup is pointing to...

Sorry for asking dumb questions, but I hadn't seen the original
threads.  Basically, what prevents the underlying shmem file getting
torn apart while another operation is using it?  It might very well
be simple, but I had enough "it's because of... oh, bugger" moments
on the receiving end of such questions...

