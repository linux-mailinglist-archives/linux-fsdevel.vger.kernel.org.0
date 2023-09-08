Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED77986B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbjIHMCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjIHMCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:02:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CDE1BC5;
        Fri,  8 Sep 2023 05:02:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C7C433C7;
        Fri,  8 Sep 2023 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174563;
        bh=pya0rHJTL/ZmBYlmVmTUln6S8vIQ17aDAD7ILANLXuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhIvmXZBR0wZ3yXHWSNJ7t+U6MShtvEOYO8vdsZicQ3oWdguCdc514Q9v+azkOsUG
         tznfcnyyOE6dEHSnwuvxS5Zxz9JrQslGf/UvfC+nymamDuUZNbAEBPYKSYdlMe4Tsq
         ID4Uy063ehL+rKBgZf+JPMBsPdsS6ylDvUb3H05y5So0XGOK9Cp12j32Yy3AsbHxHA
         2zRDEqQPeUcr8ZDjUxPisuNcoUpsfUHo5TUdXSbFhP+pTKE5a1j9KvGqmaCgWNuhHQ
         8QeSW5zImwgg8Tb/ZYiodXZIojYauvg5+iIpR22ooy6EeRvXs0C0yr/0iG5G2rjkiv
         zJV8FPUE18fSw==
Date:   Fri, 8 Sep 2023 14:02:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230908-verflachen-neudefinition-4da649d673a9@brauner>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908102014.xgtcf5wth2l2cwup@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Well, currently you click some "Eject / safely remove / whatever" button
> and then you get a "wait" dialog until everything is done after which
> you're told the stick is safe to remove. What I imagine is that the "wait"
> dialog needs to be there while there are any (or exclusive at minimum) openers
> of the device. Not until umount(2) syscall has returned. And yes, the

Agreed. umount(2) doesn't give guarantees about a filesystem being
really gone once it has returned. And it really shouldn't. There's too
many cases where that doesn't work and it's not a commitment we should
make.

And there are ways to wait until superblock shutdown that I've mentioned
before in other places where it somehow really matters. inotify's
IN_UMOUNT will notify about superblock shutdown. IOW, when it really
hits generic_shutdown_super() which can only be hit after unfreezing as
that requires active references.

So this really can be used to wait for a filesystem to go away across
all namespaces, and across filesytem freezing and it's available to
unprivileged users. Simple example:

# shell 1
sudo mount -t xfs /dev/sda /mnt
sudo mount --bind /mnt /opt
inotifywait -e unmount /mnt

#shell 2
sudo umount /opt # nothing happens in shell 1
sudo umount /mnt # shell 1 gets woken

> corner-cases. So does the current behavior, I agree, but improving
> situation for one usecase while breaking another usecase isn't really a way
> forward...

Agreed.

> Well, the filesystem (struct superblock to be exact) is invisible in
> /proc/mounts (or whatever), that is true. But it is still very much
> associated with that block device and if you do 'mount <device>
> <mntpoint>', you'll get it back. But yes, the filesystem will not go away

And now we at least have an api to detect that case and refuse to reuse
the superblock.

> until all references to it are dropped and you cannot easily find who holds
> those references and how to get rid of them.

Namespaces make this even messier. You have no easy way of knowing
whether the filesystem isn't pinned somewhere else through an explicit
bind-mount or when it was copied during mount namespace creation.
