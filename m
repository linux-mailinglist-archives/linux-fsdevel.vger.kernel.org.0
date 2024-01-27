Return-Path: <linux-fsdevel+bounces-9137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1959D83E7E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488FFB21D07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46955A55;
	Sat, 27 Jan 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLgU7pOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54328E6;
	Sat, 27 Jan 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313766; cv=none; b=JZ1cvTj6+VRlnUZinBtJ+n70F7MirJQ8AmM7ZpTW1Jyp8sf7Cv+a1PKCOIoaIIL89R7W7IHr75RO8YPDGjOS2V4MHxXwOIKhKrTDi8XnPUHQDF62t3Z5DTdCHMRCkxi+ZKjF5W3C3Cp9ftUyn/rcS+Q/Jb7K+nWvRQOo/VKoz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313766; c=relaxed/simple;
	bh=DcVbEkvBJS9yysISuMerG4PhigA4HeTQybTwwzBz7rM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a8B72oaayLgh4eVfAQbN9pYZlXs6OjypfIhPPZLG3sxfx5VlkRc4QuypHDemUpUfdXggZ7gUNE3RyqUg7bC0szEAOGt/q1WljXew51/LnTWLsZEazqKYM1UF72FrnI3u3KWfbkki5Xhaogs31mnKUhv7ZigpgTy8uvzoXSwMjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLgU7pOI; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706313764; x=1737849764;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DcVbEkvBJS9yysISuMerG4PhigA4HeTQybTwwzBz7rM=;
  b=gLgU7pOIjRZZfSSEjXJ2A1WpXCauYdinufG7SlZp/OjZfweSN0OWyAPc
   xMIwB4Os9kIdBHedKBvjldonFom+weZE7xGpV9HuErUmqqCbk8Ga9ICuk
   j334LeL3vzWCIDFNpkEmr8z9SsbRzLKHKn0XMn9Y+Lmniwp0bxdAh/Bvz
   X9t0rRUV/KS44cdmlQzhkhPMdG8mSp5rIuiOlMCB8lHyFZwP7RZbf772Y
   UXDysEQZPaRDrXVmVg1pT1WrgnvvkYxUz5jpxS6BJicmd63p2PV8/eFge
   dl0k21A4ZQPfSQDCi64wdPbFO+nZXLaN8VgwYNC70pvr7FKLZ3yJJmjSS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399770933"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="399770933"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="21523504"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:02:40 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC v2 0/4] overlayfs: Optimize override/revert creds
In-Reply-To: <CAOQ4uxgA8OAp5Htv9qBtW7S9J-YhyJeatiXTtzyw-1maraRZrA@mail.gmail.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
 <CAOQ4uxgA8OAp5Htv9qBtW7S9J-YhyJeatiXTtzyw-1maraRZrA@mail.gmail.com>
Date: Fri, 26 Jan 2024 16:02:41 -0800
Message-ID: <87cytn63tq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Amir,

Amir Goldstein <amir73il@gmail.com> writes:

> cc: fsdevel
>
> On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Hi,
>>
>
> Hi Vinicius,
>
> I have some specific comments about the overlayfs patch,
> but first I prefer to provide higher level feedback on the series.
>
>> It was noticed that some workloads suffer from contention on
>> increasing/decrementing the ->usage counter in their credentials,
>> those refcount operations are associated with overriding/reverting the
>> current task credentials. (the linked thread adds more context)
>>
>> In some specialized cases, overlayfs is one of them, the credentials
>> in question have a longer lifetime than the override/revert "critical
>> section". In the overlayfs case, the credentials are created when the
>> fs is mounted and destroyed when it's unmounted. In this case of long
>> lived credentials, the usage counter doesn't need to be
>> incremented/decremented.
>>
>> Add a lighter version of credentials override/revert to be used in
>> these specialized cases. To make sure that the override/revert calls
>> are paired, add a cleanup guard macro. This was suggested here:
>>
>> https://lore.kernel.org/all/20231219-marken-pochen-26d888fb9bb9@brauner/
>>
>> With a small number of tweaks:
>>  - Used inline functions instead of macros;
>>  - A small change to store the credentials into the passed argument,
>>    the guard is now defined as (note the added '_T =3D'):
>>
>>       DEFINE_GUARD(cred, const struct cred *, _T =3D override_creds_ligh=
t(_T),
>>                   revert_creds_light(_T));
>>
>>  - Allow "const" arguments to be used with these kind of guards;
>>
>> Some comments:
>>  - If patch 1/4 is not a good idea (adding the cast), the alternative
>>    I can see is using some kind of container for the credentials;
>>  - The only user for the backing file ops is overlayfs, so these
>>    changes make sense, but may not make sense in the most general
>>    case;
>>
>> For the numbers, some from 'perf c2c', before this series:
>> (edited to fit)
>>
>> #
>> #        ----- HITM -----                                        Shared
>> #   Num  RmtHitm  LclHitm                      Symbol            Object =
        Source:Line  Node
