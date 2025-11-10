Return-Path: <linux-fsdevel+bounces-67668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6360C46130
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD6218926C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B029307AEA;
	Mon, 10 Nov 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkLxrBqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6623B60A;
	Mon, 10 Nov 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772079; cv=none; b=FESYJVqIJ9QI45AHCRJRLHbW1eN17hzVXwtgiG8XJ2tN+EUIWAIwJvlv3BMrUBQisFB/t6PfRJ599csKYG+Swwug97hT5F3t1RHI8poKIW6+orGutqUwd3fAWHkutUM/p2gipwjJw1ST9s403CIjz+7WRkygJY9NPgxG4GTF1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772079; c=relaxed/simple;
	bh=xfHWXZ5U+Nf/hxvBKohYTokiVQ1v9bOujNlt/FgRHyA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m9GnyRB00hn74o4195nNilW0OCHEzXbG9VIh7OOlcnW7uVqlacd9mEbI37C+Bc5BD/PHCdQEMMJ21vIfJplvL8zx7hDkAUVoA2q5AiyyC9TYcS2yvtP6WGaOYqHHp+sHLM8CTBruCpQvGzTmBg+kiPzwD2J2SLTj63SWRHiWs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkLxrBqA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762772077; x=1794308077;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xfHWXZ5U+Nf/hxvBKohYTokiVQ1v9bOujNlt/FgRHyA=;
  b=hkLxrBqA4+VsVFFg0tZZCBIqujjEijo8YJERqLxzxj0+2l9ewrrH8rKC
   MlE0oHx8V07aozPAfGGmL8SvWTEMZrZa7UQit3go/bbX00y9PbEYvRv13
   MmuUdKDGHVUQuf8y91/BN2BJv7jphMJRcrKAoAoyKO55mZRAhNLSUjICV
   cd+jpt+F9jtvgU9oLazACUJdH7BgkNYxTcMXkX22wUeCIxkXZgUXcjf/a
   199muXRfldvGpnb+gzJFLVR8hEcESmIW/KUEpa1b76+eVlAYj9q+sdnVQ
   lrAZ4LZ+uBQiQBz8bZW1lHkOPG8LL5YdwEuWFVVJVblMZGPVhGwL41Pse
   Q==;
X-CSE-ConnectionGUID: AFE1l21DR0Sci64tqj1bLA==
X-CSE-MsgGUID: NlmzAmQCR3yjDY/PCA1v9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="52377792"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="52377792"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:54:37 -0800
X-CSE-ConnectionGUID: hR0t+bTVSgebUyWMAjs7KA==
X-CSE-MsgGUID: qO2TakuTTcmIC2Kj3pyLmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192903766"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:54:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 12:54:29 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: viro@zeniv.linux.org.uk, brauner@kernel.org, 
    Hans de Goede <hansg@kernel.org>, jack@suse.cz, 
    linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: wmi: Move WMI core code into a separate
 directory
In-Reply-To: <8722f933-010f-44c4-9df7-1417207a34b3@gmx.de>
Message-ID: <92ccfd06-37e1-b465-a072-846d242c47c2@linux.intel.com>
References: <20251104204540.13931-1-W_Armin@gmx.de> <20251104204540.13931-5-W_Armin@gmx.de> <7d0b6d80-4061-9eb5-5aa3-6a37bac3e2b1@linux.intel.com> <8722f933-010f-44c4-9df7-1417207a34b3@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2023958081-1762772069=:1060"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2023958081-1762772069=:1060
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Nov 2025, Armin Wolf wrote:

