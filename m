Return-Path: <linux-fsdevel+bounces-5899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98F811431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3740B20DB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC42E835;
	Wed, 13 Dec 2023 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9zQEcvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719432E626;
	Wed, 13 Dec 2023 14:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC2AC433CA;
	Wed, 13 Dec 2023 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702476419;
	bh=tm2PI5P6o9KPIR9RVFv5cihdxeSVXN3uEt/yiTzKpe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c9zQEcvQ/I/2TrO3daFju8Q2xvsVxymZ1J7YViFzMZ22+GvhKczCBu8rrJUDo+TO1
	 Anc8NUN4dA8ow4LVobcs6qb1jWphf9bw+jELBUPJqudNn/xWmkIMxcrIKvu8XEBcOa
	 WGHuZ4mBaB1rMvlvIqSSVkfP8pw0u8oJznFFXHh/0RHC1S6PyvN8OnGfzj5MLKjOEg
	 HySg5HD2tSeAL5m4LdWat8MD42qViAcfpBu0xgVl4Hr5NLzfEv0Y0pYxVLkLYlhamB
	 Yq4b1VHB5b6j9M45TKb0UiSQxQhkgwHVuLjWoh+MIYvXWbVA5RP95pk6+8WdFm9kYM
	 Og9EiU/75zGdQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so7992931e87.3;
        Wed, 13 Dec 2023 06:06:58 -0800 (PST)
X-Gm-Message-State: AOJu0YxucbavZ/Qjy1Vb5DUJJ0bNooCEMlRyYWncESP3UVIaMT1itJwG
	eoFJ3D54/QAFW0wqvhMXjfTn4/wgZTTOcI9qkw==
X-Google-Smtp-Source: AGHT+IEHGprK2wtm9q9hd2ZZLdtHsMouVaTGmtumsX7/XD4d3zOhREC7oFbL/aoRWTZ5IHg9+YH7vjYm3B+d1JvtS+g=
X-Received: by 2002:a19:8c5b:0:b0:50d:1733:ceba with SMTP id
 i27-20020a198c5b000000b0050d1733cebamr3208254lfj.58.1702476417164; Wed, 13
 Dec 2023 06:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-12-alexandru.elisei@arm.com> <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
 <ZXiMiLz9ZyUdxUP8@raptor> <CAL_Jsq+U_GR=mOK3-phnd4jeJKf79aOmhPwDOSj+f=s-7fZZWQ@mail.gmail.com>
 <ZXmr-Kl9L2SO13--@raptor>
In-Reply-To: <ZXmr-Kl9L2SO13--@raptor>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Dec 2023 08:06:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=P1Y6w38LD_xw+vK4CNqt22FW_FE9oi_XTLHVQEne7Q@mail.gmail.com>
Message-ID: <CAL_JsqL=P1Y6w38LD_xw+vK4CNqt22FW_FE9oi_XTLHVQEne7Q@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 7:05=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Hi Rob,
>
> On Tue, Dec 12, 2023 at 12:44:06PM -0600, Rob Herring wrote:
> > On Tue, Dec 12, 2023 at 10:38=E2=80=AFAM Alexandru Elisei
> > <alexandru.elisei@arm.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thank you so much for the feedback, I'm not very familiar with device=
 tree,
> > > and any comments are very useful.
> > >
> > > On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wrote:
> > > > On Sun, Nov 19, 2023 at 10:59=E2=80=AFAM Alexandru Elisei
> > > > <alexandru.elisei@arm.com> wrote:
> > > > >
> > > > > Allow the kernel to get the size and location of the MTE tag stor=
age
> > > > > regions from the DTB. This memory is marked as reserved for now.
> > > > >
> > > > > The DTB node for the tag storage region is defined as:
> > > > >
> > > > >         tags0: tag-storage@8f8000000 {
> > > > >                 compatible =3D "arm,mte-tag-storage";
> > > > >                 reg =3D <0x08 0xf8000000 0x00 0x4000000>;
> > > > >                 block-size =3D <0x1000>;
> > > > >                 memory =3D <&memory0>;    // Associated tagged me=
mory node
> > > > >         };
> > > >
> > > > I skimmed thru the discussion some. If this memory range is within
> > > > main RAM, then it definitely belongs in /reserved-memory.
> > >
> > > Ok, will do that.
> > >
> > > If you don't mind, why do you say that it definitely belongs in
> > > reserved-memory? I'm not trying to argue otherwise, I'm curious about=
 the
> > > motivation.
> >
> > Simply so that /memory nodes describe all possible memory and
> > /reserved-memory is just adding restrictions. It's also because
> > /reserved-memory is what gets handled early, and we don't need
> > multiple things to handle early.
> >
> > > Tag storage is not DMA and can live anywhere in memory.
> >
> > Then why put it in DT at all? The only reason CMA is there is to set
> > the size. It's not even clear to me we need CMA in DT either. The
> > reasoning long ago was the kernel didn't do a good job of moving and
> > reclaiming contiguous space, but that's supposed to be better now (and
> > most h/w figured out they need IOMMUs).
> >
> > But for tag storage you know the size as it is a function of the
> > memory size, right? After all, you are validating the size is correct.
> > I guess there is still the aspect of whether you want enable MTE or
> > not which could be done in a variety of ways.
>
> Oh, sorry, my bad, I should have been clearer about this. I don't want to
> put it in the DT as a "linux,cma" node. But I want it to be managed by CM=
A.

Yes, I understand, but my point remains. Why do you need this in DT?
If the location doesn't matter and you can calculate the size from the
memory size, what else is there to add to the DT?

Rob