>> # .....  .......  .......  ..........................  ................ =
 ..................  ....
>> #
>>   -------------------------
>>       0      412     1028
>>   -------------------------
>>           41.50%   42.22%  [k] revert_creds            [kernel.vmlinux] =
 atomic64_64.h:39     0  1
>>           15.05%   10.60%  [k] override_creds          [kernel.vmlinux] =
 atomic64_64.h:25     0  1
>>            0.73%    0.58%  [k] init_file               [kernel.vmlinux] =
 atomic64_64.h:25     0  1
>>            0.24%    0.10%  [k] revert_creds            [kernel.vmlinux] =
 cred.h:266           0  1
>>           32.28%   37.16%  [k] generic_permission      [kernel.vmlinux] =
 mnt_idmapping.h:81   0  1
>>            9.47%    8.75%  [k] generic_permission      [kernel.vmlinux] =
 mnt_idmapping.h:81   0  1
>>            0.49%    0.58%  [k] inode_owner_or_capable  [kernel.vmlinux] =
 mnt_idmapping.h:81   0  1
>>            0.24%    0.00%  [k] generic_permission      [kernel.vmlinux] =
 namei.c:354          0
>>
>>   -------------------------
>>       1       50      103
>>   -------------------------
>>          100.00%  100.00%  [k] update_cfs_group  [kernel.vmlinux]  atomi=
c64_64.h:15   0  1
>>
>>   -------------------------
>>       2       50       98
>>   -------------------------
>>           96.00%   96.94%  [k] update_cfs_group  [kernel.vmlinux]  atomi=
c64_64.h:15   0  1
>>            2.00%    1.02%  [k] update_load_avg   [kernel.vmlinux]  atomi=
c64_64.h:25   0  1
>>            0.00%    2.04%  [k] update_load_avg   [kernel.vmlinux]  fair.=
c:4118        0
>>            2.00%    0.00%  [k] update_cfs_group  [kernel.vmlinux]  fair.=
c:3932        0  1
>>
>> after this series:
>>
>> #
>> #        ----- HITM -----                                   Shared
>> #   Num  RmtHitm  LclHitm                 Symbol            Object      =
 Source:Line  Node
>> # .....  .......  .......   ....................  ................  ....=
............  ....
>> #
>>   -------------------------
>>       0       54       88
>>   -------------------------
>>          100.00%  100.00%   [k] update_cfs_group  [kernel.vmlinux]  atom=
ic64_64.h:15   0  1
>>
>>   -------------------------
>>       1       48       83
>>   -------------------------
>>           97.92%   97.59%   [k] update_cfs_group  [kernel.vmlinux]  atom=
ic64_64.h:15   0  1
>>            2.08%    1.20%   [k] update_load_avg   [kernel.vmlinux]  atom=
ic64_64.h:25   0  1
>>            0.00%    1.20%   [k] update_load_avg   [kernel.vmlinux]  fair=
.c:4118        0  1
>>
>>   -------------------------
>>       2       28       44
>>   -------------------------
>>           85.71%   79.55%   [k] generic_permission      [kernel.vmlinux]=
  mnt_idmapping.h:81   0  1
>>           14.29%   20.45%   [k] generic_permission      [kernel.vmlinux]=
  mnt_idmapping.h:81   0  1
