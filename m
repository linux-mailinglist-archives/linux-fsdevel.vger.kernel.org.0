Return-Path: <linux-fsdevel+bounces-65224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A170BFE6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A133A5BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3B2FE575;
	Wed, 22 Oct 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar1qImag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DC284672
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172379; cv=none; b=WV/ZYOI2YJVRf7RKovDcT/YmvPFK0NMlEXrcN4bqSc3JJ8h3ochK5xxLi7dsQd0jujKTj0B3tMj0TJxjgIaT5QnlOpVP9f4N1IRpbJmkjPnoq/WV1kqNWo/VQOy9hn885NFfxlKnlrACru7fb7SAnHk60I4yY5VQb+Uf4gOlUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172379; c=relaxed/simple;
	bh=onF2dEW2GT8z4+jPs6o/8tZ+jSkB9+bquGGz46WUlLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=offbTmZcZnXM5MYoaOFjMbqHZISDv9k4Zs01hgwlHvHY4vEXZ5eoG5QLrfpSYkTQjPH8QH8BxEBZWOi2BREjNpbrYAJ0Di98zDIDqb8M6xq0+5KJvCfC32+cVbG++hb5Dp3prcOdS7eb5xLvAoYE7IrqCajMdSG3Tvv45cJy1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar1qImag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285DBC2BCB3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761172379;
	bh=onF2dEW2GT8z4+jPs6o/8tZ+jSkB9+bquGGz46WUlLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ar1qImagDtvpiCGyN6GCkHI2EdgL3OVrIRYz7oDYU2WPoC9jaX3WZdi4JEXeovcyj
	 qE3J1kx5EzGZyWQOFZoG0gCYckXKbDJmC+AeI1eVD/lD3HDf3T2T4vkFDirT08KPb8
	 byzVxhlsag6qr1FQwmjpO3bEvKRM/T/IedDQEDF4EyrLAQC1FGkk/763o4/qRiaREO
	 3Rt/NkbTnmFPEYKJIgbMftkS5rr6Rp37AvGjL9+q8e48qyOZAfa0AzBGLs8Zw4G1yN
	 5VDtVzo3vdSoO2iCqRY+P+xfsxsq9sXSHAqO+GxI+rm0arIrEmvMNcJhp684/jDdJI
	 jSZi6uGsFjmlA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso188380a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 15:32:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWIZ8uNJk0gTjqvtHvG5fDLVeyLDwqfFEoGdghSxCQvakFElsRElOzOxzIG7OWG5vyjl6lKJ8/WTarBUY8@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeZGCLS2XGmMLI8G21gHY5uI66wpKpfKCHJSxr9c+IWU0A3nK
	A799q7LqtiWxHUBbIq9HGwdi/rgMsS+Ytmfz0jdXHdVmejIGZXUNRRKZCROyzzPboyG4onuZXiO
	gNAqjn2PaJmx3RrWaC0rO4DBSPiRj8Js=
X-Google-Smtp-Source: AGHT+IGjY3xy/N8H2wqZeaBT7Q7WCMfTzN80Zu4l3CFpCRIMxNiTLzqsv3MPxBrCf5VbHA/IgoUtg4NtTW1Rb+2HHjE=
X-Received: by 2002:a05:6402:440d:b0:639:ffb5:3604 with SMTP id
 4fb4d7f45d1cf-63c1f6edf8amr20301227a12.37.1761172377326; Wed, 22 Oct 2025
 15:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020749.5522-1-linkinjeon@kernel.org> <20251020183304.umtx46whqu4awijj@pali>
 <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
 <20251021221919.leqrmil77r2iavyo@pali> <CAKYAXd8iexxzsiEzBwyp6fWazDFME_ad4LUJdzJQFM6KjBOe=g@mail.gmail.com>
 <20251022185214.abdbkp7eqmcrnbhx@pali>
In-Reply-To: <20251022185214.abdbkp7eqmcrnbhx@pali>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Oct 2025 07:32:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9mun=jTbL2J8-d5Zfe8QuwCT-eM6c3p1Td05uxSE2yFQ@mail.gmail.com>
X-Gm-Features: AS18NWCxeXFizVpnSB5ZyfUOajGEqtne71go8Pa-jl-OM3pbTbZb0T4375NdvQI
Message-ID: <CAKYAXd9mun=jTbL2J8-d5Zfe8QuwCT-eM6c3p1Td05uxSE2yFQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, ebiggers@kernel.org, neil@brown.name, 
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:52=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Wednesday 22 October 2025 11:13:50 Namjae Jeon wrote:
> > On Wed, Oct 22, 2025 at 7:19=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > On Tuesday 21 October 2025 10:49:48 Namjae Jeon wrote:
> > > > On Tue, Oct 21, 2025 at 3:33=E2=80=AFAM Pali Roh=C3=A1r <pali@kerne=
l.org> wrote:
> > > > >
> > > > > Hello,
> > > > Hi Pali,
> > > > >
> > > > > Do you have a plan, what should be the future of the NTFS support=
 in
