Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90F2E49F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439584AbfJYL3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:29:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438379AbfJYL3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uL6B8L1AUAy/UiZQvA9Cim16okzyI5YnHL1NCMV9QY=;
        b=NQZikVbApvjf3g6TlFLatZqFHHUClZqnx8yLEZDltrwCVYoBvaxCAffuKCiZdjBLexl8dG
        WuPoexLuCVi+miUQvE7913LEx84yvePRX9FxIn7WurcM9XO6Vw3GwS8neZaiXVdanet2Ij
        7hrqI5Sdsw5QGaSp8CDB34o+IN8A/a8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-rGxqbsUBM1WDzTSbVm0iwA-1; Fri, 25 Oct 2019 07:29:27 -0400
Received: by mail-wm1-f71.google.com with SMTP id 6so939329wmj.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1a/jvPs2SyoieuY5sUx5bSduqfiYAGGvkqIa6LCkCRY=;
        b=QD+OyloQhz6yJMCoUgn4jP3vmLXjP1u9DsVufyn9Jj8RbjdtL0AGjj6h1FSlg8ucBG
         n2X6z9ErOSoE078yM5BJ3T6ICgcEPNnfoNqD9SyPJeM1i7CYmuNqun+JI9LQ6kJNb9pV
         N0SoBOYR3MviBPj3VG/jD2zxuE4PimjVnpa+q7f3GHAwl7NYI3WbDc8cTKOUoHJ6aXSm
         ibZscnI7YkYNGLYusKc1uXSxJH8LLKIVUciqVJyv41ZxireGlI257zHk+9M8qoAHiQKY
         AgxcjGyooPawcHM3HxsJ854mLU69Ni8zIjil0Kgl1yR9hdfA4gNTZ+by+pYoFfaiLeNr
         /+ug==
X-Gm-Message-State: APjAAAVXN+8CYBDBLNsGe856MWRENOQxKHJXdnTMniNBamK1glqzKPnr
        rr3xTaBE/jSuYBgjYOlgmVQtSSBswymHykd5pnlwql4d4sDiEMpBDhP6eIV/bHYVAMqr7Tgr5yx
        cpHaVIlUqQKpzsA9hemaRLevzRg==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr2518272wrn.303.1572002965921;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvfPJJ2c/wmZStZlRDQhI1hTNTMWyooEQFpsvxbtMEd+kN4kjZa+gDkGbcqMbI/WXcN+LFaw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr2518261wrn.303.1572002965778;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] ovl: unprivieged mounts
Date:   Fri, 25 Oct 2019 13:29:17 +0200
Message-Id: <20191025112917.22518-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: rGxqbsUBM1WDzTSbVm0iwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable unprivileged user namespace mounts of overlayfs.  Overlayfs's
permission model (*) ensures that the mounter itself cannot gain additional
privileges by the act of creating an overlayfs mount.

This feature request is coming from the "rootless" container crowd.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d122c07f2a43..c7f21a049c6b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1739,6 +1739,7 @@ static struct dentry *ovl_mount(struct file_system_ty=
pe *fs_type, int flags,
 static struct file_system_type ovl_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "overlay",
+=09.fs_flags=09=3D FS_USERNS_MOUNT,
 =09.mount=09=09=3D ovl_mount,
 =09.kill_sb=09=3D kill_anon_super,
 };
--=20
2.21.0