>>
>>
>> The contention is practically gone.
>
> That is very impressive.
> Can you say which workloads were running during this test?
> Specifically, I am wondering how much of the improvement came from
> backing_file.c and how much from overlayfs/*.c.
>

I received the workload packaged from one of our customer teams, it's a
docker image to run a wordpress/php/nginx thing, totally not my area and
not sure that I can give much more details. The only think that I know
is that this workload does *a lot* of faccessat().

Anyway, I did a experiment removing the backing ops patch, got this
numbers (edited for clarity):

#
#        ----- HITM -----  ------- Store Refs ------                       =
                 Shared=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
#   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A                     Sy=
mbol             Object         Source:Line  Node
# .....  .......  .......  .......  .......  ....... ......................=
....  .................  ..................  ....
#
  ---------------------------------------------------
      0       79       97        0        0        0=20
  ---------------------------------------------------
           0.00%    1.03%    0.00%    0.00%    0.00% [k] revert_creds      =
      [kernel.kallsyms]  atomic64_64.h:39     0  1
           1.27%    0.00%    0.00%    0.00%    0.00% [k] init_file         =
      [kernel.kallsyms]  atomic64_64.h:25     0  1
          62.03%   71.13%    0.00%    0.00%    0.00% [k] generic_permission=
      [kernel.kallsyms]  mnt_idmapping.h:81   0  1
          35.44%   26.80%    0.00%    0.00%    0.00% [k] generic_permission=
      [kernel.kallsyms]  mnt_idmapping.h:81   0  1
           1.27%    0.00%    0.00%    0.00%    0.00% [k] generic_permission=
      [kernel.kallsyms]  mnt_idmapping.h:81   0
           0.00%    1.03%    0.00%    0.00%    0.00% [k] generic_permission=
      [kernel.kallsyms]  namei.c:354          0  1

  ---------------------------------------------------
      1       52      103        0        0        0=20
  ---------------------------------------------------
          98.08%   98.06%    0.00%    0.00%    0.00% [k] update_cfs_group  =
[kernel.kallsyms]  atomic64_64.h:15   0  1
           0.00%    1.94%    0.00%    0.00%    0.00% [k] update_load_avg   =
[kernel.kallsyms]  atomic64_64.h:25   0  1
           1.92%    0.00%    0.00%    0.00%    0.00% [k] update_cfs_group  =
[kernel.kallsyms]  fair.c:3932        0

  ---------------------------------------------------
      2       59       77        0        0        0=20
  ---------------------------------------------------
          93.22%   98.70%    0.00%    0.00%    0.00% [k] update_cfs_group  =
[kernel.kallsyms]  atomic64_64.h:15   0  1
           5.08%    1.30%    0.00%    0.00%    0.00% [k] update_cfs_group  =
[kernel.kallsyms]  fair.c:3932        0  1
           1.69%    0.00%    0.00%    0.00%    0.00% [k] update_load_avg   =
[kernel.kallsyms]  atomic64_64.h:25   0  1


So, the main source of contention is not in the backing file ops (but
there is still some). That seems to align with the numbers that Chen Hu
provided[1], that most of the contention was in ovl_permission().

[1] https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.com/

> The reason I am asking is because the overlayfs patch is quite large and =
can
> take more time to review, so I am wondering out loud if we are not
> better off this
> course of action:
>
> 1. convert backing_file.c to use new helpers/guards
> 2. convert overlayfs to use new helpers/guards
>

For this particular workload, (2) is more important. But I am open to
propose (1) first, no problem at all.

Also, if you think that some other way of spliting the series, for
example, one patch per function being converted, would be easier/better,
I can do that too.

> #1 should definitely go in via Christian's tree and should get a wider re=
view
> from fsdevel (please CC fsdevel next time)
>

Of course. Will CC fsdevel.

> #2 is contained for overlayfs reviewers. Once the helpers are merged
> and used by backing_file helpers, overlayfs can be converted independentl=
y.
>
> #1 and #2 could both be merged in the same merge cycle, or not, it does n=
ot
> matter. Most likely, #2 will go through Christian's tree as well, but I t=
hink we
> need to work according to this merge order.
>
> We can also work on the review in parallel and you may keep the overlayfs
> patch in following posts, just wanted us to be on the same page w.r.t to
> the process.
>
> Thanks,
> Amir.


Cheers,
--=20
Vinicius

