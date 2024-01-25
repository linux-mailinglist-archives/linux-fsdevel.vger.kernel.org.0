Return-Path: <linux-fsdevel+bounces-8842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2C83BC68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12381C23978
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0221B969;
	Thu, 25 Jan 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOaqkHxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC811B958
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173045; cv=none; b=B2cU1OmJhL1P0oFFBwg9Hkhw/BVXSqKxFj22oAi27/wMub7TjNXcBCxpjXWBn57xriauwdF2KqoXVSXf+8kFkSyobq9+m6R35vU2p4ZYMcPPE74bPoVGAMw6T1wBSqQnzMfiUEfqwxmHIBre00l7e6W+nySSW48jBA9mSgh2R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173045; c=relaxed/simple;
	bh=23Lb8W/5QooObKMfINUGuu1drcARK0pUG17BP4aKXEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax020BdMXqCeh3vJ6gPj4yuzWOw4sBc7RFXNldSQ+n/FfGnUJyqxOyY8RuG98tY3QplnwG5dGV1qUszyGW/gYVU5DhtCeyIxYFbA3QHyw47Nrylm745KZZHOB5BWgi25uMbkWuTF0TpQ1yGo7ejc/+HIMldf59KCmdJx2Ol1dR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOaqkHxl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11753a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706173041; x=1706777841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r7lJ7sqN6ad0sss1zSzMT057tYjk1irl2K8XfZBIhM=;
        b=KOaqkHxl2Lvpcz3UwCNCcc9ppiVXRn4MyZmR1X64T00luoW3DRIk9f5+zlIkYFYvo7
         JXtZI65T3hlHtvzCTQzXL1P/GS87rFmLOB2cyN7SmsEJ2zVFD0J8FOtijb5zxSL9hlDo
         tENrUoh2SwGnK20we0lfsZ90mEpOLhzFZoJ90naJvJPE83DNq3OwxwiHMAm3MekrhLM1
         2j+fHfxtK5MyY5YbRtx8LPogLtXKlOY8ulbku6o8bjBvh2irc3vOJo/lq8rMk7rV9sQK
         uTy9w2u6m8j+s4/piEuU8xakMzrg2l2bL20i7J6AxZFQTLZg+AJpktO3A1sNEdlEKgCo
         Quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173041; x=1706777841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r7lJ7sqN6ad0sss1zSzMT057tYjk1irl2K8XfZBIhM=;
        b=Gd/3fo0XXpe7txtipU9c6NpLEb/DaC9+cq3rrOBt3tzepHsIWPKTTuQ3dUO/rzRY2G
         znYD6LfSQVbiCO+TM2/srRiwrWABsdQpBWyDG8TG+7J7d0dcaDINet0Gc2ioNub8j2Na
         v+4YJZhQxIEXfSDrc9PNbice5tIDAMk0kLfsI69RvcLyACsDRkql7SxTF0v+TvxmJjSU
         bOpDyQa1VrJoWNUXNPDymhfF0nOtVbhI0UDYdhq+cYQNmKlrtvdXlA4jISTRzn8eX4wc
         SyNflKlziEmVQiqHOj4g+YhT6tEn3GmUFmK0WpDON6pTi+54Kxa3O+2IHEX+6U65/Br8
         Qw6A==
X-Gm-Message-State: AOJu0YxU4srZQrYurJaj29FtNjFpclXANUrTIXOJGa4XA0Ow4QvzSbO8
	ArrNvkSkzhQD/g/xcCCkzmbp/T2EuvpqAW8DcVguh1uWyWRhRVOyRhZhYwuFnWQsJwEKeDxGpQu
	r1cW5gO0gaYADr9Ng/zR3ZDj/RuZDF8B+AVE3
X-Google-Smtp-Source: AGHT+IFb+LIomVFJLxtbxSDpe6zo+tHbcilYXj7QQv606bK/OZ61L+h8gWh+oUEOpBPLNWikPfrmSKdILBy/PKO3PEI=
X-Received: by 2002:a05:6402:290b:b0:55c:2493:2b31 with SMTP id
 ee11-20020a056402290b00b0055c24932b31mr109377edb.3.1706173041208; Thu, 25 Jan
 2024 00:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org> <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org> <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
 <Za6h-tB7plgKje5r@casper.infradead.org> <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
 <4f78fea2-ced6-fc5a-c7f2-b33fcd226f06@huawei.com> <CANn89iKbyTRvWEE-3TyVVwTa=N2KsiV73-__2ASktt2hrauQ0g@mail.gmail.com>
 <d68f50a5-8d83-99ba-1a5a-7f119cd52029@huawei.com>
