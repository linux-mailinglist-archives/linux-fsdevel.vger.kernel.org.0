Return-Path: <linux-fsdevel+bounces-67868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB6C4C9F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F744189DF52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A22EDD69;
	Tue, 11 Nov 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGClO8NE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700131E7C23
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852791; cv=none; b=WAmG8LKH3kxRiB6D05TpUTuf0mJsJBCLQqSfowKu5NN3sJLTIhzh/4PHIzG2Tq0vgTcoqVYXaWb2apxfnbWeiX8+3HwqW7M4Cfne1C6IFJBZ5DZ/WCjy9PDfCIPYNn5PAP0OhVBMB9u5GumSsXOzzTDmPNXd0IxkXc6PMJU5qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852791; c=relaxed/simple;
	bh=dVuTtHvnVZEobITrk9FyDHPMZXl5yRe3omNS/JcWa64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBYa9xU1IlxxgeE1QgTKwymWRU8mUaRodk9ezFR5cUfZDNypIUy2i9UYFe1bPrh34wyC3pPhLAq8RpguYfDtbCNYcRcrQpeeqfBoRlJFTbBUjltQetC3EVtvmEDPD9RiLRLq0jF9mrrQ8uWRoSjqwJBilMob8f05NNjC1zDyphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGClO8NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F073AC16AAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762852791;
	bh=dVuTtHvnVZEobITrk9FyDHPMZXl5yRe3omNS/JcWa64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vGClO8NE0KorCNpVq7YjjPoJy4vppAc1exbgNg08YFojL+dCZUmXYan4Wftv6Gmgv
	 GEa5Cfno24p5jxvYB/qDkaZk9C5q5w3kRLHUbzXznZ6oolxTsaWOZHMZ30eLed0sXX
	 Egq/iKpmX81Z2Ojm2N/HTq94Olgee+8BMC8ZQeiiffDB8QDkji4mseoLtGvE7ZrhYn
	 dP6Lyes8MmmyzNcHmC8Tv8TlcJnJCoZxEs+Jh5/+z/VVpJKPEC43Am3km0NAnjA2Au
	 zZAMssPqCgroICwsfk9a9tSlMA452D+MVB2qo029A00ncGyiyFIJrvq/hmj6vDJQzp
	 +9zlwlmMK1NvQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787be077127so40290217b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 01:19:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuuRZey6Wi9ARapcTVWs++yxiJ95OfoObYTYFLsoM9dHgKk43rQuzdBoTCWu9qpkSo92nMo40PA3RMxpby@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHgGrT2Gy5PLqt2Ab9s/7VFwzMcLkmL9jN4w7in5w07oRHaTW
	GSBxBhKnogdFY2U2Z5HcyL4CSPy2y84LHRY3Z07JDYXY943i5vkN3IAOFR5mgsFikEe8wBrMVAH
	Ust0LZj5+o1PXz5gUIRRhs/S6ieeDF3/75iGYWKaRfg==
X-Google-Smtp-Source: AGHT+IE7U/hfMH//RfLupvft/VoqtwYRbFfH+avnkA19gWihvYeZ3A5/gr7GLzY5y0EQ9dDLUE90MgX0MeQiFlzqDkk=
X-Received: by 2002:a05:690c:3341:b0:786:6b92:b1f5 with SMTP id
 00721157ae682-787d5439064mr100470067b3.47.1762852790107; Tue, 11 Nov 2025
 01:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
 <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
