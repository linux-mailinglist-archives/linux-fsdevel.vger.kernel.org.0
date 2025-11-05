Return-Path: <linux-fsdevel+bounces-67084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD7C34EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF053A6FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707F302162;
	Wed,  5 Nov 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1f5KIWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F93002B0;
	Wed,  5 Nov 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335703; cv=none; b=OnRu5Q7dfjEFoI4Yjz9NG+e+fT8lMviIGgKEtBwiXkgdORI4IcyZwdkJFftVNceTXDhCJK9tJ5HQiy7wr/dVTgEiCUHDD1MbvP5pZb/QQoyw+XoomBcGM8iRePvDtVFNOgbSeISnnci5gMQ0hmSam5zI+huxKjaPaiRAMglavXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335703; c=relaxed/simple;
	bh=5tXtCUIfRqWrWbLKsdxhcyUYXlvRPrVVqFxnnUlJGjQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=heqCAa7n/TnnY2vnqPZiylZaCK7sKhWuDr+rwsTOjviqFcTg55fGAbKtIjCcOK4Aq0k6DdJ5+5gEQZJ29ixZvVs9aZQ8PB8SoNROmM76yWAgBUfy072T7z5tayOvIBwG3tOLW6ksv2iS0oN5egfHdoMYXlCFiy03shl2WXa0MyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1f5KIWt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762335701; x=1793871701;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5tXtCUIfRqWrWbLKsdxhcyUYXlvRPrVVqFxnnUlJGjQ=;
  b=Y1f5KIWtQDm5jVeWzvJAxvWJZfz29vcoozcJdO1FJDpi4G4wg4cvpoY5
   g3uAYGoMjpwztqGz4WWtDs7kjboQ/9swezqr4f1ukr9ES3Uif6oMonegi
   1t84r9C+Fz+NgYaErCV4rcZO4mM4ge089ywQlVNw8LkRUW01PVbDn8n/U
   Nrl0PuWYhjh5y2GtWfRwM7OH78QNcRXwsi6MNTEGLskF33BtqgnTlNBN8
   OpoGER8ZwxgBpNpef6SnFscM1m364oYWiXwkHLHJwzzrYhcHgvWMEKQRZ
   RlHQ2yNCcS43pRlVN8tMIlFul9Q6Y9DOZy1WNRpCLNqyjalPxMnxJM6lT
   w==;
X-CSE-ConnectionGUID: nFA3uAfHSHepTC5aSHaqoA==
X-CSE-MsgGUID: AfK+miADSlSfaiG9Ypm9bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74738820"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="74738820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 01:41:40 -0800
X-CSE-ConnectionGUID: Bu8yP39LREG8PeNXmrKQIg==
X-CSE-MsgGUID: dlRRebcJTSGLmClil0Aagg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186697438"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 01:41:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 11:41:34 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: viro@zeniv.linux.org.uk, brauner@kernel.org, 
    Hans de Goede <hansg@kernel.org>, jack@suse.cz, 
    linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: wmi: Move WMI core code into a separate
 directory
In-Reply-To: <20251104204540.13931-5-W_Armin@gmx.de>
Message-ID: <7d0b6d80-4061-9eb5-5aa3-6a37bac3e2b1@linux.intel.com>
References: <20251104204540.13931-1-W_Armin@gmx.de> <20251104204540.13931-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Nov 2025, Armin Wolf wrote:

