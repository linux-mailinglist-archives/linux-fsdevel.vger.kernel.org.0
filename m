Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFB34295EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhJKRmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJKRmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:42:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396BC061570;
        Mon, 11 Oct 2021 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vQMzlZrrHWenwrSVaJ+s8I1Up0NtEx2jMMgBgtwzpgU=; b=2Htew9QXDgXovJdiSDZT91xm0P
        qcV9J2QLzVSv6c2JjV+GOD92Jq4AQ32oHgON7TO+Y+iWwh+hPsz+GjhmnyETcNWTSLudkt5K9vM2A
        /gGez+k+JLaPPkOaSp9vhNhFqVOPazcWmH3nfQd7yhEAlHhl325tMFg/aPl0+/VXjGmDSaMZQmBCa
        b2V8bax4nxFYK9H4oMraQIykqWgrJWry1DenEu1aI9HP5YTK2MD4ZCOFYhcJGPJij+Hjei0i34FeQ
        M+ZbNSbx9wTXYbpABT3hPhrrn767JyVf2rbNzJjvuLpHL70H2nAHBTlvXgnMjxzFWZcf/cMyJkMsp
        FHCaWW7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZzI2-00AGG5-JY; Mon, 11 Oct 2021 17:40:42 +0000
Date:   Mon, 11 Oct 2021 10:40:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tim.Bird@sony.com
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
Message-ID: <YWR3GnSlobVqOQWw@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-4-mcgrof@kernel.org>
 <YVxeTvKkYs938g94@kroah.com>
 <BYAPR13MB2503180449E0863CFD4672F5FDAF9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503180449E0863CFD4672F5FDAF9@BYAPR13MB2503.namprd13.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:57:55PM +0000, Tim.Bird@sony.com wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, October 5, 2021 8:17 AM
> > To: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: tj@kernel.org; akpm@linux-foundation.org; minchan@kernel.org; jeyu@kernel.org; shuah@kernel.org; bvanassche@acm.org;
> > dan.j.williams@intel.com; joe@perches.com; tglx@linutronix.de; keescook@chromium.org; rostedt@goodmis.org; linux-
> > spdx@vger.kernel.org; linux-doc@vger.kernel.org; linux-block@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
> > 
> > On Mon, Sep 27, 2021 at 09:37:56AM -0700, Luis Chamberlain wrote:
> > > --- /dev/null
> > > +++ b/lib/test_sysfs.c
> > > @@ -0,0 +1,921 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> > > +/*
> > > + * sysfs test driver
> > > + *
> > > + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify it
> > > + * under the terms of the GNU General Public License as published by the Free
> > > + * Software Foundation; either version 2 of the License, or at your option any
> > > + * later version; or, when distributed separately from the Linux kernel or
> > > + * when incorporated into other software packages, subject to the following
> > > + * license:
> 
> This is a very strange license grant, which I'm not sure is covered by any
> current SPDX syntax.
> " when distributed separately from the Linux kernel or when incorporated into
> other software packages, subject to the following license:"

drivers/xen/events/events_fifo.c has that same language.

> Why would we care about the license used when the code is used in a non-kernel
> project?  If it is desired for the code to be available outside the kernel under a
> different license, then surely the easiest thing is to make it available separately
> under that license.  I'm not sure why the kernel needs to carry this license for
> non-kernel use of the code.
> 
> I would recommend giving this a GPLv2 SPDX header, and maybe in the comment
> at the top of the file put a reference to a git repository where the code can be
> obtained under a different license.

Keeping the dual let's new updates directly on the kernel benefit from
evolution. A fork would stagnate it in place and would require updates
separately.

  Luis
