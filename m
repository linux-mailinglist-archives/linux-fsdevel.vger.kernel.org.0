Return-Path: <linux-fsdevel+bounces-70435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D021C9A4FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 07:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC9F3A545D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 06:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835B2FE059;
	Tue,  2 Dec 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mUt8iMWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0661F151C;
	Tue,  2 Dec 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657138; cv=none; b=GSQQu0b7ks20fzdfoY/hhg2cf+XhPWrAzglJle06RT9yep0hX+La8pUkM5KyE4tyferv2AzFARr4dIeah3ic/XYcxo+mbmfkAEjlyj4lNkdGg3dSpDGSMX3+ee/EPc00H23g46YHk5aVKjkLSX7bKR3SxisRsXy9hVTOhtLBpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657138; c=relaxed/simple;
	bh=Uq6N0xAtSBvoRj9BMIYS7LmkdCgAbwc9bNvAHfNSt3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh1kWa5bonqmkmZxYKvOdPGym+s8iY1OL7XbjwVZzT+lrcdW+5S8f5syjcJ7c1qjRh4Jbo/J9R2UY+6dN8k+bLiL85Vuoj0Dt9N8Kq6Y0q5CyF15BteX6miZxuvL3OhvbwLzlH9N9y45XgfBqvraBRFW8E+BuuP0VEwUmZHMM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mUt8iMWB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uYTB1rzwfpW5jBb/xp7MJKNsRackS/0Md4Xp3uSL2Ik=; b=mUt8iMWB7KN/bHuHujUcySi9UP
	R7iUksqB0kMkQUihsZTa+e+Vxtdsrs0xrWG6HYjyH6PFZ5psSdFyEk6cA4XP5/8FlTNPBCenVZaXN
	zAjc7Y+v6+mf8dlgsqz1Nut2XtgXjvyWLMUO5BZUIn+GAsLR9qKWHBNS2pWOpxUb1br8puCu22OTW
	zBR7GogQM5GNeGIyN/BSu4xp8nR2WOjDQCZcwvXZGRfkhejhOF+eGJmn4HmQU12zxyxicDoblb9pi
	sc43ZfIkCNCumcSLw4eT14rBEVxCWftNOIlEKSj0Vf6dn6rpcVUDEpf1GhZ+cDFmGISDpZMUQYigC
	qI9l5Fzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQJw4-00000003GfH-3ser;
	Tue, 02 Dec 2025 06:32:28 +0000
Date: Tue, 2 Dec 2025 06:32:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
Message-ID: <20251202063228.GD1712166@ZenIV>
References: <20251201083226.268846-1-mjguzik@gmail.com>
 <20251201085117.GB3538@ZenIV>
 <20251202023147.GA1712166@ZenIV>
 <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
 <20251202055258.GB1712166@ZenIV>
 <CAGudoHFD6bWhp-8821Pb6cDAEnR9N8UFEj9qT7G-_v0FOS+_vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFD6bWhp-8821Pb6cDAEnR9N8UFEj9qT7G-_v0FOS+_vg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 02, 2025 at 07:18:16AM +0100, Mateusz Guzik wrote:

> The claim was not that your idea results in insurmountable churn. The
> claim was *both* your idea and runtime const require churn on per kmem
> cache basis. Then the question is if one is going to churn it
> regardless, why this way over runtime const. I do think the runtime
> thing is a little bit less churn and less work on the mm side to get
> it going, but then the runtime thing *itself* needs productizing
> (which I'm not signing up to do).

Umm...  runtime thing is lovely for shifts, but for pointers it's
going to be a headache on a bunch of architectures; for something
like dentry_hashtable it's either that or the cost of dereference,
but for kmem_cache I'd try it - if architecture has a good way for
"load a 64bit constant into a register staying within I$", I'd
expect the code generated for &global_variable to be not worse than
that, after all.

Churn is pretty much negligible in case of core kernel caches either
way.

As for the amount of churn in mm/*...  Turns out to be fairly minor;
kmem_cache_args allows to propagate it without any calling convention
changes.

I'll post when I get it to reasonable shape - so far it looks easy...

