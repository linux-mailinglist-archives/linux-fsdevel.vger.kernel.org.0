Return-Path: <linux-fsdevel+bounces-51827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3AADBE38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 02:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F217D172146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 00:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E82315B0EC;
	Tue, 17 Jun 2025 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgwatPar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1ECA6F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120629; cv=none; b=P0rV4DYRXRt7ZVSQsZ/ku45CmEsClJuTw7GO6N1Nl94lWUuvjn6IhL0koWtAOIRi8f82QqTqN2TTNA7Vfj0ORTHg2ODRMm1IGMxAI6MvATiOZ2+/sfg4l2OtINlTEik/A4VMRc8VYYR/L+Mwa0aiXTjtiHxteD+pc22zIZPaP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120629; c=relaxed/simple;
	bh=LVK6KCjN4I74a6SPkbB3+D8Ue92ER+Qm1kDqk0iTEiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pcp2C8FQSvmuUNup/rKCa91Q9z75876zi+IAj17VxA0T0pNlxv6ui9osmgbqXC97SWvoTUpGl1VcXvuH3sL9N4TJTxZ1tInx562r8fGAE42ruoyb4vpLDocrihfK5ZL1acKDdYRrAgFe5acoNJxMc1WcPlLDgQ2py6wlDgDYJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgwatPar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7731C4CEEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750120628;
	bh=LVK6KCjN4I74a6SPkbB3+D8Ue92ER+Qm1kDqk0iTEiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BgwatParTPrugRCLvriVTg8Tw3w7CcNJL6zFJsF2BOrQ9Z2AP3NTrwL6rW4rMyaO/
	 8WEbGKXoc8d6dUYb9A3Z/q2qrLBRYserb5Vot4cVPAvqoFqD7UVZ2Cu3IufmL0srcn
	 3N9k/VwhJtRo3LRrYbD2/Bei1G00yTt++nypXkpkw7cbxCvGPm30GpSyJcTAikdZ6C
	 uwQMQzCOSgLxDxvkjicSY3k8GwymtrgGWHg9VBPh16ywWT87jcjmAbY6enmuIyw3q1
	 rMSgM7dsxQ8kTGY2t7eviNiedCyEIeMzEifPP7NP8zQM0Aw/5Ok1X79VUvUbXOkGeT
	 INtRllQdccJig==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso9354353a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 17:37:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU07tQj40+bg2i3AjoOj/AheulYGJukd44ZsZ3tffh4H2QlD3RrpcajjDh3LEkKJaHRklI4huVeNl+0rBwE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3IXBTkvfGtcgrpzcEyLQoEXzWA3zJk6yLSHQlhrSk6QsUzql
	OsQsmRX1v5JFXT6KuwZGRsv8S62EDWxOgDTvtyPd+W4ol6rW6LAxTGoZ/vRmnaGnNGGMvey+zLE
	DgjAKI4cH/P9sspbeZWz0m09lU8xuc8E=
X-Google-Smtp-Source: AGHT+IEGizAudBYk4aGrMCp95841OIuxAqfW6NDgTofpYrKezB+UR6yNcplE+mgbbXfOYZxx9gHzmyzsHhB00yLOZwU=
X-Received: by 2002:a17:907:7296:b0:ad8:96d2:f42 with SMTP id
 a640c23a62f3a-adfad437bcemr1118059666b.36.1750120627547; Mon, 16 Jun 2025
 17:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613103802.619272-2-Yuezhang.Mo@sony.com>
