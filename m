Return-Path: <linux-fsdevel+bounces-25140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8B9495C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4A41C215D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696040875;
	Tue,  6 Aug 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqtehuCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26847796;
	Tue,  6 Aug 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962566; cv=none; b=S9pFOfNibzGhNaseVF0cDPOmQAqr1tCYfo23lwrrOnIyKQ+dvsW/msT9XsyT6oF/tRKO11m1RXZC0fmzb/C5QAFiZSNG7TQqkhJHn8R1VIMM4VezcWj6Vj/n41PKnUdGgE56NJjvbE/ZGwbiJJ24vtReTeE7qfnw6Z9BJQjBo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962566; c=relaxed/simple;
	bh=AdT4aEeZ9Gk8AbosZZ+x3YwPaRML7jqn9xtRdwdinlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnoQcyVxbs8wsgo3jOJfLFSB+YNIG/vJ050y4lqw4oXYDR12e0f7J706qmoXfMsm6bB5j4ONJMtXDDGb02fUpUCXS7twyB8CP9bt4x+vY7YMUVNQZeGuefcWRcYCMytDHbyUDQQy/uGjpYwUH9p2cslluc5MM+QYNycPysEfsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqtehuCf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so28794a12.1;
        Tue, 06 Aug 2024 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722962563; x=1723567363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6Qh79VNkWq1dzOmcHPtk7SXwit1Ag/+GvQyjTy/yMA=;
        b=lqtehuCfFnBNrSYtiBtGSN9FZFzJzEgTXnj2DzFfhfMLRxP1gFR9ZTwVAlPqe7wE+n
         MaEC3Yql9n8cYKYn7wZ4+y1r0BGHnOZ/mLvoJV55rwnqiipgEsYNAf+QAUonmT2ZG3xa
         +bon2V0gsrfvuXeB43vP8XubMnnOsxgnnaK/Y97lCsrAobGNIuPB1XpiFurT2nzOrAII
         uASYDMuogtPZJ/TIWCZjGGfZysZKLt22NPAn85vobPMzdtobqVjIjru5PBV0YXvH8PXD
         vmY4MDUc9XfVGVh0e3hmscFvEXI7D720kor0d09SCQZOEA7kyug9BIKHoFiSJC0v47lc
         h6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962563; x=1723567363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6Qh79VNkWq1dzOmcHPtk7SXwit1Ag/+GvQyjTy/yMA=;
        b=tTuF1LP3A1zUWJFq4chdlb4dAgtIXQ6k4MYOWFyGwW5i6UDHXa1+RJj1hPlKl75Wo5
         n5mS+Tg9HHrZ4bbdYH/39breMq3CoLA0sQUoT1IBE79tha+WxwrbqzBvRrx/mzfKjDV5
         wx1fJW02ywTaPboleTJJZLOdoufwZPrZyjGGmrXlY3ARui7ZuE3K8Du+mAOGPRdpCHI3
         zsurxzldBHkpWeXvXQVwU7bZWuzEp/Vn2AisSWhlT/xpmBlUuRKkvZsd+fGycxAg2lQU
         p9S1oVvQAO/yIXVkHndIRtCL0X8xNRM4QIlnfmRo5a4PRHGgltbWDkYdqna5n7tIaMjN
         PTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZR/ktZ/JfirH1v7PWj/tYCgZVyuNCQ0/Hlwd9I8/MsxwHcK9vGXONjZehRZTrQ5y/qXByaGSt2GNSiG0pW42PpM8TV+KaU1DMen2n6z65BDCyJ+Z+Jg+OTCEz/YKBFl3xPZbhvzNoMwAZow==
X-Gm-Message-State: AOJu0YybI6Bt9c6fa8z0Yha3SIDLWCd53s0OY+J/Kkh8R8GpxtApQXB8
	z9CKgE1KfVOg7eOJkM2V2QBanJJNv5lROrz+b9x5g+AxZ8JwuRAlV6NutOCJnHGSHbJZ38XkNPv
	ZAd6a0UcYFSJj8NLPlREKuWFBSps=
X-Google-Smtp-Source: AGHT+IG8ZkNY7H+nOAKXJSFZ5nYAf1bD+eT5/Q40XUAsV7ogwxlKL71lR+SPCpcvqR6v2VhDIcn8UCfWYY8mdgfPk7c=
X-Received: by 2002:a17:907:94d4:b0:a7a:ab1a:2d79 with SMTP id
 a640c23a62f3a-a7dc6287000mr1528350166b.29.1722962562582; Tue, 06 Aug 2024
 09:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com> <915bca37dc73206b0a79f2fba4cac3255f8f6c0d.camel@kernel.org>
