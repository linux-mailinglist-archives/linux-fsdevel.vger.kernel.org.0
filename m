Return-Path: <linux-fsdevel+bounces-48090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16AAA958D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3573E3BD3C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1325C83B;
	Mon,  5 May 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noTZKSTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09425C82C
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454804; cv=none; b=tmK9enSDjCoNL9aP/p/pNFAjZICBDo/jv5lDPnqXBOeocdrURTeuijTHug2qaoKYV3Ef3mCqqRHeyNeRh+Md+v6K+Lr8+FHxs/uZiwrjRoQVxTdPgnD6eoCEdYYPLZLbehG7oaoKyRb/n/p6Z04JQkwLmo6YPi2dvicnLCmiKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454804; c=relaxed/simple;
	bh=suwF67Vg1UwuufYHmKYCOHiiqIkk22eDaSlnWMgX0H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEYJsPPqHna4uk/wpkFpucXXfFyhFqNrFxokumNglw2wkf8+/bhfym0dFUq4qSEjJAezGfEhdgbZPCSQBno3IUm2hDBFfppEPm4EMdwie17QNuUaVscscQVeaPJIE+o4kb9vZYBTSd6QrtgXxOsxf3hxyytJZ1200bxnFrtUGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noTZKSTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D5EC4CEEF;
	Mon,  5 May 2025 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746454804;
	bh=suwF67Vg1UwuufYHmKYCOHiiqIkk22eDaSlnWMgX0H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noTZKSTqzM02RF3rw4rrGj6Tpsan9mcY7JuRGWEUw+K6WpJW8r1/UbbjPhQNrMdB5
	 JBLhA3yLeHZm2xDYC5SjQkb/wLAWCMirHabxhLw9juLsfDeJWjSDXSG8FMhvveXetB
	 QMHVYpbpxIYK+Rr3KcP3AXR0oloGDCYpqG9bzGanrInUiEnXodrbGduOUNXri2m15n
	 xgSlOpnonzzFPOIk1owVAhXBhea1JOPla76OxWUEvxXTqRNN2PYZecwHpW4g+VnHAk
	 I8P5PCbGnmrv6azny3SwlcIyE/vsRs2Ym4XL5191QqFFDuLMiwxRvzATg0nXoCe9c0
	 Cf3e4piyeGQcw==
Date: Mon, 5 May 2025 16:20:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250505-habilitation-dampf-9769b10e51c7@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
 <20250429051054.GP2023217@ZenIV>
 <20250505050855.GE2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505050855.GE2023217@ZenIV>

>         if (is_anon_ns(ns)) {
> 		/*
> 		 * Can't move the root of namespace into the same
> 		 * namespace.  Reject that early.
> 		 */
> 		if (ns == p->mnt)
> 			goto out;
> What am I missing here?

Seems good to me. Thanks.

> Another odd thing: what's the point rejecting move of /foo/bar/baz/ beneath
> /foo?  What's wrong with doing that?  _IF_ that's really intended, it needs
> at least a comment spelling that out.  TBH, for quite a while I'd been
> staring at that wondering WTF do you duplicate the common check for target
> not being a descendent of source, but with different error value.  Until
> spotting that the check is about _source_ being a descendent of target
> rather than the other way round...

You mean:

          for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
                  if (p == mnt_to)
                          return -EINVAL;

I wasn't sure whether the resulting mount tree was sane under all
conditions for the service configuration update use-case. Feel free to
remove it.

