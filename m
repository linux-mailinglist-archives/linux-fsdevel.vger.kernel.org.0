Return-Path: <linux-fsdevel+bounces-21667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE78907BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F167284920
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BC614B09E;
	Thu, 13 Jun 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdc0pr7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85234139CFE;
	Thu, 13 Jun 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304485; cv=none; b=r9sdCIh3yax/6Q85GNLnUDbjzovFrjf1tevvDaJ/zusdJXoNKiI9jQbRvcXcuWG+MMvu0tsztgJIDfOUWWrotuLmuBRn31Xi7Ku5W3hlJj8UHHRVmdcs10vle6Q4gH7tu9h0HheJIZKIcngXmqPfvaFO31rxgZ0JjsNEY7z3QZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304485; c=relaxed/simple;
	bh=jDC2WopaP8wwQT8tkhJXoTaLu7lhe4KWedRpM6w6EXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njCH4w/4m8WvMo+N+7KyZcD0WDZNJ2Wb1P7yqgPf8jlMTsf857OWojkTiHK0Um863A6TCHFfX3l18MlPjROPrII7xcyRcluc8rT+FkEHYXf9b/Gow3x4Reo9OAfCR+vcNsdC8QliSqWbVIGP63Iyd2XHKz9PunSuaAJ0eClwQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdc0pr7q; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so12394981fa.2;
        Thu, 13 Jun 2024 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718304482; x=1718909282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAHHUmlI1HZMnU0nOLjhl7EwWJ339LXWesOFBL1gGLM=;
        b=Hdc0pr7qUgMfT7F+JUPcEQrK2D8elIzUhPMx1EGtt412ohgY1Rue/+19K+nxn1TpWm
         VV+gWQWtzJ4UJvxPkEczsB8TvX7a67RfPIDtieaZCaJEXCQQ6CcUc2bFBFmv/4U5khmm
         +mEyWqPU/eF2zFGAZmSyk2LxMnfbnZFNPCyfm5kr7L+fuENeAf02nhg59rwxaWMDx0a/
         jSfLc1uZ0YjJBI5GJTDWoFOrQHdU51qMptMXj3LG9vKacfqXRc3KQtyskehHOG4etPyg
         fNq0uQhouxK0iJfkEUFIgtrnRcg7nvO3/zkAZ79/wHWu3JvtfzPKYwymhX5Cw+ri7Gdi
         s/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304482; x=1718909282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAHHUmlI1HZMnU0nOLjhl7EwWJ339LXWesOFBL1gGLM=;
        b=nZpzQQCc1r/NwRNnOip/uUGGcPgXDXajkrEQHKpxdH9FEMGIOp9fqP3ehX9Mz4MUNc
         mgM4FAlCSuIvWocO5NpHEhuUtYHaXeRyht4sNzfSM26SyL9rXQfOSZknnKithoJtbcWE
         LpYpddV+KPTXAU91OHx4tN+M7SQ+oz3jwThHK9zcz/tP5/WChzId+1xFQETuhEiEQaSY
         +KFWJn8D3TjJOaxgPLUm7pO6iS+c3FKssPXGG1D1k/FUR//2WfKJ9Kh4yqdlABayzPIp
         m/+7pyd3H3m8eXjP/hDwqb0zOwZl+mS9D3nGph3acGdT+8zWlvabSOdKHImSdrkgpNXI
         3v0A==
X-Forwarded-Encrypted: i=1; AJvYcCUlr8Pz+962dn/U+ro8zatCL0qLPAFQaFEM7C/h63FX80u0Jz81AABAxmabf8ZfLERzyx+G1tRkY1mKDHFWtotW3syL2fLKJ0/jEEGBCu2o0Bt32p22wOJI4aHLmWf6fCYEtFuOn600f7GVvw==
X-Gm-Message-State: AOJu0Ywf6k58ClPjp3g0vmslV5M2uu2hfuaXcf8OKkQfUpCwIxG0n8fO
	E/6mCz+RNyC01RmL9lHY422A0wFXqXlEwGyEIZws/QC5Kncg5x+Wb8Kh1naWR3NWuBjQnIJpjNp
	58kc3Q45v2bWkSZIKpptmgbD5cDPK7ipk
