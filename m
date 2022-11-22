Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B9634B54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 00:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiKVXpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 18:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKVXpV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:45:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04235C722C
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 15:45:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so15816852pfz.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Br32V4f5RhJzAJZzqIlTw5MxWMCxMPceRuTf9fFBWs=;
        b=LMp1DNYW9KAAMAhwIRp13A+UoP5f9oi+tOL9pTcPwVL3Hc6Ia0RKrsPyHf7sk3dYlL
         v9YR+AZs0izub2IeIbLi9+6o8cIngufh1uDpzVlhQ/ZFDkXxqwXovqRsjKBm6NZFGvv6
         pSeTyc8+Xrg5pYq9dVwahpyuRyB+A0L7WHBm9FYVIm3CSim0mFWLdFJcXn1W/Cirm8wU
         4cx6I/5Z9/oLvxF/W/DNvYvSDm5Y1x5ZXSK3G4AXZe853DkbvzdSe2ugzOjJtso17frU
         aC8o3HsIYiTKdAMhTgI75zsB1Xqbrkav8T2gO/YrQ38GZirJO2OPKZh8DErpWJLFpzvk
         XPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Br32V4f5RhJzAJZzqIlTw5MxWMCxMPceRuTf9fFBWs=;
        b=7V0L4S2yFopjMeYjqEjv1u/3YSCzsGFn+te1iWp+BfzJx1TcDU3dUGr1EQxHZx1hYe
         4CC7GclV4mxVoo/4FoJd3l3EjslHYFV7c46Xh8DSjf+hhjN2mkb2tDVE/QijX1tvANGJ
         QQD0s+gwPp/b90a8xlMDw/JCQdOC9PDLInE6UTW8dilev9WrWAadTesVyrgeOlVnZYf/
         LwnyzQ/+dcJ5j9jlmalRkTU7dseNob4nc/OzZdXk3+5R+1UBAkjcA9+rfM0hja6D0iX0
         KlXbiGCHkT3HLg8dKoFcHACA9cDrSTByVQ28kkhiK978smD9SFOMx0dBCihEphge9vsz
         cUVw==
X-Gm-Message-State: ANoB5pkCiVw+bZ2JA+POEI0ssoHpXCQSD5zvmnrsbPnZwjjQ9JN70FH5
        s0uAKSUSlQh1DCxV14uw0rlitQ==
X-Google-Smtp-Source: AA0mqf4vEA83Ja+O0Ci0KfXTX8Oj7a0KKnCvRMdSpSJjVAh65PF1JRO/J4lVuOvYHHckcCKBomIqGQ==
X-Received: by 2002:a63:1626:0:b0:470:2c90:d89f with SMTP id w38-20020a631626000000b004702c90d89fmr7904405pgl.253.1669160719359;
        Tue, 22 Nov 2022 15:45:19 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id e126-20020a621e84000000b00573769811d6sm6800188pfe.44.2022.11.22.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:45:18 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oxcx1-00HS2f-47; Wed, 23 Nov 2022 10:45:15 +1100
Date:   Wed, 23 Nov 2022 10:45:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v1] xfs_spaceman: add fsuuid command
Message-ID: <20221122234515.GT3600936@dread.disaster.area>
References: <20221109222335.84920-1-catherine.hoang@oracle.com>
 <Y3abjYmX//CF/ey0@magnolia>
 <20221117215125.GH3600936@dread.disaster.area>
 <Y3bKjm2vOwy/jV4Z@magnolia>
 <20221121233357.GO3600936@dread.disaster.area>
 <Y3xqhXjJpXosOPPH@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3xqhXjJpXosOPPH@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:21:57PM -0800, Darrick J. Wong wrote:
