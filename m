Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6F40D14F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhIPBkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 21:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhIPBkg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:40:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 171A761185;
        Thu, 16 Sep 2021 01:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631756357;
        bh=qiapaZb67wwUv941O9e/iIpg4NcRC50TGqFQbf4qXHo=;
        h=Date:From:To:Cc:Subject:From;
        b=cadutgf1ZfCzX5z3WVOk4howI0AgD1RNcLPqmp8PxFR/4/y6UX1vZM1LG4j26sRe9
         jjhZlqZxObUx+K762pxoDBQjY36GxIiRoF9J4iR4A/mKsWyAp3/fwsvhR8mCQOP/gA
         XC47oOq2cOai7vdexXAJyGyEEy6EfG2tjIp17dHc5F0vqdr39dIaIAg8safm+CaDHn
         slh80w93XUsVV8Lc8CPsncSDprErEfP9FD/UZ1qk9Rnamf0UqVDjq9Xco3KbEgTBea
         jPSbOcTpQU7b8wd3oBaFMUpTgw4Ves8I0zqqNqIn6gBUYVpXQgxf2FoMbAAHiS1vxd
         ZlFT0zm9FBsFA==
Date:   Wed, 15 Sep 2021 18:39:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Shameless plug for the FS Track at LPC next week!
Message-ID: <20210916013916.GD34899@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks!

The Linux Plumbers conference is next week!  The filesystems mini
conference is next Tuesday, 21 September, starting at 14:00 UTC:

https://linuxplumbersconf.org/event/11/sessions/111/#20210921

(it's the light green column second from the right)

As most of you are probably aware, LSFMM has been cancelled for a second
year in a row, which leaves LPC as the only developer focused gathering
this year.  This year's conference is virtual, like last year.  If you'd
like to participate, it's not too late to register ($50 USD):

https://linuxplumbersconf.org/event/11/page/112-attend

---

The first session will be run by Matthew Wilcox, who will say something
about the ongoing folio work, assuming Linus isn't going to pull it for
5.15.  We'll see where things are in a week.

Christian Brauner will run the second session, discussing what idmapped
filesystem mounts are for and the current status of supporting more
filesystems.

---

Next up will be a session run by me about both of the atomic file write
features that have been variously proposed and asked for by various
enterprisey users.  The first proposal refers to direct atomic file
writes to storage hardware.  I /think/ this mostly involves enabling the
relevant plumbing in the block layer and then wiring up iomap/xfs to use
it.  Possibly also a new pwritev2 flag or file mode or something.

(Christoph did this in 2019: https://lwn.net/Articles/789600/ )

The /other/ atomic file write feature, of course, is my longstanding RFC
to add a VFS call that enables atomic swapping of file contents, which
enables a program to reflink a file's contents to an O_TMPFILE file,
write some changes to the tempfile, and then swap /all/ the changed
blocks back to the original file.  This call would be durable even if
the system goes down.  The feature is actually the brainchild of the
online filesystem repair effort, but I figured it wasn't so hard to
extend a tendril to userspace to make it more generally useful.

https://lwn.net/Articles/818977/
https://lore.kernel.org/linux-fsdevel/161723932606.3149451.12366114306150243052.stgit@magnolia/

---

Allison will be running the fourth session about our current progress
towards enabling sysadmins to shrink filesystems, and what pieces we're
going to need to clear space from the end of the filesystem and then
reduce the size.  FWIW Dave has been working on an inode relocation
("reno") tool, and I've been working on a free space defragmenter that
kind of barely works.  Originally this was a XFS-focused discussion, but
it seems that Andreas still remembers the last time someone tried to add
it to ext4.

---

Session #4 discusses the proliferation of cloud storage technologies and
the new failure modes that Ted and I have observed with these devices.
I think Ted had a few things to say about cloud devices, and due to the
repeated requests I think it would be worth polling the audience to find
out if they'd like filesystems to be more resilient (when possible) in
the face of not-totally-reliable storage.  Obviously everyone wants that
as a broad goal, but what should we pitch?  Metadata IO retries?
Restoring lost information from a mirror?  Online repair?

---

The final session will be a presentation about the XFS roadmap for 2022.
I'll start with a recap of the new features from last year's LTS that
have been maturing this year, and which pieces have landed for this
year's LTS kernel.

I /hope/ that this will attract a conversation between (x)fs developers
and real application developers about what features could be coming down
the pipeline and what features would they most be interested in.

---

To all the XFS developers: it has been a very long time since I've seen
all your faces!  I would love to have a developer BOF of some kind to
see you all again, and to introduce Catherine Hoang (our newest
addition) to the group.

If nobody else shows up to the roadmap we could do it there, but I'd
like to have /some/ kind of venue for everyone who don't find the
timeslots convenient (i.e. Dave and Chandan).  This doesn't have to take
a long time -- even a 15 minute meet and greet to help everyone
(re)associate names with faces would go a long way towards feeling
normal(ish) again. ;)

--D
