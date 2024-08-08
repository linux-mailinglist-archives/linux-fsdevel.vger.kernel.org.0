Return-Path: <linux-fsdevel+bounces-25394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C3E94B67F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3B1F249D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D01185E50;
	Thu,  8 Aug 2024 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwU3dH1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E1535B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097296; cv=none; b=VrUr25YfIwaI6OM1ABkNg5wp7L71BT0IcPh1hzp+DZhXtBMCVck9APKKU7YFiUSdC0u388aIOhjmRLzwUNUtimzanwDs/1AXKXN2Q3To4aEntXGDL9UlLaxke13WiX4k8Jv1hNA1RzBu8UuC2vJlsvMzXD6eFjUBIjQ5snt8WYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097296; c=relaxed/simple;
	bh=XDhG1+tV85aSrS5xxczRVGKJETSyI9kR9POWZ6+ejtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cditww6BQk+lLVuE6yF87pDDGV0S2xkO/WgW10IXUk5iGI1ymjzRDqc2uFSUypS9zYsROlUfR5QjjF4dVFqICur6/xiFt8VFuxtGrX0n3Ak9LRd/ckUGFwIe3MRZF6bA6Bo6rivNttdhJ1vCJ3KKymwnNhyp4XEhSyIi8mICcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwU3dH1B; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so75856066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723097293; x=1723702093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kgc/9kq/+nfyV/eHyxKr07ad4+lOreKRGHK6cA3r9Q=;
        b=DwU3dH1BCSYmM6J0E7TsWqv4rPYdteBA7LP2SMAbY5UgSmApP53yHuUwA3lx0tXG2K
         qVJelVknp2eZaNsT3R58HIM7Sf5zzxo5eub4jOjeDsPg7hG4uK9MihLWt3Hp3tpgo6r8
         q8vYBzvADfHWqdf8BIvEEgZ5TPB1Tv6HlqzPdtQWJ3KK4p17ZQMj2IrBAkpL4xgm0ld9
         1XLJeyy8M3AvZKExQGzlEzXL2h0e68VZ1BGYMcog5ZCEHcYPeOIS3yerSzw3xmrzjTNP
         xZwMKdXyDeXbxwwdOeES7kRH6dXHGrwfH+xKKzEK6ZzyNdcIkgc3n3Kif3Tjoij0Gpqe
         BnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723097293; x=1723702093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kgc/9kq/+nfyV/eHyxKr07ad4+lOreKRGHK6cA3r9Q=;
        b=gtUCDVmi/OajbCNj83XyWwW0VNB3RXT+RASnEGe3OP2qhh22g3onlvW6bOW3BUaJGb
         8jA/AgZ+ZoQNU8Ty7q92+l+it0o8dqkwjGlKD68bSi8asnCIvHt3ICd/hh8AARK493eO
         ciFWueFDe1XSOg790+mhtiUFmeGd6BbEJm+pDU+IOq4XHvDiE06rlmgRQmQCczt2aj5c
         Q3RcGt1AqKFU3fqv8Pi/QM3oISBkeMUnidXrc6LsK3mib/HBl0+WQYNjCOcOt/qvK4dw
         q7lB5tl8mNS1xFAPy4a0a1e6vvaVDThTFhBKp+3iLv4UsldsHxf7rUWe8UJTxV9vf3yG
         scdw==
X-Forwarded-Encrypted: i=1; AJvYcCUJTJqCbPlTfzL4vH/SIUHw5ID6dSPm/DovQTuqer8XMA5y7Zs73hi+1JcQtVmb8cXAH3PnVNz/5suGS/Y9Zy2F6opsXfJyoptkmw/gGQ==
X-Gm-Message-State: AOJu0YwogzxhLhedwCfErjyP1TOrITG0mr7lbI3KNPqNZLVhhrYAyff+
	80YgksMFmol7Nfj7wkJJG6+PaQJ0vDgelMLMekoyTZc+9gijz1i+t67Lp/vCis1vhveqFFn0A3y
	smZTjVmaA5kvUfVJZQZ0hqiHT12k=
X-Google-Smtp-Source: AGHT+IF2id12PdzwXd3i8PpFw2vQkOI646DJCZnNme3rNbtSvvrg5SEAKcVhF50XprOvzEWaBHeAJ7HzvIS7nvtA27I=
X-Received: by 2002:a17:907:9448:b0:a7a:a06b:eec9 with SMTP id
 a640c23a62f3a-a8090c255f0mr45235766b.4.1723097292645; Wed, 07 Aug 2024
 23:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808025029.GB5334@ZenIV> <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
 <20240808033505.GC5334@ZenIV> <20240808034600.GD5334@ZenIV>
In-Reply-To: <20240808034600.GD5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 8 Aug 2024 08:08:00 +0200
Message-ID: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
Subject: Re: [RFC] why do we need smp_rmb/smp_wmb pair in fd_install()/expand_fdtable()?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:46=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Aug 08, 2024 at 04:35:05AM +0100, Al Viro wrote:
> > On Wed, Aug 07, 2024 at 08:06:31PM -0700, Linus Torvalds wrote:
>
> > > But release/acquire is the RightThing(tm), and the fact that alpha
> > > based its ordering on the bad old model is not really our problem.
> >
> > alpha would have fuckloads of full barriers simply from all those READ_=
ONCE()
> > in rcu reads...
> >
> > smp_rmb() is on the side that is much hotter - fd_install() vs. up to w=
hat, 25 calls
> > of expand_fdtable() per files_struct instance history in the worst poss=
ible case?
> > With rather big memcpy() done by those calls, at that...
>
> BTW, an alternative would be to have LSB of ->fdt (or ->fd, if we try to
> eliminate that extra dereference) for ->resize_in_progress.  Then no barr=
ier
> is needed for ordering of those.  Would cost an extra &~1 on ->fdt fetche=
s,
> though...

Note smp_load_acquire still emits a fenced instruction on arm64, but I
have no idea what the cost is.

While my understanding of RCU guarantees in face of synchronize_rcu is
rather limited here, I do suspect the entire thing can be handled with
a consume fence, which does expand to a regular load on everything but
alpha.

So the question to Paul is if given this in expand_fdtable:
         files->resize_in_progress =3D true;
         ....
        if (atomic_read(&files->count) > 1)
                synchronize_rcu();

does something like this work for fd_install:

        rcu_read_lock_sched();
        files =3D smp_load_consume(current->files);
        if (unlikely(files->resize_in_progress))
                ....
        fdt =3D rcu_dereference_sched(files->fdt);
        rcu_assign_pointer(fdt->fd[fd], file);
        rcu_read_unlock_sched();


--=20
Mateusz Guzik <mjguzik gmail.com>

