Return-Path: <linux-fsdevel+bounces-33700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C69BD89E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ACF28464D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61354216A18;
	Tue,  5 Nov 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLEQktjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A281216A00;
	Tue,  5 Nov 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845636; cv=none; b=irkjCpdi3lrK34AyHmfEA8T29gcd53MutOtM8AxKK5ctQmvlvZUzwwMK6jyls+vpJug4w/4Q8cnfb+giJq/Kr/W5zymesMBIpS7sdey0Va3VLHXmg4tj4KQGeWd1bSGUtcGVH/pDT5B0FGHb+ZElovfmTclB3rnSvCnNzu04Y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845636; c=relaxed/simple;
	bh=2T40XpaqtxgeuN0I8keNWpQc6lEEgaKrm7K/bebhG/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipgffls4O9W4hn8ZQ3kGGk6DNCwH6URFuplLfz10yDsAKU5M4wdYNi8TK/Fsx5eJdQJPlz1ebfTYHHhwx2g2eevNOjfyWtO8c2vyVKIWTydT301tbEwm7D2nYI1qPGWpGbqWJmaST32MViZ2ITY5FXEBOXWo8Bt3FHKjEayulHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLEQktjv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845636; x=1762381636;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2T40XpaqtxgeuN0I8keNWpQc6lEEgaKrm7K/bebhG/w=;
  b=SLEQktjvVMKDIz04oZoqq7AxrsNCtX/0tO5T/3O8UmJ1iyrtXtjwqllC
   eYlFOP2NwuNBwOwAUWxb3FxV73OWSlAQTZZwinMKxb9XUKdzYOtCSnN07
   uALLd7mc+yKKd5TYclvVepHZgwOE2wXNMvgmatJIEagtRy+aAL6ByVGm0
   TF5rgdpkTWwkr5D2i3jj82eVZNk23gdm78Seq61aRcvh/vQnnebxbqQhU
   ro3jIJoJaOWREu2KonTpDNFoq5JNEEGyoeW23kR32b0cKsSlzieVVC3YU
   4HPw5LrZIEa7+La4XisrRxlgv1gwHToIvKmhmvys+b/nAUP84XOXHxqnY
   A==;
X-CSE-ConnectionGUID: v1GjZUMeRPGfYAZgnqKz5A==
X-CSE-MsgGUID: lsupN1ktReWnF8w6AKFA6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="56020738"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="56020738"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:27:15 -0800
X-CSE-ConnectionGUID: HeOGFYR9SsKNOe0QbM4hHg==
X-CSE-MsgGUID: 6iruFa55RAK6hE29LMIryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="83730334"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.238])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:27:14 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH overlayfs-next v3 0/4] overlayfs: Optimize
 override/revert creds
In-Reply-To: <CAOQ4uxiaRE_cQ9m9LZMEiDCeSQKkZDfsJbpt85ds6hgvjnwHUQ@mail.gmail.com>
References: <20241105193514.828616-1-vinicius.gomes@intel.com>
 <CAOQ4uxiaRE_cQ9m9LZMEiDCeSQKkZDfsJbpt85ds6hgvjnwHUQ@mail.gmail.com>
Date: Tue, 05 Nov 2024 14:27:13 -0800
Message-ID: <871pzpqptq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Nov 5, 2024 at 8:35=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Hi,
>>
>> This series is rebased on top of Amir's overlayfs-next branch.
>>
>> Changes from v2:
>>  - Removed the "convert to guard()/scoped_guard()" patches (Miklos Szere=
di);
>>  - In the overlayfs code, convert all users of override_creds()/revert_c=
reds() to the _light() versions by:
>>       1. making ovl_override_creds() use override_creds_light();
>>       2. introduce ovl_revert_creds() which calls revert_creds_light();
>>       3. convert revert_creds() to ovl_revert_creds()
>>    (Amir Goldstein);
>>  - Fix an potential reference counting issue, as the lifetime
>>    expectations of the mounter credentials are different (Christian
>>    Brauner);
>>
>
> Hi Vicius,
>
> The end result looks good to me, but we still need to do the series a
> bit differently.
>
>> The series is now much simpler:
>>
>> Patch 1: Introduce the _light() version of the override/revert cred oper=
ations;
>> Patch 2: Convert backing-file.c to use those;
>> Patch 3: Do the conversion to use the _light() version internally;
>
> This patch mixes a small logic change and a large mechanical change
> that is not a good mix.
>
> I took the liberty to split out the large mechanical change to
> ovl: use wrapper ovl_revert_creds()
> and pushed it to branch
> https://github.com/amir73il/linux/commits/ovl_creds
>
> I then rebased overlayfs-next over this commit and resolved the
> conflicts with the pure mechanical change.
>
> Now you can rebase your patches over ovl_creds and they should
> not be conflicting with overlayfs-next changes.
>
> The reason I wanted to do this is that Christian could take your changes
> as well as my ovl_creds branch through the vfs tree if he chooses to do s=
o.
>

Makes sense.

>> Patch 4: Fix a potential refcounting issue
>
> This patch cannot be separated from patch #3 because it would introduce t=
he
> refcount leak mid series.
>
> But after I took out all the mechanical changes out of patch #3,
> there should be no problem for you to squash patches #3 and #4 together.
>

Done.=20

> One more nit: please use "ovl: ..." for commit titles instead of
> "fs/overlayfs: ...".
>

Also done. Will give the series a round of testing, just to be sure, and
will send the next version tomorrow.

> Thanks,
> Amir.


Cheers,
--=20
Vinicius

