Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CD7A63B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjISMul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjISMuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:50:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4DD99;
        Tue, 19 Sep 2023 05:50:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03154C433C7;
        Tue, 19 Sep 2023 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695127834;
        bh=Z6QQpDkL2SswUlO6H3+msbaSsQLtoo9xMCHAPMmiOuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ks30c9KGn0ulpQMYsz6/c9HIcUl6Ku6iehBT/YRiO20dEq7nnfaLrmNs3sG62slvx
         edyHvvN7gUAcXgRuj7bigO2LnBpS5rjRY8l5dMzqW0yChPGFuiTfrckvcCaOMKksWH
         rUBTiC70HXweArRfyQc8A6nwyMVigx/9cjbLPnHzNuXU/3Ne4AbE8V13y0AL5deBky
         g1LB1i1lsP7bttZPmOH/UYLPuS4yLWHj6A8l5kg+a4QY+xHAvZzFjn0fNz36vPHhTI
         plCwFaOUBT4/J8FGKGmAj8BZHCf8VyGRYkiKBXUHCKTMDdS/GLoAmRnvqAV4jweQR2
         olouQz4SiPZVA==
Date:   Tue, 19 Sep 2023 14:50:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230919-gewusel-hingabe-714c000cef8f@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <59DA5D4F-8242-4BD4-AE1C-FC5A6464E377@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59DA5D4F-8242-4BD4-AE1C-FC5A6464E377@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:58:00PM -0600, Andreas Dilger wrote:
> On Sep 18, 2023, at 7:51 AM, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > 
> >> The type and subtype are naturally limited to sane sizes, those are
> >> not an issue.
> > 
> > What's the limit for fstype actually? I don't think there is one.
> > There's one by chance but not by design afaict?
> > 
> > Maybe crazy idea:
> > That magic number thing that we do in include/uapi/linux/magic.h
> > is there a good reason for this or why don't we just add a proper,
> > simple enum:
> > 
> > enum {
> > 	FS_TYPE_ADFS        1
> > 	FS_TYPE_AFFS        2
> > 	FS_TYPE_AFS         3
> > 	FS_TYPE_AUTOFS      4
> > 	FS_TYPE_EXT2	    5
> > 	FS_TYPE_EXT3	    6
> > 	FS_TYPE_EXT4	    7
> > 	.
> > 	.
> > 	.
> > 	FS_TYPE_MAX
> > }
> > 
> > that we start returning from statmount(). We can still return both the
> > old and the new fstype? It always felt a bit odd that fs developers to
> > just select a magic number.
> 
> Yes, there is a very good reason that there isn't an enum for filesystem

I think this isn't all that relevant to the patchset so I'm not going to
spend a lot of time on this discussion but I'm curious.

> type, which is because this API would be broken if it encounters any
> filesystem that is not listed there.  Often a single filesystem driver in
> the kernel will have multiple different magic numbers to handle versions,
> endianness, etc.

Why isn't this a problem for magically chosen numbers?

> 
> Having a 32-bit magic number allows decentralized development with low
> chance of collision, and using new filesystems without having to patch
> every kernel for this new API to work with that filesystem.  Also,

We don't care about out of tree filesystems.

> filesystems come and go (though more slowly) over time, and keeping the

Even if we did ever remove a filesystem we'd obviously leave the enum in
place. Same thig we do for deprecated flags, same thing we'd do for
magic numbers.

> full list of every filesystem ever developed in the kernel enum would be
> a headache.

I really don't follow this argument.

> 
> The field in the statmnt() call would need to be at a fixed-size 32-bit
> value in any case, so having it return the existing magic will "just work"
> because userspace tools already know and understand these magic values,
> while introducing an in-kernel enum would be broken for multiple reasons.

We already do expose the magic number in statmount() but it can't
differentiate between ext2, ext3, and ext4 for example which is why I
asked.

Afaict, none of the points you mention are show stoppers and none of
them are unique to an enum.
