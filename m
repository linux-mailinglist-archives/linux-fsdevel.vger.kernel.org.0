Return-Path: <linux-fsdevel+bounces-67976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D11AC4F5AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4463B9AD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0228725A;
	Tue, 11 Nov 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA4sqBM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD723D7FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884039; cv=none; b=WiWG7DvV89b3mh4E13fhvCp2yhnhsB+sFl5xqXAa2zIQPFGPJkPpaI8viOsFwvZc3eVX1Jtc7tfxflmymKQWqhBezy/Ijbamt9A3GAWBeP30Dnac87XHuWlt+/H/CaDsHhG4SrH5v1KaUDn+c6ukUYMqWdiSTYNL3e9w0NAQCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884039; c=relaxed/simple;
	bh=kATU/DzP4hdGvz7FmmPIwTVU+bE2WNBSBrXqQYIuJ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA43Z9MfM74J6IWvqerW7fcHwTMSq8s4opGXF8SJOKSg4Vj3yZ0XU8XhJiT9cey/Did/ndzyjfy0wIaJOAElgWSlhCfi8WeOGF06cjzDHaLUBMflUAS2/GZ+a8au32yaEc7po6Hi9ETluJbMdznaLFg/Wg/xekCy3E1V6BQmszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA4sqBM2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso4887798a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762884036; x=1763488836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HbiXIUVYuhI5l7PvzzJZfhSL3tvH5Y6RzQWs5tXFd0=;
        b=IA4sqBM2ne4i4nzd36VoMyLTV2HtAkNPNG/tdK2eCmfg6oO7xIqZa8pGzRUBzFi5Ir
         W31wAl6yefnb7o44jcwUorUOZfU1Vjd6V4sq+ICzXgGE3/ywcrlB2Sv2CcuwmCOoY+Mk
         auhMkjoPSKjKPU+l0Cq/zW/XX6xf+reW6eYo0k9auh5hHkwnG9DtCuhBU9zE4fEh58tC
         gyjdhfDXHuYUSs/mjOtu/z+PQF2CqMLpN9qawD0zyP1oFbdBCeWHhnwH7zURUYbYKXsg
         vCt3g9xAdGe4zF+7IYFMzXZuCJoFR4SaCBWsYFRIDQXFroPkNHW8FAt3zVaf4MkoDG5N
         KfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884036; x=1763488836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HbiXIUVYuhI5l7PvzzJZfhSL3tvH5Y6RzQWs5tXFd0=;
        b=R3o5B9qNHES7XTFEGZL82JZ78Tsk+T5rwWrqDwWn8FdHYnH+/kMS7KiOV9unNOyDIY
         doY2Q8OvQMDZQGgKP3lQnpbuI4sqfRWREnKzP720O1geYW1Myn8NkZfVpJ5jemdfUow/
         lNAoQ/GEiW9RLxDwFBv/Ix1z/Eg/4VU4E5G8jkme70zoDHMuhTvrgZ/E4zf9vME3LFqS
         t4J91l4ivdeuiD/kWUWs5Mps5A8F5hmyNyr+EqsswfiB3Oiq6GvpBY0LCf4HZH8yIFC3
         PLLXF6VVdhmtDGd2maXSVxbryoPhE0CetcwFQw0+E6vX6KChPDpY7fyoDRsG1oeGNhGG
         ZexA==
X-Forwarded-Encrypted: i=1; AJvYcCXfPpbywnGNUU4eB4ANak8SIPea5yecBmNKl2+LE/Qgja9P+sWnbMyOVGjTr3TkApVBpW2mODNJ0ZhxTfAI@vger.kernel.org
X-Gm-Message-State: AOJu0YwynswyofjrkgzNl1KUb3MGRznphBLuEhfl1CsVNPHkevCgWsjm
	DvjOpz5xiuKy6G/S2mJYUbBN5a4b2ZYSXmnQoFfys/2YPrHyvtt4ue3rd7AfiVPrqjnxHEdx3kD
	PL1Qdj2XQVvAerqtYG79rjcRi0P/kZR8=
X-Gm-Gg: ASbGncuGD+akw0Z7iX15KtIMqzHqLrc8q0jTzqRM0Hlqy9LvLuEHFXIbiJNAGiIh8Xb
	qhtspxiMhKP1HAQdML/cBj0H6dJ6mBfJ3UMfW3VDUreqH1m8dsSHVl9rUUBA+iBfGUVARXlsblj
	ckv6+RGgZ5NLrVIvT5utrTyFhTMfww1qzgHnYZhmUMe3DIeBN4QZQyGODLSr3egmZKX2kSAxL8f
	dlQVtQ2nKj2A9rLcJPmEhQNQ+Su7Y4p2wZbxt2qY63GoN+D/5UzDnVNK2hNfybsB4bPqEtGVetF
	0ps2CxIwm++AlZs=
X-Google-Smtp-Source: AGHT+IFuYz6RaM7hRc/WcQ4vZzXewSIOn8vea6fhjhW7Umd5v1YbFmLycKdc0r7yHCPCiDACpYaF/NZM++1eZ2f7y60=
X-Received: by 2002:a17:907:9709:b0:b46:abad:430e with SMTP id
 a640c23a62f3a-b7331a972abmr3512966b.37.1762884035562; Tue, 11 Nov 2025
 10:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110165901.1491476-1-mjguzik@gmail.com> <20251111033226.GP2441659@ZenIV>