In-Reply-To: <d68f50a5-8d83-99ba-1a5a-7f119cd52029@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 09:57:10 +0100
Message-ID: <CANn89iJSxsx_6oTM+ggo90vacNM33e_DpgJJg1HQRfkdj3ewqg@mail.gmail.com>
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:18=E2=80=AFAM zhangpeng (AS) <zhangpeng362@huawei=
.com> wrote:
>
> On 2024/1/24 18:11, Eric Dumazet wrote:
>
> > On Wed, Jan 24, 2024 at 10:30=E2=80=AFAM zhangpeng (AS) <zhangpeng362@h=
uawei.com> wrote:
> >>
> >> By using git-bisect, the patch that introduces this issue is 05255b823=
a617
> >> ("tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive."). v4.18=
-rc1.
> >>
> >> Currently, there are no other repro or c reproduction programs can rep=
roduce
> >> the issue. The syz log used to reproduce the issue is as follows:
> >>
> >> r3 =3D socket$inet_tcp(0x2, 0x1, 0x0)
> >> mmap(&(0x7f0000ff9000/0x4000)=3Dnil, 0x4000, 0x0, 0x12, r3, 0x0)
> >> r4 =3D socket$inet_tcp(0x2, 0x1, 0x0)
> >> bind$inet(r4, &(0x7f0000000000)=3D{0x2, 0x4e24, @multicast1}, 0x10)
> >> connect$inet(r4, &(0x7f00000006c0)=3D{0x2, 0x4e24, @empty}, 0x10)
> >> r5 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\x00=
',
> >> 0x181e42, 0x0)
> >> fallocate(r5, 0x0, 0x0, 0x85b8818)
> >> sendfile(r4, r5, 0x0, 0x3000)
> >> getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
> >> &(0x7f00000001c0)=3D{&(0x7f0000ffb000/0x3000)=3Dnil, 0x3000, 0x0, 0x0,
> >> 0x0, 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=3D0x10)
> >> r6 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\x00=
',
> >> 0x181e42, 0x0)
> >>
> > Could you try the following fix then ?
> >
> > (We also could remove the !skb_frag_off(frag) condition, as the
> > !PageCompound() is necessary it seems :/)
> >
> > Thanks a lot !
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 1baa484d21902d2492fc2830d960100dc09683bf..ee954ae7778a651a9da4de0=
57e3bafe35a6e10d6
> > 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1785,7 +1785,9 @@ static skb_frag_t *skb_advance_to_frag(struct
> > sk_buff *skb, u32 offset_skb,
> >
> >   static bool can_map_frag(const skb_frag_t *frag)
> >   {
> > -       return skb_frag_size(frag) =3D=3D PAGE_SIZE && !skb_frag_off(fr=
ag);
> > +       return skb_frag_size(frag) =3D=3D PAGE_SIZE &&
> > +              !skb_frag_off(frag) &&
> > +              !PageCompound(skb_frag_page(frag));
> >   }
> >
> >   static int find_next_mappable_frag(const skb_frag_t *frag,
>
> This patch doesn't fix this issue. The page cache that can trigger this i=
ssue
> doesn't necessarily need to be compound. =F0=9F=99=81

Ah, too bad :/

So the issue is that the page had a mapping. I am no mm expert,
I am not sure if we need to add more tests (like testing various
illegal page flags) ?

Can you test this ?

(I am still  converting the repro into C)

Thanks.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1baa484d21902d2492fc2830d960100dc09683bf..2128015227a5066ea74b3911eca=
efe7992da132f
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1785,7 +1785,17 @@ static skb_frag_t *skb_advance_to_frag(struct
sk_buff *skb, u32 offset_skb,

 static bool can_map_frag(const skb_frag_t *frag)
 {
-       return skb_frag_size(frag) =3D=3D PAGE_SIZE && !skb_frag_off(frag);
+       struct page *page;
+
+       if (skb_frag_size(frag) !=3D PAGE_SIZE || skb_frag_off(frag))
+               return false;
+
+       page =3D skb_frag_page(frag);
+
+       if (PageCompound(page) || page->mapping)
+               return false;
+
+       return true;
 }

 static int find_next_mappable_frag(const skb_frag_t *frag,

