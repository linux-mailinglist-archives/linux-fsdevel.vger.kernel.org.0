Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C00437695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhJVMQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 08:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhJVMP6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:15:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73BFB6101C;
        Fri, 22 Oct 2021 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634904821;
        bh=0Jm729A//8Gt6aSpcc+e0DHH9iZ1PE/6ep8ru4Kc8to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSFp2NVnT5t2g3+IA1M+f0gn8ac4es5WuyfjANrKbE6rlHjQZBE1RYCQ6URdbX2Tc
         UaVKYOAb/DY7DT8VuJFuPSOKCTjSJKBPCHeItWSWlvznwo4Uz7XSlx0zeKhWrUvNXM
         XoYa5Uo2ITzL/AuHPGeHTovMLFh4HOxTqVS0ia7g=
Date:   Fri, 22 Oct 2021 14:13:38 +0200
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
Subject: Re: [PATCH v2 08/10] firmware_loader: move builtin build helper to
 shared library
Message-ID: <YXKq8gJsQE/U9ZKq@kroah.com>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
 <20211021155843.1969401-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021155843.1969401-9-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:58:41AM -0700, Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> If we wanted to use a different directory for building target
> builtin firmware it is easier if we just have a shared library
> Makefile, and each target directory can then just include it and
> populate the respective needed variables. This reduces clutter,
> makes things easier to read, and also most importantly allows
> us to not have to try to magically adjust only one target
> kconfig symbol for built-in firmware files. Trying to do this
> can easily end up causing odd build issues if the user is not
> careful.
> 
> As an example issue, if we are going to try to extend the
> FW_LOADER_BUILTIN_FILES list and FW_LOADER_BUILTIN_DIR in case
> of a new test firmware builtin support currently our only option
> would be modify the defaults of each of these in case test firmware
> builtin support was enabled. Defaults however won't augment a prior
> setting, and so if FW_LOADER_BUILTIN_DIR="/lib/firmware" and you
> and want this to be changed to something like
> FW_LOADER_BUILTIN_DIR="drivers/base/firmware_loader/test-builtin"
> the change will not take effect as a prior build already had it
> set, and the build would fail. Trying to augment / append the
> variables in the Makefile just makes this very difficult to
> read.
> 
> Using a library let's us split up possible built-in targets so
> that the user does not have to be involved. This will be used
> in a subsequent patch which will add another user to this
> built-in firmware library Makefile and demo how to use it outside
> of the default FW_LOADER_BUILTIN_DIR and FW_LOADER_BUILTIN_FILES.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

I'm sorry, but I do not understand the need for this change at all.  You
are now building this as a library, but what uses this library?  The
patches after this series are just testing patches, to verify that the
code previous in this series is working correctly, it should not depend
on a new library that only the testing code requires, right?

confused,

greg k-h
