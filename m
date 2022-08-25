Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE65A19C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiHYTsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiHYTsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A225F12A;
        Thu, 25 Aug 2022 12:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7612761DCF;
        Thu, 25 Aug 2022 19:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBCBC433C1;
        Thu, 25 Aug 2022 19:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661456892;
        bh=r8gaxJKLQI+z6juVzGPZoOj4RUwyYCmoO+hFGBi7yio=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HDLiJw9Oy8arB3LTOsdS+SDOeJbX+vBcaTADTdnfo41tdS09mjbzlWhnDnfva+x4g
         BjKUYzjJM0KmbD5ADf4P2NZUl6JYLFgGhIqfJv+PBq8RAZA+1zu7S79xGQXsz5M2Ci
         0YEfVeZs98dFwDoUhDpoxiDLWCB/NmTFitQq9abEb6kP+l4mP3Zztwp74A3uHznlIA
         Nlpuue//VRmfvXJahz0JhGI6SaPXkVDjIWHKMK/6sf45SCoepMiCV91giZ2O+EJPME
         qaOJ0nE5cyGhIXp6sgMq5RBjvGMrBhMcHFq8rSuvQToRb3cIml8cmdtm7nY26beVcU
         kAw01z3J9LPeg==
Message-ID: <0339f5f540010ba1bae74121d33c0643f26fefab.camel@kernel.org>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION
 inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Colin Walters <walters@verbum.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Date:   Thu, 25 Aug 2022 15:48:10 -0400
In-Reply-To: <fc59bfa8-295e-4180-9cf0-c2296d2e8707@www.fastmail.com>
References: <20220819115641.14744-1-jlayton@kernel.org>
         <20220823215333.GC3144495@dread.disaster.area>
         <fc59bfa8-295e-4180-9cf0-c2296d2e8707@www.fastmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-08-25 at 14:48 -0400, Colin Walters wrote:
>=20
> On Tue, Aug 23, 2022, at 5:53 PM, Dave Chinner wrote:
> >=20
> > THere's no definition of what consitutes an "inode change" and this
> > exposes internal filesystem implementation details (i.e. on disk
> > format behaviour) directly to userspace. That means when the
> > internal filesystem behaviour changes, userspace applications will
> > see changes in stat->ino_version changes and potentially break them.
>=20
> As a userspace developer (ostree, etc. who is definitely interested in th=
is functionality) I do agree with this concern; but a random drive by comme=
nt: would it be helpful to expose iversion (or other bits like this from th=
e vfs) via e.g. debugfs to start?  I think that'd unblock writing fstests i=
n the short term right?
>=20
>=20

It's great to hear from userland developers who are interested in this!

I don't think there is a lot of controversy about the idea of presenting
a value like this via statx. The usefulness seems pretty obvious if
you've ever had to deal with timestamp granularity issues.

The part we're wrestling with now is that applications will need a clear
(and testable!) definition of what this value means. We need to be very
careful how we define this so that userland developers don't get stuck
dealing with semantics that vary per fstype, while still allowing the
broadest range of filesystems to support it.

My current thinking is to define this such that the reported ino_version
MUST change any time that the ctime would change (even if the timestamp
doesn't appear to change). That should also catch mtime updates.

The part I'm still conflicted about is whether we should allow for a
conformant implementation to increment the value even when there is no
apparent change to the inode.

IOW, should this value mean that something _did_ change in the inode or
that something _may_ have changed in it?

Implementations that do spurious increments would less than ideal, but
defining it that way might allow a broader range of filesystems to
present this value.

What would you prefer, as a userland developer?
--=20
Jeff Layton <jlayton@kernel.org>
