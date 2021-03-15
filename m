Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BBB33B223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCOMIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhCOMHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615810068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ufNP28iDEq7bxKgBp6VXlSCiguLGQUtUfb7Q0JdhYsQ=;
        b=Y8IqBLfMP59k+6HFaJGmqhA5DLnExCG87R1jJcY0SDV3ffS1XM7nB6QSlN53qbcxhhDjJP
        obiNCXZ/PdN8+68oBk/o+0wDreDkwkeQXnNlrKxyJWH9wQA+JvZoMpxDNpQy0PuKeu/m/Z
        lmApJIQnHONZXAiyYmyjShs9K/M/ADU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-lM_eGnjbO4usxMzdgNrZ9w-1; Mon, 15 Mar 2021 08:07:44 -0400
X-MC-Unique: lM_eGnjbO4usxMzdgNrZ9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABAF5800C78;
        Mon, 15 Mar 2021 12:07:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA97310190A7;
        Mon, 15 Mar 2021 12:07:40 +0000 (UTC)
Subject: [RFC][PATCH 0/3] vfs: Use an xarray instead of inserted bookmarks to
 scan mount list
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Mar 2021 12:07:39 +0000
Message-ID: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al, Miklós,

Can we consider replacing the "insert cursor" approach we're currently
using for proc files to scan the current namespace's mount list[1] with
something that uses an xarray of mounts indexed by mnt_id?

This has some advantages:

 (1) It's simpler.  We don't need to insert dummy mount objects as
     bookmarks into the mount list and code that's walking the list doesn't
     have to carefully step over them.

 (2) We can use the file position to represent the mnt_id and can jump to
     it directly - ie. using seek() to jump to a mount object by its ID.

 (3) It might make it easier to use RCU in future to dump mount entries
     rather than having to take namespace_sem.  xarray provides for the
     possibility of tagging entries to say that they're viewable to avoid
     dumping incomplete mount objects.

But there are a number of disadvantages:

 (1) We have to allocate memory to maintain the xarray, which becomes more
     of a problem as mnt_id values get scattered.

 (2) We need to preallocate the xarray memory because we're manipulating

 (3) The effect could be magnified because someone mounts an entire
     subtree and propagation has to copy all of it.

David

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f6c61f96f2d97cbb5f7fa85607bc398f843ff0f [1]

---
David Howells (3):
      vfs: Use an xarray in the mount namespace to handle /proc/mounts list
      vfs: Use the mounts_to_id array to do /proc/mounts and co.
      vfs: Remove mount list trawling cursor stuff


 fs/mount.h            |  2 +-
 fs/namespace.c        | 66 ++++++++++---------------------------------
 fs/proc_namespace.c   |  3 --
 include/linux/mount.h |  4 +--
 4 files changed, 17 insertions(+), 58 deletions(-)


