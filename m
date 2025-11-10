Return-Path: <linux-fsdevel+bounces-67670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74EC46174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6179D3A7460
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662AE306B11;
	Mon, 10 Nov 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C61FmnxD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F801BCA1C;
	Mon, 10 Nov 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772431; cv=none; b=HQdUBamg11qH0/DVbltliqy225bKrGnTp2TguLHrGJQg70UHIgARLiyUQtoPRQRduVT8NjKGjg7xMBNERPLCGJtG+BzzHh2IhRocjzdqQZIbi4/BSLrottDALgKJ6lrsc5O02Q71ZwwhLegdubpOvuimx/HsdfwlNwL38KEhwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772431; c=relaxed/simple;
	bh=8ift9Rg3TQGD5vHXV0+nocKMqDeBl8HFojWB0fbU0RA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DVW+XVoWsxMAg3RfFRgPkiDWlV3M51JW7dQCybQjIgYfACl5R2qGajGJny9ao4EqtwvGFtFk2PrLiAC0hWIdd51E8FP4AskYwCdJpgDPb1/RVe+XhRvYYe9zdovJ2M2Nm7d4g6A1kJzTAae131ZsxH/kOjM8qY9mTshHffhMxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C61FmnxD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762772430; x=1794308430;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8ift9Rg3TQGD5vHXV0+nocKMqDeBl8HFojWB0fbU0RA=;
  b=C61FmnxDMzjnq5OcTr8fEAgXvUaogZwKXdJFCf44WQmWu1OHneuUDpvW
   AJ6nBfe7b5bxcSIqlU2XO2nyDPT1lzf30wUTipoIIz94MCDYQ6Rezfao3
   69H2TdEqN7R2hQBfSoMnSuGuns/zVZ2R/WJ5W1tQV7oTv5VMzAO0Esuwm
   nCFNrITNBB6HBF3gCrLfMxOtWV76Aj8LXy90BXfAoG63j0q9UUDIMzp4i
   NzbbuVzXaT9MwmVBX+aGyP0lZuKOeZfkzLghz0I49gaayrThuFfO/22+y
   5jc2n9Q8MuiUlxEpuTyTFcbZKyNOBVvPut4Dp89ytOEZBw0dQ/npN6hLj
   Q==;
X-CSE-ConnectionGUID: FZPqlVxrS5GZEQutX041GQ==
X-CSE-MsgGUID: tEybnN6KQIyJ3OvX1LMa5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75926054"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75926054"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:00:29 -0800
X-CSE-ConnectionGUID: lZJkAA9YRPmu1LvJEaWzTw==
X-CSE-MsgGUID: FUJNAYtlSESH/OWPvyJgqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188809151"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:00:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 13:00:20 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Mario Limonciello <superm1@kernel.org>, viro@zeniv.linux.org.uk, 
    brauner@kernel.org, Hans de Goede <hansg@kernel.org>, jack@suse.cz, 
    linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/4] platform/x86: wmi: Prepare for future changes
In-Reply-To: <17515e4d-6e3b-4eb9-99eb-840933315d55@gmx.de>
Message-ID: <6dcc3eda-f06a-22b3-fff6-f4805f709f5f@linux.intel.com>
References: <20251104204540.13931-1-W_Armin@gmx.de> <e40a0d9c-7f38-44ab-a954-b09c9687ea88@kernel.org> <17515e4d-6e3b-4eb9-99eb-840933315d55@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-673320136-1762772420=:1060"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-673320136-1762772420=:1060
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Nov 2025, Armin Wolf wrote:

> Am 04.11.25 um 21:52 schrieb Mario Limonciello:
>=20
> > On 11/4/25 2:45 PM, Armin Wolf wrote:
> > > After over a year of reverse engineering, i am finally ready to
> > > introduce support for WMI-ACPI marshalling inside the WMI driver core=
=2E
> > marshaling> Since the resulting patch series is quite large, i am plann=
ing
> > to
> > > submit the necessary patches as three separate patch series.
> > >=20
> > > This is supposed to be the first of the three patch series. Its main
> > > purpose is to prepare the WMI driver core for the upcoming changes.
> > > The first patch fixes an issue inside the nls utf16 to utf8 conversio=
n
> > > code, while the next two patches fix some minor issues inside the WMI
> > > driver core itself. The last patch finally moves the code of the WMI
> > > driver core into a separate repository to allow for future additions
> > > without cluttering the main directory.
> >=20
> > One question I have here on the patch to move things.
> >=20
> > Since Windows on ARM (WoA) laptops are a thing - is this still actually=
 x86
> > specific?=C2=A0 I am wondering if this should be moving to a different =
subsystem
> > altogether like ACPI; especially now with this impending other large pa=
tch
> > series you have on your way.
>=20
> I know of a few WoA laptops that contain ACPI-WMI devices, meaning this d=
river
> is indeed not x86-specific.
> However i need to make some changes to the WMI driver core (and actually =
tests
> it on a AArch64 VM) first
> before moving it out of drivers/platform/x86.
>=20
> Once i am actually ready for this i would prefer to move the whole stuff =
to
> drivers/platform, as drivers/acpi
> IMHO is better suited for core ACPI drivers.

So no need to put it under drivers/platform/x86/wmi/ then at all. It=20
can move directly to drivers/platform/wmi/ and you work there towards=20
making it non-x86-specific.

--=20
 i.

>=20
> Thanks,
> Armin Wolf
>=20
> > >=20
> > > Armin Wolf (4):
> > > =C2=A0=C2=A0 fs/nls: Fix utf16 to utf8 conversion
> > > =C2=A0=C2=A0 platform/x86: wmi: Use correct type when populating ACPI=
 objects
> > > =C2=A0=C2=A0 platform/x86: wmi: Remove extern keyword from prototypes
> > > =C2=A0=C2=A0 platform/x86: wmi: Move WMI core code into a separate di=
rectory
> > >=20
> > > =C2=A0 Documentation/driver-api/wmi.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0 drivers/platform/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +-----------------=
-
> > > =C2=A0 drivers/platform/x86/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0 drivers/platform/x86/wmi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 34 ++++++++++++++++++++++
> > > =C2=A0 drivers/platform/x86/wmi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++
> > > =C2=A0 drivers/platform/x86/{wmi.c =3D> wmi/core.c} | 34 ++++++++++++=
+---------
> > > =C2=A0 fs/nls/nls_base.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++---
> > > =C2=A0 include/linux/wmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 15 ++++------
> > > =C2=A0 9 files changed, 84 insertions(+), 59 deletions(-)
> > > =C2=A0 create mode 100644 drivers/platform/x86/wmi/Kconfig
> > > =C2=A0 create mode 100644 drivers/platform/x86/wmi/Makefile
> > > =C2=A0 rename drivers/platform/x86/{wmi.c =3D> wmi/core.c} (98%)
> > >=20
> >=20
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>=20
--8323328-673320136-1762772420=:1060--

