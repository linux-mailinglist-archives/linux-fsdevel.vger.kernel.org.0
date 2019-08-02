Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71D87FF54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391597AbfHBRP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 13:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfHBRP2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E451781F22;
        Fri,  2 Aug 2019 17:15:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-230.ams2.redhat.com [10.36.117.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0041608C2;
        Fri,  2 Aug 2019 17:15:23 +0000 (UTC)
From:   "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, Nikolaus@rath.org
Cc:     stefanha@redhat.com, vgoyal@redhat.com, tao.peng@linux.alibaba.com
Subject: [PATCH 0/3] Fuse definitions for virtiofs
Date:   Fri,  2 Aug 2019 18:15:18 +0100
Message-Id: <20190802171521.21807-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 02 Aug 2019 17:15:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  Virtiofs is a fuse-over-virtio filesystem to allow
virtual machines to access a fileystem easily, it's
currently in development, and we'd like to try and
get some of our structures and commands stabilised.
Since it runs over virtio, a spec is currently running through
the virtio standardisation process, and they'd like to
see the additional Fuse commands nailed down.  Also we'd
like to stop chasing bit/command number allocation.

The additions included here provide a performance feature
that lets the daemon map files into the hypervisor and thus
guests address space, allowing a DAX like mapping.

Note:
  For you following these patches in virtiofs, I've
made three changes:
     a) Remove the unused 'fh' field from removemapping
     b) Change the 'map_alignment' field to be log2(size) and
        use up the current uint16_t padding rather than eating
        a fresh uint32_t
     c) Moved FUSE_MAP_ALIGNMENT along one bit since
        FUSE_EXPLICIT_INVAL_DATA used up bit 25.

References:
    virtiofs home page: https://virtio-fs.gitlab.io/
    virtio-fs specification patches: https://lists.oasis-open.org/archives/virtio-dev/201907/msg00052.html

Dave

Dr. David Alan Gilbert (3):
  fuse: Add 'setupmapping'
  fuse: add 'removemapping'
  fuse: Add map_alignment for setup/remove mapping

 include/uapi/linux/fuse.h | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.21.0

