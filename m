Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801847803F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 04:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357327AbjHRCxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357320AbjHRCw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D731706;
        Thu, 17 Aug 2023 19:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F9D60C09;
        Fri, 18 Aug 2023 02:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6C5C433C7;
        Fri, 18 Aug 2023 02:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692327177;
        bh=oKWvl5cR+aN7W6Ji9c7Edvn9oPXPfUDSKX2O+ONXOxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQFHjEJKGV9Tqr52SOusQnN7Yl56ANN1btFHVmJ29VdDF7Jt+W3fouYvza9+lB1TB
         YuIfYN2v1y3NrQzAYsBQv5YCW5hiP0VLibIt/EHCm54jKOS8WAJ/8DOhcpcaRG9xPQ
         t4WGve5L4FRAaul9rMadQrwLTTKyADodVV1MlIsnqztyVFyds43yEMrbTXqDLWpEJ0
         pz6Qu0/PiAVtEhwuUIKgjw3vQ24809RvxWeO9gfp1Fy1LQxsAM9GNII6raJ5FLy0Im
         JPGfkhaZcNdEzZhM2kwjH+yIU0RyERYj4/+gt+0qWBdT6JrIN68XyDuI/DD83JiqYv
         ZDvHCVRXNgoeg==
Date:   Thu, 17 Aug 2023 19:52:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     sandeen@redhat.com,
        syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Message-ID: <20230818025255.GA2175@sol.localdomain>
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
 <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
 <20230817161118.GC2247938@mit.edu>
 <20230817164739.GC1483@sol.localdomain>
 <20230818021038.GC3464136@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818021038.GC3464136@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:10:38PM -0400, Theodore Ts'o wrote:
> On Thu, Aug 17, 2023 at 09:47:39AM -0700, Eric Biggers wrote:
> > 
> > Eric S. is correct that for a filesystem image to enable panic on error, support
> > for panic on error should have to be properly consented to by the kernel
> > configuration, for example through an fs.allow_panic_on_error sysctl.
> 
> I disagree.  It's up to the system administrator, not the kernel ---
> and the system adminsitrator is perfectly free to run e2fsck on a
> random file system, or to use tune2fs to adjust the panic on error
> setting on the file system, befure using their root powers to mount
> the file system.
> 
> Root can do many things that cause the system to reboot.  For example,
> the system adminsirtator could run /sbin/reboot.  Should the kernel
> "consent" by setting fs.allow_reboot_system_call_to_work before the
> root user can run the /sbin/reboot binary?  Hopefully it's obvious why
> this makes absolutely no sense.
> 
> > It can be argued that this not important, or not worth implementing when the
> > default will need to remain 1 for backwards compatibility.  Or even that
> > syzkaller should work around it in the mean time.  But it is incorrect to write
> > "This is fundamentally a syzbot bug."
> 
> Well, the current behaviour is Working as Intended.  And if syzbot is
> going about whining about things that are Working as Intended, it's
> not fit for the upostream developers' purpose.
> 
> As another example, root can set a real-time priority of a process to
> be at a level where it will prempt all other processes, including
> kernel threads.  Do enough of these, and you *will* lock up the
> kernel.  Again, should there be a sysctl that allows real-time
> priorities to work?  Or do we teach syzbot that doing things that are
> documented to cause the kernel to lock up are not something that's
> worthy of a report.  In the past, syzbot issued a *huge* amount of
> noise caused by precisely to this.  Upstream developers complained
> that it was a false positive, and syzbot was adjusted to Stop Doing
> That.

Obviously it's up to the system administrator; that should have been clear since
I suggested a sysctl.  Sorry if I wasn't clear.  The point is that there are
certain conventions for what is allowed to break the safety guarantees that the
kernel provides to userspace, which includes causing a kernel panic.  Panics on
various problems are configured by /proc/sys/kernel/panic_*.  So having to
opt-in to panic-on-error, or at least being able to opt-out, by setting a sysctl
seems natural.  Whereas having mount() being able to automatically panic the
kernel with no way to opt-out seems like a violation of broader kernel
conventions, even if it happens to be "working as intended" in the ext4 context.

Anyway, I'm not actually saying this issue is important.  I just get frustrated
by the total denial that it could even possibly be considered something that
could be improved in the kernel...

- Eric
