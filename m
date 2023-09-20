Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF507A6FDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 02:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjITAdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 20:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITAdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:33:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6FB3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 17:33:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0c6d4d650so56392725ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695170022; x=1695774822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKQxNeellezX5Y0mQHg8y7UScp5LaytEe/qPzTBC6Ug=;
        b=Oo7MfOyfCxd6jBY7koJG3ilRZjbLrb/6faxcyiCvyQuXClPaPvZRuCIh61yNvtj9wt
         XVqN49okFD0N0arnBKyj+h0w2O+xZQbJhy95NZmapczcPmf8W1NYN9uci24gw3Yd/bIZ
         RXc0g1puSf56N2NohIElAsWNgPh5CLC+hqVLqwybmvzwJSB0sp73Qv4siMn58RmX/q06
         P6r3OD+4kZbRk8ze0zsTMQN8Np8Vu2LD7StMKvJr03Kiz+XHjRluQXQ4pTUx5KyhAByU
         hqa8PqJ2arTDBruOKhyW9wADEJxLeX5In8ruTvgcGM6tQZ+XSqRNxIwE9xUPTHK+iIv9
         rSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170022; x=1695774822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKQxNeellezX5Y0mQHg8y7UScp5LaytEe/qPzTBC6Ug=;
        b=XjDLSbn6oydPMoHnpamDEGCEqJiwxFgnzNsdaM6LANkngjXXIA3GHrqqPOZyVKgLXS
         XinhM5HqIRG3DTt3PnDsRx1QiFLn0xiV2KbZhEvsqQZmB4gCthNc2EfwP5zrPXnH2n6a
         FR1n01cu500jY8J4cv7/gj0+M/0chuqZBkz9ClrlQg+hFhysXlDc8FrNgh4pQTiBnzhN
         B7EBZL51MRNtagzHJP1pBOojCIhh29ZfGjM2ceOL8g8VjqCRGHxCRtd/auTa3bqSAkB7
         WrcJFX0yE9aoi08eeSeINEzew96E7mnr+HR8gowdMRaDok6FOmzN5Bvcwvp8c1iAqTcz
         8LLQ==
X-Gm-Message-State: AOJu0YxWgFH7BjCFtBeJeo5IP3UecBBUdi//p4oBqrBBtw0gIN0Cz3T7
        Em68NgoT3ILRUojwgGVaKUvYrg==
X-Google-Smtp-Source: AGHT+IEq+pZ9/XpOY8sFOY3TimoLUCK6/YD5xSWxI22i6qGdReylNBwBjv8Uita4Yd+EI2ifHtwMGA==
X-Received: by 2002:a17:902:c40a:b0:1b7:e355:d1ea with SMTP id k10-20020a170902c40a00b001b7e355d1eamr1160432plk.24.1695170022429;
        Tue, 19 Sep 2023 17:33:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b001c1f0b3e900sm7106591plb.229.2023.09.19.17.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:33:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qil9u-0030Yl-2u;
        Wed, 20 Sep 2023 10:33:38 +1000
Date:   Wed, 20 Sep 2023 10:33:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
Message-ID: <ZQo94mCzV7hOrVkh@dread.disaster.area>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <59DA5D4F-8242-4BD4-AE1C-FC5A6464E377@dilger.ca>
 <20230919-gewusel-hingabe-714c000cef8f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-gewusel-hingabe-714c000cef8f@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:50:28PM +0200, Christian Brauner wrote:
