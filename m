Return-Path: <linux-fsdevel+bounces-60145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D3B41E32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33890686770
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770702EC08C;
	Wed,  3 Sep 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icme4MtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C7271476
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900889; cv=none; b=Vc33iBA+xWQ6CDu+69GCVuoXuw379o08uBBSRMwwmsosBZ9e5uoe002PXsuBXbXr2iK8af8m50gvj/ffaxFGXYdUZ+gXdknNcDuKPa+TIotwwhQUvLkXtVVVVWg2Ztvr94Rb1q50TCVi0SkW8YiWLi4mnL+J47w7m3hhqXtiBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900889; c=relaxed/simple;
	bh=SgEIiuwLcSrw6MD5nIirqY+K5Kdo4DYK6RCMVmv6iUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUjEn9MIMWSRwitOsolCm3HorMx5mEqenpl6+qQGWvJDcbvk7ngAN+lATKsx3IsCxPRDsAF0SPoDuxc0U7UDwrTjpIiL01XQ168FmWDFiTzMcb4a9Ur1vzPfje5ecFBaXAGsVqA73JFzcTvjsyl8FUJFfFbD8ADCnaoNi4LLOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icme4MtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390A3C4CEF8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 12:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756900889;
	bh=SgEIiuwLcSrw6MD5nIirqY+K5Kdo4DYK6RCMVmv6iUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=icme4MtP4ixMvin/7G/0nNV41Gm1TQJmaJnJ0dW+OZ+2pjC6FpS51ykWY68Q3q+14
	 QiMjNyJiCm8+8H+sJQzbBTsxm/yMOhvgPmlrJYNAdsN+SqavaEMUjEnQflYunGPd2b
	 dGmPd6jG52GNocJHMyv68FOyD5koj5KZXoRlEbCfVK3q2VT2VyqProECVcl7dl5Yi+
	 qLTuj+fIRqC/f7rzHkSKFoUSdx1RxIZTCW3ON8l/d4hds/xQAY5luJP/FiHUJvkPfi
	 WYzxjnu9A+e5CRQCvCDnSEmvr4WqezDOISExJamkogn3CkTKr3RGipAySOYLdXVfnd
	 wyhDiaYHxzzjg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60504788so55052597b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 05:01:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEMO99M3SkgEOkNt0Tqzt9zzKxhaBA/OY7dEZ5GW7cV4bap5matP0u2+qY70HiBI//5kGxAdRqOtZRGOkn@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNB8nwEw2O5WePaw+m1J0aQOKhMVeo4kFBRPZaZFbLoitBJrk
	/4vbyWSIiUlT3+81QFcZjPgQ2tz9J3jOfiwwPIXUrtkwRLOJDv7ZE4d99HpWtkLwbWPmkAuqequ
	ZtxJtlw3Xl02Ce/KK7ABo3y64txWJ0vvA98vpSmWJuQ==
X-Google-Smtp-Source: AGHT+IE4JH+G2zBjwcp5ZndEi3KH81dyDqIXqxzLOg6ubc41EehCrYJhcRJA7wdiZ97h/waR6UCU6+RrLKpBoRMuIMg=
X-Received: by 2002:a05:690c:6c91:b0:720:58fd:6433 with SMTP id
 00721157ae682-722764fde88mr185636597b3.35.1756900886929; Wed, 03 Sep 2025
 05:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com> <20250902134156.GM186519@nvidia.com>
In-Reply-To: <20250902134156.GM186519@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Sep 2025 05:01:15 -0700
X-Gmail-Original-Message-ID: <CACePvbWGR+XPfTub41=Ekj3aSMjzyO+FyJmzMy5HEQKq0-wqag@mail.gmail.com>
X-Gm-Features: Ac12FXxFJL5c-w1tGynHxdN6KdFavaA7kvNM60j8pd-MmHVmJ4Um0SW70V3tLbU
Message-ID: <CACePvbWGR+XPfTub41=Ekj3aSMjzyO+FyJmzMy5HEQKq0-wqag@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:42=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:18:43PM -0700, Chris Li wrote:
>
> > Another idea is that having a middle layer manages the life cycle of
> > the reserved memory for you. Kind of like a slab allocator for the
> > preserved memory.
>
> If you want a slab allocator then I think you should make slab
> preservable.. Don't need more allocators :\

Sure, we can reuse the slab allocator to add the KHO function to it. I
consider that as the implementation detail side, I haven't even
started yet. I just want to point out that we might want to have a
high level library to take care of the life cycle of the preserved
memory. Less boilerplate code for the caller.

> > Question: Do we have a matching FDT node to match the memfd C
> > structure hierarchy? Otherwise all the C struct will lump into one FDT
> > node. Maybe one FDT node for all C struct is fine. Then there is a
> > risk of overflowing the 4K buffer limit on the FDT node.
>
> I thought you were getting rid of FDT? My suggestion was to be taken
> as a FDT replacement..

Thanks for the clarification. Yes, I do want to get rid of FDT, very much s=
o.

If we are not using FDT, adding an object might change the underlying
C structure layout causing a chain reaction of C struct change back to
the root. That is where I assume you might be still using FDT. I see
your later comments address that with a list of objects. I will
discuss it there.

> You need some kind of hierarchy of identifiers, things like memfd
> should chain off some higher level luo object for a file descriptor.

Ack.

>
> PCI should be the same, but not fd based.

Ack.

