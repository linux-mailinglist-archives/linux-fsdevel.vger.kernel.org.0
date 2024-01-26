Return-Path: <linux-fsdevel+bounces-9055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643D83D97E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE091C23D05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D7175A1;
	Fri, 26 Jan 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUbZBaOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24D1427F;
	Fri, 26 Jan 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269254; cv=none; b=FfFlhtKwtzeEdpdpWRuqqiLkKLk0YAZkQANJBDcy+5VTX6ElW8t1hQmHKxmIZQoksH7UESL8PdDTx9mNJktAsgwDQ7Nm0ZsxkWwnLcYmA3MjCd+FwC/7t+m2JVmGKbqgoDW0jACGzO0yU9SvP0yazNkPrnDRv6g4gQiMuPsiPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269254; c=relaxed/simple;
	bh=/3o8LMDYZa891pv/+7XoRHQ8MeuE5NNlBKlJHMHcXUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVzHz7+r4x7njvR6thmCO9dnAjidVLgnGkqOwEwidGG/WhCNgr82ayCWPrA45FqL1fPutOuth+k6Edwt0D9mQlD3XRRu8XPzOwpOheTYHPExg6xigA63Li2kEPgIoVf6cRZ1FdT8H3Acjh0Y+Xc2jEAV71P9tafX9haeM5KxL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUbZBaOy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783cd27aef4so20777385a.2;
        Fri, 26 Jan 2024 03:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706269251; x=1706874051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WywnUEa8/PFBaA7RrQ/d7DELIRLf0x0WvxBTi+4gRBQ=;
        b=ZUbZBaOy7QZxxRup9uNFUxF7hr5mjZ2PBcet9JwfpYfSYt8IrFCe+7OxoI7+N5tsu5
         wbStgixfg+LLB1Lm5ygoYkoYx56TtIOMgUpSpT0LpHa5ve+jZ/1KEZt1RA8/+Ka9Q/Nx
         0Z8Ht5u0avaT5T7lEgbQiEOhGPxyjFEfnZ/coEk8M6yOkj1IDE5OwIvNKtxLCC1WNtau
         zNY1ibv9/xNSzqk6u0nPhCbjRG57mbdBoR45nDmbOdbuKPci3DqYkJXpjdn4/z8d1F3T
         nSYied7ARIgsOX1aI5L1bzqlV7Vitg7dYTkNnjIDxCKf1fVI7FwDmmwnbPvy0lzg6++7
         yt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706269251; x=1706874051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WywnUEa8/PFBaA7RrQ/d7DELIRLf0x0WvxBTi+4gRBQ=;
        b=OUV6CmmWnFtqB4yHR3nxGxyMw+fgMbGfgJIumY7gIz7xuyiy3mE49DoyT4oOCJyfAO
         FL9c5Tsd7ZDsz+v3nK4W79oBV7nyoNl8lFH1ma8gkLxF58/JmGsCDAQ5jr0AKvIg9Z+o
         woIh64vdb2tmnaunE4XSEUNVni4gRaKs4f0VyzX/6yiAb57N90Krk8tIbD/1zsLKslb9
         lWPtCtQmGszfnH5yukyxtMR1qGJPqf9vOy7MwOYz7YICRjnpuhITrOxj+Goe8Vy6mvqq
         RqxGvM08CnO07irtKHrteSdk3r+y2h1r0EsrfTLqvqM6enr/V8hXlrO92lAWepofLj66
         hFGw==
X-Gm-Message-State: AOJu0Yyj7X14PwOfZtXQXJXjQUBTf+PgPJ0TKs5YLrTtiajccTLiP8u3
	iLt3fSLrfgou0qrCAqMzHAKk8rKPXhy/KwSUVgEPW5KFJvgPRASU5Yr8DL+r/V//lv9kvSWN43L
	1ZjibzEmjrG1I9Xqe54iISt5+6AY=
X-Google-Smtp-Source: AGHT+IFx/lFm2tRr6Yg+XpQcdPkpnwCm+YkwiTOsK+mYBjfNsOAEQUFhryN+xS0O6eyKCR0BRNUzOOfv34eLa8oKr+0=
X-Received: by 2002:ad4:5f0c:0:b0:680:b7fd:e3c0 with SMTP id
 fo12-20020ad45f0c000000b00680b7fde3c0mr1354002qvb.130.1706269251403; Fri, 26
 Jan 2024 03:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
In-Reply-To: <20240125235723.39507-1-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 13:40:40 +0200
Message-ID: <CAOQ4uxgA8OAp5Htv9qBtW7S9J-YhyJeatiXTtzyw-1maraRZrA@mail.gmail.com>
Subject: Re: [RFC v2 0/4] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc: fsdevel

On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Hi,
>

Hi Vinicius,

I have some specific comments about the overlayfs patch,
but first I prefer to provide higher level feedback on the series.

