Return-Path: <linux-fsdevel+bounces-33884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BC9C0220
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FC31F22CF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486451CC8A3;
	Thu,  7 Nov 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQwnNLi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0971E6DD5;
	Thu,  7 Nov 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974767; cv=none; b=BYi5GeclC0mRvBSSoTy+2PodUZiVddguv3gIPEs10Dok/4h521j+GW++MtdmGoiFhcDFslRHX3sksJKKmRP217AmgZJ75StXrN+vEbcKKhydfNrnohMFDG+jTIRh1D3rK8iFsR1WBOdPDNc4+1SQHd1BF6yHmSBCzM3DJYendDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974767; c=relaxed/simple;
	bh=Nh36q/QoTFpVJNyCLOHpFLSFeP/04g7ydKxz3TWP5vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQa0fFjowG6Grt/qlEw+IHkfQsEnSna//Mld2TevKozrfMSDynwxQ5IJbwie3VX3u7GT1JKwdUneZC/V7G994GxNNoJbGCLC7BvMGZSMuQXjb2TQ8do3WyH0Yo0EAg4DsyUS07C3//P2FuhKrfuNO2AnF5czcXGliaF/uuCR0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQwnNLi3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b147a2ff04so40189985a.3;
        Thu, 07 Nov 2024 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730974765; x=1731579565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3plpGM3EHwM3caz4tMUdRPr0tmM3sq5Xfe6uFa3U8g=;
        b=nQwnNLi3tDecPFXFZT8IRTi5K9TQ4Zg+AM9DmIKymEOgi5mleaz81D//ykIfAI7OE/
         QL9PpHCb1qBZDtySmJgX5TR6e56Kfnk1NNDEQ7pzZL/kkKepV3oOLNtoL7xryCLBnRSV
         UkJ/TkERD0vPtub23v+Jj5uxoY6yocjaztV6ocTgwDriw25n9OWWSPnfSYGCFlWpTwXs
         exoeUlvi9TnZ+vo6AZBq12qGLoUe3EM56W82SAm3WxVKbDNRPZcD/rmRj9WyhW7TLih0
         H2AcydkjqWL/UFRBAJsrBJmkxTFW97XhGCjnGvF4m+BhRUpv7ZbMbKukl2YAYLm7MCCB
         rpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974765; x=1731579565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3plpGM3EHwM3caz4tMUdRPr0tmM3sq5Xfe6uFa3U8g=;
        b=ab8XioVax430hSSenMhv+D+IWliwsD/68Q1UC//hCA5b8TELrZq6Fca/h8IhzmN+jM
         HT27uyUShL8qqU63o8R1djiOFmMzrska9DFZ7oH5OWIPiCVgBZr76PMRjPxPXld5NLhL
         cZgZVGQ2bvxsmZhWhJsRj7BU/UiKqA0onXIpaQzQNMxlYTaow12lWQ5TMjciUbBt9tPU
         +B5QWb8cbCrsHiRvSaTSDqtUQC3RLISKz/SMCjzwndGXu6m4bHAlOVh1RWnMua0YCJWE
         6Nt665vElFcaKXe7z9UXtFHvkZkyQQ1vTbmzFvlyDa1k2zSp+Xsud5EB/tGx4N1vIEmE
         A1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV0nHcmBH4aZ2aOM2JzrIl1R222NP7w3oXm9cAKNkQE81b6ED9S2H7dAoT4UZfLtwBdn4qjM7UY0qTQMAmM@vger.kernel.org, AJvYcCV7IHZITTMnHTNWTGJFNFZJEgFqoawrs5CVTBny5/RW8bRhvqPbYj8ILzXPvXSUNgXuVue6sLGOyn5mNSea0w==@vger.kernel.org, AJvYcCVzbPW299f4h7M0I8AUYsFjDbJjqmtU4KKTQx9JAE59OrWMVD1NGkl0LS6TMobDGdjCv0t3MeAtBUWXg8NA@vger.kernel.org
