Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB92E06E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 08:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLVHsW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 02:48:22 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:27947 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgLVHsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:48:21 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-LUivkJ76PaauRD-seN6ksg-1; Tue, 22 Dec 2020 02:47:20 -0500
X-MC-Unique: LUivkJ76PaauRD-seN6ksg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5DA21005D53;
        Tue, 22 Dec 2020 07:47:18 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0F55C730;
        Tue, 22 Dec 2020 07:47:12 +0000 (UTC)
Subject: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 15:47:09 +0800
Message-ID: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is what I currently have for the patch series we were discussing
recently.

I'm interested to see how this goes with the problem you are seeing.

The last patch in the series (the attributes update patch) has seen
no more than compile testing, I hope I haven't messed up on that.

Please keep in mind that Greg's continued silence on the question
of whether the series might be re-considered indicates to me that
he has not changed his position on this.

---

Ian Kent (6):
      kernfs: move revalidate to be near lookup
      kernfs: use VFS negative dentry caching
      kernfs: use revision to identify directory node changes
      kernfs: switch kernfs to use an rwsem
      kernfs: stay in rcu-walk mode if possible
      kernfs: add a spinlock to kernfs iattrs for inode updates


 fs/kernfs/dir.c             |  285 ++++++++++++++++++++++++++++---------------
 fs/kernfs/file.c            |    4 -
 fs/kernfs/inode.c           |   19 ++-
 fs/kernfs/kernfs-internal.h |   30 ++++-
 fs/kernfs/mount.c           |   12 +-
 fs/kernfs/symlink.c         |    4 -
 include/linux/kernfs.h      |    5 +
 7 files changed, 238 insertions(+), 121 deletions(-)

--
Ian

