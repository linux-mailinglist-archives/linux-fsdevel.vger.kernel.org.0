Return-Path: <linux-fsdevel+bounces-29177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B9976ABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571351C239FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CA1B011C;
	Thu, 12 Sep 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl0/tcyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D41A4E89
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148018; cv=none; b=J75C+hKUaWPPmi/IZYmDaFL8eA3WYr5Fkmp4p6kbJdthxv2JyKHExWVq3IpciMFZSqNbFKMS70Dy01XfC7ZEkUU3I3soVGMudWN28XzGDQLTznCQc/sNwW1l0lMwN6aIdie1D30neJjy0QkgjIj0axexUwxSVGuXE7xPkL0JJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148018; c=relaxed/simple;
	bh=N1EUdjJhsVq65ucpyiwhVLmsuX0Ur6eSUxFUZJCoZeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtTK9GWybxwicp9k1SarSknydb1hYVlb5ppDFiXi6BeROHrpmNkX6w4qlCgOfa2s5FE2TAIsuphsxfrbBFsZCZenHeQOmUJEpPggJtxVnb22rLn7efimQD8MoLhyNQwdRDBlMcpeEy33KReDdk+itQ4xoJ1/vrNpclNbPIbAJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl0/tcyN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c548eb3380so4720236d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726148015; x=1726752815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1EUdjJhsVq65ucpyiwhVLmsuX0Ur6eSUxFUZJCoZeI=;
        b=jl0/tcyNj0tOPlx+17uEEslTQBTZdeEffzh3sN1SacO5MhIgQTKWicBgn0YJGh/B+S
         1QR/Xs1vYL++NVwgORF6EOP6HebqanheIyxjIr+SBuRPdXz2rury9W6zVurYosnbM/bR
         LbUdqwFrpqjsKoaAUPMKd6qOuhFjsZT7rKmerE6Gm+B5qbTx01qzvZrlJ7Iceg1+CYOw
         r3n35t4LmYpImPzvV0Zp1O/MvC3n8QCcmIDOnSLZ8OnVCAooBwAwdXh+JSsTIwLvUXVK
         bYQAPurKB0oAVK5Ok6KdP7XsQAxaig6iMYypr00Zg72sm1O/NEFg+cW+ugECuEKrAvgm
         tEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148015; x=1726752815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1EUdjJhsVq65ucpyiwhVLmsuX0Ur6eSUxFUZJCoZeI=;
        b=D6iwzfh5oeO/vPN0U8YWcIh5Yf2w6h9VqQLQp69c01Yk6KhZAg8s8zKdPxg9+Cc7W1
         bpTpkch6JKGW9QV82qmKofQ4Yky5WcjzW0mwU5gkrM+7N2j/gIdqhVxyCSHh+o2e+3da
         vQrVWOnz8I5L7uJFXFhawdbDbSRtK1puZy9la7KZjliwx47ABcvSNP0IJW42TwR2ZjoA
         KGV9hMWcWQ47f5imuuDJjgKU/Tj2MAFc2pMWSZP+jhHL7Rrt3M12BNnxjhJV7SygN/+t
         eNOkw+/Z81BSypAwwSaABgi9lYTJEcqycxnaAf2CTtAGMM2KT56W0szuoyiv21tZch1Z
         I3zw==
X-Forwarded-Encrypted: i=1; AJvYcCWorvCYCeA4v5K87F7Kcz4Aji2EHkQcAKy33HK4W/hAvFNKTYrzjIpc+dl2mMOXIL4jBPOf2/DSBrNgf0Ap@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUjVUtrTfa++C/IRFwnbZ1NbeTZDAxYXXvWzxYfTKFg1a0L1k
	wye6ZVH2Y9LAKtk8LNaBpQvT/e1Jg69vd+xe5rTogc5woTTG7IN377d8g/346genavzwENJ/cz6
	5k5F/lpn3RyPRpIS7Jhie5sukqnM=