X-Gm-Message-State: AOJu0YzEExTfloM7cRJiZxt7TCJ/Rofw8oY1pWbN56cZ7dvvZqxmqIZi
	QQF6WYoGSeGoraW9T2uXKZByGfniYoge2UACjhXzgq1RBAwxvAKyLR9qul1zSuhM0r3cW+m/rJu
	+pkrGlp0i4hPQd8LCYegT9/snoro=
X-Google-Smtp-Source: AGHT+IH6QSEcbPGPcMIYpelJbcFBcnCqlj1H82ORr7HTPOPg9FGN7vDqPQyRDtYTzeA07Y7IH3aZ0ianWboZHDJDupI=
X-Received: by 2002:a05:6214:5401:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6d35c132068mr383752566d6.20.1730974764603; Thu, 07 Nov 2024
 02:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
In-Reply-To: <20241107005720.901335-1-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Nov 2024 11:19:13 +0100
Message-ID: <CAOQ4uxiRgXy-0WkTBbt6qNJ0+wbE=xBQLyOYnD7nPwQP1weV9g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, brauner@kernel.org
Cc: hu1.chen@intel.com, miklos@szeredi.hu, malini.bhandaru@intel.com, 
	tim.c.chen@intel.com, mikko.ylinen@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Hi,
>
> Changes from v3:
>  - Another reorganization of the series: separate the pure mechanical
>    changes into their own (Amir Goldstein)
>
> The series now reads:
>
> Patch 1: Introduce the _light() version of the override/revert cred opera=
tions;
> Patch 2: Convert backing-file.c to use those;
> Patch 3: Mechanical change to introduce the ovl_revert_creds() helper;
> Patch 4: Make the ovl_{override,convert}_creds() use the _light()
>   creds helpers, and fix the reference counting issue that would happen;
>

For the record, this series depends on backing_file API cleanup patch by Mi=
klos:
https://lore.kernel.org/linux-fsdevel/20241021103340.260731-1-mszeredi@redh=
at.com/

> Changes from v2:
>  - Removed the "convert to guard()/scoped_guard()" patches (Miklos Szered=
i);
>  - In the overlayfs code, convert all users of override_creds()/revert_cr=
eds() to the _light() versions by:
>       1. making ovl_override_creds() use override_creds_light();
>       2. introduce ovl_revert_creds() which calls revert_creds_light();
>       3. convert revert_creds() to ovl_revert_creds()
>    (Amir Goldstein);
>  - Fix an potential reference counting issue, as the lifetime
>    expectations of the mounter credentials are different (Christian
>    Brauner);
>

I pushed these patches to:
https://github.com/amir73il/linux/commits/ovl_creds

rebased overlayfs-next on top of them and tested.

Christian,

Since this work is mostly based on your suggestions,
I thought that you might want to author and handle this PR?

Would you like to take the patches from ovl_creds (including the backing_fi=
le
API cleanup) to a stable branch in your tree for me to base overlayfs-next =
on?
Or would you rather I include them in the overlayfs PR for v6.13 myself?

Thanks,
Amir.

P.S. some of the info below is relevant for the PR message and
some of it is completely stale...

> The series is now much simpler:
>
> Patch 1: Introduce the _light() version of the override/revert cred opera=
tions;
> Patch 2: Convert backing-file.c to use those;
> Patch 3: Do the conversion to use the _light() version internally;
> Patch 4: Fix a potential refcounting issue
>
> Changes from v1:
>  - Re-organized the series to be easier to follow, more details below
>    (Miklos Szeredi and Amir Goldstein);
>
> The series now reads as follows:
>
> Patch 1: Introduce the _light() version of the override/revert cred opera=
tions;
> Patch 2: Convert backing-file.c to use those;
> Patch 3: Introduce the overlayfs specific _light() helper;
> Patch 4: Document the cases that the helper cannot be used (critical
>       section may change the cred->usage counter);
> Patch 5: Convert the "rest" of overlayfs to the _light() helpers (mostly =
mechanical);
> Patch 6: Introduce the GUARD() helpers;
> Patch 7: Convert backing-file.c to the GUARD() helpers;
> Patch 8-15: Convert each overlayfs/ file to use the GUARD() helpers,
>       also explain the cases in which the scoped_guard() helper is
>       used. Note that a 'goto' jump that crosses the guard() should
>       fail to compile, gcc has a bug that fails to detect the
>       error[1].
> Patch 16: Remove the helper introduced in Patch 3 to close the series,
>       as it is no longer used, everything was converted to use the
>       safer/shorter GUARD() helpers.

