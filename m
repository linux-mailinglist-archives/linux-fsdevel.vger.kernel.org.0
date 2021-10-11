Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB75429888
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhJKU63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhJKU6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:58:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50ACC061570;
        Mon, 11 Oct 2021 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OMRA5Uy0CFXQGBZKXpMNyiSotsoVxsy0srVBHW0eyHE=; b=sRfuKtWUNHZUGaWjNQQbXf/e8b
        iEkEAXyheUHXhWt4e7rydqqkHjMCfN8Sh7O/Y+Nw9QLVBeQ+k8ZWIM0/AzbOCL63UB/EMCpp46KiS
        +F0yVbklkLFCPZZIDvcy7aybZraDYDTr3zZQyiGBvTETg6ZwvTCyi+lNMKiS7yPCreyoBYGLTLTAc
        HC5QKkLo7ssw3OMMdkup6XnzsYzVsdr4yLx4uDX+0Cbpk5xVE0e3aKm10V/4LylFQpXDozuAYtJea
        5Chg0HgbknV86PRZYhJxB1LkXM43W8HFdMsN0EpEEzeApLlOXqrgm+oFSUkXk95G5Hert03HWNbh7
        PJh8ufmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma2LJ-00AffX-0F; Mon, 11 Oct 2021 20:56:17 +0000
Date:   Mon, 11 Oct 2021 13:56:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/12] test_sysfs: add support to use kernfs failure
 injection
Message-ID: <YWSk8N1apUGE5gnd@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-6-mcgrof@kernel.org>
 <202110051248.FCF2E89@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110051248.FCF2E89@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:51:33PM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:37:58AM -0700, Luis Chamberlain wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index a29b7d398c4e..176b822654e5 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2358,6 +2358,9 @@ config TEST_SYSFS
> >  	depends on SYSFS
> >  	depends on NET
> >  	depends on BLOCK
> > +	select FAULT_INJECTION
> > +	select FAULT_INJECTION_DEBUG_FS
> > +	select FAIL_KERNFS_KNOBS
> 
> I don't like seeing "select" for user-configurable CONFIGs -- things
> tend to end up weird. This should simply be:
> 
> 	depends on FAIL_KERNFS_KNOBS

Sure.

> > diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
> > index 2043ca494af8..c6e62de61403 100644
> > --- a/lib/test_sysfs.c
> > +++ b/lib/test_sysfs.c
> > @@ -38,6 +38,11 @@
> >  #include <linux/rtnetlink.h>
> >  #include <linux/genhd.h>
> >  #include <linux/blkdev.h>
> > +#include <linux/kernfs.h>
> > +
> > +#ifdef CONFIG_FAIL_KERNFS_KNOBS
> 
> This isn't an optional config here (and following)?

Sure with the above change this is no longer needed. Removed all that
ifdef'ery.

  Luis
