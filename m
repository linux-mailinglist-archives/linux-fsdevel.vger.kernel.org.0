Return-Path: <linux-fsdevel+bounces-40193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9BA20336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 03:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8DD3A522C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 02:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054A713AD1C;
	Tue, 28 Jan 2025 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vqulnEcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12D2943F;
	Tue, 28 Jan 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738032993; cv=none; b=WS2Ez1l/TFw0YS0c9VMJ+jcX+XELbk3xHCLBmxL2r0YovYJ3j4XnDXShoA0b4qFxVmegPWRGRF1WsQDSaT6n5PmWJSQZJMThvJG2xAL4KhBaKokHDHBwBGYyeeAZIJ90GFFBCxgTBdqVizXkjsUFNo/kDJPK/LaR/Brxh+RHXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738032993; c=relaxed/simple;
	bh=t5FDNw42ECXI5tcLn/Uyh6QRRKvjjVIPX5Gu5czjWWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTcB6BzXlIKI7gyyRX55VC3U5HhXAmzTUVRQHMuIlxOs2SSWlgJ/cR9HqrTI9JlZu4w+hO55eJduCdznRMXUMtIUDTIkIOrb9SbZ4nh7hs+xfmgAcgIkCfyKxy6KktfKoOCGe/aIrrPwMMe62TOLFFlgYy/x8Tp7w/b8XclHrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vqulnEcL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R8Y5wHexKqlzN203sNfTv+H8aZJ92fFvTRgDyEBFghI=; b=vqulnEcLnaCE8s0jbS9ITh7DKB
	zrlT6+uLf/p+jJB6Kecbfy5NkOCKXzwENN4iilb7qLfbI4y55doPlP+a/3PlKRcJi4olvlLsqqEKL
	iq76WBEeiF0mDz5NgHuypRj1teu1qnkOAGp6zZOcYpugCUuZVxVCt8oJRi4C0BqvNU1B2IeIQHqE0
	X+tgnSBI4T/YrgLIkW0ha3pfeiDLIM30LzXmftR12TT0s6Bjzw1l7aLexoBTfO2lRC9PkTYN5ZsKG
	R/y7YsfV2eNacQhWBw5X8KztV8Za/jOeAt6TkKHFixOTO7BRDLkE4vzfMO00MhoWJwrUmrS7SZl+e
	OTtjX2CQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcbm8-0000000Dt9c-0cn3;
	Tue, 28 Jan 2025 02:56:28 +0000
Date: Tue, 28 Jan 2025 02:56:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250128025628.GM1977892@ZenIV>
References: <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
 <20250128002659.GJ1977892@ZenIV>
 <CAHk-=wiyuiqR9wJ5pn_d-vmPL9uOFtTVuJsjVxkWvvwzhWEP4A@mail.gmail.com>
 <20250128012120.GL1977892@ZenIV>
 <CAHk-=whtfm7wKucbsT7=qSvtt7YZcQNmgn_cj3+h__1w7d_0WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtfm7wKucbsT7=qSvtt7YZcQNmgn_cj3+h__1w7d_0WQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 05:27:08PM -0800, Linus Torvalds wrote:
> On Mon, 27 Jan 2025 at 17:21, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Umm...  On some architectures it does, but mostly that's the ones
> > where unaligned word loads are costly.  Which target do you have
> > in mind?
> 
> I was more thinking that we could just make the fallback case be a 'memcmp()'.
> 
> It's not like this particular place matters - as you say, that
> byte-at-a-time code is only used on architectures that don't enable
> the dcache word-at-a-time code (that requires the special "do loads
> that can fault" zeropad helper), but we've had some other places where
> we'd worry about the string length.
> 
> Look at d_path() for another example. That copy_from_kernel_nofault()
> in prepend_copy()...

Hmm...  So something like

/*
 * Returns a pointer to name and a length; length might be
 * inaccurate in case of race with dentry renaming, but
 * it will not exceed the distance from returned pointer
 * to the end of containing object.
 * Caller MUST hold rcu_read_lock().
 * Caller MUST NOT expect the contents of name to remain
 * stable - it can change at any time.
 */
const char *__d_name_rcu(struct dentry *dentry, int *p)
{
	const char *name = smp_load_acquire(&dentry->d_name.name);

	if (unlikely(name != &dentry->d_shortname.string))
		*p = container_of(name, struct external_name, name)->len;
	else if (unlikely((*p = dentry->d_name.name) >= DNAME_INLINE_LEN)
		*p = DNAME_INLINE_LEN - 1;
	return name;
}

with very limited accessibility (basically, dcache.c and d_path.c)

prepend_name() might be able to use that...

