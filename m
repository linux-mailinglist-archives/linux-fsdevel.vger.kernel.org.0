Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A562559F50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF1PrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1PrC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56FF081F12;
        Fri, 28 Jun 2019 15:47:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF025DD6E;
        Fri, 28 Jun 2019 15:46:59 +0000 (UTC)
Subject: [PATCH 0/6] fsinfo: Add mount topology query [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:46:58 +0100
Message-ID: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 28 Jun 2019 15:47:02 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches that builds upon the previously posted fsinfo()
interface to:

 (a) Make it possible to invoke a query based on a mount ID rather than a
     path.  This is done by setting AT_FSINFO_MOUNTID_PATH and pointing the
     pathname argument to the mount ID as a string.

     A pathname is not a unique handle into the mount topology tree.  It's
     possible for there to be multiple overlying mounts at any particular
     point in the tree, and only the topmost can be directly accessed (the
     bottom might be inferrable from the parent).

     Usage of the mount ID permits all mount objects to be queried.  It
     would be possible to restrict the query based on the method used to
     address the object, though I haven't done this for now.

 (b) Provide a change ID for each mount object that is incremented each
     time a change is applied to that mount object.

 (c) Allow the mount topology to be queried.  The mount topology
     information returned is sprinkled with change IDs to make it easier to
     check for changes during multiple queries.  A future notification
     mechanism will also help with this.

 (d) Provide a system-unique superblock identifier that can be used to
     check to see if a mount object references the same superblock as it
     used to or as another mount object without relying on device numbers -
     which might not be seen to change over an unmount-mount combo.

A sample is also provided that allows the mount topology tree at a point to
be listed.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	fsinfo-mount

[!] Note that this depends on the fsinfo branch.


===================
SIGNIFICANT CHANGES
===================

 ver #15:

 (*) Split from the fsinfo-core branch.

 (*) Rename notify_counter to change_counter as there's no notification
     stuff here (that's in separate branches).
