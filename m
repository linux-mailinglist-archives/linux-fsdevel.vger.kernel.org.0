Return-Path: <linux-fsdevel+bounces-7032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3D82036D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 04:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4692A1F219FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA9138E;
	Sat, 30 Dec 2023 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDr8d6iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D510F5
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3600902871fso18897675ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 19:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703905208; x=1704510008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAZ5ajf3MkVnFkC6sywbs4Pf+xQBE5WGQ//t20vsfwU=;
        b=TDr8d6iyAj1v4tUJWVYXuJOp8hDCjsmLOmcBixCr2x0DP8LO4nLrR+OgBKKJdJMPfZ
         wyVbd+N7EiVaIiYSZzABAf9bTH+1VHsUfGmBUi7uveOZOwkqgtRNVLjjDTnpw80E/ZUM
         CmM+XFRo7twIpqkRbfpNds5wu1YYmRNI2GwauuzvK/U5cyrOYgd/8LYwDyCLLKTGMTEu
         goyTCzxJ1qWc1cpKXthi5dORxCJmgqJiymRyKf3eqHv2z/6M2o1OnjPtlOOCCzVoKy34
         EFlB+th/l1J3C6ZpqKLhQ6Mjs2F4BkzPIjRe0GGcU9ZLWwNlu+D0XZ21IhzpJ3A6Wvvo
         jhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703905208; x=1704510008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAZ5ajf3MkVnFkC6sywbs4Pf+xQBE5WGQ//t20vsfwU=;
        b=sXduojplF+bpIjB7flPZMPbzXdsxFkEdNapVnt0NAgla3LKOnm7YKSZBHQEwwmdSqD
         qvomoRuIubun857Lo7JR97OSHXU12X0/GmQRrKy594/oHwpW6XSp08NpMQvVA33wBtPT
         XlJwxigstDNoVPdMfd1iu4B1A5TEOLKspwZF8A9hWgsKMD8g24lHwp1Kyz+1a4eJyuKr
         3rPCBoHtrVSAnzNc97fFaU7YnptAL5Ev3DWv8Pdhxm6e7acNc5AInaFr8VSlzzLs7NNx
         CGaehmvCre9ythmfmXqgBb2FnSojJW6hiMHkwp+p5LFnsQNqwq1Miu9spuIaNyAIJrkJ
         gSZA==
X-Gm-Message-State: AOJu0Yzk+2lzvPc6gEoBIH5dAeDW8S2J9VNQmGKyY+CKLWJUhEsqNXlG
	od3VCrJR80Xh9XSgZTqD/ACUAa6MyYMWW08h/mgLZGuF4Ix7
X-Google-Smtp-Source: AGHT+IGNgtZ3iUb7oRokQhbYD5WD4BXce8diJEX3rvWdVxJ9n3DFkx5GXlipFyhxrY5aAuvH3DMNwWD60PTYpeW0ius=
X-Received: by 2002:a05:6e02:2492:b0:35f:f00b:e697 with SMTP id
 bt18-20020a056e02249200b0035ff00be697mr10506299ilb.83.1703905207798; Fri, 29
 Dec 2023 19:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230025636.2477429-1-surenb@google.com>
In-Reply-To: <20231230025636.2477429-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 29 Dec 2023 18:59:54 -0800
Message-ID: <CAJuCfpGg_TDoaN5Fqa5-QJJ3tpT9E15GTB0TMh8ic+2877xoHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/mm: add separate UFFDIO_MOVE test for PMD splitting
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I screwed up when sending it out. It's not [1/2], it's supposed
to be a stand-alone patch. IOW, don't expect a [2/2] followup :)

On Fri, Dec 29, 2023 at 6:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add a test for UFFDIO_MOVE ioctl operating on a hugepage which has to
> be split because destination is marked with MADV_NOHUGEPAGE. With this
> we cover all 3 cases: normal page move, hugepage move, hugepage splitting
> before move.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Patch applies over mm-unstable.
>
>  tools/testing/selftests/mm/uffd-unit-tests.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index d8091523c2df..cce90a10515a 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1199,6 +1199,16 @@ static void uffd_move_test(uffd_test_args_t *targs=
)
>
>  static void uffd_move_pmd_test(uffd_test_args_t *targs)
>  {
> +       if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
> +               err("madvise(MADV_HUGEPAGE) failure");
> +       uffd_move_test_common(targs, read_pmd_pagesize(),
> +                             uffd_move_pmd_handle_fault);
> +}
> +
> +static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
> +{
> +       if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
> +               err("madvise(MADV_NOHUGEPAGE) failure");
>         uffd_move_test_common(targs, read_pmd_pagesize(),
>                               uffd_move_pmd_handle_fault);
>  }
> @@ -1330,6 +1340,13 @@ uffd_test_case_t uffd_tests[] =3D {
>                 .uffd_feature_required =3D UFFD_FEATURE_MOVE,
>                 .test_case_ops =3D &uffd_move_test_pmd_case_ops,
>         },
> +       {
> +               .name =3D "move-pmd-split",
> +               .uffd_fn =3D uffd_move_pmd_split_test,
> +               .mem_targets =3D MEM_ANON,
> +               .uffd_feature_required =3D UFFD_FEATURE_MOVE,
> +               .test_case_ops =3D &uffd_move_test_pmd_case_ops,
> +       },
>         {
>                 .name =3D "wp-fork",
>                 .uffd_fn =3D uffd_wp_fork_test,
> --
> 2.34.1
>