X-Google-Smtp-Source: AGHT+IFz8yJ3m4VI8jyKyRrwDoI/7jlv6e++V4B/+LeXuJPq/nrLb4KGGPX1Q4uF7XPcFXDmpEXVGDW+meFXYTwCWn8=
X-Received: by 2002:a2e:9658:0:b0:2eb:68d0:88be with SMTP id
 38308e7fff4ca-2ec0e46df16mr4446241fa.12.1718304481334; Thu, 13 Jun 2024
 11:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com> <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
In-Reply-To: <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 13 Jun 2024 20:47:49 +0200
Message-ID: <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:43=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 13 Jun 2024 at 11:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I would assume the rule is pretty much well known and instead an
> > indicator where is what (as added in my comments) would be welcome.
>
> Oh, the rule is well-known, but I think what is worth pointing out is
> the different classes of fields, and the name[] field in particular.
>
> This ordering was last really updated back in 2011, by commit
> 44a7d7a878c9 ("fs: cache optimise dentry and inode for rcu-walk"). And
> it was actually somewhat intentional at the time. Quoting from that
> commit:
>
>     We also fit in 8 bytes of inline name in the first 64 bytes, so for s=
hort
>     names, only 64 bytes needs to be touched to perform the lookup. We sh=
ould
>     get rid of the hash->prev pointer from the first 64 bytes, and fit 16=
 bytes
>     of name in there, which will take care of 81% rather than 32% of the =
kernel
>     tree.
>

Right. Things degrading by accident is why I suggested BUILD_BUG_ON.

> but what has actually really changed - and that I didn't even realize
> until I now did a 'pahole' on it, was that this was all COMPLETELY
> broken by
>
>        seqcount_spinlock_t        d_seq;
>
> because seqcount_spinlock_t has been entirely broken and went from
> being 4 bytes back when, to now being 64 bytes.
>
> Crazy crazy.
>
> How did that happen?
>

perhaps lockdep in your config?

this is the layout on my prod config:
struct dentry {
        unsigned int               d_flags;              /*     0     4 */
        seqcount_spinlock_t        d_seq;                /*     4     4 */
        struct hlist_bl_node       d_hash;               /*     8    16 */
        struct dentry *            d_parent;             /*    24     8 */
        struct qstr                d_name;               /*    32    16 */
        struct inode *             d_inode;              /*    48     8 */
        unsigned char              d_iname[40];          /*    56    40 */
        /* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
        const struct dentry_operations  * d_op;          /*    96     8 */
        struct super_block *       d_sb;                 /*   104     8 */
        long unsigned int          d_time;               /*   112     8 */
        void *                     d_fsdata;             /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct lockref             d_lockref
__attribute__((__aligned__(8))); /*   128     8 */
        union {
                struct list_head   d_lru;                /*   136    16 */
                wait_queue_head_t * d_wait;              /*   136     8 */
        };                                               /*   136    16 */
        struct hlist_node          d_sib;                /*   152    16 */
        struct hlist_head          d_children;           /*   168     8 */
        union {
                struct hlist_node  d_alias;              /*   176    16 */
                struct hlist_bl_node d_in_lookup_hash;   /*   176    16 */
                struct callback_head d_rcu
__attribute__((__aligned__(8))); /*   176    16 */
        } d_u __attribute__((__aligned__(8)));           /*   176    16 */

        /* size: 192, cachelines: 3, members: 16 */
        /* forced alignments: 2 */
} __attribute__((__aligned__(8)));


--=20
Mateusz Guzik <mjguzik gmail.com>