> It may be that luo maintains some flat dictionary of
>   string -> [object type, version, u64 ptr]*

I see, got it. That answers my question of how to add a new object
without changing the C structure layout. You are using a list of the
same C structure. When adding more objects to it, just add more items
to the list. This part of the boiler plate detail is not mentioned in
your original suggestion.  I understand your proposal better now.

> And if you want to serialize that the optimal path would be to have a
> vmalloc of all the strings and a vmalloc of the [] data, sort of like
> the kho array idea.

The KHO array idea is already implemented in the existing KHO code or
that is something new you want to propose?

Then we will have to know the combined size of the string up front,
similar to the FDT story. Ideally the list can incrementally add items
to it. May be stored as a list as raw pointer without vmalloc
first,then have a final pass vmalloc and serialize the string and
data.

With the additional detail above, I would like to point out something
I have observed earlier: even though the core idea of the native C
struct is simple and intuitive, the end of end implementation is not.
When we compare C struct implementation, we need to include all those
additional boilerplate details as a whole, otherwise it is not a apple
to apple comparison.

> > At this stage, do you see that exploring such a machine idea can be
> > beneficial or harmful to the project? If such an idea is considered
> > harmful, we should stop discussing such an idea at all. Go back to
> > building more batches of hand crafted screws, which are waiting by the
> > next critical component.
>
> I haven't heard a compelling idea that will obviously make things
> better.. Adding more layers and complexity is not better.

Yes, I completely understand how you reason it, and I agree with your
assessment.

I like to add to that you have been heavily discounting the
boilerplate stuff in the C struct solution. Here is where our view
point might different:
If the "more layer" has its counterpart in the C struct solution as
well, then it is not "more", it is the necessary evil. We need to
compare apples to apples.

> Your BTF proposal doesn't seem to benifit memfd at all, it was focused
> on extracting data directly from an existing struct which I feel very
> strongly we should never do.

From data flow point of view, the data is get from a C struct and
eventually store into a C struct. That is no way around that. That is
the necessary evil if you automate this process. Hey, there is also no
rule saying that you can't use a bounce buffer of some kind of manual
control in between.

It is just a way to automate stuff to reduce the boilerplate. We can
put different label on that and escalate that label or concept is bad.
Your C struct has the exact same thing pulling data from the C struct
and storing into C struct. It is just the label we are arguing. This
label is good and that label is bad. Underlying it has the similar
common necessary evil.

> The above dictionary, I also don't see how BTF helps. It is such a
> special encoding. Yes you could make some elaborate serialization
> infrastructure, like FDT, but we have all been saying FDT is too hard
> to use and too much code. I'm not sure I'm convinced there is really a

Are you ready to be connived? If you keep this as a religion you can
never be convinced.

The reason FDT is too hard to use have other reason. FDT is design to
be constructed by offline tools. In kernel mostly just read only. We
are using FDT outside of its original design parameter. It does not
mean that some thing (the machine) specially design for this purpose
can't be build and easier to use.

> better middle ground :\

With due respect, it sounds like you have the risk of judging
something you haven't fully understood. I feel that a baby, my baby,
has been thrown out with the bathwater.

As a test of water for the above statement, can you describe my idea
equal or better than I do so it passes the test of I say: "yes, this
is exactly what I am trying to build".

That is the communication barrier I am talking about. I estimate at
this rate it will take us about 15 email exchanges to get to the core
stuff. It might be much quicker to lock you and me in a room, Only
release us when you and I can describe each other's viewpoint at a
mutual satisfactory level. I understand your time is precious, and I
don't want to waste your time. I fully respect and comply with your
decision. If you want me to stop now, I can stop. No question asked.

That gets back to my original question, do we already have a ruling
that even the discussion of "the machine" idea is forbidden.

> IMHO if there is some way to improve this it still yet to be found,

In my mind, I have found it. I have to get over the communication
barrier to plead my case to you. You can issue a preliminary ruling to
dismiss my case. I just wish you fully understood the case facts
before you make such a ruling.

> and I think we don't well understand what we need to serialize just
> yet.

That may be true, we don't have 100% understanding of what needs to be
serialized.  On the other hand, it is not 0% either. Based on what we
understand, we can already use "the machine" to help us do what we
know much more effectively. Of course, there is a trade off for
developing "the machine". It takes extra time and the complexity to
maintain such a machine. I fully understand that.

> Smaller ideas like preserve the vmalloc will make big improvement
> already.

Yes, I totally agree. It is a local optimization we can do, it might
not be the global optimized though. "the machine" might not use
vmalloc at all, all this small incremental change will be throw away
once we have "the machine".

I put this situation in the airplane story, yes, we build diamond
plated filers to produce the hand craft screws faster. The missing
opportunity is that, if we have "the machine" earlier, we can pump out
machined screws much faster at scale, minus the time to build the
machine, it might still be an overall win. We don't need to use
diamond plated filter if we have the machine.

> Lets not race ahead until we understand the actual problem properly.

Is that the final ruling? It feels like so. Just clarifying what I am recei=
ving.

I feel a much stronger sense of urgency than you though.  The stakes
are high, currently you already have four departments can use this
common serialization library right now:
1) PCI
2) VFIO
3) IOMMU
4) Memfd.

We are getting into the more complex data structures. If we merge this
into the mainline, it is much harder to pull them out later.
Basically, this is a done deal. That is why I am putting my reputation
and my job on the line to pitch "the machine" idea. It is a very risky
move, I fully understand that.

Chris

