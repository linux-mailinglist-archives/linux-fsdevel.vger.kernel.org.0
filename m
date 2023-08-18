Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0F780DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 16:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377715AbjHRO03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377449AbjHRO0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:26:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98893AA4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 07:26:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-121-162.bstnma.fios.verizon.net [173.48.121.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37IEPi9R008983
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 10:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692368747; bh=mr78n3qsUgsgPJgzwDA3ALe/I5P61WM2l6xoqGgEaxk=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=ifckXAgyqVrtSRdqKrD9L/Sz32XDzO9iBLPsAWc3woHvB45OxXeNyyurXmSdK/1Ou
         5KrKw2StHw3SqGZ9hQfuuurrTylF99RTMEjbg1BoPT0Wgv2fQdlcpQwJPLQHAARscK
         dpbRs8QuHAdrRIDP/w0gqOHY3q7kB4cfmLxmNrjWviMT3OOkR24h+TOwGfPw/URuEJ
         Hf4euGVDyeGXRWC1h/VHzvTy5ZgsYKrGn4Te+QHg/AKHU7FRBCvFvRFra0eHXBYB8t
         C0Uz4b6+d0cbMlUOfF8/Bwj06gL80gl/kq1u4vuQdEQuoezh5ZBjhLWmnS2Y/9s/cE
         AcNNVB0ajSlFw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A684315C0501; Fri, 18 Aug 2023 10:25:44 -0400 (EDT)
Date:   Fri, 18 Aug 2023 10:25:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     sandeen@redhat.com,
        syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Message-ID: <20230818142544.GA3513305@mit.edu>
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
 <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
 <20230817161118.GC2247938@mit.edu>
 <20230817164739.GC1483@sol.localdomain>
 <20230818021038.GC3464136@mit.edu>
 <20230818025255.GA2175@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818025255.GA2175@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 07:52:55PM -0700, Eric Biggers wrote:
> Obviously it's up to the system administrator; that should have been clear since
> I suggested a sysctl.  Sorry if I wasn't clear.  The point is that there are
> certain conventions for what is allowed to break the safety guarantees that the
> kernel provides to userspace, which includes causing a kernel panic.  Panics on
> various problems are configured by /proc/sys/kernel/panic_*.  So having to
> opt-in to panic-on-error, or at least being able to opt-out, by setting a sysctl
> seems natural.  Whereas having mount() being able to automatically panic the
> kernel with no way to opt-out seems like a violation of broader kernel
> conventions, even if it happens to be "working as intended" in the ext4 context.

The reason why a sysctl isn't really great is because the system
administrator might want to configure the behavior on a per-file
system basis.  And you *can* configure it as a mount option, via
"mount -o errors=continue" or "mount -o "errors=panic".  The
superblock setting is just the default if something isn't explicitly
specified as a mount option (either on the command line or in
/etc/fstab).

So mount does not "automatically" panic the kernel, and there are
*plenty* of ways to opt-out.  You can use the mount option; you can
run "tune2fs -e continue"; you can just !@#!?! run fsck.ext4 before
mounting the file system.  There are all ways of "opting out."  Some
of them, such as the last, is even considered best practice --- just
as picking up a USB stick, or worse, a firewire drive, in a parking
lot, and *not* plugging it into your laptop is considered best practice.

	     	  	    	      	       - Ted
