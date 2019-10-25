Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1674E49E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439048AbfJYL3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:29:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfJYL3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tawb+nccujPimrWiHS9Aa32LfRsfrtEJbJYur7m9f88=;
        b=Ja2wLQeWVQJrin19JM6+yPFiicY0vegf5CZo5wOP8muVf8kf7gf/9QrSqltn47Bm28g3Si
        tqiQb6AUbcwifnrwrQqGp09meZdoAZ3WfDiSfpACz/bEyggZ3p4P4vGPCRtLtW4Fn2/ASn
        VZm1KyIeLl43sJtkJ/xezO5TXR3em/Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-gVKvugroNwWpwvjG0BGDAw-1; Fri, 25 Oct 2019 07:29:21 -0400
Received: by mail-wr1-f72.google.com with SMTP id c6so936158wrp.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LV2TveLTnx1fiN/bkmnJtZ0B+hWPbHsr/HLlAeKi1Y=;
        b=eP0sIFgVqY3FmL/cneaH09SoTYli9BB3FTRfxg0efmHDpkM71Fz2UTKGanqfiQzmzc
         DUj/8UMKwYIu25+7u+YO+KKwse8RRXL1shJUF3hQ2gd+OufGEKghBm2JC/S0RaShvu2k
         eqPKMpKyYCoC88HrM7RMonXFsw/y0GmPQcqvPUrxxCLCHsrfij6aIXxDtjqVPWpmnPZP
         w0/8CCYRWzDwibAr67hjut/kMQNcgpu4KZTRwLB51Ee8txxpCRWB9Y3rxQr3aVeKbtzf
         086SoOX8oHTB6Qns9J045LV/SsHFpgAS6lrQfWW7yn0JYf2FNyuwZ95/+yS1WUKBVGC3
         sFnQ==
X-Gm-Message-State: APjAAAXP7wWGnbW5PGXtFKifaLp0aAPrj+Ht1nsdAdvYrbcVgEVkbvrp
        vdXrf3qKZvDhUr1v8lXDkVopS5ZVESPyxWJe0hMiAcAszTXajRguN9If4tO4Pvs9Uvr9Br2RaMN
        xKyrB1YvRp/okfuYamWfTWihbbA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr2546006wra.201.1572002960743;
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzq6KqqiDo1k9UizmtJKHpklyWh4CoC38j2QsAc29ZM9Kley/036A6fB9ibAZsda5ZgBfW13A==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr2545995wra.201.1572002960542;
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] allow unprivileged overlay mounts
Date:   Fri, 25 Oct 2019 13:29:12 +0200
Message-Id: <20191025112917.22518-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: gVKvugroNwWpwvjG0BGDAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

Can you please have a look at this patchset?

The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
whether I'm correct in stating that this isn't going to introduce any
holes, or not...

Thanks,
Miklos

---
Miklos Szeredi (5):
  ovl: document permission model
  ovl: ignore failure to copy up unknown xattrs
  vfs: allow unprivileged whiteout creation
  ovl: user xattr
  ovl: unprivieged mounts

 Documentation/filesystems/overlayfs.txt | 44 +++++++++++++
 fs/char_dev.c                           |  3 +
 fs/namei.c                              | 17 ++---
 fs/overlayfs/copy_up.c                  | 34 +++++++---
 fs/overlayfs/dir.c                      |  2 +-
 fs/overlayfs/export.c                   |  2 +-
 fs/overlayfs/inode.c                    | 39 ++++++------
 fs/overlayfs/namei.c                    | 56 +++++++++--------
 fs/overlayfs/overlayfs.h                | 81 +++++++++++++++---------
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  5 +-
 fs/overlayfs/super.c                    | 53 +++++++++++-----
 fs/overlayfs/util.c                     | 82 +++++++++++++++++++++----
 include/linux/device_cgroup.h           |  3 +
 14 files changed, 298 insertions(+), 124 deletions(-)

--=20
2.21.0