> [adding Ted, the ext4 list, fsdevel, and api, because why not?]
> 
> On Tue, Nov 22, 2022 at 10:33:57AM +1100, Dave Chinner wrote:
> > On Thu, Nov 17, 2022 at 03:58:06PM -0800, Darrick J. Wong wrote:
> > > On Fri, Nov 18, 2022 at 08:51:25AM +1100, Dave Chinner wrote:
> > > > On Thu, Nov 17, 2022 at 12:37:33PM -0800, Darrick J. Wong wrote:
> > > > > On Wed, Nov 09, 2022 at 02:23:35PM -0800, Catherine Hoang wrote:
> > > > > > Add support for the fsuuid command to retrieve the UUID of a mounted
> > > > > > filesystem.
> > > > > > 
> > > > > > Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > > > > > ---
> 
> <snip to the good part>
> > > > > If you're really unlucky, the C compiler will put the fsuuid right
> > > > > before the call frame, which is how stack smashing attacks work.  It
> > > > > might also lay out bp[] immediately afterwards, which will give you
> > > > > weird results as the unparse function overwrites its source buffer.  The
> > > > > C compiler controls the stack layout, which means this can go bad in
> > > > > subtle ways.
> > > > > 
> > > > > Either way, gcc complains about this (albeit in an opaque manner)...
> > > > > 
> > > > > In file included from ../include/xfs.h:9,
> > > > >                  from ../include/libxfs.h:15,
> > > > >                  from fsuuid.c:7:
> > > > > In function ‘platform_uuid_unparse’,
> > > > >     inlined from ‘fsuuid_f’ at fsuuid.c:45:3:
> > > > > ../include/xfs/linux.h:100:9: error: ‘uuid_unparse’ reading 16 bytes from a region of size 0 [-Werror=stringop-overread]
> > > > >   100 |         uuid_unparse(*uu, buffer);
> > > > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > ../include/xfs/linux.h: In function ‘fsuuid_f’:
> > > > > ../include/xfs/linux.h:100:9: note: referencing argument 1 of type ‘const unsigned char *’
> > > > > In file included from ../include/xfs/linux.h:13,
> > > > >                  from ../include/xfs.h:9,
> > > > >                  from ../include/libxfs.h:15,
> > > > >                  from fsuuid.c:7:
> > > > > /usr/include/uuid/uuid.h:107:13: note: in a call to function ‘uuid_unparse’
> > > > >   107 | extern void uuid_unparse(const uuid_t uu, char *out);
> > > > >       |             ^~~~~~~~~~~~
> > > > > cc1: all warnings being treated as errors
> > > > > 
> > > > > ...so please allocate the struct fsuuid object dynamically.
> > > > 
> > > > So, follow common convention and you'll get it wrong, eh? That a
> > > > score of -4 on Rusty's API Design scale.
> > > > 
> > > > http://sweng.the-davies.net/Home/rustys-api-design-manifesto
> > > > 
> > > > Flex arrays in user APIs like this just look plain dangerous to me.
> > > > 
> > > > Really, this says that the FSUUID API should have a fixed length
> > > > buffer size defined in the API and the length used can be anything
> > > > up to the maximum.
> > > > 
> > > > We already have this being added for the ioctl API:
> > > > 
> > > > #define UUID_SIZE 16
> > > > 
> > > > So why isn't the API definition this:
> > > > 
> > > > struct fsuuid {
> > > >     __u32   fsu_len;
> > > >     __u32   fsu_flags;
> > > >     __u8    fsu_uuid[UUID_SIZE];
> > > > };
> > > > 
> > > > Or if we want to support larger ID structures:
> > > > 
> > > > #define MAX_FSUUID_SIZE 256
> > > > 
> > > > struct fsuuid {
> > > >     __u32   fsu_len;
> > > >     __u32   fsu_flags;
> > > >     __u8    fsu_uuid[MAX_FSUUID_SIZE];
> > > > };
> > > > 
> > > > Then the structure can be safely placed on the stack, which means
> > > > "the obvious use is (probably) the correct one" (a score of 7 on
> > > > Rusty's API Design scale). It also gives the kernel a fixed upper
> > > > bound that it can use to validate the incoming fsu_len variable
> > > > against...
> > > 
> > > Too late now, this already shipped in 6.0.  Changing the struct size
> > > would change the ioctl number, which is a totally new API.  This was
> > > already discussed back in July on fsdevel/api.
> > 
> > It is certainly not too late - if we are going to lift this to the
> > VFS, then we can simply make it a new ioctl. The horrible ext4 ioctl
> > can ber left to rot in ext4 and nobody else ever needs to care that
> > it exists.
> 
> You're wrong.  This was discussed **multiple times** this summer on
> the fsdevel and API lists.  You had plenty of opportunity to make these
> suggestions about the design, and yet you did not:
> 
> https://lore.kernel.org/linux-api/20220701201123.183468-1-bongiojp@gmail.com/
> https://lore.kernel.org/linux-api/20220719065551.154132-1-bongiojp@gmail.com/
> https://lore.kernel.org/linux-api/20220719234131.235187-1-bongiojp@gmail.com/
> https://lore.kernel.org/linux-api/20220721224422.438351-1-bongiojp@gmail.com/


There's good reason for that: this was posted and reviewed as *an
EXT4 specific API*.  Why are you expecting XFS developers to closely
review a patchset that was titled "Add ioctls to get/set the ext4
superblock uuid."?

There was -no reasons- for me to pay attention to it, and I have
enough to keep up with without having to care about the minutae of
what ext4 internal information is being exposing to userspace.

However, now it's being proposed as a *generic VFS API*, and so it's
now important enough for developers from other filesystems to look
at this ioctl API.

> Jeremy built the functionality and followed the customary process,
> sending four separate revisions for reviews.  He adapted his code based
> on our feedback about how to future-proof it by adding an explicit
> length parameter, and got it merged into ext4 in 6.0-rc1.

*As an EXT4 modification*, not a generic VFS ioctl.

> Now you want Catherine and I to tear down his work and initiate a design
> review of YET ANOTHER NEW IOCTL just so the API can hit this one design
> point you care about, and then convince Ted to go back and redo all the
> work that has already been done.  All this to extract 16 bytes from the
> kernel in a slightly different style than the existing XFS fsgeometry
> ioctl.

I'm not asking you to tear anything down. Just leave the ext4 ioctl
as it is currently defined and nothing existing breaks or needs
reworking.

All I'm asking is that instead of lifting the ext4 ioctl verbatim,
you lift it with a fixed maximum size for the uuid data array to
replace the flex array. It's a *trivial change to make*, and yes, I
know that this means it's not the same as the ext4 ioctl.

But, really, who cares that it will be a different ioctl? Nobody but
ext4 utilities will be using the ext4 ioctl, and we expect generic
block/fs utilities and applications to use the VFS definition of the
ioctl, not the ext4 specific one.

> This was /supposed/ to be a simple way for a less experienced staffer to
> gain some experience wiring up an existing ioctl.  And, well, I hope she
> doesn't take away that developing for Linux is institutionally broken
> and frustrating, because that's what I've taken away from the last 2+
> years of being here.

When we lift stuff from filesystem specific scope (where few people
care about API warts) to generic VFS scope that the whole world is
expected to see, use and understand, you should expect a larger
number of experienced developers to scrutinise it.  The wider scope
of the API means the "acceptibility bar" is set higher.

Just because the code change is simple, it doesn't mean the issues
surrounding the code change are simple or straight forward. Just
because it went through a review on the ext4 list it doesn't mean
the API or implementation is flawless.

The point I'm making is that lifting fs ioctl APIs verbatim is a
*known broken process* that leads to future pain fixing all the
problems inherited from the original fs specific API and
implementation.  If we want to lift functionality to be generic VFS
UAPI and at the time of lifting we find problems with the UAPI
and/or implementation, then we need to fix the problems before we
expose the new VFS API to the entire world.

Repeat past mistakes, or learn from them. Your choice...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