In-Reply-To: <915bca37dc73206b0a79f2fba4cac3255f8f6c0d.camel@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 6 Aug 2024 18:42:30 +0200
Message-ID: <CAGudoHHrYAjpaajVEWNU7mBhShQKnU5025=kodpPRSunXgKfNw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-08-06 at 17:25 +0200, Mateusz Guzik wrote:
> > On Tue, Aug 6, 2024 at 4:32=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> > wrote:
> > >
> > > Today, when opening a file we'll typically do a fast lookup, but if
> > > O_CREAT is set, the kernel always takes the exclusive inode lock. I
> > > assume this was done with the expectation that O_CREAT means that
> > > we
> > > always expect to do the create, but that's often not the case. Many
> > > programs set O_CREAT even in scenarios where the file already
> > > exists.
> > >
> > > This patch rearranges the pathwalk-for-open code to also attempt a
> > > fast_lookup in certain O_CREAT cases. If a positive dentry is
> > > found, the
> > > inode_lock can be avoided altogether, and if auditing isn't
> > > enabled, it
> > > can stay in rcuwalk mode for the last step_into.
> > >
> > > One notable exception that is hopefully temporary: if we're doing
> > > an
> > > rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing
> > > the
> > > dentry in that case is more expensive than taking the i_rwsem for
> > > now.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > Here's a revised patch that does a fast_lookup in the O_CREAT
> > > codepath
> > > too. The main difference here is that if a positive dentry is found
> > > and
> > > audit_dummy_context is true, then we keep the walk lazy for the
> > > last
> > > component, which avoids having to take any locks on the parent
> > > (just
> > > like with non-O_CREAT opens).
> > >
> > > The testcase below runs in about 18s on v6.10 (on an 80 CPU
> > > machine).
> > > With this patch, it runs in about 1s:
> > >
> >
> > I don't have an opinion on the patch.
> >
> > If your kernel does not use apparmor and the patch manages to dodge
> > refing the parent, then indeed this should be fully deserialized just
> > like non-creat opens.
> >
>
> Yep. Pity that auditing will slow things down, but them's the breaks...
>
> > Instead of the hand-rolled benchmark may I interest you in using
> > will-it-scale instead? Notably it reports the achieved rate once per
> > second, so you can check if there is funky business going on between
> > reruns, gives the cpu the time to kick off turbo boost if applicable
> > etc.
> >
> > I would bench with that myself, but I temporarily don't have handy
> > access to bigger hw. Even so, the below is completely optional and
> > perhaps more of a suggestion for the future :)
> >
> > I hacked up the test case based on tests/open1.c.
> >
> > git clone https://github.com/antonblanchard/will-it-scale.git
> >
> > For example plop into tests/opencreate1.c && gmake &&
> > ./opencreate1_processes -t 70:
> >
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <assert.h>
> > #include <string.h>
> >
> > char *testcase_description =3D "Separate file open/close + O_CREAT";
> >
> > #define template        "/tmp/willitscale.XXXXXX"
> > static char (*tmpfiles)[sizeof(template)];
> > static unsigned long local_nr_tasks;
> >
> > void testcase_prepare(unsigned long nr_tasks)
> > {
> >         int i;
> >         tmpfiles =3D (char(*)[sizeof(template)])malloc(sizeof(template)
> > * nr_tasks);
> >         assert(tmpfiles);
> >
> >         for (i =3D 0; i < nr_tasks; i++) {
> >                 strcpy(tmpfiles[i], template);
> >                 char *tmpfile =3D tmpfiles[i];
> >                 int fd =3D mkstemp(tmpfile);
> >
> >                 assert(fd >=3D 0);
> >                 close(fd);
> >         }
> >
> >         local_nr_tasks =3D nr_tasks;
> > }
> >
> > void testcase(unsigned long long *iterations, unsigned long nr)
> > {
> >         char *tmpfile =3D tmpfiles[nr];
> >
> >         while (1) {
> >                 int fd =3D open(tmpfile, O_RDWR | O_CREAT, 0600);
> >                 assert(fd >=3D 0);
> >                 close(fd);
> >
> >                 (*iterations)++;
> >         }
> > }
> >
> > void testcase_cleanup(void)
> > {
> >         int i;
> >         for (i =3D 0; i < local_nr_tasks; i++) {
> >                 unlink(tmpfiles[i]);
> >         }
> >         free(tmpfiles);
> > }
> >
> >
>
> Good suggestion and thanks for the testcase. With v6.10 kernel, I'm
> seeing numbers like this at -t 70:
>
> min:4873 max:11510 total:418915
> min:4884 max:10598 total:408848
> min:3704 max:12371 total:467658
> min:2842 max:11792 total:418239
> min:2966 max:11511 total:414144
> min:4756 max:11381 total:413137
> min:4557 max:10789 total:404628
> min:4780 max:11125 total:413349
> min:4757 max:11156 total:405963
>
> ...with the patched kernel, things are significantly faster:
>
> min:265865 max:508909 total:21464553
> min:263252 max:500084 total:21242190
> min:263989 max:504929 total:21396968
> min:263343 max:505852 total:21346829
> min:263023 max:507303 total:21410217
> min:263420 max:506593 total:21426307
> min:259556 max:494529 total:20927169
> min:264451 max:508967 total:21433676
> min:263486 max:509460 total:21399874
> min:263906 max:507400 total:21393015
>
> I can get some fancier plots if anyone is interested, but the benefit
> of this patch seems pretty clear.

In the commit message I would replace that handrolled bench thing with +/-:
<quote>
70-way open(.., O_RDWR | O_CREAT) calls on already existing files, one
per-worker:
before: 467658
after:  21464553 (+4589%)
</quote>

I guess it would make sense to check if unlink1_processes is doing
fine if it's not too much hassle.

overall pretty decent win :P

--=20
Mateusz Guzik <mjguzik gmail.com>

