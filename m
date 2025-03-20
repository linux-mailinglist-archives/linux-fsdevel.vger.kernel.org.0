Return-Path: <linux-fsdevel+bounces-44609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93767A6AA4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001C4178714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99C2144C9;
	Thu, 20 Mar 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAbNY+ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359A74BED
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485820; cv=none; b=cfjtvmdK9kmxIc2lldiLcWUlRJDtkzTuqxOP5aJe3ldUy0kAWnWeDhKNpyzTTsN8nfwxOqHgRF+I4iEQ0GD9zVGwdWQyyhwR8mLiP17yB1KUpSwwvpBosCwZoS/LQoDzelYf4g8CfP+ldJULz19O3PdBL/952p0P6oB94TaeX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485820; c=relaxed/simple;
	bh=MD923ETrfGNkwtBQ5Cc/qfTHEY4et7lO4KUdx0xtL4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq3FVfrMF1oij/qKGvRBUuYcmz30zF0kSfzjfGoURs4i0NwanlAmvce0OKpRNAljVbhH36x+LSgs60I4swdEMMurgQxhot05wE6IvQ2eBivnNYmY4xdNsY3eJ0+NboU8XWfFAyXnBiQ0N38tQ+zj95s/+RL/tBfySHwJ3VKip80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAbNY+ug; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769e30af66so320891cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742485816; x=1743090616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJR1TIVVvTn578naWfOFfrvhntkzNIdqhtCPD5htUrY=;
        b=CAbNY+ughpsCqFj66pO+UfNKRhD2Cb7e3Xyi2WiycdTg4JV5rl/pgRtlqeYp+fqP7A
         YAKwmiusIHRkFmP9o7Sz0fIVv5NV/wKPxQd5VpOtWf4bzLS+2/JDMRe39RIhZJWMbJNL
         O0vMpjudZG1GuM5VDRyLrF41+nr3TirtX+d/Eka65zQJtxiSU+5PembxDP0316FalZUS
         drYj9IGCLwmwBIgtCdGm3yi2aNuc4mnagQhDFjIl5HPuJZgtpMxz1pgWgYXsZ267kfE8
         p9vmq4bVwdltmjtXR+0t+lI6fspSbSXq1gzuvjR+PWEPlku3r9IzCuyVG7R9tSdZXAwA
         r+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742485816; x=1743090616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJR1TIVVvTn578naWfOFfrvhntkzNIdqhtCPD5htUrY=;
        b=BGgcfY2388i9ZGFuVItH0NcQSydxA3sPPMSHWGcTPtU39oXxS9KASyceafahIcqFYF
         333RXhA3C+F526gDQwP9DVQzlFyMabHyVw+f6PD5PGpCzAX2+PI1ANS3B/OQ1AFSvY4E
         g27zqEfI2Frgzh2TPJCMGZuqvEykXD9zr2bBO9voeRlCzw8reHKt9/p/8m9jJ1bSQ2PD
         L0IpaSnKp3PQC2KPbaRINKbsGG4jr08asESj3niyZjBP3xESts/3fCG8j2gAdnC5fOdI
         gZ6xMoa7HZky/DQaBne5cL5BzJT1bekHnlCsrbf5U/zMDqW0CqiSNS95566a6Sl9Iu36
         GqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpBSIl22lj7hBv52QicuYkBHHAqqk6ad04Sg/tdKCLdcmb1ybgHodXJay9IKzc6WZuySYXZzY3i/wHhbdq@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOQcQZ/lF2y7M0OqL7Ug0gLM2epErT25AQTFZJK6CsojFkK34
	a9R2X5dSFNKU7YQWxGu+WkVYI/cIodzgufEBBtK/Y4dEwrgfrMFHdc0+qm6FfVzy3w/scmoHk+K
	XQ+EDXI2AG/i/bj1AVS3p7qG2sP7mCaVA3hf7
X-Gm-Gg: ASbGncs+C45PJWoDyjS5YSRsQcu3JDduGru6csNIuF1crO6YaaE9Y5w1OJ8eoTTaobg
	ERXplxePSSMszKm9HO5NgX7vFxVmzFex+/RTm34V6aLyI8F+rXWuWg+KTpO2zglmHG08B77WHJc
	kOHaHs0gl4c84w8Hu+mzC6GhXjPi+lRI9dlWYnbWqR61T6mt/XZO+NcmCl