> It was noticed that some workloads suffer from contention on
> increasing/decrementing the ->usage counter in their credentials,
> those refcount operations are associated with overriding/reverting the
> current task credentials. (the linked thread adds more context)
>
> In some specialized cases, overlayfs is one of them, the credentials
> in question have a longer lifetime than the override/revert "critical
> section". In the overlayfs case, the credentials are created when the
> fs is mounted and destroyed when it's unmounted. In this case of long
> lived credentials, the usage counter doesn't need to be
> incremented/decremented.
>
> Add a lighter version of credentials override/revert to be used in
> these specialized cases. To make sure that the override/revert calls
> are paired, add a cleanup guard macro. This was suggested here:
>
> https://lore.kernel.org/all/20231219-marken-pochen-26d888fb9bb9@brauner/
>
> With a small number of tweaks:
>  - Used inline functions instead of macros;
>  - A small change to store the credentials into the passed argument,
>    the guard is now defined as (note the added '_T =3D'):
>
>       DEFINE_GUARD(cred, const struct cred *, _T =3D override_creds_light=
(_T),
>                   revert_creds_light(_T));
>
>  - Allow "const" arguments to be used with these kind of guards;
>
> Some comments:
>  - If patch 1/4 is not a good idea (adding the cast), the alternative
>    I can see is using some kind of container for the credentials;
>  - The only user for the backing file ops is overlayfs, so these
>    changes make sense, but may not make sense in the most general
>    case;
>
> For the numbers, some from 'perf c2c', before this series:
> (edited to fit)
>
> #
> #        ----- HITM -----                                        Shared
> #   Num  RmtHitm  LclHitm                      Symbol            Object  =
       Source:Line  Node
> # .....  .......  .......  ..........................  ................  =
..................  ....
> #
>   -------------------------
>       0      412     1028
>   -------------------------
>           41.50%   42.22%  [k] revert_creds            [kernel.vmlinux]  =
atomic64_64.h:39     0  1
>           15.05%   10.60%  [k] override_creds          [kernel.vmlinux]  =
atomic64_64.h:25     0  1
>            0.73%    0.58%  [k] init_file               [kernel.vmlinux]  =
atomic64_64.h:25     0  1
>            0.24%    0.10%  [k] revert_creds            [kernel.vmlinux]  =
cred.h:266           0  1
>           32.28%   37.16%  [k] generic_permission      [kernel.vmlinux]  =
mnt_idmapping.h:81   0  1
>            9.47%    8.75%  [k] generic_permission      [kernel.vmlinux]  =
mnt_idmapping.h:81   0  1
>            0.49%    0.58%  [k] inode_owner_or_capable  [kernel.vmlinux]  =
mnt_idmapping.h:81   0  1
>            0.24%    0.00%  [k] generic_permission      [kernel.vmlinux]  =
namei.c:354          0
>
>   -------------------------
>       1       50      103
>   -------------------------
>          100.00%  100.00%  [k] update_cfs_group  [kernel.vmlinux]  atomic=
64_64.h:15   0  1
>
>   -------------------------
>       2       50       98
>   -------------------------
>           96.00%   96.94%  [k] update_cfs_group  [kernel.vmlinux]  atomic=
64_64.h:15   0  1
>            2.00%    1.02%  [k] update_load_avg   [kernel.vmlinux]  atomic=
64_64.h:25   0  1
>            0.00%    2.04%  [k] update_load_avg   [kernel.vmlinux]  fair.c=
:4118        0
>            2.00%    0.00%  [k] update_cfs_group  [kernel.vmlinux]  fair.c=
:3932        0  1
>
> after this series:
>
> #
> #        ----- HITM -----                                   Shared
> #   Num  RmtHitm  LclHitm                 Symbol            Object       =
Source:Line  Node
> # .....  .......  .......   ....................  ................  .....=
...........  ....
> #
>   -------------------------
>       0       54       88
>   -------------------------
>          100.00%  100.00%   [k] update_cfs_group  [kernel.vmlinux]  atomi=
c64_64.h:15   0  1
>
>   -------------------------
>       1       48       83
>   -------------------------
>           97.92%   97.59%   [k] update_cfs_group  [kernel.vmlinux]  atomi=
c64_64.h:15   0  1
>            2.08%    1.20%   [k] update_load_avg   [kernel.vmlinux]  atomi=
c64_64.h:25   0  1
>            0.00%    1.20%   [k] update_load_avg   [kernel.vmlinux]  fair.=
c:4118        0  1
>
>   -------------------------
>       2       28       44
>   -------------------------
>           85.71%   79.55%   [k] generic_permission      [kernel.vmlinux] =
 mnt_idmapping.h:81   0  1
>           14.29%   20.45%   [k] generic_permission      [kernel.vmlinux] =
 mnt_idmapping.h:81   0  1
>
>
> The contention is practically gone.

That is very impressive.
Can you say which workloads were running during this test?
Specifically, I am wondering how much of the improvement came from
backing_file.c and how much from overlayfs/*.c.

The reason I am asking is because the overlayfs patch is quite large and ca=
n
take more time to review, so I am wondering out loud if we are not
better off this
course of action:

1. convert backing_file.c to use new helpers/guards
2. convert overlayfs to use new helpers/guards

#1 should definitely go in via Christian's tree and should get a wider revi=
ew
from fsdevel (please CC fsdevel next time)

#2 is contained for overlayfs reviewers. Once the helpers are merged
and used by backing_file helpers, overlayfs can be converted independently.

#1 and #2 could both be merged in the same merge cycle, or not, it does not
matter. Most likely, #2 will go through Christian's tree as well, but I thi=
nk we
need to work according to this merge order.

We can also work on the review in parallel and you may keep the overlayfs
patch in following posts, just wanted us to be on the same page w.r.t to
the process.

Thanks,
Amir.

