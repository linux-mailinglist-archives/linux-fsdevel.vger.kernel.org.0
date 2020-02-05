Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15051153B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 23:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgBEWs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 17:48:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgBEWs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580942905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t/qTEPqR0cY0604IZz8N3YsyuvUfo4KjEtSgdINyG0Q=;
        b=NjK7vwvNyexu0VFBf62JWYJoYq/ZwCBKXRHZbXnqjiHwX8xnmJozFXOk2zW0ZJ1Z6sKZve
        9JJFqSHr3US5N2R3IU0ma+/Sy77J+ouO3aHyeuVk2Ft88bG2FWanihvC4m+vD6qsdkblAj
        gfkRoTtdifhn0TKRha9LHv0tJtTrL5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ZYbvO7ofNkOYGq3SfpU4Ow-1; Wed, 05 Feb 2020 17:48:22 -0500
X-MC-Unique: ZYbvO7ofNkOYGq3SfpU4Ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64835100551A;
        Wed,  5 Feb 2020 22:48:21 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49E1B10013A1;
        Wed,  5 Feb 2020 22:48:21 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
        id 4536A2002F9A; Wed,  5 Feb 2020 17:48:20 -0500 (EST)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 0/3] fstests: fixes for 64k pages and dax
Date:   Wed,  5 Feb 2020 17:48:15 -0500
Message-Id: <20200205224818.18707-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This set of patches fixes a few false positives I encountered when
testing DAX on ppc64le (which has a 64k page size).

Patch 1 is actually not specific to non-4k page sizes.  Right now we
only test for dax incompatibility in the dm flakey target.  This means
that tests that use dm-thin or the snapshot target will still try to
run.  Moving the check to _require_dm_target fixes that problem.

Patches 2 and 3 get rid of hard coded block/page sizes in the tests.
They run just fine on 64k pages and 64k block sizes.

Even after these patches, there are many more tests that fail in the
following configuration:

MKFS_OPTIONS=3D"-b size=3D65536 -m reflink=3D0" MOUNT_OPTIONS=3D"-o dax"

One class of failures is tests that create a really small file system
size.  Some of those tests seem to require the very small size, but
others seem like they could live with a slightly bigger size that
would then fit the log (the typical failure is a mkfs failure due to
not enough blocks for the log).  For the former case, I'm tempted to
send patches to _notrun those tests, and for the latter, I'd like to
bump the file system sizes up.  300MB seems to be large enough to
accommodate the log.  Would folks be opposed to those approaches?

Another class of failure is tests that either hard-code a block size
to trigger a specific error case, or that test a multitude of block
sizes.  I'd like to send a patch to _notrun those tests if there is
a user-specified block size.  That will require parsing the MKFS_OPTIONS
based on the fs type, of course.  Is that something that seems
reasonable?

I will follow up with a series of patches to implement those changes
if there is consensus on the approach.  These first three seemed
straight-forward to me, so that's where I'm starting.

Thanks!
Jeff

[PATCH 1/3] dax/dm: disable testing on devices that don't support dax
[PATCH 2/3] t_mmap_collision: fix hard-coded page size
[PATCH 3/3] xfs/300: modify test to work on any fs block size

