Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72EC670EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 01:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjARAoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 19:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjARAnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:43:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9891CAE3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 16:22:45 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y1so35257049plb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 16:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZabAU69kzrS+JlD6u3p/eokT1Xy/TCkqyu/YUto0/Ws=;
        b=bNgJ7mGfmxJpyJk7YI84f7nG4msD6s4J4JmN1EPghdNBOuCNluQcCi1Swcg1TiC3c2
         ozA70KYSMLsJu/PD/QzAfK+i8UNfBvX/+97HD0y0C1QKkte+2j6N36nKd4x1q4J7RSiC
         TNScLNaFOSudcM0bBvgMC7ZoY+nNp6LVmExiJPYlr1Wsvyh4ovVMX5+bIO3UioZS4yrR
         tRHguYB8v4aOygf/iJku39qyCxHX0wXit7zVLrnUm6et8GeXe6uH2aYd552FAgjrZIye
         KoLkDudyOkGNYTFPNxxktGbMmat5QjC1Z+/wVixOc4EjGLs58La34uLOizbcim1w+8kk
         DmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZabAU69kzrS+JlD6u3p/eokT1Xy/TCkqyu/YUto0/Ws=;
        b=ycswO+x2UC+BtzGAy6JxTw6EHwJjUywlusequuB3AdtKa7a+lZbc4gSQlJSa6xzDMJ
         gYJbxeeAGEslQ1ksTmNGBArrFqHyBauObHrvgrHodQ1Apl0rcAdcRWEnYA+6v6PnHnhk
         Rxz+A8n7xSUnI85cDXF+/nx/y2JsEIzCAcvcuGe4LzDdicxEv/X/+H42RNAZplJXxEE/
         jqkBFHzT+xqghp9/5U7mb0OP6JjeVN3ZEJ7uvQxzJGjfO1/CnQQA+PBmHe/MgVWyZ3sG
         31gZXtZNmkhpIDesZzYwYSX4v+xLnK4nKwz6KwelQaWda/NHOSqsc6vhzHb7h5l7EoDg
         P4Cg==
X-Gm-Message-State: AFqh2kpu+qXk/K/1Fx8iMWeerF6dXCY6kSuDwyTWmdm3NwvDtcmRVVv9
        qAGGxgftow2+gVaQxWINqircAg==
X-Google-Smtp-Source: AMrXdXsnE4uTo9Sd2trzRSUN8IJ7cXKOr8CKXxHjD2NB2cLB/x8JUyyCdAmzDB4PvK09dTddfEhVMg==
X-Received: by 2002:a17:90a:7e08:b0:219:672a:42db with SMTP id i8-20020a17090a7e0800b00219672a42dbmr4827377pjl.19.1674001365228;
        Tue, 17 Jan 2023 16:22:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id ei7-20020a17090ae54700b00227223c58ecsm121029pjb.42.2023.01.17.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:22:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pHwDy-004LZS-3X; Wed, 18 Jan 2023 11:22:42 +1100
Date:   Wed, 18 Jan 2023 11:22:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Message-ID: <20230118002242.GB937597@dread.disaster.area>
References: <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
 <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
 <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
 <87fsc9gt7b.fsf@redhat.com>
 <20230117152756.jbwmeq724potyzju@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117152756.jbwmeq724potyzju@wittgenstein>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:27:56PM +0100, Christian Brauner wrote:
> On Tue, Jan 17, 2023 at 02:56:56PM +0100, Giuseppe Scrivano wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> > 2) no multi repo support:
> > 
> > Both reflinks and hardlinks do not work across mount points, so we
> 
> Just fwiw, afaict reflinks work across mount points since at least 5.18.

The might work for NFS server *file clones* across different exports
within the same NFS server (or server cluster), but they most
certainly don't work across mountpoints for local filesystems, or
across different types of filesystems.

I'm not here to advocate that composefs as the right solution, I'm
just pointing out that the proposed alternatives do not, in any way,
have the same critical behavioural characteristics as composefs
provides container orchestration systems and hence do not solve the
problems that composefs is attempting to solve.

In short: any solution that requires userspace to create a new
filesystem heirarchy one file at a time via standard syscall
mechanisms is not going to perform acceptibly at scale - that's a
major problem that composefs addresses.

The whole problem with file copying to create images - even with
reflink or hardlinks avoiding data copying - is the overhead of
creating and destroying those copies in the first place. A reflink
copy of a tens of thousands of files in a complex directory
structure is not free - each individual reflink has a time, CPU,
memory and IO cost to it. The teardown cost is similar - the only
way to remove the "container image" built with reflinks is "rm -rf",
and that has significant time, CPU memory and IO costs associated
with it as well.

Further, you can't ship container images to remote hosts using
reflink copies - they can only be created at runtime on the host
that the container will be instantiated on. IOWs, the entire cost of
reflink copies for container instances must be taken at container
instantiation and destruction time.

When you have container instances that might only be needed for a
few seconds, taking half a minute to set up the container instance
and then another half a minute to tear it down just isn't viable -
we need instantiation and teardown times in the order of a second or
two.

From my reading of the code, composefs is based around the concept
of a verifiable "shipping manifest", where the filesystem namespace
presented to users by the kernel is derived from the manifest rahter
than from some other filesystem namespace. Overlay, reflinks, etc
all use some other filesystem namespace to generate the container
namespace that links to the common data, whilst composefs uses the
manifest for that.

The use of a minfest file means there is almost zero container setup
overhead - ship the manifest file, mount it, all done - and zero
teardown overhead as unmounting the filesystem is all that is needed
to remove all traces of the container instance from the system.

In having a custom manifest format, the manifest can easily contain
verification information alongside the pointer to the content the
namespace should expose. i.e. the manifest references a secure
content addressed repository that is protected by fsverity and
contains the fsverity digests itself. Hence it doesn't rely on the
repository to self-verify, it actually ensures that the repository
files actually contain the data the manifest expects them to
contain.

Hence if the composefs kernel module is provided with a mechanism
for validating the chain of trust for the manifest file that a user
is trying to mount, then we just don't care who the mounting user
is.  This architecture is a viable path to rootless mounting of
pre-built third party container images.

Also, with the host's content addressed repository being managed
separately by the trusted host and distro package management, the
manifest is not be unique to a single container host. The distro can
build manifests so that containers are running known, signed and
verified container images built by the distro. The container
orchestration software or admin could also build manifests on demand
and sign them.

If the manifest is not signed, not signed with a key loaded
into the kernel keyring, or does not pass verification, then we
simply fall back to root-in-the-init-ns permissions being required
to mount the manifest. This fallback is exactly the same security
model we have for every other type of filesystem image that the
linux kernel can mount - we trust root not to be mounting malicious
images.

Essentially, I don't think any of the filesystems in the linux
kernel currently provide a viable solution to the problem that
composefs is trying to solve. We need a different way of solving the
ephemeral container namespace creation and destruction overhead
problem. Composefs provides a mechanism that not only solves this
problem and potentially several others, whilst also being easy to
retrofit into existing production container stacks.

As such, I think composefs is definitely worth further time and
investment as a unique line of filesystem development for Linux.
Solve the chain of trust problem (i.e. crypto signing for the
manifest files) and we potentially have game changing container
infrastructure in a couple of thousand lines of code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
