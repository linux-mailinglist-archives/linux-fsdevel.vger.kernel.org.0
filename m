Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5D22CDDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXSig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:38:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbgGXSie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595615913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dD6ELtINb6MLo80ynXeu86NT2lN2iBdYu/ec0pcOOq4=;
        b=RyxLUxizs0g3yCn9+uRBFHjP/+FaS5k9VeK00ywew5NSpMcXpmTw3W6M1makjNRgZq62sS
        d7aAjA6CS+p0OlhpvQmZOabFfopCSVOggJNTEiqzSvprnk5A77JsAVccPSFWMyi5ndFYw/
        cWvZFjhrw4cMC3P5VIYoDSh8p7uPELs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-ijZ7Je_7N0GHA-PQBqQP3A-1; Fri, 24 Jul 2020 14:38:30 -0400
X-MC-Unique: ijZ7Je_7N0GHA-PQBqQP3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3141519200C3;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 950B72DE7E;
        Fri, 24 Jul 2020 18:38:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1EE022204C7; Fri, 24 Jul 2020 14:38:25 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [RFC PATCH 0/5] fuse: Implement FUSE_HANDLE_KILLPRIV_V2 and enable SB_NOSEC 
Date:   Fri, 24 Jul 2020 14:38:07 -0400
Message-Id: <20200724183812.19573-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Here is the updated RFC patch for implementing FUSE_HANDLE_KILLPRIV_V2
and enabling SB_NOSEC. Previous discussion was here.

https://lore.kernel.org/linux-fsdevel/20200716144032.GC422759@redhat.com/

Based on previous discussion, you preferred that enabling SB_NOSEC
should dependent on FUSE_HANDLE_KILLPRIV. We also agreed that
implementing FUSE_HANDLE_KILLPRIV_V2 probably is a good idea because
current version clears suid/sgid even if caller has CAP_FSETID in
certain cases.

So I decided to give it a try and here are the RFC patches. This is only
compile and boot tested. Before I spend more time, I want to make sure
I am heading in right direction.

I have done some virtiofsd changes as well to enable handle_killpriv_v2
and proof of concept patch is here.

https://github.com/rhvgoyal/qemu/commit/5c8b40dd94e094942df3fd2796b1ee468f9d3df3

TODO: I want to set set SB_NOSEC flag after I get a response from file
      server. But we send init request asynchronously. That means
      by the time fill_super finishes, we might not get resoponse
      from server and that means we might not enable SB_NOSEC.

Before I improve these patches, I have my doubts that enabling
SB_NOSEC should be dependent on FUSE_HANDLE_KILLPRIV_V2. And here
is my rationale.

If server clears suid/sgid/caps on chown/trunc/write always, then
it probably just provides little better coherency in certain cases
where client B might have modified file metadata and client A does
not know about it.

So those who have even stricter coherency requirement can enable
FUSE_HANDLE_KILLPRIV_V2. But I am not sure why it should be a
pre-requisite for SB_NOSEC.

Even now, clearing of suid/sgid happens based on cached state of
inode->mode. So even with SB_NOSEC disabled, it is very much possible
that client B sets suid/sgid and client A write will not clear it.

Only exception seems to be security.capability. Because we don't
cache this xattr, currently we always check with file server if
this xattr is set. If it is, we clear it. So while suid/sgid
clearing is dedendent on cached attributes in client, clearing
of caps is not. I feel this is probably more by accident and
not design.

To me, I can think of following two models.

- weak coherency

  Clearing of suid/sgid/caps is driven by cached attributes in client.
  If attributes are stale, then suid/sgid/caps might not be cleared.
  This is the current default (except the case of caps).

- strong coherency

  File server takes care of clearing suid/sgid/caps so that even if
  client cache is old/stale, server will still be able to clear it.
  This is what FUSE_HANDLE_KILLPRIV_V2 can achieve based on the
  use case.

IOW, FUSE_HANDLE_KILLPRIV_V2 will help choose between weak/strong
coherency model when it comes to clearing suid/sgid/caps. But
notion of SB_NOSEC seems to be orthogonal to FUSE_HANDLE_KILLPRIV_V2
and SB_NOSEC should work both with and without FUSE_HANDLE_KILLPRIV_V2.

FUSE_HANDLE_KILLPRIV_V2 has its own issues. Right now enabling it does
not disable client driven clearing of suid/sgid/caps
(file_remove_privs() and other chown/trucnation paths).

If we actively work on supressing file_remove_privs/setattr when
FUSE_HANDLE_KILLPRIV_V2 is set, then we have the issue of client
attributes going stale (suid/sgid), as server might clear suid/sgid
upon write but client will have no idea. May be we can keep track
of completion of writes and clear suid/sgid in local cache or
invalidate attrs etc. Something to think about.
  
In short, I feel more inclined that SB_NOSEC should not be dependent
on FUSE_HANDLE_KILLPRIV_V2. It should be a separate feature which
works both with and without and user chooses FUSE_HANDLE_KILLPRIV_V2
if they want stronger coherency.

If you are concerned about regression w.r.t clear of caps, then we
can think of enabling SB_NOSEC conditionally. Say user chooses it
as mount option. But given caps is just an outlier and currently
we clear suid/sgid based on cache (and not based on state on server),
I feel it might not be a huge issue.

What do you think?

Thanks
Vivek

Vivek Goyal (5):
  fuse: Introduce the notion of FUSE_HANDLE_KILLPRIV_V2
  fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
  fuse: Add a flag FUSE_SETATTR_KILL_PRIV
  fuse: For sending setattr in case of open(O_TRUNC)
  virtiofs: Support SB_NOSEC flag to improve direct write performance

 fs/fuse/dir.c             | 13 +++++++++----
 fs/fuse/file.c            |  2 ++
 fs/fuse/fuse_i.h          |  6 ++++++
 fs/fuse/inode.c           | 17 ++++++++++++++++-
 fs/fuse/virtio_fs.c       |  3 +++
 include/uapi/linux/fuse.h | 18 +++++++++++++++++-
 6 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.25.4

