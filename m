Return-Path: <linux-fsdevel+bounces-45932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E807A7F7A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EC0173077
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7C263C97;
	Tue,  8 Apr 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYcXVTGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2E212B1E;
	Tue,  8 Apr 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100432; cv=none; b=VBBZWIav06GdMXQrbk4BnZOCX1rjIcmxtSTxNBTZQ7ZC7VrJTagL/q6i0+qbDe8z8VzbkAq0yKtlsrwMZcbBqN/9PkNDGaIh0CZIOdzbCQpVqRedhsfU8jmx7k1I+6WHKJlh1lwWS0c4Q5xvysFyrhyRipGuT5/lcruYjXykdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100432; c=relaxed/simple;
	bh=Gl8aKp8YPTXV6vYNBx5WZb1Y3vIRz7X/10qClRoa1ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN22RNCNg+P9jkxCiJQP7OZzbaqrvTzhu3FitDf/H/SgPq+14f7DJK34vaNfRgrbZAAKMWpmnsGHRdDeXdSKO1R71iu3CHBRKC43TCRubA0qIp7aJvVBSv8PLGlhF48NtFjsLWC9yflOmf7iiM60FKZkxfV6+mVE8+805/PDl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYcXVTGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA34C4CEE5;
	Tue,  8 Apr 2025 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744100431;
	bh=Gl8aKp8YPTXV6vYNBx5WZb1Y3vIRz7X/10qClRoa1ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYcXVTGlrj2UFsKmrHbtAvoofgPMX1u0d6/CD4+V20TsvQnKdJo/EEAz0ikU+VAr1
	 7r52Uw+Gu45agIKqKyDefSxnQzdeQn6Fd9/5cJaiURAE8N+Kr0ovvZ0yBQrJLmkzV6
	 WHbbu8ECVse8tCKEnlhAaJ4Fsbz252zkvHUSpotiA+g2jHUikFrKCxnNxPgm39PkMx
	 9PtG3+DrijSJRsOvkYrvMni0IomOKoe39NtmUlTTzItNtIBqj9UJ1VY4l2hbvitIqa
	 Y73UdqZhs1k9+w24iUFvuIEvpottq85HsCI2Qw2/DlHbCd0G0+rBI47iHbPwmZI2gz
	 c6D121dAJJPgw==
Date: Tue, 8 Apr 2025 10:20:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Ackerley Tng <ackerleytng@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk, muchun.song@linux.dev, 
	hughd@google.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	lorenzo.stoakes@oracle.com, jannh@google.com, ryan.roberts@arm.com, jthoughton@google.com, 
	peterx@redhat.com, graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, 
	derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <20250408-wegrand-eifrig-355127b5d3a3@brauner>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
 <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
 <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com>
 <2bohfxnbthvf3w4kz5u72wj5uxh5sb5s3mbhdk5eg2ingkpkqg@ylykphugpydy>
 <9326367c-977d-4d55-80bd-f1ad3673f375@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9326367c-977d-4d55-80bd-f1ad3673f375@redhat.com>

On Mon, Apr 07, 2025 at 04:46:48PM +0200, David Hildenbrand wrote:
> On 07.04.25 16:24, Liam R. Howlett wrote:
> > * Nikita Kalyazin <kalyazin@amazon.com> [250407 10:05]:
> > > 
> > 
> > ...
> > 
> > > > 
> > > > All of this is extremely confusing because the onus of figuring out what
> > > > the final code will look like is put on the reviewer.  As it is, we have
> > > > issues with people not doing enough review of the code (due to limited
> > > > time).  One way to get reviews is to make the barrier of entry as low as
> > > > possible.
> > > > 
> > > > I spent Friday going down a rabbit hole of patches referring to each
> > > > other as dependencies and I gave up.  It looks like I mistook one set of
> > > > patches as required vs them requiring the same in-flight ones as your
> > > > patches.
> > > > 
> > > > I am struggling to see how we can adequately support all of you given
> > > > the way the patches are sent out in batches with dependencies - it is
> > > > just too time consuming to sort out.
> > > 
> > > I'm happy to do whatever I can to make the review easier.  I suppose the
> > > extreme case is to wait for the dependencies to get accepted, effectively
> > > serialising submissions, but that slows the process down significantly.  For
> > > example, I received very good feedback on v1 and v2 of this series and was
> > > able to address it instead of waiting for the dependency.  Would including
> > > the required patches directly in the series help?  My only concern is in
> > > that case the same patch will be submitted multiple times (as a part of
> > > every depending series), but if it's better, I'll be doing that instead.
> > 
> > Don't resend patches that someone else is upstreaming, that'll cause
> > other problems.
> > 
> > Three methods come to mind:
> > 
> > 1. As you stated, wait for the dependencies to land.  This is will mean
> > what you are working against is well tested and won't change (and you
> > won't have to re-spin due to an unstable base).
> > 
> > 2. Combine them into a bigger patch set.  I can then pull one patch set
> > and look at the parts of interest to the mm side.
> > 
> > 3. Provide a git repo with the necessary changes together.
> > 
> > I think 2 and 3 together should be used for the guest_memfd patches.
> > Someone needs to be managing these to send upstream.  See the discussion
> > in another patch set on guest_memfd here [1].
> 
> The issue is that most extensions are fairly independent from each other,
> except that they built up on Fuad's mmap support,
> 
> Sending all together as one thing might not be the best option.
> 
> Once basic mmap support is upstream, some of the extensions (e.g., directmap
> removal) can go in next.
> 
> So until that is upstream, I agree that tagging the stuff that builds up on
> that is the right thing to do, and providing git trees is another very good
> idea.
> 
> I'll prioritize getting Fuad's mmap stuff reviewed. (I keep saying that, I
> know)

Fwiw, b4 allows to specify dependencies so you can b4 shazam/am and it
will pull in all prerequisite patches:

b4 prep --edit-deps           Edit the series dependencies in your defined $EDITOR (or core.editor)

