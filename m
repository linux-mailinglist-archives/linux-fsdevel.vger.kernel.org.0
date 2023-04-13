Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F916E1716
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDMWAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDMWAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C42E77;
        Thu, 13 Apr 2023 15:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E47641B1;
        Thu, 13 Apr 2023 22:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D42C4339B;
        Thu, 13 Apr 2023 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681423244;
        bh=KXQ9+RwPixOi0rgkMhHezUvM6/ynnCXl4qi1DXvbj+8=;
        h=Subject:From:To:Cc:Date:From;
        b=a4/1dyJysDP/HOXY+f2vcGrgt5FF9IIsKn3Aj6faKcx7aye8+EA+5KG+ubBNzg9/V
         c6uKkzSJIgzkAzanwVf09i6H69XuHFuarQ/X7za9F0AwcOIEwLBOKZ2y/PRUU90SzW
         x05QehvE6pfY2rzj5lvppLNT3elqlXrMZOQlo3oy3aOOEL9ALNXK3zTCQbVT3t3T/G
         uQiIBP8x0ydO2S8djQdG2UUsv8I4B+zwK3JDXc7vplDm0M1sEFC0fZkevk93bu3387
         6F5xO619jHXCa/Pk/G3+Ffk61pzmPXwxaKFOxZUvzvbx1oQUZYOvRVwJLL43ETABvh
         gBmISpIoBJyKw==
Message-ID: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
Subject: allowing for a completely cached umount(2) pathwalk
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 13 Apr 2023 18:00:42 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Wysochanski posted this a week ago:

    https://lore.kernel.org/linux-nfs/CALF+zOnizN1KSE=3DV095LV6Mug8dJirqk7e=
N1joX8L1-EroohPA@mail.gmail.com/

It describes a situation where there are nested NFS mounts on a client,
and one of the intermediate mounts ends up being unexported from the
server. In a situation like this, we end up being unable to pathwalk
down to the child mount of these unreachable dentries and can't unmount
anything, even as root.

A decade ago, we did some work to make the kernel not revalidate the
leaf dentry on a umount [1]. This helped some similar sorts of problems
but it doesn't help if the problem is an intermediate dentry.

The idea at the time was that umount(2) is a special case: We are
specifically looking to stop using the mount, so there's nothing to be
gained by revalidating its root dentry and inode.

Based on the problem Dave describes, I'd submit that umount(2) is
special in another way too: It's intended to manipulate the mount table
of the local host, so contacting the backing store (the NFS server in
this case) during a pathwalk doesn't really help anything. All we care
about is getting to the right spot in the mount tree.

A "modest" proposal:
--------------------
This is still somewhat handwavy, but what if we were to make umount(2)
an even more special case for the pathwalk? For the umount(2) pathwalk,
we could:

1/ walk down the dentry tree without calling ->d_revalidate: We don't
care about changes that might have happened remotely. All we care about
is walking down the cached dentries as they are at that moment.

2/ disallow ->lookup operations: a umount is about removing an existing
mount, so the dentries had better already be there.

3/ skip inode ->permission checks. We don't want to check with the
server about our permission to walk the path when we're looking to
unmount. We're walking down the path on the _local_ machine so we can
unuse it. The server should have no say-so in the matter. (We probably
would want to require CAP_SYS_ADMIN or CAP_DAC_READ_SEARCH for this of
course).

We might need other safety checks too that I haven't considered yet.

Is this a terrible idea? Are there potentially problems with
containerized setups if we were to do something like this? Are there
better ways to solve this problem (and others like it)? Maybe this would
be best done with a new UMOUNT_CACHED flag for umount2()?

--=20
Jeff Layton <jlayton@kernel.org>

[1] 8033426e6bdb vfs: allow umount to handle mountpoints without
revalidating them