> Move the WMI core code into a separate directory to prepare for
> future additions to the WMI driver.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/driver-api/wmi.rst           |  2 +-
>  MAINTAINERS                                |  2 +-
>  drivers/platform/x86/Kconfig               | 30 +------------------
>  drivers/platform/x86/Makefile              |  2 +-
>  drivers/platform/x86/wmi/Kconfig           | 34 ++++++++++++++++++++++
>  drivers/platform/x86/wmi/Makefile          |  8 +++++
>  drivers/platform/x86/{wmi.c => wmi/core.c} |  0
>  7 files changed, 46 insertions(+), 32 deletions(-)
>  create mode 100644 drivers/platform/x86/wmi/Kconfig
>  create mode 100644 drivers/platform/x86/wmi/Makefile
>  rename drivers/platform/x86/{wmi.c => wmi/core.c} (100%)
> 
> diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/wmi.rst
> index 4e8dbdb1fc67..66f0dda153b0 100644
> --- a/Documentation/driver-api/wmi.rst
> +++ b/Documentation/driver-api/wmi.rst
> @@ -16,5 +16,5 @@ which will be bound to compatible WMI devices by the driver core.
>  .. kernel-doc:: include/linux/wmi.h
>     :internal:
>  
> -.. kernel-doc:: drivers/platform/x86/wmi.c
> +.. kernel-doc:: drivers/platform/x86/wmi/core.c
>     :export:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..abc0ff6769a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -402,7 +402,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-wmi
>  F:	Documentation/driver-api/wmi.rst
>  F:	Documentation/wmi/
> -F:	drivers/platform/x86/wmi.c
> +F:	drivers/platform/x86/wmi/
>  F:	include/uapi/linux/wmi.h
>  
>  ACRN HYPERVISOR SERVICE MODULE
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 46e62feeda3c..ef59425580f3 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -16,35 +16,7 @@ menuconfig X86_PLATFORM_DEVICES
>  
>  if X86_PLATFORM_DEVICES
>  
> -config ACPI_WMI
> -	tristate "WMI"
> -	depends on ACPI
> -	help
> -	  This driver adds support for the ACPI-WMI (Windows Management
> -	  Instrumentation) mapper device (PNP0C14) found on some systems.
> -
> -	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
> -	  ACPI firmware to userspace - this is done through various vendor
> -	  defined methods and data blocks in a PNP0C14 device, which are then
> -	  made available for userspace to call.
> -
> -	  The implementation of this in Linux currently only exposes this to
> -	  other kernel space drivers.
> -
> -	  This driver is a required dependency to build the firmware specific
> -	  drivers needed on many machines, including Acer and HP laptops.
> -
> -	  It is safe to enable this driver even if your DSDT doesn't define
> -	  any ACPI-WMI devices.
> -
> -config ACPI_WMI_LEGACY_DEVICE_NAMES
> -	bool "Use legacy WMI device naming scheme"
> -	depends on ACPI_WMI
> -	help
> -	  Say Y here to force the WMI driver core to use the old WMI device naming
> -	  scheme when creating WMI devices. Doing so might be necessary for some
> -	  userspace applications but will cause the registration of WMI devices with
> -	  the same GUID to fail in some corner cases.
> +source "drivers/platform/x86/wmi/Kconfig"
>  
>  config WMI_BMOF
>  	tristate "WMI embedded Binary MOF driver"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c7db2a88c11a..c9f6e9275af8 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -5,7 +5,7 @@
>  #
>  
>  # Windows Management Interface
> -obj-$(CONFIG_ACPI_WMI)		+= wmi.o
> +obj-y				+= wmi/

Is there a good reason for the first part of the change?
That is, do you anticipate need for something outside of what this would 
cover:

obj-$(CONFIG_ACPI_WMI)               += wmi/

Other than that, this series looks fine.

-- 
 i.


>  obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
>  
>  # WMI drivers
> diff --git a/drivers/platform/x86/wmi/Kconfig b/drivers/platform/x86/wmi/Kconfig
> new file mode 100644
> index 000000000000..9e7c84876ef5
> --- /dev/null
> +++ b/drivers/platform/x86/wmi/Kconfig
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# ACPI WMI Core
> +#
> +
> +config ACPI_WMI
> +	tristate "WMI"
> +	depends on ACPI
> +	help
> +	  This driver adds support for the ACPI-WMI (Windows Management
> +	  Instrumentation) mapper device (PNP0C14) found on some systems.
> +
> +	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
> +	  ACPI firmware to userspace - this is done through various vendor
> +	  defined methods and data blocks in a PNP0C14 device, which are then
> +	  made available for userspace to call.
> +
> +	  The implementation of this in Linux currently only exposes this to
> +	  other kernel space drivers.
> +
> +	  This driver is a required dependency to build the firmware specific
> +	  drivers needed on many machines, including Acer and HP laptops.
> +
> +	  It is safe to enable this driver even if your DSDT doesn't define
> +	  any ACPI-WMI devices.
> +
> +config ACPI_WMI_LEGACY_DEVICE_NAMES
> +	bool "Use legacy WMI device naming scheme"
> +	depends on ACPI_WMI
> +	help
> +	  Say Y here to force the WMI driver core to use the old WMI device naming
> +	  scheme when creating WMI devices. Doing so might be necessary for some
> +	  userspace applications but will cause the registration of WMI devices with
> +	  the same GUID to fail in some corner cases.
> diff --git a/drivers/platform/x86/wmi/Makefile b/drivers/platform/x86/wmi/Makefile
> new file mode 100644
> index 000000000000..71b702936b59
> --- /dev/null
> +++ b/drivers/platform/x86/wmi/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for linux/drivers/platform/x86/wmi
> +# ACPI WMI core
> +#
> +
> +wmi-y			:= core.o
> +obj-$(CONFIG_ACPI_WMI)	+= wmi.o
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi/core.c
> similarity index 100%
> rename from drivers/platform/x86/wmi.c
> rename to drivers/platform/x86/wmi/core.c
> 