X-Google-Smtp-Source: AGHT+IG6fAJcDDHg+PLZXwTzgCSYZGoSylptNZVqM1MUG2yRD7/J0OXUbe4MwVWLdJRpwzGSJiXz6S5GGTmuk4J0KnM=
X-Received: by 2002:a05:622a:1f86:b0:476:f1a6:d8e8 with SMTP id
 d75a77b69052e-47712ba3267mr3875601cf.11.1742485815361; Thu, 20 Mar 2025
 08:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI2PR04MB11147C17A467F501A333073F4E8D82@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
In-Reply-To: <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 20 Mar 2025 08:50:04 -0700
X-Gm-Features: AQ5f1JrzqQe95iHFrWYdcG3JQVK_OMm648b8ZmU7db74dAXXkb2jCxtPKQECet8
Message-ID: <CAJuCfpGajtAP8-kw5B5mKmhfyq6Pn67+PJgMjBeozW-qzjQMkw@mail.gmail.com>
Subject: Re: Ask help about this patch b951aaff5035 " mm: enable page
 allocation tagging"
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Carlos Song <carlos.song@nxp.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:24=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Mar 20, 2025 at 11:07:41AM +0000, Carlos Song wrote:
> > Hi, all
> >
> > I found a 300ms~600ms IRQ off when writing 1Gb data to mmc device at I.=
MX7d SDB board at Linux-kernel-v6.14.
> > But I test the same case at Linux-kernel-v6.7, this longest IRQ off tim=
e is only 1ms~2ms. So the issue is introduced from v6.7~v6.14.
> >
> > Run this cmd to test:
> > dd if=3D/dev/zero of=3D/dev/mmcblk2p4 bs=3D4096 seek=3D12500 count=3D25=
6000 conv=3Dfsync
> >
> > This issue looks from blkdev_buffered_write() function. Because when I =
run this cmd with "oflag=3Ddirect" to use
> > blkdev_direct_write(), I can not see any long time IRQ off.
> >
> > Then I use Ftrace irqoff tracer to trace the longest IRQ off event, I f=
ound some differences between v6.7 and v6.14:
> > In iomap_file_buffered_write(), __folio_alloc (in v6.7) is replaced by =
_folio_alloc_noprof (in v6.14) by this patch.
> > The spinlock disabled IRQ ~300ms+. It looks there are some fixes for th=
is patch, but I still can see IRQ off 300ms+ at 6.14.0-rc7-next-20250319.

Do you have CONFIG_MEM_ALLOC_PROFILING enabled and if so, does the
issue disappear if you disable CONFIG_MEM_ALLOC_PROFILING?

