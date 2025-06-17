Return-Path: <linux-fsdevel+bounces-51848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91957ADC1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5A518969FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30DC25D52D;
	Tue, 17 Jun 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBLnRnTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16E42AB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140106; cv=none; b=d9bNde+RTaz8enwUQigMe4Nb6us1aREfKQypNW428ba402Tlb59GPhayWTah7jB04ndR/rTGld0Qn2DipcIXXIwJ8JIkd+zofZ3S0t2h4jsZd5u0O7plKS9NAKYcV+spgm6kpYOMCsSKgos6NlJ6V6gxFkjeRnUAiE70wLdk/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140106; c=relaxed/simple;
	bh=3NTFXqKcGJqCQ5bgBS7+JCOrJi/fIV/k7uNR1Up8Nws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8JTXS4S9t6QAhqTMrk1Ondmn0MiwhrDSSGbtUpERbWwFRe+Oy1o2KkzaLuOg4FXpsI9PgJsIKFDQqa6COZCliWvjM8t2yFN5intphWyL3eqz3fHHvTbALSwWPIgGFHhdAVj2aLYnq3yrzHUiSky1TYiSodr4rHKHwlF3oPUlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBLnRnTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B5DC4CEF0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140103;
	bh=3NTFXqKcGJqCQ5bgBS7+JCOrJi/fIV/k7uNR1Up8Nws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fBLnRnTV9JKUlZlIHeQw3O15N/3byGuVzaZBy2SrGxK2bYZUsqGTOiTTVEyaTzO3o
	 zW7QK79RDsAIVtGGeXszPqJjd3wO1z8DSk07BJ7vutYdjdg8FXw/2Vgk1ZRNBmwOgF
	 hgx+9x+3WPAhoLBphD3Nok25BvlHIU0PZETifD5d9MoU8Bf9hPdiOBKv/iWdG9srWp
	 kmfhZurbODS2CCHL1N+cqM4kfPYNsGcIO+Gp1nmPTW5q1RlXEMP9YO/XROpajHwPT7
	 EuV+jHw6mR0GtMNCOxzOViGgwh7lL2G4483WA6fPZ7vrdVRqMEVVSjFaw31y08Ou7c
	 roQdumXFCI12w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade326e366dso972420966b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 23:01:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUxCp+BKbiubLXwGEkAoBMar8Q+5kklF4Yk3LtNjdOFIdv8+AQIUrhEgaXTdd2DCr2hzHZPMPl2MKuDqCF@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYVbCstJ6QRk+T9r3Ssh+HkFdLBYzZ5KeR2f0EbHjRCvlipsR
	41G7LrcpoccDv93i261ZX7GotBhCHVlWURyG0RiwQPNRH34gdCRTmkT65VHgEK6WGEJ12zdCAw7
	B+dOnTCkD/ZKQq7qz4ETVD+PA210FrrU=
X-Google-Smtp-Source: AGHT+IF1vWArbINVQrlgkj4sm8JXeMV6AnUVRz1nSAccy1b4o3wa302bfM+NuZATaIzzYest63oRMZWqB1IEtehkyUc=
X-Received: by 2002:a17:907:2d9f:b0:add:ed0d:a581 with SMTP id
 a640c23a62f3a-adfad31a905mr1249847966b.17.1750140101906; Mon, 16 Jun 2025
 23:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613103802.619272-2-Yuezhang.Mo@sony.com> <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
 <PUZPR04MB6316B26325B23BD49C3DC97C8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316B26325B23BD49C3DC97C8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Jun 2025 15:01:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-p6-HcjS4ZZHJ4YDsYgynBLczWKLJbh-5ATHyDHLCwGw@mail.gmail.com>