In-Reply-To: <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 11 Nov 2025 01:19:37 -0800
X-Gmail-Original-Message-ID: <CACePvbUHCrNNy38G4fZP92sdMY7k5pRQkcfo=iPp0=10T5oCEw@mail.gmail.com>
X-Gm-Features: AWmQ_bkffqW5YvxjFtC7ucCTeEYe-oG-VIvciMpKUSHdG9LRrce-7fJweHmox0c
Message-ID: <CACePvbUHCrNNy38G4fZP92sdMY7k5pRQkcfo=iPp0=10T5oCEw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:28=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> > > > I kind of wish the swap system could still use swp_entry_t. At leas=
t I
> > > > don't see any complete reason to massively rename all the swap syst=
em
> > > > code if we already know the entry is the limited meaning of swap en=
try
> > > > (device + offset).
> > >
> > > Well the reason would be because we are trying to keep things consist=
ent
> > > and viewing a swap entry as merely being one of the modes of a softle=
af.
> >
> > Your reason applies to the multi-personality non-present pte entries.
> > I am fine with those as softleaf. However the reasoning does not apply
> > to the swap entry where we already know it is for actual swap. The
> > multi-personality does not apply there. I see no conflict with the
> > swp_entry type there. I argue that it is even cleaner that the swap
> > codes only refer to those as swp_entry rather than softleaf because
> > there is no possibility that the swap entry has multi-personality.
>
> Swap is one of the 'personalities', very explicitly. Having it this way h=
ugely
> cleans up the code.
>
> I'm not sure I really understand your objection given the type will be
> bit-by-bit compatible.

Just to clarify. I only object to the blanket replacing all the
swp_entry_t to softleaf_t.
It seems you are not going to change the swp_entry_t for actual swap
usage, we are in alignment then.

BTW, about the name "softleaf_t", it does not reflect the nature of
this type is a not presented pte. If you have someone new to guess
what does  "softleaf_t" mean, I bet none of them would have guessed it
is a PTE  related value. I have considered  "idlepte_t", something
given to the reader by the idea that it is not a valid PTE entry. Just
some food for thought.

> I'll deal with this when I come to this follow-up series.
>
> As I said before I'm empathetic to conflicts, but also - this is somethin=
g we
> all have to live with. I have had to deal with numerous conflict fixups. =
They're
> really not all that bad to fix up.
>
> And again I'm happy to do it for you if it's too egregious.
>
> BUT I'm pretty sure we can just keep using swp_entry_t. In fact unless th=
ere's
> an absolutely compelling reason not to - this is exactly what I"ll do :)

Good.

> > > So this series will proceed as it is.
> >
> > Please clarify the "proceed as it is" regarding the actual swap code.
> > I hope you mean you are continuing your series, maybe with
> > modifications also consider my feedback. After all, you just say " But
> > I did think perhaps we could maintain this type explicitly for the
> > _actual_ swap code."
>
> I mean keeping this series as-is, of course modulo changes in response to=
 review
> feedback.
>
> To be clear - I have no plans whatsoever to change the actual swap code _=
in this
> series_ beyond what is already here.
>
> And in the follow-up that will do more on this - I will most likely keep =
the
> swp_entry_t as-is in core swap code or at least absolutely minimal change=
s
> there.

Ack

> And that series you will be cc'd on and welcome of course to push back on
> anything you have an issue with :)
>
> >
> > > However I'm more than happy to help resolve conflicts - if you want t=
o send
> > > me any of these series off list etc. I can rebase to mm-new myself if
> > > that'd be helpful?
> >
> > As I said above, leaving the actual swap code alone is more helpful
> > and I consider it cleaner as well. We can also look into incremental
> > change on your V2 to crave out the swap code.
>
> Well I welcome review feedback.
>
> I don't think I really touched anything particularly swap-specific that i=
s
> problematic, but obviously feel free to review and will absolutely try to
> accommodate any reasonable requests!
>
> >
> > >
> > > >
> > > > Does this renaming have any behavior change in the produced machine=
 code?
> > >
> > > It shouldn't result in any meaningful change no.
> >
> > That is actually the reason to give the swap table change more
> > priority. Just saying.
>
> I'm sorry but this is not a reasonable request. I am being as empathetic =
and
> kind as I can be here, but this series is proceeding without arbitrary de=
lay.
>
> I will do everything I can to accommodate any concerns or issues you may =
have
> here _within reason_ :)

I did not expect you to delay this. It is just expressing the
viewpoint that this is internal clean up for benefit the developers
rather than the end users.

Keep the existing swp_entry_t for the actual core swap usage is within
reasonable request. We already align on that.

Chris