> On Mon, Sep 18, 2023 at 02:58:00PM -0600, Andreas Dilger wrote:
> > On Sep 18, 2023, at 7:51 AM, Christian Brauner <brauner@kernel.org> wrote:
> > > 
> > > 
> > >> The type and subtype are naturally limited to sane sizes, those are
> > >> not an issue.
> > > 
> > > What's the limit for fstype actually? I don't think there is one.
> > > There's one by chance but not by design afaict?
> > > 
> > > Maybe crazy idea:
> > > That magic number thing that we do in include/uapi/linux/magic.h
> > > is there a good reason for this or why don't we just add a proper,
> > > simple enum:
> > > 
> > > enum {
> > > 	FS_TYPE_ADFS        1
> > > 	FS_TYPE_AFFS        2
> > > 	FS_TYPE_AFS         3
> > > 	FS_TYPE_AUTOFS      4
> > > 	FS_TYPE_EXT2	    5
> > > 	FS_TYPE_EXT3	    6
> > > 	FS_TYPE_EXT4	    7
> > > 	.
> > > 	.
> > > 	.
> > > 	FS_TYPE_MAX
> > > }
> > > 
> > > that we start returning from statmount(). We can still return both the
> > > old and the new fstype? It always felt a bit odd that fs developers to
> > > just select a magic number.
> > 
> > Yes, there is a very good reason that there isn't an enum for filesystem
> 
> I think this isn't all that relevant to the patchset so I'm not going to
> spend a lot of time on this discussion but I'm curious.
> 
> > type, which is because this API would be broken if it encounters any
> > filesystem that is not listed there.  Often a single filesystem driver in
> > the kernel will have multiple different magic numbers to handle versions,
> > endianness, etc.
> 
> Why isn't this a problem for magically chosen numbers?

What problem are you asking about? The 32 bit space that contains
a few hundred magic numbers remains a vast field of empty space that
makes collisions easy to avoid....

> > Having a 32-bit magic number allows decentralized development with low
> > chance of collision, and using new filesystems without having to patch
> > every kernel for this new API to work with that filesystem.  Also,
> 
> We don't care about out of tree filesystems.

In this case, we most certainly do care. Downstream distros support
all sorts of out of tree filesystems loaded via kernel modules, so a
syscall that is used to uniquely identify a filesystem type to
userspace *must* have a mechanism for the filesystem to provide that
unique identifier to userspace.

Fundamentally, the kernel does not and should not dictate what
filesystem types it supports; the user decides what filesystem they
need to use, and it is the kernel's job to provide infrastructure
that works with that user's choice.

Remember: it's not just applications that stat the mounted
filesystem that know about the filesystem amgic numbers.  Apps like
grub, libblkid, etc all look at filesystem magic numbers directly on
the block device to identify the type of filesystem that is on the
device.

If we introduce a new identifer specific to mounted kernel
filesystems, these sorts of apps now need to use two different
identifiers in different contexts instead of the same magic number
everywhere. That's not a win for anyone.

Magic numbers are also portable - it does not matter what OS you see
that FS on, it has the same unique, stable type identifier. You can
look at the block device and identify the filesystem by it's magic
number, you can stat the mounted filesystem and get the same magic
number. It just works the same *everywhere*.

Magic numbers have served the purpose of being unique filesystem
identifiers for over 40 years. They work just fine for this purpose
and nothing has changed in the past couple of decades that has
broken them or needs fixing.

> > filesystems come and go (though more slowly) over time, and keeping the
> 
> Even if we did ever remove a filesystem we'd obviously leave the enum in
> place. Same thig we do for deprecated flags, same thing we'd do for
> magic numbers.

So why try to replace magic numbers if we must replicate all the
same unique, stable behaviour that magic numbers already provide the
kernel and userspace with?

>
> > full list of every filesystem ever developed in the kernel enum would be
> > a headache.
> 
> I really don't follow this argument.

The kernel currently doesn't need to know about all the potential
fuse filesystem types that can be mounted. It doesn't need to know
about all the 3rd party filesystems that could be mounted. these all
just work and userspace can identify them just fine via their unique
magic numbers that are passed through the kernel interfaces from the
filesystem.

Then enum proposal breaks these existing working use cases unless
the enum explicitly includes ever possible filesystem type that the
kernel might expose to userspace. The kernel *should not care* what
filesystems it exposes to userspace and that's the whole point of using
a filesystem supplied magic number as the unique identifier for the
filesystem...

> > The field in the statmnt() call would need to be at a fixed-size 32-bit
> > value in any case, so having it return the existing magic will "just work"
> > because userspace tools already know and understand these magic values,
> > while introducing an in-kernel enum would be broken for multiple reasons.
> 
> We already do expose the magic number in statmount() but it can't
> differentiate between ext2, ext3, and ext4 for example which is why I
> asked.

That's just an extN quirk, and it's trivial to fix for the new
interface. Define new magic numbers for ext3 and ext4 and only use
them in the new interface, leave the old interfaces using the ext2
magic number for all of them.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
