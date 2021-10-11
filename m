Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B24295FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhJKRsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 13:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhJKRsH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:48:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D88D60F11;
        Mon, 11 Oct 2021 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633974366;
        bh=4TBfE9Rzk3TgLICfxbmtsZgSk07WQpuq6KQNlcoRChM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAKTONy3TU/ziCpABOZkrPunxgKX0Y13t5JUj+3yISi8P38M0v7ccfzBEAwloWjgN
         FZ3Tw3aUzUlN13EwdzlzsVlmQvkp5DNFhFC7mBvDLaXVafw89iQyPd5YDzmYv1Mc9d
         q3TFN2+cOoPRX3u5JDcCeJYjXf+vkq2fck5RVjrU=
Date:   Mon, 11 Oct 2021 19:46:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Subject: Re: [PATCH 04/14] firmware_loader: add built-in firmware kconfig
 entry
Message-ID: <YWR4XKrC2Bkr4qKQ@kroah.com>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
 <20210917182226.3532898-5-mcgrof@kernel.org>
 <YVxhbhmNd7tahLV7@kroah.com>
 <YWR16e/seTx/wxE+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWR16e/seTx/wxE+@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:35:37AM -0700, Luis Chamberlain wrote:
> On Tue, Oct 05, 2021 at 04:30:06PM +0200, Greg KH wrote:
> > On Fri, Sep 17, 2021 at 11:22:16AM -0700, Luis R. Rodriguez wrote:
> > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > 
> > > The built-in firmware is always supported when a user enables
> > > FW_LOADER=y today, that is, it is built-in to the kernel. When the
> > > firmware loader is built as a module, support for built-in firmware
> > > is skipped. This requirement is not really clear to users or even
> > > developers.
> > > 
> > > Also, by default the EXTRA_FIRMWARE is always set to an empty string
> > > and so by default we really have nothing built-in to that kernel's
> > > sections for built-in firmware, so today a all FW_LOADER=y kernels
> > > spins their wheels on an empty set of built-in firmware for each
> > > firmware request with no true need for it.
> > > 
> > > Add a new kconfig entry to represent built-in firmware support more
> > > clearly. This let's knock 3 birds with one stone:
> > > 
> > >  o Clarifies that support for built-in firmware requires the
> > >    firmware loader to be built-in to the kernel
> > > 
> > >  o By default we now always skip built-in firmware even if a FW_LOADER=y
> > > 
> > >  o This also lets us make it clear that the EXTRA_FIRMWARE_DIR
> > >    kconfig entry is only used for built-in firmware
> > > 
> > > Reviewed-by: Borislav Petkov <bp@suse.de>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  .../driver-api/firmware/built-in-fw.rst       |  2 ++
> > >  Documentation/x86/microcode.rst               |  5 ++--
> > >  drivers/base/firmware_loader/Kconfig          | 25 +++++++++++++------
> > >  drivers/base/firmware_loader/Makefile         |  3 +--
> > >  drivers/base/firmware_loader/main.c           |  4 +--
> > >  5 files changed, 26 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/firmware/built-in-fw.rst b/Documentation/driver-api/firmware/built-in-fw.rst
> > > index bc1c961bace1..9dd2b1df44f0 100644
> > > --- a/Documentation/driver-api/firmware/built-in-fw.rst
> > > +++ b/Documentation/driver-api/firmware/built-in-fw.rst
> > > @@ -8,6 +8,7 @@ the filesystem. Instead, firmware can be looked for inside the kernel
> > >  directly. You can enable built-in firmware using the kernel configuration
> > >  options:
> > >  
> > > +  * CONFIG_FW_LOADER_BUILTIN
> > >    * CONFIG_EXTRA_FIRMWARE
> > >    * CONFIG_EXTRA_FIRMWARE_DIR
> > >  
> > > @@ -17,6 +18,7 @@ into the kernel with CONFIG_EXTRA_FIRMWARE:
> > >  * Speed
> > >  * Firmware is needed for accessing the boot device, and the user doesn't
> > >    want to stuff the firmware into the boot initramfs.
> > > +* Testing built-in firmware
> > >  
> > >  Even if you have these needs there are a few reasons why you may not be
> > >  able to make use of built-in firmware:
> > > diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
> > > index a320d37982ed..d199f0b98869 100644
> > > --- a/Documentation/x86/microcode.rst
> > > +++ b/Documentation/x86/microcode.rst
> > > @@ -114,11 +114,12 @@ Builtin microcode
> > >  =================
> > >  
> > >  The loader supports also loading of a builtin microcode supplied through
> > > -the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
> > > -currently supported.
> > > +the regular builtin firmware method using CONFIG_FW_LOADER_BUILTIN and
> > > +CONFIG_EXTRA_FIRMWARE. Only 64-bit is currently supported.
> > >  
> > >  Here's an example::
> > >  
> > > +  CONFIG_FW_LOADER_BUILTIN=y
> > >    CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
> > >    CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
> > >  
> > > diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> > > index 5b24f3959255..de4fcd9d41f3 100644
> > > --- a/drivers/base/firmware_loader/Kconfig
> > > +++ b/drivers/base/firmware_loader/Kconfig
> > > @@ -29,8 +29,10 @@ if FW_LOADER
> > >  config FW_LOADER_PAGED_BUF
> > >  	bool
> > >  
> > > -config EXTRA_FIRMWARE
> > > -	string "Build named firmware blobs into the kernel binary"
> > > +config FW_LOADER_BUILTIN
> > > +	bool "Enable support for built-in firmware"
> > > +	default n
> > 
> > n is always the default, no need to list it again.
> 
> Oh, alrighty, I'll remove that line.
> 
> > > +	depends on FW_LOADER=y
> > 
> > I don't see what this gets us to add another config option.  Are you
> > making things easier later on?
> 
> This makes a few things clearer for both developers and users.
> The code in question is a *feature* *only* when FW_LOADER=y, by
> adding a new kconfig to represent this and clearly makeing it
> depend on FW_LOADER=y it let's us:
> 
>   o Clarify that support for built-in firmware requires
>     the firmware loader to be built-in to the kernel

That is good.

>   o By default we now always skip built-in firmware even if a FW_LOADER=y

I do not understand, why would we ever want to skip built-in firmware?

>   o This also lets us make it clear that the EXTRA_FIRMWARE_DIR
>     kconfig entry is only used for built-in firmware

How was it ever used for anything else?  :)

> The above is not easily obvious to developers (including myself when
> I was reviewing this code) or users without this new kconfig entry.
> 
> Should I re-send by just removing the one line you asked for?

I can not take this as-is, so yes :)

thanks,

greg k-h
