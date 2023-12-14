Return-Path: <linux-fsdevel+bounces-6130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF87813A61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BF1C20E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E24468B9F;
	Thu, 14 Dec 2023 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNQWZJxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A97208BD;
	Thu, 14 Dec 2023 18:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A97C433CA;
	Thu, 14 Dec 2023 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702580129;
	bh=nci52wgEP29pe93sJfvh7z3E961dOjZ6XELoPwO7AJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gNQWZJxLGAyg3thh8sppsdtne0S14JwyQcivHbHv7WO114nKNzDxo48NPc6NwYych
	 LICtIuEwziEeq/jC1lhaXr9ngYWoZaqo8fUMS/56euTdwBx/kPmE7C+R0ZGJ1IKzrC
	 tVwMMIGyAkxdOTcUZeHtX/oH7Bydean26t2VSLflEoxoggGkGn/iOrGO8984m5MjWF
	 6g6HOVwqpoozuR4ruL1FZairOzZ7r/I7gsRUbrIno5RR1LH/MvdqsoVIm43vGmBRJL
	 vDwFwwCLWushNGNgEe0Jm42brbIwAIz/lHY9dFRME70eLb5XNXSRgbJ4ah8tKyaXMg
	 S4KZ7ptfgHhzQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bf32c0140so9612505e87.1;
        Thu, 14 Dec 2023 10:55:29 -0800 (PST)
X-Gm-Message-State: AOJu0YxiTCAhY2AQ5BIIh/0VUE3tqq/dEH7sH5AZSHS4ZPq4T1cnOoUl
	5RhUfBRWtEf53n4Cfx0PVrbTm5G1zO+vPPMMhA==
X-Google-Smtp-Source: AGHT+IHH/MtbPf3CsSHjCsaUiPlKJlfOgEPCUUPp4Ha+UDKvnOS4RB7kkEQUG6S8vXVoP3f52VmIHsLn4Hf6iJQk34o=
X-Received: by 2002:ac2:51b0:0:b0:50b:fd52:e629 with SMTP id
 f16-20020ac251b0000000b0050bfd52e629mr4153621lfk.125.1702580127399; Thu, 14
 Dec 2023 10:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231119165721.9849-12-alexandru.elisei@arm.com>
 <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
 <ZXiMiLz9ZyUdxUP8@raptor> <CAL_Jsq+U_GR=mOK3-phnd4jeJKf79aOmhPwDOSj+f=s-7fZZWQ@mail.gmail.com>
 <ZXmr-Kl9L2SO13--@raptor> <CAL_JsqL=P1Y6w38LD_xw+vK4CNqt22FW_FE9oi_XTLHVQEne7Q@mail.gmail.com>
 <ZXnE3724jYYSg4o6@raptor> <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>
 <ZXnthcg0BkEd-RgK@raptor> <CAL_JsqLAW0--F8R0oTaajN3YpbK2KgE6Ypn8tk4_pf_s=xC+aw@mail.gmail.com>
 <ZXsjFYKHkJM_JLCy@raptor>
In-Reply-To: <ZXsjFYKHkJM_JLCy@raptor>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Dec 2023 12:55:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJF7Bs6nGt0hdP25YTMpzPK8V3h6C5Thkh=PnzPbwFEkQ@mail.gmail.com>
Message-ID: <CAL_JsqJF7Bs6nGt0hdP25YTMpzPK8V3h6C5Thkh=PnzPbwFEkQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com, 
	steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com, 
	david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:45=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Hi,