X-Gm-Features: AX0GCFtHXlFemTU5oGnl-ZyC85oEX-1_Rm8ZLOtk7fkKSF2ylhmBc-_XoPGV5yk
Message-ID: <CAKYAXd-p6-HcjS4ZZHJ4YDsYgynBLczWKLJbh-5ATHyDHLCwGw@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: add cluster chain loop check for dir
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:38=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> > On Fri, Jun 13, 2025 at 7:39=E2=80=AFPM Yuezhang Mo <Yuezhang.Mo@sony.c=
om> wrote:
> > >
> > > An infinite loop may occur if the following conditions occur due to
> > > file system corruption.
> > >
> > > (1) Condition for exfat_count_dir_entries() to loop infinitely.
> > >     - The cluster chain includes a loop.
> > >     - There is no UNUSED entry in the cluster chain.
> > >
> > > (2) Condition for exfat_create_upcase_table() to loop infinitely.
> > >     - The cluster chain of the root directory includes a loop.
> > >     - There are no UNUSED entry and up-case table entry in the cluste=
r
> > >       chain of the root directory.
> > >
> > > (3) Condition for exfat_load_bitmap() to loop infinitely.
> > >     - The cluster chain of the root directory includes a loop.
> > >     - There are no UNUSED entry and bitmap entry in the cluster chain
> > >       of the root directory.
> > >
> > > This commit adds checks in exfat_count_num_clusters() and
> > > exfat_count_dir_entries() to see if the cluster chain includes a loop=
,
> > > thus avoiding the above infinite loops.
> > >
> > > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > > ---
> > >  fs/exfat/dir.c    | 33 +++++++++++++++++++++------------
> > >  fs/exfat/fatent.c | 10 ++++++++++
> > >  fs/exfat/super.c  | 32 +++++++++++++++++++++-----------
> > >  3 files changed, 52 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> > > index 3103b932b674..467271ad4d71 100644
> > > --- a/fs/exfat/dir.c
> > > +++ b/fs/exfat/dir.c
> > > @@ -1194,7 +1194,8 @@ int exfat_count_dir_entries(struct super_block =
*sb, struct exfat_chain *p_dir)
> > >  {
> > >         int i, count =3D 0;
> > >         int dentries_per_clu;
> > > -       unsigned int entry_type;
> > > +       unsigned int entry_type =3D TYPE_FILE;
> > > +       unsigned int clu_count =3D 0;
> > >         struct exfat_chain clu;
> > >         struct exfat_dentry *ep;
> > >         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > > @@ -1205,18 +1206,26 @@ int exfat_count_dir_entries(struct super_bloc=
k *sb, struct exfat_chain *p_dir)
> > >         exfat_chain_dup(&clu, p_dir);
> > >
> > >         while (clu.dir !=3D EXFAT_EOF_CLUSTER) {
> > > -               for (i =3D 0; i < dentries_per_clu; i++) {
> > > -                       ep =3D exfat_get_dentry(sb, &clu, i, &bh);
> > > -                       if (!ep)
> > > -                               return -EIO;
> > > -                       entry_type =3D exfat_get_entry_type(ep);
> > > -                       brelse(bh);
> > > +               clu_count++;
> > > +               if (clu_count > sbi->used_clusters) {
> >                     if (++clu_count > sbi->used_clusters) {
>
> Well, that's more concise.
>
> > > +                       exfat_fs_error(sb, "dir size or FAT or bitmap=
 is corrupted");
> > > +                       return -EIO;
> > > +               }
> > >
> > > -                       if (entry_type =3D=3D TYPE_UNUSED)
> > > -                               return count;
> > > -                       if (entry_type !=3D TYPE_DIR)
> > > -                               continue;
> > > -                       count++;
> > > +               if (entry_type !=3D TYPE_UNUSED) {
> > > +                       for (i =3D 0; i < dentries_per_clu; i++) {
> > > +                               ep =3D exfat_get_dentry(sb, &clu, i, =
&bh);
> > > +                               if (!ep)
> > > +                                       return -EIO;
> > > +                               entry_type =3D exfat_get_entry_type(e=
p);
> > > +                               brelse(bh);
> > > +
> > > +                               if (entry_type =3D=3D TYPE_UNUSED)
> > > +                                       break;
> > Is there any reason why you keep doing loop even though you found an
> > unused entry?
>
> There are unused directory entries when calling this func, but there
> may be none after files are created. That will cause a infinite loop in
> exfat_check_dir_empty() and exfat_find_dir_entry().
Isn't the infinite loop issue in this patch improved by checking
clu_count and ->used_clusters?
If it reaches an unused entry, how about returning right away like before?

Thanks.
>
> >
> > > +                               if (entry_type !=3D TYPE_DIR)
> > > +                                       continue;
> > > +                               count++;
> > > +                       }
> > >                 }
> > >
> > >                 if (clu.flags =3D=3D ALLOC_NO_FAT_CHAIN) {
> > > diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> > > index 23065f948ae7..2a2615ca320f 100644
> > > --- a/fs/exfat/fatent.c
> > > +++ b/fs/exfat/fatent.c
> > > @@ -490,5 +490,15 @@ int exfat_count_num_clusters(struct super_block =
*sb,
> > >         }
> > >
> > >         *ret_count =3D count;
> > > +
> > > +       /*
> > > +        * since exfat_count_used_clusters() is not called, sbi->used=
_clusters
> > > +        * cannot be used here.
> > > +        */
> > > +       if (i =3D=3D sbi->num_clusters) {
> > This is also right, But to make it more clear, wouldn't it be better
> > to do clu !=3D EXFAT_EOF_CLUSTER?
>
> OK, I will add this.
>
> >
> > Thanks.
> > > +               exfat_fs_error(sb, "The cluster chain has a loop");
> > > +               return -EIO;
> > > +       }
> > > +
> > >         return 0;
> > >  }
>

