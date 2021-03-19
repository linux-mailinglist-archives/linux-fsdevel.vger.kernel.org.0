Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6460B342689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhCST4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 15:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230229AbhCST4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616183771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dWYozCwlu1FczO30gGHipO2kB8X8eyCR6cAqemLMC8E=;
        b=fuaiwBewKu6gZBmEeuUJ8mwadao6LzJOYbwZsbyOEo0fPp+xe4xXIcchP8TISfxn5PfmJY
        4eQ1zlUbehjazpmbGg3jQ5LkmSVIO2LB47RpY1zIB3xHmffhqICh/XEwJuX2s67dryMPw1
        HOlgjWeQzuPL7R1MtWBBp0G4nGueIy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-CKBav8n4O_C7CKrR0QsitA-1; Fri, 19 Mar 2021 15:56:08 -0400
X-MC-Unique: CKBav8n4O_C7CKrR0QsitA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABC11084D69;
        Fri, 19 Mar 2021 19:56:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-114.rdu2.redhat.com [10.10.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3F1C60C04;
        Fri, 19 Mar 2021 19:56:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 380D3220BCF; Fri, 19 Mar 2021 15:56:02 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: [PATCH 0/3] fuse: Fix clearing SGID when access ACL is set
Date:   Fri, 19 Mar 2021 15:55:44 -0400
Message-Id: <20210319195547.427371-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Luis reported that xfstests generic/375 fails with virtiofs. Little
debugging showed that when posix access acl is set that in some
cases SGID needs to be cleared and that does not happen with virtiofs.

Setting posix access acl can lead to mode change and it can also lead
to clear of SGID. fuse relies on file server taking care of all
the mode changes. But file server does not have enough information to
determine whether SGID should be cleared or not.

Hence this patch series add support to send a flag in SETXATTR message
to tell server to clear SGID.

I have staged corresponding virtiofsd patches here.

https://github.com/rhvgoyal/qemu/commits/acl-sgid-setxattr-flag

With these patches applied "./check -g acl" passes now on virtiofs.

Vivek Goyal (3):
  posic_acl: Add a helper determine if SGID should be cleared
  fuse: Add support for FUSE_SETXATTR_V2
  fuse: Add a flag FUSE_SETXATTR_ACL_KILL_SGID to kill SGID

 fs/fuse/acl.c             |  7 ++++++-
 fs/fuse/fuse_i.h          |  5 ++++-
 fs/fuse/inode.c           |  4 +++-
 fs/fuse/xattr.c           | 21 +++++++++++++++------
 fs/posix_acl.c            |  3 +--
 include/linux/posix_acl.h | 11 +++++++++++
 include/uapi/linux/fuse.h | 17 +++++++++++++++++
 7 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.25.4