> >
> > Do I trigger one bug? I know little about mem so I have to report it an=
d hope I can get some help or guide.
> > I put my ftrace log at the mail tail to help trace and explain.
>
> Did you track down which spinlock?
>
> >
> > commit b951aaff503502a7fe066eeed2744ba8a6413c89
> > Author: Suren Baghdasaryan surenb@google.com<mailto:surenb@google.com>
> > Date:   Thu Mar 21 09:36:40 2024 -0700
> >
> >     mm: enable page allocation tagging
> >
> >     Redefine page allocators to record allocation tags upon their invoc=
ation.
> >     Instrument post_alloc_hook and free_pages_prepare to modify current
> >     allocation tag.
> >
> >     [surenb@google.com: undo _noprof additions in the documentation]
> >       Link: https://lkml.kernel.org/r/20240326231453.1206227-3-surenb@g=
oogle.com
> >     Link: https://lkml.kernel.org/r/20240321163705.3067592-19-surenb@go=
ogle.com
> >     Signed-off-by: Suren Baghdasaryan surenb@google.com<mailto:surenb@g=
oogle.com>
> >     Co-developed-by: Kent Overstreet kent.overstreet@linux.dev<mailto:k=
ent.overstreet@linux.dev>
> >     Signed-off-by: Kent Overstreet kent.overstreet@linux.dev<mailto:ken=
t.overstreet@linux.dev>
> >     Reviewed-by: Kees Cook keescook@chromium.org<mailto:keescook@chromi=
um.org>
> >     Tested-by: Kees Cook keescook@chromium.org<mailto:keescook@chromium=
.org>
> >     Cc: Alexander Viro viro@zeniv.linux.org.uk<mailto:viro@zeniv.linux.=
org.uk>
> >     Cc: Alex Gaynor alex.gaynor@gmail.com<mailto:alex.gaynor@gmail.com>
> >     Cc: Alice Ryhl aliceryhl@google.com<mailto:aliceryhl@google.com>
> >     Cc: Andreas Hindborg a.hindborg@samsung.com<mailto:a.hindborg@samsu=
ng.com>
> >     Cc: Benno Lossin benno.lossin@proton.me<mailto:benno.lossin@proton.=
me>
> >     Cc: "Bj=C3=B6rn Roy Baron" bjorn3_gh@protonmail.com<mailto:bjorn3_g=
h@protonmail.com>
> >     Cc: Boqun Feng boqun.feng@gmail.com<mailto:boqun.feng@gmail.com>
> >     Cc: Christoph Lameter cl@linux.com<mailto:cl@linux.com>
> >     Cc: Dennis Zhou dennis@kernel.org<mailto:dennis@kernel.org>
> >     Cc: Gary Guo gary@garyguo.net<mailto:gary@garyguo.net>
> >     Cc: Miguel Ojeda ojeda@kernel.org<mailto:ojeda@kernel.org>
> >     Cc: Pasha Tatashin pasha.tatashin@soleen.com<mailto:pasha.tatashin@=
soleen.com>
> >     Cc: Peter Zijlstra peterz@infradead.org<mailto:peterz@infradead.org=
>
> >     Cc: Tejun Heo tj@kernel.org<mailto:tj@kernel.org>
> >     Cc: Vlastimil Babka vbabka@suse.cz<mailto:vbabka@suse.cz>
> >     Cc: Wedson Almeida Filho wedsonaf@gmail.com<mailto:wedsonaf@gmail.c=
om>
> >     Signed-off-by: Andrew Morton akpm@linux-foundation.org<mailto:akpm@=
linux-foundation.org>
> >
> >
> > Ftrace irqoff tracer shows detail:
> > At v6.14:
> > # tracer: irqsoff
> > #
> > # irqsoff latency trace v1.1.5 on 6.14.0-rc7-next-20250319
> > # --------------------------------------------------------------------
> > # latency: 279663 us, #21352/21352, CPU#0 | (M:NONE VP:0, KP:0, SP:0 HP=
:0 #P:2)
> > #    -----------------
> > #    | task: dd-805 (uid:0 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #  =3D> started at: __rmqueue_pcplist
> > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > #
> > #
> > #                    _------=3D> CPU#
> > #                   / _-----=3D> irqs-off/BH-disabled
> > #                  | / _----=3D> need-resched
> > #                  || / _---=3D> hardirq/softirq
> > #                  ||| / _--=3D> preempt-depth
> > #                  |||| / _-=3D> migrate-disable
> > #                  ||||| /     delay
> > #  cmd     pid     |||||| time  |   caller
> > #     \   /        ||||||  \    |    /
> >       dd-805       0d....    1us : __rmqueue_pcplist
> >       dd-805       0d....    3us : _raw_spin_trylock <-__rmqueue_pcplis=
t
> >       dd-805       0d....    7us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >       dd-805       0d....   10us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >       dd-805       0d....   12us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >       dd-805       0d....   15us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >       dd-805       0d....   17us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >       dd-805       0d....   19us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >    ...
> >       dd-805       0d.... 1535us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1538us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1539us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1542us+: try_to_claim_block <-__rmqueue_pcpli=
st
> >       dd-805       0d.... 1597us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1599us+: try_to_claim_block <-__rmqueue_pcpli=
st
> >       dd-805       0d.... 1674us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1676us+: try_to_claim_block <-__rmqueue_pcpli=
st
> >       dd-805       0d.... 1716us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1718us+: try_to_claim_block <-__rmqueue_pcpli=
st
> >       dd-805       0d.... 1801us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-805       0d.... 1803us+: try_to_claim_block <-__rmqueue_pcpli=
st
> > ...
> >      dd-805       0d.... 279555us : find_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-805       0d.... 279556us : find_suitable_fallback <-__rmqueue=
_pcplist
> >       dd-805       0d.... 279558us : find_suitable_fallback <-__rmqueue=
_pcplist
> >       dd-805       0d.... 279560us+: try_to_claim_block <-__rmqueue_pcp=
list
> >       dd-805       0d.... 279616us : find_suitable_fallback <-__rmqueue=
_pcplist
> >       dd-805       0d.... 279618us : __mod_zone_page_state <-__rmqueue_=
pcplist
> >       dd-805       0d.... 279620us : find_suitable_fallback <-__rmqueue=
_pcplist
> > ...
> >       dd-805       0d.... 279658us : find_suitable_fallback <-__rmqueue=
_pcplist
> >       dd-805       0d.... 279660us : _raw_spin_unlock_irqrestore <-__rm=
queue_pcplist
> >       dd-805       0d.... 279662us : _raw_spin_unlock_irqrestore
> >       dd-805       0d.... 279666us+: trace_hardirqs_on <-_raw_spin_unlo=
ck_irqrestore
> >       dd-805       0d.... 279712us : <stack trace>
> > =3D> get_page_from_freelist
> > =3D> __alloc_frozen_pages_noprof
> > =3D> __folio_alloc_noprof
> > =3D> __filemap_get_folio
> > =3D> iomap_write_begin
> > =3D> iomap_file_buffered_write
> > =3D> blkdev_write_iter
> > =3D> vfs_write
> > =3D> ksys_write
> > =3D> ret_fast_syscall
> >
> > At v6.7:
> > # tracer: irqsoff
> > #
> > # irqsoff latency trace v1.1.5 on 6.7.0
> > # --------------------------------------------------------------------
> > # latency: 2477 us, #146/146, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #=
P:2)
> > #    -----------------
> > #    | task: dd-808 (uid:0 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #  =3D> started at: _raw_spin_lock_irqsave
> > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > #
> > #
> > #                    _------=3D> CPU#
> > #                   / _-----=3D> irqs-off/BH-disabled
> > #                  | / _----=3D> need-resched
> > #                  || / _---=3D> hardirq/softirq
> > #                  ||| / _--=3D> preempt-depth
> > #                  |||| / _-=3D> migrate-disable
> > #                  ||||| /     delay
> > #  cmd     pid     |||||| time  |   caller
> > #     \   /        ||||||  \    |    /
> >       dd-808       0d....    1us!: _raw_spin_lock_irqsave
> >       dd-808       0d....  186us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  189us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  191us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  192us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  194us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  196us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  199us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d....  203us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d....  330us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  332us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  334us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  336us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  338us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  339us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  341us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d....  343us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d....  479us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  481us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  483us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  485us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  486us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  488us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  490us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d....  492us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d....  630us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  632us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  634us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  636us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  638us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  640us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  642us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d....  644us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d....  771us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  773us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  775us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  777us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  778us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  780us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  782us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d....  784us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d....  911us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  913us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  915us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  916us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  918us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  920us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d....  922us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d....  924us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1055us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1058us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1059us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1061us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1063us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1065us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1066us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1068us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1194us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1196us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1198us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1200us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1202us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1203us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1205us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1208us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1333us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1335us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1337us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1339us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1341us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1342us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1344us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1346us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1480us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1482us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1484us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1486us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1488us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1490us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1492us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1494us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1621us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1623us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1625us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1627us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1629us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1630us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1632us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1634us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1761us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1763us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1765us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1766us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1768us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1770us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1772us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1774us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 1900us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1902us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1903us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1905us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1907us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1909us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 1911us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 1913us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 2038us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2040us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2042us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2044us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2046us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2047us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2049us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2051us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2053us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 2055us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 2175us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2176us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2178us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2180us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2182us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2183us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2185us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2187us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2189us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2191us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2192us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2194us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 2196us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 2323us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2325us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2327us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2328us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2330us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2332us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2334us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2335us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2337us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2339us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2341us : find_suitable_fallback <-__rmqueue_p=
cplist
> >       dd-808       0d.... 2343us : steal_suitable_fallback <-__rmqueue_=
pcplist
> >       dd-808       0d.... 2345us!: move_freepages_block <-steal_suitabl=
e_fallback
> >       dd-808       0d.... 2470us : __mod_zone_page_state <-__rmqueue_pc=
plist
> >       dd-808       0d.... 2473us : _raw_spin_unlock_irqrestore <-__rmqu=
eue_pcplist
> >       dd-808       0d.... 2476us : _raw_spin_unlock_irqrestore
> >       dd-808       0d.... 2479us+: tracer_hardirqs_on <-_raw_spin_unloc=
k_irqrestore
> >       dd-808       0d.... 2520us : <stack trace>
> > =3D> get_page_from_freelist
> > =3D> __alloc_pages
> > =3D> __folio_alloc
> > =3D> __filemap_get_folio
> > =3D> iomap_write_begin
> > =3D> iomap_file_buffered_write
> > =3D> blkdev_write_iter
> > =3D> vfs_write
> > =3D> ksys_write
> > =3D> ret_fast_syscall
> >
> > Best Regard
> > Carlos Song
> >