> > > > > Linux? Because basically this is a third NTFS driver in recent ye=
ars
> > > > > and I think it is not a good idea to replace NTFS driver every de=
cade by
> > > > > a new different implementation.
> > > > Our product is currently using ntfsplus without any issues, but we =
plan to
> > > > provide support for the various issues that are reported from users=
 or
> > > > developers once it is merged into the mainline kernel.
> > > > This is very basic, but the current ntfs3 has not provided this sup=
port
> > > > for the last four years.
> > > > After ntfsplus was merged, our next step will be to implement full =
journal
> > > > support. Our ultimate goal is to provide stable NTFS support in Lin=
ux,
> > > > utilities support included fsck(ntfsprogs-plus) and journaling.
> > >
> > > One important thing here is that all those drivers are implementing
> > > support for same filesystem. So theoretically they should be equivale=
nt
> > > (modulo bugs and missing features).
> > >
> > > So basically the userspace ntfs fs utils should work with any of thos=
e
> > > drivers and also should be compatible with Windows ntfs.sys driver.
> > > And therefore independent of the used kernel driver.
> > >
> > > It would be really nice to have working fsck utility for ntfs. I hope
> > > that we would not have 3 ntfs mkfs/fsck tools from 3 different projec=
t
> > > and every one would have different set of bugs or limitations.
> > >
> > > > >
> > > > > Is this new driver going to replace existing ntfs3 driver? Or sho=
uld it
> > > > > live side-by-side together with ntfs3?
> > > > Currently, it is the latter. I think the two drivers should compete=
.
> > > > A ntfs driver that users can reliably use for ntfs in their
> > > > products is what should be the one that remains.
> > > > Four years ago, ntfs3 promised to soon release the full journal and
> > > > public utilities support that were in their commercial version.
> > > > That promise hasn't been kept yet, Probably, It would not be easy f=
or
> > > > a company that sells a ntfs driver commercially to open some or all=
 sources.
> > > > That's why I think we need at least competition.
> > >
> > > I understand it. It is not really easy.
> > >
> > > Also same thing can happen with your new ntfsplus. Nobody knows what
> > > would happen in next one or two years.
> > Since I publicly mentioned adding write support to ntfs driver, I have =
devoted
> > a great deal of time and effort to fulfilling that while working on oth=
er tasks
> > in parallel. Your comment seems to undermine all the effort I have done
> > over the years.
>
> I'm really sorry, I did not mean it in that way. I just wanted to point
> that year is a very long period and unexpected things could happen.
> Nothing against your or any others effort.
I apologize for the misunderstanding. Thank you for clarifying that for me.

>
> > >
> > > > >
> > > > > If this new driver is going to replace ntfs3 then it should provi=
de same
> > > > > API/ABI to userspace. For this case at least same/compatible moun=
t
> > > > > options, ioctl interface and/or attribute features (not sure what=
 is
> > > > > already supported).
> > > > Sure, If ntfsplus replace ntfs3, it will support them.
> > > > >
> > > > > You wrote that ntfsplus is based on the old ntfs driver. How big =
is the
> > > > > diff between old ntfs and new ntfsplus driver? If the code is sti=
ll
> > > > > same, maybe it would be better to call it ntfs as before and cons=
truct
> > > > > commits in a way which will first "revert the old ntfs driver" an=
d then
> > > > > apply your changes on top of it (like write feature, etc..)?
> > > > I thought this patch-set was better because a lot of code clean-up
> > > > was done, resulting in a large diff, and the old ntfs was removed.
> > > > I would like to proceed with the current set of patches rather than
> > > > restructuring the patchset again.
> > >
> > > Sure. In the current form it looks to be more readable and easier for
> > > review.
> > >
> > > But I think that more developers could be curious how similar is the =
new
> > > ntfsplus to the old removed ntfs. And in the form of revert + changes=
 it
> > > is easier to see what was changed, what was fixed and what new develo=
ped.
> > >
> > > I'm just thinking, if the code has really lot of common parts, maybe =
it
> > > would make sense to have it in git in that "big revert + new changes"
> > > form?
> > >
> > > > >
> > > > > For mount options, for example I see that new driver does not use
> > > > > de-facto standard iocharset=3D mount option like all other fs dri=
ver but
> > > > > instead has nls=3D mount option. This should be fixed.
> > > > Okay, I will fix it on the next version.
> > > > >
> > > > > Pali
> > > > Thank you for your review:)

