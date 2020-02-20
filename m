Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7303A1667F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgBTUGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:06:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728927AbgBTUGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582229200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aLcbxLIEN6WxbwBtj6Q9wHAChnBoKRB6in28M9dpO/0=;
        b=dGEq1mqEuKTW4LG5PjR2Bic1hyl7tAtTrO45nLFyMhRLX9eFaM8Yo7lDMkDRpZKkS6M9ea
        rvJfQ7Tbc1pqwjR8AF+MKronFBhgnr4fUbtrGCIZzhi4XpnGX7gO71hP5rfjYSbaF8ZI1j
        mNlfi57o3Txf4y+brtnDTSaqM7Yoprw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-7lJAB-32OMWUw5RRWVw9qw-1; Thu, 20 Feb 2020 15:06:36 -0500
X-MC-Unique: 7lJAB-32OMWUw5RRWVw9qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE385100550E;
        Thu, 20 Feb 2020 20:06:35 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA5175DA76;
        Thu, 20 Feb 2020 20:06:35 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
        id 92E352015B1B; Thu, 20 Feb 2020 15:06:34 -0500 (EST)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH V2 0/3] fstests: fixes for 64k pages and dax
Date:   Thu, 20 Feb 2020 15:06:29 -0500
Message-Id: <20200220200632.14075-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This set of patches fixes a few false positives I encountered when
testing DAX on ppc64le (which has a 64k page size).

Patch 1 is actually not specific to non-4k page sizes.  Currently,
each individual dm rc file checks for the presence of the DAX mount
option, and _notruns the test as part of the initializtion.  This
doesn't work for the snapshot target.  Moving the check into the
_require_dm_target fixes the problem, and keeps from the cut-n-paste
of boilerplate.

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

Changes in v2:
- patch 2: remove the boilerplate from all dm rc files (Zorro Lang)
- cc fstests (thanks, Dave)

[PATCH V2 1/3] dax/dm: disable testing on devices that don't support
[PATCH V2 2/3] t_mmap_collision: fix hard-coded page size
[PATCH V2 3/3] xfs/300: modify test to work on any fs block size