X-Google-Smtp-Source: AGHT+IE+UWgtE+VZ6QLMiXZWMdoUdUJYQh64LC8pfqdF15BmMSm1fqXuJYlSRZ+v9yTDezEo/IUwm7fcq3u0Z/PFntw=
X-Received: by 2002:a05:6214:568c:b0:6c3:6e19:aa0f with SMTP id
 6a1803df08f44-6c57357a64cmr47087596d6.25.1726148015295; Thu, 12 Sep 2024
 06:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912091548.98132-1-laoar.shao@gmail.com> <20240912105340.k2qsq7ao2e7f4fci@quack3>
 <20240912-programm-umgibt-a1145fa73bb6@brauner>
In-Reply-To: <20240912-programm-umgibt-a1145fa73bb6@brauner>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 12 Sep 2024 21:32:58 +0800
Message-ID: <CALOAHbC6Dxxni3OSc_P5+9ybMdVrcZ7ZgwH6HAMcRWRjKa3Dzg@mail.gmail.com>
Subject: Re: [PATCH RFC] vfs: Introduce a new open flag to imply dentry
 deletion on file removal
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 8:04=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Sep 12, 2024 at 12:53:40PM GMT, Jan Kara wrote:
> > On Thu 12-09-24 17:15:48, Yafang Shao wrote:
> > > Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting=
 a
> > > file") introduced an unconditional deletion of the associated dentry =
when a
> > > file is removed. However, this led to performance regressions in spec=
ific
> > > benchmarks, such as ilebench.sum_operations/s [0], prompting a revert=
 in
> > > commit 4a4be1ad3a6e ("Revert 'vfs: Delete the associated dentry when
> > > deleting a file'").
> > >
> > > This patch seeks to reintroduce the concept conditionally, where the
> > > associated dentry is deleted only when the user explicitly opts for i=
t
> > > during file removal.
> > >
> > > There are practical use cases for this proactive dentry reclamation.
> > > Besides the Elasticsearch use case mentioned in commit 681ce8623567,
> > > additional examples have surfaced in our production environment. For
> > > instance, in video rendering services that continuously generate temp=
orary
> > > files, upload them to persistent storage servers, and then delete the=
m, a
> > > large number of negative dentries=E2=80=94serving no useful purpose=
=E2=80=94accumulate.
> > > Users in such cases would benefit from proactively reclaiming these
> > > negative dentries. This patch provides an API allowing users to activ=
ely
> > > delete these unnecessary negative dentries.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oli=
ver.sang@intel.com [0]
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> >
> > Umm, I don't think we want to burn a FMODE flag and expose these detail=
s of
> > dentry reclaim to userspace. BTW, if we wanted to do this, we already h=
ave
> > d_mark_dontcache() for in-kernel users which we could presumably reuse.
> >
> > But I would not completely give up on trying to handle this in an autom=
ated
> > way inside the kernel. The original solution you mention above was perh=
aps
> > too aggressive but maybe d_delete() could just mark the dentry with a
> > "deleted" flag, retain_dentry() would move such dentries into a special=
 LRU
> > list which we'd prune once in a while (say once per 5 s). Also this lis=
t
> > would be automatically pruned from prune_dcache_sb(). This way if there=
's
> > quick reuse of a dentry, it will get reused and no harm is done, if it
> > isn't quickly reused, we'll free them to not waste memory.
> >
> > What do people think about such scheme?
>
> I agree that a new open flag is not the right way to go and it also
> wastes a PF_* flag.
>
> I think it'll probably be rather difficult to ensure that we don't see
> performance regressions for some benchmark. Plus there will be users
> that want aggressive negative dentry reclaim being fine with possibly
> increased lookup cost independent of the directory case.
>
> So imo the simple option is to add 681ce8623567 back behind a sysctl
> that users that need aggressive negative dentry reclaim can simply turn o=
n.

We are currently using the sysctl method on our production servers.
This feature has been deployed across many of our production
environments for several months without any reported regressions.

--=20
Regards
Yafang