In-Reply-To: <20251111033226.GP2441659@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 19:00:23 +0100
X-Gm-Features: AWmQ_bngX1Oah-ZA9B-eywkR85FJ9hEMiYvrt9XCFZFyl54Q2lTDQGDrkBjD5PM
Message-ID: <CAGudoHG1=RFjUE6cdqg4UJDvaA1QZfUnw++m7QZkwd4V8MZVtw@mail.gmail.com>
Subject: Re: [PATCH v4] fs: add predicts based on nd->depth
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:32=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Nov 10, 2025 at 05:59:01PM +0100, Mateusz Guzik wrote:
>
> > Given these results:
> > 1. terminate_walk() is called towards the end of the lookup. I failed
> >    run into a case where it has any depth to clean up. For now predict
> >    it does not.
>
> Easy - just have an error while resolving a nested symlink in the middle
> of pathname.  On success it will have zero nd->depth, of course.
>

Ok, I'll update the commit message.

> > 2. legitimize_links() is also called towards the end of lookup and most
> >    of the time there s 0 depth. Patch consumers to avoid calling into i=
t
> >    in that case.
>
> On transition from lazy to non-lazy mode on cache miss, ->d_revalidate()
> saying "dunno, try in non-lazy mode", etc.
>
> That can happen inside a nested symlink as well as on the top level, but
> the latter is more common on most of the loads.
>

Given the rest of the e-mail I take it you are clarifying when depth >
0 in this case, as opposed to contesting the predict.

> > 3. walk_component() is typically called with WALK_MORE and zero depth,
> >    checked in that order. Check depth first and predict it is 0.
>
> Does it give a measurable effect?

I did not benchmark this patch at all, merely checked for predicts
going the right way with bpftrace. What do I intend to benchmark is
the following: cleanup and inlining of func calls to walk_component()
and step_into(), which happen every time.

The routine got ->depth predicts in this patch because I was already
sprinkling it.

The current asm of walk_component() is penalized by lookup_slow(!)
being inlined and convincing the compiler to spill extra registers.
step_into() also looks like it can be shortened for the common case.

When inlined the compiler should be able to elide branching on WALK_MORE an=
yway.

You can find profiling info from a kernel running my patches (modulo
this one) here:
https://lore.kernel.org/linux-fsdevel/20251111-brillant-umgegangen-e7c89151=
3bce@brauner/T/#mee42496c2c6495a54c6b0b4da5c4121540ad92d9

walk_component() is hanging out there at over 2.7% and step_into() is
4.8%. I would suspect there is at least 1% total hiding here for
trivial fixups + inlining.

That said, I can drop this bit no problem and add it later to the
patchset which takes care of both walk_component() and step_into()
(which will come with benchmarks).

>
> > 4. link_path_walk() predicts not dealing with a symlink, but the other
> >    part of symlink handling fails to make the same predict. Add it.
>
> Unconvincing, that - one is "we have a component; what are the odds of th=
at
> component being a symlink?", another - "we have reached the end of pathna=
me
> or the end of nested symlink; what are the odds of the latter being the c=
ase?"
>

Fair, so I added the following crapper:

diff --git a/fs/dcache.c b/fs/dcache.c
index de3e4e9777ea..2bac37c09bf6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3268,3 +3268,7 @@ void __init vfs_caches_init(void)
        bdev_cache_init();
        chrdev_init();
 }
+
+
+void link_path_walk_probe(int);
+void link_path_walk_probe(int) { }
diff --git a/fs/namei.c b/fs/namei.c
index caeed986108d..00125c578af4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2470,6 +2470,8 @@ static inline const char *hash_name(struct
nameidata *nd, const char *name, unsi
   #define LAST_WORD_IS_DOTDOT  0x2e2e
 #endif

+void link_path_walk_probe(int);
+
 /*
  * Name resolution.
  * This is the basic name resolution function, turning a pathname into
@@ -2544,6 +2546,7 @@ static int link_path_walk(const char *name,
struct nameidata *nd)
                } while (unlikely(*name =3D=3D '/'));
                if (unlikely(!*name)) {
 OK:
+                       link_path_walk_probe(depth);
                        /* pathname or trailing symlink, done */
                        if (likely(!depth)) {
                                nd->dir_vfsuid =3D
i_uid_into_vfsuid(idmap, nd->inode);

then probing over kernel build:
bpftrace -e 'kprobe:link_path_walk_probe { @[probe] =3D lhist(arg0, 0, 8, 1=
); }'
@[kprobe:link_path_walk_probe]:
[0, 1)           7528231 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[1, 2)            407905 |@@                                               =
   |

I think that's nicely skewed.

> I can believe that answers to both questions are fairly low, but they are
> not the same.  I'd expect the latter to be considerably higher than the
> former.
>
> > -     if (unlikely(!legitimize_links(nd)))
> > +     if (unlikely(nd->depth && !legitimize_links(nd)))
>
> I suspect that
>         if (unlikely(nd->depth) && !legitimize_links(nd))
> might be better...
>

Well it says it is unlikely there is depth, but when there is and
legitimize_links is called, it is unlikely it fails. I think this
matches the current intent, except avodiing the func call most of the
time.

