Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0512A4376AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJVMVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 08:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhJVMVT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:21:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B396108B;
        Fri, 22 Oct 2021 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634905142;
        bh=FUishw8k4XRuNkUk0Ay8ewVfHmBDFHfAlBgLlhvOUA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9q8HYNPVkPnLJqzg5XwTyDMSfbfo5npeR/doP0fFmN36EGN2XY4ubKCuxVIh84v4
         fGJ2TJOvCV6T0THS20u4g/GRs0fok7IKqCJGB5ojpcJONgxV03SCpK67v3OlAQYW+q
         s4hlmfn3e9fePF0y8da5IWZkNTjof7iWP0QKd0TE=
Date:   Fri, 22 Oct 2021 14:19:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] firmware_loader: rename EXTRA_FIRMWARE and
 EXTRA_FIRMWARE_DIR
Message-ID: <YXKsNNONY/TlsK8a@kroah.com>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
 <20211021155843.1969401-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021155843.1969401-8-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:58:40AM -0700, Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Now that we've tied loose ends on the built-in firmware API,
> rename the kconfig symbols for it to reflect more that they are
> associated to the firmware_loader and to make it easier to
> understand what they are for.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  .../driver-api/firmware/built-in-fw.rst       |  6 ++--
>  Documentation/x86/microcode.rst               |  8 ++---
>  arch/x86/Kconfig                              |  4 +--
>  drivers/base/firmware_loader/Kconfig          | 29 ++++++++++++-------
>  drivers/base/firmware_loader/builtin/Makefile |  6 ++--
>  drivers/staging/media/av7110/Kconfig          |  4 +--
>  6 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/driver-api/firmware/built-in-fw.rst b/Documentation/driver-api/firmware/built-in-fw.rst
> index bc1c961bace1..a9a0ab8c9512 100644
> --- a/Documentation/driver-api/firmware/built-in-fw.rst
> +++ b/Documentation/driver-api/firmware/built-in-fw.rst
> @@ -8,11 +8,11 @@ the filesystem. Instead, firmware can be looked for inside the kernel
>  directly. You can enable built-in firmware using the kernel configuration
>  options:
>  
> -  * CONFIG_EXTRA_FIRMWARE
> -  * CONFIG_EXTRA_FIRMWARE_DIR
> +  * CONFIG_FW_LOADER_BUILTIN_FILES
> +  * CONFIG_FW_LOADER_BUILTIN_DIR
>  
>  There are a few reasons why you might want to consider building your firmware
> -into the kernel with CONFIG_EXTRA_FIRMWARE:
> +into the kernel with CONFIG_FW_LOADER_BUILTIN_FILES:
>  
>  * Speed
>  * Firmware is needed for accessing the boot device, and the user doesn't
> diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
> index a320d37982ed..2cacc7f60014 100644
> --- a/Documentation/x86/microcode.rst
> +++ b/Documentation/x86/microcode.rst
> @@ -114,13 +114,13 @@ Builtin microcode
>  =================
>  
>  The loader supports also loading of a builtin microcode supplied through
> -the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
> -currently supported.
> +the regular builtin firmware method using CONFIG_FW_LOADER_BUILTIN and
> +CONFIG_FW_LOADER_BUILTIN_FILES. Only 64-bit is currently supported.
>  
>  Here's an example::
>  
> -  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
> -  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
> +  CONFIG_FW_LOADER_BUILTIN_FILES="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
> +  CONFIG_FW_LOADER_BUILTIN_DIR="/lib/firmware"
>  
>  This basically means, you have the following tree structure locally::
>  
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 999907dd7544..cfb09dc7f21b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1315,8 +1315,8 @@ config MICROCODE
>  	  initrd for microcode blobs.
>  
>  	  In addition, you can build the microcode into the kernel. For that you
> -	  need to add the vendor-supplied microcode to the CONFIG_EXTRA_FIRMWARE
> -	  config option.
> +	  need to add the vendor-supplied microcode to the configuration option
> +	  CONFIG_FW_LOADER_BUILTIN_FILES
>  
>  config MICROCODE_INTEL
>  	bool "Intel microcode loading support"
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5b24f3959255..2dc3e137d903 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -22,14 +22,14 @@ config FW_LOADER
>  	  You typically want this built-in (=y) but you can also enable this
>  	  as a module, in which case the firmware_class module will be built.
>  	  You also want to be sure to enable this built-in if you are going to
> -	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
> +	  enable built-in firmware (CONFIG_FW_LOADER_BUILTIN_FILES).
>  
>  if FW_LOADER
>  
>  config FW_LOADER_PAGED_BUF
>  	bool
>  
> -config EXTRA_FIRMWARE
> +config FW_LOADER_BUILTIN_FILES
>  	string "Build named firmware blobs into the kernel binary"
>  	help
>  	  Device drivers which require firmware can typically deal with
> @@ -43,14 +43,21 @@ config EXTRA_FIRMWARE
>  	  in boot and cannot rely on the firmware being placed in an initrd or
>  	  initramfs.
>  
> -	  This option is a string and takes the (space-separated) names of the
> +	  Support for built-in firmware is not supported if you are using
> +	  the firmware loader as a module.
> +
> +	  This option is a string and takes the space-separated names of the
>  	  firmware files -- the same names that appear in MODULE_FIRMWARE()
>  	  and request_firmware() in the source. These files should exist under
> -	  the directory specified by the EXTRA_FIRMWARE_DIR option, which is
> +	  the directory specified by the FW_LOADER_BUILTIN_DIR option, which is
>  	  /lib/firmware by default.
>  
> -	  For example, you might set CONFIG_EXTRA_FIRMWARE="usb8388.bin", copy
> -	  the usb8388.bin file into /lib/firmware, and build the kernel. Then
> +	  For example, you might have set:
> +
> +	  CONFIG_FW_LOADER_BUILTIN_FILES="usb8388.bin"
> +
> +	  After this you would copy the usb8388.bin file into directory
> +	  specified by FW_LOADER_BUILTIN_DIR and build the kernel. Then
>  	  any request_firmware("usb8388.bin") will be satisfied internally
>  	  inside the kernel without ever looking at your filesystem at runtime.
>  
> @@ -60,13 +67,15 @@ config EXTRA_FIRMWARE
>  	  image since it combines both GPL and non-GPL work. You should
>  	  consult a lawyer of your own before distributing such an image.
>  
> -config EXTRA_FIRMWARE_DIR
> -	string "Firmware blobs root directory"
> +config FW_LOADER_BUILTIN_DIR
> +	string "Directory with firmware to be built-in to the kernel"
>  	depends on EXTRA_FIRMWARE != ""

You forgot to update this dependency :(

I took the first 6 patches here, this one needs work.

thanks,

greg k-h