In-Reply-To: <20250613103802.619272-2-Yuezhang.Mo@sony.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Jun 2025 09:36:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
X-Gm-Features: AX0GCFuapI-w9SaTFw9Y9_GhjNVygcSJkGsH3U5rglEnmANdiJPmFOwnnbs0Rl0
Message-ID: <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: add cluster chain loop check for dir
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 7:39=E2=80=AFPM Yuezhang Mo <Yuezhang.Mo@sony.com> =
wrote:
>
> An infinite loop may occur if the following conditions occur due to
> file system corruption.
>
> (1) Condition for exfat_count_dir_entries() to loop infinitely.
>     - The cluster chain includes a loop.
>     - There is no UNUSED entry in the cluster chain.
>
> (2) Condition for exfat_create_upcase_table() to loop infinitely.
>     - The cluster chain of the root directory includes a loop.
>     - There are no UNUSED entry and up-case table entry in the cluster
>       chain of the root directory.
>
> (3) Condition for exfat_load_bitmap() to loop infinitely.
>     - The cluster chain of the root directory includes a loop.
>     - There are no UNUSED entry and bitmap entry in the cluster chain
>       of the root directory.
>
> This commit adds checks in exfat_count_num_clusters() and
> exfat_count_dir_entries() to see if the cluster chain includes a loop,
> thus avoiding the above infinite loops.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> ---
>  fs/exfat/dir.c    | 33 +++++++++++++++++++++------------
>  fs/exfat/fatent.c | 10 ++++++++++
>  fs/exfat/super.c  | 32 +++++++++++++++++++++-----------
>  3 files changed, 52 insertions(+), 23 deletions(-)
>
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 3103b932b674..467271ad4d71 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -1194,7 +1194,8 @@ int exfat_count_dir_entries(struct super_block *sb,=
 struct exfat_chain *p_dir)
>  {
>         int i, count =3D 0;
>         int dentries_per_clu;
> -       unsigned int entry_type;
> +       unsigned int entry_type =3D TYPE_FILE;
> +       unsigned int clu_count =3D 0;
>         struct exfat_chain clu;
>         struct exfat_dentry *ep;
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> @@ -1205,18 +1206,26 @@ int exfat_count_dir_entries(struct super_block *s=
b, struct exfat_chain *p_dir)
>         exfat_chain_dup(&clu, p_dir);
>
>         while (clu.dir !=3D EXFAT_EOF_CLUSTER) {
> -               for (i =3D 0; i < dentries_per_clu; i++) {
> -                       ep =3D exfat_get_dentry(sb, &clu, i, &bh);
> -                       if (!ep)
> -                               return -EIO;
> -                       entry_type =3D exfat_get_entry_type(ep);
> -                       brelse(bh);
> +               clu_count++;
> +               if (clu_count > sbi->used_clusters) {
                    if (++clu_count > sbi->used_clusters) {

> +                       exfat_fs_error(sb, "dir size or FAT or bitmap is =
corrupted");
> +                       return -EIO;
> +               }
>
> -                       if (entry_type =3D=3D TYPE_UNUSED)
> -                               return count;
> -                       if (entry_type !=3D TYPE_DIR)
> -                               continue;
> -                       count++;
> +               if (entry_type !=3D TYPE_UNUSED) {
> +                       for (i =3D 0; i < dentries_per_clu; i++) {
> +                               ep =3D exfat_get_dentry(sb, &clu, i, &bh)=
;
> +                               if (!ep)
> +                                       return -EIO;
> +                               entry_type =3D exfat_get_entry_type(ep);
> +                               brelse(bh);
> +
> +                               if (entry_type =3D=3D TYPE_UNUSED)
> +                                       break;
Is there any reason why you keep doing loop even though you found an
unused entry?

> +                               if (entry_type !=3D TYPE_DIR)
> +                                       continue;
> +                               count++;
> +                       }
>                 }
>
>                 if (clu.flags =3D=3D ALLOC_NO_FAT_CHAIN) {
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> index 23065f948ae7..2a2615ca320f 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -490,5 +490,15 @@ int exfat_count_num_clusters(struct super_block *sb,
>         }
>
>         *ret_count =3D count;
> +
> +       /*
> +        * since exfat_count_used_clusters() is not called, sbi->used_clu=
sters
> +        * cannot be used here.
> +        */
> +       if (i =3D=3D sbi->num_clusters) {
This is also right, But to make it more clear, wouldn't it be better
to do clu !=3D EXFAT_EOF_CLUSTER?

Thanks.
> +               exfat_fs_error(sb, "The cluster chain has a loop");
> +               return -EIO;
> +       }
> +
>         return 0;
>  }

