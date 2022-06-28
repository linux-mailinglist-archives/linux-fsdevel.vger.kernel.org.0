Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28255E479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiF1N2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbiF1N13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9769433354;
        Tue, 28 Jun 2022 06:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33C43617C5;
        Tue, 28 Jun 2022 13:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94BAC3411D;
        Tue, 28 Jun 2022 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422759;
        bh=zWipI4/HuL6mWJ9CnZHWaGr7nNngJkU/KjLz7LVeqGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyA4r1T6XCkyVvzyhKhyQMp7L5HID1ud7C12uE5pFDCd96vOprVyNXKl5FyR600E5
         eswmsaZ1tY1GFkcMyaGqPnoXa6Rn7o1iU/4pnlRAdUZ2GwwBliWT00an7Yfy1tO0qb
         TlE1Dy5EVSW6hmqCGiMg5+hldWvAlmMUI1E8xcBYt5XpQpTu2x3osanq1HzPrzl7gy
         YlaJDQTOV5qASJUR2ySS9rEL/TuWKeof3HP4eqCQMayUDLwxwy26PEgNPId7Dquqm1
         lkr9NFgj7OdCWAb7uIOiqxvoLiqBz6sirG1ckL1m971PqsAe3eS+JUZp3fVRfwb6sR
         ZyCQ0PBQmMf3g==
Date:   Tue, 28 Jun 2022 15:25:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH v2 2/3] fs: define a firmware security filesystem
 named fwsecurityfs
Message-ID: <20220628132552.ryjlz2dou52sghhr@wittgenstein>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
 <20220622215648.96723-3-nayna@linux.ibm.com>
 <YrQqPhi4+jHZ1WJc@kroah.com>
 <41ca51e8db9907d9060cc38adb59a66dcae4c59b.camel@HansenPartnership.com>
 <54af4a92356090d88639531413ea8cb46837bd18.camel@linux.ibm.com>
 <YrleOHmEbpLPZ1n8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrleOHmEbpLPZ1n8@kroah.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:37:28AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jun 26, 2022 at 11:48:06AM -0400, Mimi Zohar wrote:
> > On Thu, 2022-06-23 at 09:23 -0400, James Bottomley wrote:
> > > On Thu, 2022-06-23 at 10:54 +0200, Greg Kroah-Hartman wrote:
> > > [...]
> > > > > diff --git a/fs/fwsecurityfs/inode.c b/fs/fwsecurityfs/inode.c
> > > > > new file mode 100644
> > > > > index 000000000000..5d06dc0de059
> > > > > --- /dev/null
> > > > > +++ b/fs/fwsecurityfs/inode.c
> > > > > @@ -0,0 +1,159 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Copyright (C) 2022 IBM Corporation
> > > > > + * Author: Nayna Jain <nayna@linux.ibm.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/sysfs.h>
> > > > > +#include <linux/kobject.h>
> > > > > +#include <linux/fs.h>
> > > > > +#include <linux/fs_context.h>
> > > > > +#include <linux/mount.h>
> > > > > +#include <linux/pagemap.h>
> > > > > +#include <linux/init.h>
> > > > > +#include <linux/namei.h>
> > > > > +#include <linux/security.h>
> > > > > +#include <linux/lsm_hooks.h>
> > > > > +#include <linux/magic.h>
> > > > > +#include <linux/ctype.h>
> > > > > +#include <linux/fwsecurityfs.h>
> > > > > +
> > > > > +#include "internal.h"
> > > > > +
> > > > > +int fwsecurityfs_remove_file(struct dentry *dentry)
> > > > > +{
> > > > > +	drop_nlink(d_inode(dentry));
> > > > > +	dput(dentry);
> > > > > +	return 0;
> > > > > +};
> > > > > +EXPORT_SYMBOL_GPL(fwsecurityfs_remove_file);
> > > > > +
> > > > > +int fwsecurityfs_create_file(const char *name, umode_t mode,
> > > > > +					u16 filesize, struct dentry
> > > > > *parent,
> > > > > +					struct dentry *dentry,
> > > > > +					const struct file_operations
> > > > > *fops)
> > > > > +{
> > > > > +	struct inode *inode;
> > > > > +	int error;
> > > > > +	struct inode *dir;
> > > > > +
> > > > > +	if (!parent)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	dir = d_inode(parent);
> > > > > +	pr_debug("securityfs: creating file '%s'\n", name);
> > > > 
> > > > Did you forget to call simple_pin_fs() here or anywhere else?
> > > > 
> > > > And this can be just one function with the directory creation file,
> > > > just check the mode and you will be fine.  Look at securityfs as an
> > > > example of how to make this simpler.
> > > 
> > > Actually, before you go down this route can you consider the namespace
> > > ramifications.  In fact we're just having to rework securityfs to pull
> > > out all the simple_pin_... calls because simple_pin_... is completely
> > > inimical to namespaces.

I described this at length in the securityfs namespacing thread at
various points. simple_pin_*() should be avoided if possible. Ideally
the filesystem will just be cleaned up on umount. There might be a
reason to make it survive umounts if you have state that stays around
and somehow is intimately tied to that filesystem.

> > > 
> > > The first thing to consider is if you simply use securityfs you'll
> > > inherit all the simple_pin_... removal work and be namespace ready.  It
> > > could be that creating a new filesystem that can't be namespaced is the
> > > right thing to do here, but at least ask the question: would we ever
> > > want any of these files to be presented selectively inside containers? 
> > > If the answer is "yes" then simple_pin_... is the wrong interface.
> > 
> > Greg, the securityfs changes James is referring to are part of the IMA
> > namespacing patch set:
> > https://lore.kernel.org/linux-integrity/20220420140633.753772-1-stefanb@linux.ibm.com/
> > 
> > I'd really appreciate your reviewing the first two patches:
> > [PATCH v12 01/26] securityfs: rework dentry creation
> > [PATCH v12 02/26] securityfs: Extend securityfs with namespacing
> > support
> 
> Looks like others have already reviewed them, they seem sane to me if
> they past testing.

Thanks for taking a look.