this info is stale and confusing in the context of this series.

>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D91951
>
> This bug was also noticed here:
>
> https://lore.kernel.org/all/20240730050927.GC5334@ZenIV/
>
> Link to v1:
>
> https://lore.kernel.org/r/20240403021808.309900-1-vinicius.gomes@intel.co=
m/
>
> Changes from RFC v3:
>  - Removed the warning "fixes" patches, as they could hide potencial
>    bugs (Christian Brauner);
>  - Added "cred-specific" macros (Christian Brauner), from my side,
>    added a few '_' to the guards to signify that the newly introduced
>    helper macros are preferred.
>  - Changed a few guard() to scoped_guard() to fix the clang (17.0.6)
>    compilation error about 'goto' bypassing variable initialization;
>
> Link to RFC v3:
>
> https://lore.kernel.org/r/20240216051640.197378-1-vinicius.gomes@intel.co=
m/
>
> Changes from RFC v2:
>  - Added separate patches for the warnings for the discarded const
>    when using the cleanup macros: one for DEFINE_GUARD() and one for
>    DEFINE_LOCK_GUARD_1() (I am uncertain if it's better to squash them
>    together);
>  - Reordered the series so the backing file patch is the first user of
>    the introduced helpers (Amir Goldstein);
>  - Change the definition of the cleanup "class" from a GUARD to a
>    LOCK_GUARD_1, which defines an implicit container, that allows us
>    to remove some variable declarations to store the overriden
>    credentials (Amir Goldstein);
>  - Replaced most of the uses of scoped_guard() with guard(), to reduce
>    the code churn, the remaining ones I wasn't sure if I was changing
>    the behavior: either they were nested (overrides "inside"
>    overrides) or something calls current_cred() (Amir Goldstein).
>
> New questions:
>  - The backing file callbacks are now called with the "light"
>    overriden credentials, so they are kind of restricted in what they
>    can do with their credentials, is this acceptable in general?
>  - in ovl_rename() I had to manually call the "light" the overrides,
>    both using the guard() macro or using the non-light version causes
>    the workload to crash the kernel. I still have to investigate why
>    this is happening. Hints are appreciated.
>
> Link to the RFC v2:
>
> https://lore.kernel.org/r/20240125235723.39507-1-vinicius.gomes@intel.com=
/
>
> Original cover letter (lightly edited):
>
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
>  - If patch 1/5 and 2/5 are not a good idea (adding the cast), the
>    alternative I can see is using some kind of container for the
>    credentials;
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
> The contention is practically gone.
>
> Link: https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.c=
om/
>
> Vinicius Costa Gomes (4):
>   cred: Add a light version of override/revert_creds()
>   fs/backing-file: Convert to revert/override_creds_light()
>   ovl: use wrapper ovl_revert_creds()
>   ovl: Optimize override/revert creds
>
>  fs/backing-file.c        | 20 ++++++++++----------
>  fs/overlayfs/copy_up.c   |  2 +-
>  fs/overlayfs/dir.c       | 17 +++++++++++------
>  fs/overlayfs/file.c      | 14 +++++++-------
>  fs/overlayfs/inode.c     | 20 ++++++++++----------
>  fs/overlayfs/namei.c     | 10 +++++-----
>  fs/overlayfs/overlayfs.h |  1 +
>  fs/overlayfs/readdir.c   |  8 ++++----
>  fs/overlayfs/util.c      | 11 ++++++++---
>  fs/overlayfs/xattrs.c    |  9 ++++-----
>  include/linux/cred.h     | 18 ++++++++++++++++++
>  kernel/cred.c            |  6 +++---
>  12 files changed, 82 insertions(+), 54 deletions(-)
>
> --
> 2.47.0
>