> Am 05.11.25 um 10:41 schrieb Ilpo J=C3=A4rvinen:
>=20
> > On Tue, 4 Nov 2025, Armin Wolf wrote:
> >=20
> > > Move the WMI core code into a separate directory to prepare for
> > > future additions to the WMI driver.
> > >=20
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   Documentation/driver-api/wmi.rst           |  2 +-
> > >   MAINTAINERS                                |  2 +-
> > >   drivers/platform/x86/Kconfig               | 30 +------------------
> > >   drivers/platform/x86/Makefile              |  2 +-
> > >   drivers/platform/x86/wmi/Kconfig           | 34 +++++++++++++++++++=
+++
> > >   drivers/platform/x86/wmi/Makefile          |  8 +++++
> > >   drivers/platform/x86/{wmi.c =3D> wmi/core.c} |  0
> > >   7 files changed, 46 insertions(+), 32 deletions(-)
> > >   create mode 100644 drivers/platform/x86/wmi/Kconfig
> > >   create mode 100644 drivers/platform/x86/wmi/Makefile
> > >   rename drivers/platform/x86/{wmi.c =3D> wmi/core.c} (100%)
> > >=20
> > > diff --git a/Documentation/driver-api/wmi.rst
> > > b/Documentation/driver-api/wmi.rst
> > > index 4e8dbdb1fc67..66f0dda153b0 100644
> > > --- a/Documentation/driver-api/wmi.rst
> > > +++ b/Documentation/driver-api/wmi.rst
> > > @@ -16,5 +16,5 @@ which will be bound to compatible WMI devices by th=
e
> > > driver core.
> > >   .. kernel-doc:: include/linux/wmi.h
> > >      :internal:
> > >   -.. kernel-doc:: drivers/platform/x86/wmi.c
> > > +.. kernel-doc:: drivers/platform/x86/wmi/core.c
> > >      :export:
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 46126ce2f968..abc0ff6769a8 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -402,7 +402,7 @@ S:=09Maintained
> > >   F:=09Documentation/ABI/testing/sysfs-bus-wmi
> > >   F:=09Documentation/driver-api/wmi.rst
> > >   F:=09Documentation/wmi/
> > > -F:=09drivers/platform/x86/wmi.c
> > > +F:=09drivers/platform/x86/wmi/
> > >   F:=09include/uapi/linux/wmi.h
> > >     ACRN HYPERVISOR SERVICE MODULE
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
> > > index 46e62feeda3c..ef59425580f3 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -16,35 +16,7 @@ menuconfig X86_PLATFORM_DEVICES
> > >     if X86_PLATFORM_DEVICES
> > >   -config ACPI_WMI
> > > -=09tristate "WMI"
> > > -=09depends on ACPI
> > > -=09help
> > > -=09  This driver adds support for the ACPI-WMI (Windows Management
> > > -=09  Instrumentation) mapper device (PNP0C14) found on some systems.
> > > -
> > > -=09  ACPI-WMI is a proprietary extension to ACPI to expose parts of =
the
> > > -=09  ACPI firmware to userspace - this is done through various vendo=
r
> > > -=09  defined methods and data blocks in a PNP0C14 device, which are =
then
> > > -=09  made available for userspace to call.
> > > -
> > > -=09  The implementation of this in Linux currently only exposes this=
 to
> > > -=09  other kernel space drivers.
> > > -
> > > -=09  This driver is a required dependency to build the firmware spec=
ific
> > > -=09  drivers needed on many machines, including Acer and HP laptops.
> > > -
> > > -=09  It is safe to enable this driver even if your DSDT doesn't defi=
ne
> > > -=09  any ACPI-WMI devices.
> > > -
> > > -config ACPI_WMI_LEGACY_DEVICE_NAMES
> > > -=09bool "Use legacy WMI device naming scheme"
> > > -=09depends on ACPI_WMI
> > > -=09help
> > > -=09  Say Y here to force the WMI driver core to use the old WMI devi=
ce
> > > naming
> > > -=09  scheme when creating WMI devices. Doing so might be necessary f=
or
> > > some
> > > -=09  userspace applications but will cause the registration of WMI
> > > devices with
> > > -=09  the same GUID to fail in some corner cases.
> > > +source "drivers/platform/x86/wmi/Kconfig"
> > >     config WMI_BMOF
> > >   =09tristate "WMI embedded Binary MOF driver"
> > > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Mak=
efile
> > > index c7db2a88c11a..c9f6e9275af8 100644
> > > --- a/drivers/platform/x86/Makefile
> > > +++ b/drivers/platform/x86/Makefile
> > > @@ -5,7 +5,7 @@
> > >   #
> > >     # Windows Management Interface
> > > -obj-$(CONFIG_ACPI_WMI)=09=09+=3D wmi.o
> > > +obj-y=09=09=09=09+=3D wmi/
> > Is there a good reason for the first part of the change?
> > That is, do you anticipate need for something outside of what this woul=
d
> > cover:
> >=20
> > obj-$(CONFIG_ACPI_WMI)               +=3D wmi/
> >=20
> > Other than that, this series looks fine.
>=20
> The final version will look like this:
>=20
> wmi-y                   :=3D core.o marshalling.o string.o
> obj-$(CONFIG_ACPI_WMI)  +=3D wmi.o
>=20
> # Unit tests
> obj-y                   +=3D tests/
>=20
> So i think this change is necessary.

Fair enough.

--=20
 i.

--8323328-2023958081-1762772069=:1060--