>
> On Wed, Dec 13, 2023 at 02:30:42PM -0600, Rob Herring wrote:
> > On Wed, Dec 13, 2023 at 11:44=E2=80=AFAM Alexandru Elisei
> > <alexandru.elisei@arm.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 11:22:17AM -0600, Rob Herring wrote:
> > > > On Wed, Dec 13, 2023 at 8:51=E2=80=AFAM Alexandru Elisei
> > > > <alexandru.elisei@arm.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, Dec 13, 2023 at 08:06:44AM -0600, Rob Herring wrote:
> > > > > > On Wed, Dec 13, 2023 at 7:05=E2=80=AFAM Alexandru Elisei
> > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > >
> > > > > > > Hi Rob,
> > > > > > >
> > > > > > > On Tue, Dec 12, 2023 at 12:44:06PM -0600, Rob Herring wrote:
> > > > > > > > On Tue, Dec 12, 2023 at 10:38=E2=80=AFAM Alexandru Elisei
> > > > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Rob,
> > > > > > > > >
> > > > > > > > > Thank you so much for the feedback, I'm not very familiar=
 with device tree,
> > > > > > > > > and any comments are very useful.
> > > > > > > > >
> > > > > > > > > On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wro=
te:
> > > > > > > > > > On Sun, Nov 19, 2023 at 10:59=E2=80=AFAM Alexandru Elis=
ei
> > > > > > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Allow the kernel to get the size and location of the =
MTE tag storage
> > > > > > > > > > > regions from the DTB. This memory is marked as reserv=
ed for now.
> > > > > > > > > > >
> > > > > > > > > > > The DTB node for the tag storage region is defined as=
:
> > > > > > > > > > >
> > > > > > > > > > >         tags0: tag-storage@8f8000000 {
> > > > > > > > > > >                 compatible =3D "arm,mte-tag-storage";
> > > > > > > > > > >                 reg =3D <0x08 0xf8000000 0x00 0x40000=
00>;
> > > > > > > > > > >                 block-size =3D <0x1000>;
> > > > > > > > > > >                 memory =3D <&memory0>;    // Associat=
ed tagged memory node
> > > > > > > > > > >         };
> > > > > > > > > >
> > > > > > > > > > I skimmed thru the discussion some. If this memory rang=
e is within
> > > > > > > > > > main RAM, then it definitely belongs in /reserved-memor=
y.
> > > > > > > > >
> > > > > > > > > Ok, will do that.
> > > > > > > > >
> > > > > > > > > If you don't mind, why do you say that it definitely belo=
ngs in
> > > > > > > > > reserved-memory? I'm not trying to argue otherwise, I'm c=
urious about the
> > > > > > > > > motivation.
> > > > > > > >
> > > > > > > > Simply so that /memory nodes describe all possible memory a=
nd
> > > > > > > > /reserved-memory is just adding restrictions. It's also bec=
ause
> > > > > > > > /reserved-memory is what gets handled early, and we don't n=
eed
> > > > > > > > multiple things to handle early.
> > > > > > > >
> > > > > > > > > Tag storage is not DMA and can live anywhere in memory.
> > > > > > > >
> > > > > > > > Then why put it in DT at all? The only reason CMA is there =
is to set
> > > > > > > > the size. It's not even clear to me we need CMA in DT eithe=
r. The
> > > > > > > > reasoning long ago was the kernel didn't do a good job of m=
oving and
> > > > > > > > reclaiming contiguous space, but that's supposed to be bett=
er now (and
> > > > > > > > most h/w figured out they need IOMMUs).
> > > > > > > >
> > > > > > > > But for tag storage you know the size as it is a function o=
f the
> > > > > > > > memory size, right? After all, you are validating the size =
is correct.
> > > > > > > > I guess there is still the aspect of whether you want enabl=
e MTE or
> > > > > > > > not which could be done in a variety of ways.
> > > > > > >
> > > > > > > Oh, sorry, my bad, I should have been clearer about this. I d=
on't want to
> > > > > > > put it in the DT as a "linux,cma" node. But I want it to be m=
anaged by CMA.
> > > > > >
> > > > > > Yes, I understand, but my point remains. Why do you need this i=
n DT?
> > > > > > If the location doesn't matter and you can calculate the size f=
rom the
> > > > > > memory size, what else is there to add to the DT?
> > > > >
> > > > > I am afraid there has been a misunderstanding. What do you mean b=
y
> > > > > "location doesn't matter"?
> > > >
> > > > You said:
> > > > > Tag storage is not DMA and can live anywhere in memory.
> > > >
> > > > Which I took as the kernel can figure out where to put it. But mayb=
e
> > > > you meant the h/w platform can hard code it to be anywhere in memor=
y?
> > > > If so, then yes, DT is needed.
> > >
> > > Ah, I see, sorry for not being clear enough, you are correct: tag sto=
rage
> > > is a hardware property, and software needs a mechanism (in this case,=
 the
> > > dt) to discover its properties.
> > >
> > > >
> > > > > At the very least, Linux needs to know the address and size of a =
memory
> > > > > region to use it. The series is about using the tag storage memor=
y for
> > > > > data. Tag storage cannot be described as a regular memory node be=
cause it
> > > > > cannot be tagged (and normal memory can).
> > > >
> > > > If the tag storage lives in the middle of memory, then it would be
> > > > described in the memory node, but removed by being in reserved-memo=
ry
> > > > node.
> > >
> > > I don't follow. Would you mind going into more details?
> >
> > It goes back to what I said earlier about /memory nodes describing all
> > the memory. There's no reason to reserve memory if you haven't
> > described that range as memory to begin with. One could presumably
> > just have a memory node for each contiguous chunk and not need
> > /reserved-memory (ignoring the need to say what things are reserved
> > for). That would become very difficult to adjust. Note that the kernel
> > has a hardcoded limit of 64 reserved regions currently and that is not
> > enough for some people. Seems like a lot, but I have no idea how they
> > are (ab)using /reserved-memory.
>
> Ah, I see what you mean, reserved memory is about marking existing memory
> (from a /memory node) as special, not about adding new memory.
>
> After the memblock allocator is initialized, the kernel can use it for it=
s
> own allocations. Kernel allocations are not movable.
>
> When a page is allocated as tagged, the associated tag storage cannot be
> used for data, otherwise the tags would corrupt that data. To avoid this,
> the requirement is that tag storage pages are only used for movable
> allocations. When a page is allocated as tagged, the data in the associat=
ed
> tag storage is migrated and the tag storage is taken from the page
> allocator (via alloc_contig_range()).
>
> My understanding is that the memblock allocator can use all the memory fr=
om
> a /memory node. If the tags storage memory is declared in a /memory node,
> there exists the possibility that Linux will use tag storage memory for i=
ts
> own allocation, which would make that tags storage memory unmovable, and
> thus unusable for storing tags.

