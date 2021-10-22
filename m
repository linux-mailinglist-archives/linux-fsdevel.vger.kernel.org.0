Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF7437BA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhJVRRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhJVRRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:17:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F30C061764;
        Fri, 22 Oct 2021 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A2qIKzLmaHiruo4ITVd737DFb76HJfGU1G5yRr7n2nA=; b=rHoviyfXzd/lrQqDvJrWfUZPJb
        khSzljNSmZgr6NeCLmL2ZONpCIRpKB4oHioCY+rox2FwEHu4Ywt0HONuXefuBv/3UpAur5nkRyFqH
        J7hTmn+S8ptHG7GDNZkQsDxTGe7GNJdFCUMvsLXKyIEUrYxwnpCxBnNzSCRtUP63ii5JIHDdRbHiS
        xItouevSX03vuGJ4AWRBwdEVidWlfR+a84nHSvDQSoLkasicCW9qV0Wdkc1U02fJ62Z5EX4JRkSYW
        8YR2rsMzwlL7ahaWXhIDk4BP1EtoaXVSoklKfpcXL6qO3C3iIfQS4m2fEqm+Mp9587qQjSmZLJysz
        8qltYNeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdy8H-00BbTQ-Sx; Fri, 22 Oct 2021 17:15:05 +0000
Date:   Fri, 22 Oct 2021 10:15:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YXLxmbxLU/+eV+JH@bombadil.infradead.org>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
 <20211021155843.1969401-9-mcgrof@kernel.org>
 <YXKq8gJsQE/U9ZKq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXKq8gJsQE/U9ZKq@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:13:38PM +0200, Greg KH wrote:
> On Thu, Oct 21, 2021 at 08:58:41AM -0700, Luis R. Rodriguez wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > If we wanted to use a different directory for building target
> > builtin firmware it is easier if we just have a shared library
> > Makefile, and each target directory can then just include it and
> > populate the respective needed variables. This reduces clutter,
> > makes things easier to read, and also most importantly allows
> > us to not have to try to magically adjust only one target
> > kconfig symbol for built-in firmware files. Trying to do this
> > can easily end up causing odd build issues if the user is not
> > careful.
> > 
> > As an example issue, if we are going to try to extend the
> > FW_LOADER_BUILTIN_FILES list and FW_LOADER_BUILTIN_DIR in case
> > of a new test firmware builtin support currently our only option
> > would be modify the defaults of each of these in case test firmware
> > builtin support was enabled. Defaults however won't augment a prior
> > setting, and so if FW_LOADER_BUILTIN_DIR="/lib/firmware" and you
> > and want this to be changed to something like
> > FW_LOADER_BUILTIN_DIR="drivers/base/firmware_loader/test-builtin"
> > the change will not take effect as a prior build already had it
> > set, and the build would fail. Trying to augment / append the
> > variables in the Makefile just makes this very difficult to
> > read.
> > 
> > Using a library let's us split up possible built-in targets so
> > that the user does not have to be involved. This will be used
> > in a subsequent patch which will add another user to this
> > built-in firmware library Makefile and demo how to use it outside
> > of the default FW_LOADER_BUILTIN_DIR and FW_LOADER_BUILTIN_FILES.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> I'm sorry, but I do not understand the need for this change at all.  You
> are now building this as a library, but what uses this library?  The
> patches after this series are just testing patches, to verify that the
> code previous in this series is working correctly, it should not depend
> on a new library that only the testing code requires, right?

The last patch adds support to test built-in firmware, but most kernels
will have and do want EXTRA_FIRMWARE="", and so there cannot be anything
that can be tested. And so we need aother two pair of kconfig symbols
which are independent to test built-in firmware. The reason for this is
explained in the commit log, if we try to augment the EXTRA_FIRMWARE
when enabling testing built-in firmware we can easily end up with odd
build issues.

So this patch moves the logic to enable us to re-use the same built-in
magic for two independent kconfig test symbols.

  Luis
