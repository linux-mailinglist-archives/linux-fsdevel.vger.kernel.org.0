Return-Path: <linux-fsdevel+bounces-5989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2504D811B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7F31C2115A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697A57869;
	Wed, 13 Dec 2023 17:44:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF63193;
	Wed, 13 Dec 2023 09:44:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4703EC15;
	Wed, 13 Dec 2023 09:45:39 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37DBF3F762;
	Wed, 13 Dec 2023 09:44:48 -0800 (PST)
Date: Wed, 13 Dec 2023 17:44:37 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
Message-ID: <ZXnthcg0BkEd-RgK@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-12-alexandru.elisei@arm.com>
 <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
 <ZXiMiLz9ZyUdxUP8@raptor>
 <CAL_Jsq+U_GR=mOK3-phnd4jeJKf79aOmhPwDOSj+f=s-7fZZWQ@mail.gmail.com>
 <ZXmr-Kl9L2SO13--@raptor>
 <CAL_JsqL=P1Y6w38LD_xw+vK4CNqt22FW_FE9oi_XTLHVQEne7Q@mail.gmail.com>
 <ZXnE3724jYYSg4o6@raptor>
 <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>

On Wed, Dec 13, 2023 at 11:22:17AM -0600, Rob Herring wrote:
> On Wed, Dec 13, 2023 at 8:51 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Hi,
> >
> > On Wed, Dec 13, 2023 at 08:06:44AM -0600, Rob Herring wrote:
> > > On Wed, Dec 13, 2023 at 7:05 AM Alexandru Elisei
> > > <alexandru.elisei@arm.com> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Tue, Dec 12, 2023 at 12:44:06PM -0600, Rob Herring wrote:
> > > > > On Tue, Dec 12, 2023 at 10:38 AM Alexandru Elisei
> > > > > <alexandru.elisei@arm.com> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > Thank you so much for the feedback, I'm not very familiar with device tree,
> > > > > > and any comments are very useful.
> > > > > >
> > > > > > On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wrote:
> > > > > > > On Sun, Nov 19, 2023 at 10:59 AM Alexandru Elisei
> > > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > > >
> > > > > > > > Allow the kernel to get the size and location of the MTE tag storage
> > > > > > > > regions from the DTB. This memory is marked as reserved for now.
> > > > > > > >
> > > > > > > > The DTB node for the tag storage region is defined as:
> > > > > > > >
> > > > > > > >         tags0: tag-storage@8f8000000 {
> > > > > > > >                 compatible = "arm,mte-tag-storage";
> > > > > > > >                 reg = <0x08 0xf8000000 0x00 0x4000000>;
> > > > > > > >                 block-size = <0x1000>;
> > > > > > > >                 memory = <&memory0>;    // Associated tagged memory node
> > > > > > > >         };
> > > > > > >
> > > > > > > I skimmed thru the discussion some. If this memory range is within
> > > > > > > main RAM, then it definitely belongs in /reserved-memory.
> > > > > >
> > > > > > Ok, will do that.
> > > > > >
> > > > > > If you don't mind, why do you say that it definitely belongs in
> > > > > > reserved-memory? I'm not trying to argue otherwise, I'm curious about the
> > > > > > motivation.
> > > > >
> > > > > Simply so that /memory nodes describe all possible memory and
> > > > > /reserved-memory is just adding restrictions. It's also because
> > > > > /reserved-memory is what gets handled early, and we don't need
> > > > > multiple things to handle early.
> > > > >
> > > > > > Tag storage is not DMA and can live anywhere in memory.
> > > > >
> > > > > Then why put it in DT at all? The only reason CMA is there is to set
> > > > > the size. It's not even clear to me we need CMA in DT either. The
> > > > > reasoning long ago was the kernel didn't do a good job of moving and
> > > > > reclaiming contiguous space, but that's supposed to be better now (and
> > > > > most h/w figured out they need IOMMUs).
> > > > >
> > > > > But for tag storage you know the size as it is a function of the
> > > > > memory size, right? After all, you are validating the size is correct.
> > > > > I guess there is still the aspect of whether you want enable MTE or
> > > > > not which could be done in a variety of ways.
> > > >
> > > > Oh, sorry, my bad, I should have been clearer about this. I don't want to
> > > > put it in the DT as a "linux,cma" node. But I want it to be managed by CMA.
> > >
> > > Yes, I understand, but my point remains. Why do you need this in DT?
> > > If the location doesn't matter and you can calculate the size from the
> > > memory size, what else is there to add to the DT?
> >
> > I am afraid there has been a misunderstanding. What do you mean by
> > "location doesn't matter"?
> 
> You said:
> > Tag storage is not DMA and can live anywhere in memory.
> 
> Which I took as the kernel can figure out where to put it. But maybe
> you meant the h/w platform can hard code it to be anywhere in memory?
> If so, then yes, DT is needed.

Ah, I see, sorry for not being clear enough, you are correct: tag storage
is a hardware property, and software needs a mechanism (in this case, the
dt) to discover its properties.

> 
> > At the very least, Linux needs to know the address and size of a memory
> > region to use it. The series is about using the tag storage memory for
> > data. Tag storage cannot be described as a regular memory node because it
> > cannot be tagged (and normal memory can).
> 
> If the tag storage lives in the middle of memory, then it would be
> described in the memory node, but removed by being in reserved-memory
> node.

I don't follow. Would you mind going into more details?

> 
> > Then there's the matter of the tag storage block size (explained in this
> > commit message), and also knowing the memory range for which a tag storage
> > region stores the tags. This is explained in the cover letter.
> 
> Honestly, I just forgot about that part.

I totally understand, there are a lot of things to consider at the same
time.

Thanks,
Alex