No, because the tag storage would be reserved in /reserved-memory.

Of course, the arch code could do something between scanning /memory
nodes and /reserved-memory, but that would be broken arch code.
Ideally, there wouldn't be any arch code in between those 2 points,
but it's complicated. It used to mainly be powerpc, but we keep adding
to the complexity on arm64.

> Looking at early_init_dt_scan_memory(), even if a /memory node if marked =
at
> hotpluggable, memblock will still use it, unless "movable_node" is set on
> the kernel command line.
>
> That's the reason why I'm not describing tag storage in a /memory node.  =
Is
> there way to tell the memblock allocator not to use memory from a /memory
> node?
>
> >
> > Let me give an example. Presumably using MTE at all is configurable.
> > If you boot a kernel with MTE disabled (or older and not supporting
> > it), then I'd assume you'd want to use the tag storage for regular
> > memory. Well, If tag storage is already part of /memory, then all you
> > have to do is ignore the tag reserved-memory region. Tweaking the
> > memory nodes would be more work.
>
> Right now, memory is added via memblock_reserve(), and if MTE is disabled
> (for example, via the kernel command line), the code calls
> free_reserved_page() for each tag storage page. I find that straightfowar=
d
> to implement.

But better to just not reserve the region in the first place. Also, it
needs to be simple enough to back port.

Also, does free_reserved_page() work on ranges outside of memblock
range (e.g. beyond end_of_DRAM())? If the tag storage happened to live
at the end of DRAM and you shorten the /memory node size to remove tag
storage, is it still going to work?

Rob

