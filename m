Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B751B664B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 19:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjAJStK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 13:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbjAJSsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:48:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37265372;
        Tue, 10 Jan 2023 10:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7B861881;
        Tue, 10 Jan 2023 18:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767D3C433EF;
        Tue, 10 Jan 2023 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376124;
        bh=g3CRnTTazWLR2Hh58q3CRcJBbpAnJEnxst035yVP2JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqTUBuLoJqiA6XVnVZWR+jPO7aNl7WWPgJZJ6OhsJDk+nWTQLSw1HLn617q1B+IvI
         /xTo4MhG+C4e92CmQbPuosfUhQ67lQURj0w8zUxeHdq7wEtl/3bEBJvRhFoDbkGOJ1
         juAKdMMT2/e5U2s2Z4atHu89Hss1utQctXg5R6xhmnBzEolqYZJ9/xL0FFyEEibHXq
         UrgmBT/fs/d6aBCiXmHVshq2kcdGkQVLUY96mAQK+qSTH9FU9V5Rlj1t5sZsxs0BL9
         6Ggt3vRGC2qhEGPvw1rY/K8TD+43AXWwGLnhL4RQCfiKKgQkmW4pbmHcc4PYZM3eaa
         whUGhcZMEyfNA==
Date:   Tue, 10 Jan 2023 18:42:03 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
Message-ID: <Y72xe72B+A1KrcaY@gmail.com>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-2-glider@google.com>
 <20221122145615.GE5824@twin.jikos.cz>
 <CAG_fn=Waivo=jEEqp7uMjKXdAvqP3XPtnAQeiRfu6ptwPmkyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Waivo=jEEqp7uMjKXdAvqP3XPtnAQeiRfu6ptwPmkyjw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:27:03PM +0100, Alexander Potapenko wrote:
> On Tue, Nov 22, 2022 at 3:56 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> > > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > > an error passing the latter to aops->write_end().
> > >
> > > Fix this by unconditionally initializing fsdata.
> > >
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > With the fixed Fixes: reference,
> >
> > Acked-by: David Sterba <dsterba@suse.com>
> 
> Hi David,
> 
> I've noticed that the ext4 counterpart of this patch is in the
> upstream tree already, whereas the affs, f2fs, hfs and hfsplus
> versions are not.
> Are they picked via a different tree?

Generally each filesystem has its own development tree.  All the information is
in MAINTAINERS.  hfs and hfsplus are unmaintained, though.

Maybe try asking Andrew Morton to apply the hfs and hfsplus patches, and any
others that don't get applied, as "maintainer of last resort".

- Eric
