Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF06798B4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjIHROY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIHROY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:14:24 -0400
X-Greylist: delayed 899 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 10:14:18 PDT
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9121FD5;
        Fri,  8 Sep 2023 10:14:18 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 1BBD61E4FA;
        Fri,  8 Sep 2023 12:49:08 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id B999DA8915; Fri,  8 Sep 2023 12:49:07 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25851.20611.732252.455034@quad.stoffel.home>
Date:   Fri, 8 Sep 2023 12:49:07 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Zdenek Kabelac <zkabelac@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
In-Reply-To: <20230908-verflachen-neudefinition-4da649d673a9@brauner>
References: <20230906-aufheben-hagel-9925501b7822@brauner>
        <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
        <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
        <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
        <20230907094457.vcvmixi23dk3pzqe@quack3>
        <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
        <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
        <20230908073244.wyriwwxahd3im2rw@quack3>
        <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
        <20230908102014.xgtcf5wth2l2cwup@quack3>
        <20230908-verflachen-neudefinition-4da649d673a9@brauner>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "Christian" == Christian Brauner <brauner@kernel.org> writes:

>> Well, currently you click some "Eject / safely remove / whatever" button
>> and then you get a "wait" dialog until everything is done after which
>> you're told the stick is safe to remove. What I imagine is that the "wait"
>> dialog needs to be there while there are any (or exclusive at minimum) openers
>> of the device. Not until umount(2) syscall has returned. And yes, the

> Agreed. umount(2) doesn't give guarantees about a filesystem being
> really gone once it has returned. And it really shouldn't. There's
> too many cases where that doesn't work and it's not a commitment we
> should make.

So how the heck is someone supposed to know, from userspace, that a
filesystem is unmounted?  Just wearing my SysAdmin hat, this strikes
me as really potentially painful and annoying.  But then again, so are
bind mounts from alot of views too.  

Don't people remember how bad it can be when you are trying to
shutdown and system and it hangs because a remote NFS server is down
and not responding?  And your client system hangs completely?  

> And there are ways to wait until superblock shutdown that I've
> mentioned before in other places where it somehow really
> matters. inotify's IN_UMOUNT will notify about superblock
> shutdown. IOW, when it really hits generic_shutdown_super() which
> can only be hit after unfreezing as that requires active references.

Can we maybe invert this discussion and think about it from the
userspace side of things?  How does the user(space) mount/unmount
devices cleanly and reliably?  

> So this really can be used to wait for a filesystem to go away across
> all namespaces, and across filesytem freezing and it's available to
> unprivileged users. Simple example:

> # shell 1
> sudo mount -t xfs /dev/sda /mnt
> sudo mount --bind /mnt /opt
> inotifywait -e unmount /mnt

> #shell 2
> sudo umount /opt # nothing happens in shell 1
> sudo umount /mnt # shell 1 gets woken

So what makes this *useful* to anyone?  Why doesn't the bind mount
A) lock /mnt into place, but B) give you some way of seeing that
there's a bindmount in place?  

>> corner-cases. So does the current behavior, I agree, but improving
>> situation for one usecase while breaking another usecase isn't really a way
>> forward...

> Agreed.

>> Well, the filesystem (struct superblock to be exact) is invisible
>> in /proc/mounts (or whatever), that is true. But it is still very
>> much associated with that block device and if you do 'mount
>> <device> <mntpoint>', you'll get it back. But yes, the filesystem
>> will not go away

Then should it be unmountable in the first place?  I mean yes, we
always need a way to force an unmount no matter what, even if that
breaks some other process on the system, but for regular use,
shouldn't it just give back an error like:

	  /mnt in use by bind mount /opt

or something like that?  Give the poor sysadmin some information on
what's going on here. 

> And now we at least have an api to detect that case and refuse to reuse
> the superblock.

>> until all references to it are dropped and you cannot easily find
>> who holds those references and how to get rid of them.

ding ding ding!!!!  I don't want to have to run 'lsof' or something
like that.

> Namespaces make this even messier. You have no easy way of knowing
> whether the filesystem isn't pinned somewhere else through an
> explicit bind-mount or when it was copied during mount namespace
> creation.

This is the biggest downside of namespaces and bind mounts in my
mind.  The lack of traceability back to the source.  
