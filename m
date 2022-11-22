Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A71633530
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 07:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiKVGWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 01:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKVGWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:22:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49732D77B;
        Mon, 21 Nov 2022 22:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 238CE61552;
        Tue, 22 Nov 2022 06:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D708C433D6;
        Tue, 22 Nov 2022 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669098117;
        bh=bfNLT2YUtJP1xSjZ7j5UfuX/y0pWjX4jNCEWTPv1j80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRgoEpQy5REN8BKzBaovdzyF35oCrh6mGm3ozrdxaLAGicgmzYiOjeYxokQ5COyyf
         yFOFyUpKLw5rK04aueAliIfl5oXj4kayf2QnRihJNm69a/vkFNDr4svGrK1QaTPmJc
         hgMB8kV1OarC3/JG1HJgNPKYtqfB96jMnca0XJ5zD10fAJDPYWfzGtrhYcOLCyuvHm
         ufnOAHSVEFDw76U/XTYwUA8K9CTxt26JThqmqOEGS48i3tSDJkSc/zIXgAf5FpMc0Y
         PjxEv9TDZTw2gBMAY371vL/f09B8GcQPrHaM0mN3IzEiRgiJ0yZIgBxoKjiBh0Aw0w
         ayWWK+ZSXaslw==
Date:   Mon, 21 Nov 2022 22:21:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v1] xfs_spaceman: add fsuuid command
Message-ID: <Y3xqhXjJpXosOPPH@magnolia>
References: <20221109222335.84920-1-catherine.hoang@oracle.com>
 <Y3abjYmX//CF/ey0@magnolia>
 <20221117215125.GH3600936@dread.disaster.area>
 <Y3bKjm2vOwy/jV4Z@magnolia>
 <20221121233357.GO3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121233357.GO3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[adding Ted, the ext4 list, fsdevel, and api, because why not?]

On Tue, Nov 22, 2022 at 10:33:57AM +1100, Dave Chinner wrote:
> On Thu, Nov 17, 2022 at 03:58:06PM -0800, Darrick J. Wong wrote:
> > On Fri, Nov 18, 2022 at 08:51:25AM +1100, Dave Chinner wrote:
> > > On Thu, Nov 17, 2022 at 12:37:33PM -0800, Darrick J. Wong wrote:
> > > > On Wed, Nov 09, 2022 at 02:23:35PM -0800, Catherine Hoang wrote:
> > > > > Add support for the fsuuid command to retrieve the UUID of a mounted
> > > > > filesystem.
> > > > > 
> > > > > Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > > > > ---

<snip to the good part>

