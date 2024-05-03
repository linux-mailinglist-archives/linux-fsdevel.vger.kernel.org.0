Return-Path: <linux-fsdevel+bounces-18556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80658BA469
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E59CB23C12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922CC1FDD;
	Fri,  3 May 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uNb7D7Fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CB360;
	Fri,  3 May 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695296; cv=none; b=p7BYO4jAYzVjWM9onIfRRhM2G5ehiAGmxBLMHF5WFNSlk0ECf/EitXkNosHj6Zc/NSvsD48V3OqyiN2+6yvJo0iFZa6CF+3HnvsG0A3l7C0OMp2JcAkPocF2lsxbkULUIzKQaXUovW1lkK0DRQVBeaaUVLoQhzKZpw9DKczNrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695296; c=relaxed/simple;
	bh=HCnj/OkzEzOO+/XL6a+aSpOJoeQi2rezZ087V4Ar3Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZduyox02FF+KG8cjVBapIYmywxYi5zKWkIm48lNAKBw5OFIOenmj2kCL1jWSgKXttobjBQBoDOqo025pLXbYmTWAWhRI9x+cDShUzXQZcqM9+ebgFopuF3ngCsJWK5FkrpDmfaKBcWBFtcaCB5rEtg4TMPeKbqt1Ejb160gVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uNb7D7Fb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G3Jio2yzFj4vaco3e+Tc71ImBBiH17zdhCTdlG7XsuE=; b=uNb7D7Fb2PbGKO/92xZCL9LsYs
	RdvfEf5PqWKVi7x2E2QlcM7GwI3J3WTtY8//MjmRfJELa2socVN/t9746mBG5FZRa5NnNj+wdxZkp
	IcY3tJcPw5eD0BWXu7SjKu/bHgQS6O4dNfCFQt7EMrwB9wG4f8ylJyyP4I+srq6vF6lLvC5GAV6xV
	CxZghgNEb+6Esna7RajcRC7xlt9gGMRQ5ncbcpO3RMlowwaNJAE/Qrneo+mx1KAbC5/cjudLHHLkW
	mORaxJHCnmq+9SQqh8LHfZERRWSUQZTFeD2pifw2zNJ6oO0rfYuhHz4CpHtMLHIAYc4QuO+LjPZIC
	cTkgcdhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gZZ-009tdL-2S;
	Fri, 03 May 2024 00:14:45 +0000
Date: Fri, 3 May 2024 01:14:45 +0100
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
Message-ID: <20240503001445.GR2118490@ZenIV>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
 <20240502231228.GN2118490@ZenIV>
 <202405021620.C8115568@keescook>
 <20240502234152.GP2118490@ZenIV>
 <202405021708.267B02842@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405021708.267B02842@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 05:10:18PM -0700, Kees Cook wrote:

> But anyway, there needs to be a general "oops I hit 0"-aware form of
> get_file(), and it seems like it should just be get_file() itself...

... which brings back the question of what's the sane damage mitigation
for that.  Adding arseloads of never-exercised failure exits is generally
a bad idea - it's asking for bitrot and making the thing harder to review
in future.

