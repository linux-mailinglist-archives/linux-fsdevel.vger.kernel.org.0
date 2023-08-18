Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6B7803B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 04:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357196AbjHRCL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357197AbjHRCLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:11:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBF35BF
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 19:11:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I2Acvu020102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 22:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692324641; bh=LpT20QH/hu7wFLRE2zsy7cC3Q44uuq8Hmr2dybBwTxk=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=DnGHoNCnT4NHxG4T1TjOqGIhDKNqnSMGhGJB64sBbM6STLDyxzBwu0KeBQePPR++3
         6ivYBU3VTxxDXWxki5wv2CL2y16WO0j7ftOxm8my/XU33gv1RkbS5WDARdYdgsoUZD
         BvybOX0CjFbBT+GXa+YxNfruzgvt6ETcg9WeJVRLbgJK7kDnt799aMkBhcQjqZg1ld
         RhYCuF5eFFXxx5xqn2oczbZrF22SJ56S7Thr+pbs7AIpBrOVbZL1KVMeNxrsp54jWV
         G10ZJyWkJx1H7Oz6/ghBTd0f9l2vK2thwN6M5kR7+1k5c4HkN7rE2WF9mvksEyBABa
         lyAb8w56jLa9g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 10C8615C0501; Thu, 17 Aug 2023 22:10:38 -0400 (EDT)
Date:   Thu, 17 Aug 2023 22:10:38 -0400
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
Message-ID: <20230818021038.GC3464136@mit.edu>
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
 <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
 <20230817161118.GC2247938@mit.edu>
 <20230817164739.GC1483@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817164739.GC1483@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:47:39AM -0700, Eric Biggers wrote:
> 
> Eric S. is correct that for a filesystem image to enable panic on error, support
> for panic on error should have to be properly consented to by the kernel
> configuration, for example through an fs.allow_panic_on_error sysctl.

I disagree.  It's up to the system administrator, not the kernel ---
and the system adminsitrator is perfectly free to run e2fsck on a
random file system, or to use tune2fs to adjust the panic on error
setting on the file system, befure using their root powers to mount
the file system.

Root can do many things that cause the system to reboot.  For example,
the system adminsirtator could run /sbin/reboot.  Should the kernel
"consent" by setting fs.allow_reboot_system_call_to_work before the
root user can run the /sbin/reboot binary?  Hopefully it's obvious why
this makes absolutely no sense.

> It can be argued that this not important, or not worth implementing when the
> default will need to remain 1 for backwards compatibility.  Or even that
> syzkaller should work around it in the mean time.  But it is incorrect to write
> "This is fundamentally a syzbot bug."

Well, the current behaviour is Working as Intended.  And if syzbot is
going about whining about things that are Working as Intended, it's
not fit for the upostream developers' purpose.

As another example, root can set a real-time priority of a process to
be at a level where it will prempt all other processes, including
kernel threads.  Do enough of these, and you *will* lock up the
kernel.  Again, should there be a sysctl that allows real-time
priorities to work?  Or do we teach syzbot that doing things that are
documented to cause the kernel to lock up are not something that's
worthy of a report.  In the past, syzbot issued a *huge* amount of
noise caused by precisely to this.  Upstream developers complained
that it was a false positive, and syzbot was adjusted to Stop Doing
That.

						- Ted