> > > > > diff --git a/spaceman/fsuuid.c b/spaceman/fsuuid.c
> > > > > new file mode 100644
> > > > > index 00000000..be12c1ad
> > > > > --- /dev/null
> > > > > +++ b/spaceman/fsuuid.c
> > > > > @@ -0,0 +1,63 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2022 Oracle.
> > > > > + * All Rights Reserved.
> > > > > + */
> > > > > +
> > > > > +#include "libxfs.h"
> > > > > +#include "libfrog/fsgeom.h"
> > > > > +#include "libfrog/paths.h"
> > > > > +#include "command.h"
> > > > > +#include "init.h"
> > > > > +#include "space.h"
> > > > > +#include <sys/ioctl.h>
> > > > > +
> > > > > +#ifndef FS_IOC_GETFSUUID
> > > > > +#define FS_IOC_GETFSUUID	_IOR('f', 44, struct fsuuid)
> > > > > +#define UUID_SIZE 16
> > > > > +struct fsuuid {
> > > > > +    __u32   fsu_len;
> > > > > +    __u32   fsu_flags;
> > > > > +    __u8    fsu_uuid[];
> > > > 
> > > > This is a flex array   ^^ which has no size.  struct fsuuid therefore
> > > > has a size of 8 bytes (i.e. enough to cover the two u32 fields) and no
> > > > more.  It's assumed that the caller will allocate the memory for
> > > > fsu_uuid...
> > > > 
> > > > > +};
> > > > > +#endif
> > > > > +
> > > > > +static cmdinfo_t fsuuid_cmd;
> > > > > +
> > > > > +static int
> > > > > +fsuuid_f(
> > > > > +	int		argc,
> > > > > +	char		**argv)
> > > > > +{
> > > > > +	struct fsuuid	fsuuid;
> > > > > +	int		error;
> > > > 
> > > > ...which makes this usage a problem, because we've not reserved any
> > > > space on the stack to hold the UUID.  The kernel will blindly assume
> > > > that there are fsuuid.fsu_len bytes after fsuuid and write to them,
> > > > which will clobber something on the stack.
> > > > 
> > > > If you're really unlucky, the C compiler will put the fsuuid right
> > > > before the call frame, which is how stack smashing attacks work.  It
> > > > might also lay out bp[] immediately afterwards, which will give you
> > > > weird results as the unparse function overwrites its source buffer.  The
> > > > C compiler controls the stack layout, which means this can go bad in
> > > > subtle ways.
> > > > 
> > > > Either way, gcc complains about this (albeit in an opaque manner)...
> > > > 
> > > > In file included from ../include/xfs.h:9,
> > > >                  from ../include/libxfs.h:15,
> > > >                  from fsuuid.c:7:
> > > > In function ‘platform_uuid_unparse’,
> > > >     inlined from ‘fsuuid_f’ at fsuuid.c:45:3:
> > > > ../include/xfs/linux.h:100:9: error: ‘uuid_unparse’ reading 16 bytes from a region of size 0 [-Werror=stringop-overread]
> > > >   100 |         uuid_unparse(*uu, buffer);
> > > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ../include/xfs/linux.h: In function ‘fsuuid_f’:
> > > > ../include/xfs/linux.h:100:9: note: referencing argument 1 of type ‘const unsigned char *’
> > > > In file included from ../include/xfs/linux.h:13,
> > > >                  from ../include/xfs.h:9,
> > > >                  from ../include/libxfs.h:15,
> > > >                  from fsuuid.c:7:
> > > > /usr/include/uuid/uuid.h:107:13: note: in a call to function ‘uuid_unparse’
> > > >   107 | extern void uuid_unparse(const uuid_t uu, char *out);
> > > >       |             ^~~~~~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > > 
> > > > ...so please allocate the struct fsuuid object dynamically.
> > > 
> > > So, follow common convention and you'll get it wrong, eh? That a
> > > score of -4 on Rusty's API Design scale.
> > > 
> > > http://sweng.the-davies.net/Home/rustys-api-design-manifesto
> > > 
> > > Flex arrays in user APIs like this just look plain dangerous to me.
> > > 
> > > Really, this says that the FSUUID API should have a fixed length
> > > buffer size defined in the API and the length used can be anything
> > > up to the maximum.
> > > 
> > > We already have this being added for the ioctl API:
> > > 
> > > #define UUID_SIZE 16
> > > 
> > > So why isn't the API definition this:
> > > 
> > > struct fsuuid {
> > >     __u32   fsu_len;
> > >     __u32   fsu_flags;
> > >     __u8    fsu_uuid[UUID_SIZE];
> > > };
> > > 
> > > Or if we want to support larger ID structures:
> > > 
> > > #define MAX_FSUUID_SIZE 256
> > > 
> > > struct fsuuid {
> > >     __u32   fsu_len;
> > >     __u32   fsu_flags;
> > >     __u8    fsu_uuid[MAX_FSUUID_SIZE];
> > > };
> > > 
> > > Then the structure can be safely placed on the stack, which means
> > > "the obvious use is (probably) the correct one" (a score of 7 on
> > > Rusty's API Design scale). It also gives the kernel a fixed upper
> > > bound that it can use to validate the incoming fsu_len variable
> > > against...
> > 
> > Too late now, this already shipped in 6.0.  Changing the struct size
> > would change the ioctl number, which is a totally new API.  This was
> > already discussed back in July on fsdevel/api.
> 
> It is certainly not too late - if we are going to lift this to the
> VFS, then we can simply make it a new ioctl. The horrible ext4 ioctl
> can ber left to rot in ext4 and nobody else ever needs to care that
> it exists.

You're wrong.  This was discussed **multiple times** this summer on
the fsdevel and API lists.  You had plenty of opportunity to make these
suggestions about the design, and yet you did not:

https://lore.kernel.org/linux-api/20220701201123.183468-1-bongiojp@gmail.com/
https://lore.kernel.org/linux-api/20220719065551.154132-1-bongiojp@gmail.com/
https://lore.kernel.org/linux-api/20220719234131.235187-1-bongiojp@gmail.com/
https://lore.kernel.org/linux-api/20220721224422.438351-1-bongiojp@gmail.com/

Jeremy built the functionality and followed the customary process,
sending four separate revisions for reviews.  He adapted his code based
on our feedback about how to future-proof it by adding an explicit
length parameter, and got it merged into ext4 in 6.0-rc1.

Now you want Catherine and I to tear down his work and initiate a design
review of YET ANOTHER NEW IOCTL just so the API can hit this one design
point you care about, and then convince Ted to go back and redo all the
work that has already been done.  All this to extract 16 bytes from the
kernel in a slightly different style than the existing XFS fsgeometry
ioctl.

This was /supposed/ to be a simple way for a less experienced staffer to
gain some experience wiring up an existing ioctl.  And, well, I hope she
doesn't take away that developing for Linux is institutionally broken
and frustrating, because that's what I've taken away from the last 2+
years of being here.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
