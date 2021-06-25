Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E973B4927
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYTPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 15:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhFYTPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624648368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9jlkrQX6UiRHtSPer//iWV/pHePpofAUb5TL0KfYgzI=;
        b=JXFqcmrZWEnDB4xLMUkLv2TKoTKBqYKgLvg7WXSfSxwvaRqNc8NG29HtGVX3wb1MYJyCHv
        GhMJzb4quZyYq7mHZ/KF9GlXAV4VGddF73elu6+MGgM6H2DwSpHkvHoWADlxgeBTtI+YHE
        P2u3vhG3uZgxNd+Z7L6kAo0XQ2yWFjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-QZoH_G0_Me-HVQSiV5jw8g-1; Fri, 25 Jun 2021 15:12:45 -0400
X-MC-Unique: QZoH_G0_Me-HVQSiV5jw8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65F36101DA63;
        Fri, 25 Jun 2021 19:12:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-161.rdu2.redhat.com [10.10.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB0B517C5F;
        Fri, 25 Jun 2021 19:12:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 80DCC22054F; Fri, 25 Jun 2021 15:12:40 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        berrange@redhat.com, vgoyal@redhat.com
Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special files if caller has CAP_SYS_RESOURCE
Date:   Fri, 25 Jun 2021 15:12:28 -0400
Message-Id: <20210625191229.1752531-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

In virtiofs, actual file server is virtiosd daemon running on host.
There we have a mode where xattrs can be remapped to something else.
For example security.selinux can be remapped to
user.virtiofsd.securit.selinux on the host.

This remapping is useful when SELinux is enabled in guest and virtiofs
as being used as rootfs. Guest and host SELinux policy might not match
and host policy might deny security.selinux xattr setting by guest
onto host. Or host might have SELinux disabled and in that case to
be able to set security.selinux xattr, virtiofsd will need to have
CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
guest security.selinux (or other xattrs) on host to something else
is also better from security point of view.

But when we try this, we noticed that SELinux relabeling in guest
is failing on some symlinks. When I debugged a little more, I 
came to know that "user.*" xattrs are not allowed on symlinks
or special files.

"man xattr" seems to suggest that primary reason to disallow is
that arbitrary users can set unlimited amount of "user.*" xattrs
on these files and bypass quota check.

If that's the primary reason, I am wondering is it possible to relax
the restrictions if caller has CAP_SYS_RESOURCE. This capability
allows caller to bypass quota checks. So it should not be
a problem atleast from quota perpective.

That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
and remap xattrs arbitrarily. 

Thanks
Vivek

Vivek Goyal (1):
  xattr: Allow user.* xattr on symlink/special files with
    CAP_SYS_RESOURCE

 fs/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.4

