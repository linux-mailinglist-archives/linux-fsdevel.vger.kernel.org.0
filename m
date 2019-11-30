Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1861810DCA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 06:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfK3FbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 00:31:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42437 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3FbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so13755792plt.9;
        Fri, 29 Nov 2019 21:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lYWP7zytKnpdVNeZVRSceMLc6JN66P/+OOZqYOKvOUw=;
        b=igLUlxuCC+k/SSH2NPd7tiC4wvtspNZoNwamKYlkc0m7L0n//FM+My6BZ6azDP7/SK
         iRm0oAwcLTi6MrNA4QeyFD+KnJht4TLd1zL8f8fiyzwHF/LDKepPK1eaihuGZMIjjQ8F
         Yr2+F95dejxJI0Qt39U7G/iHawD9aTbeuikL0WSb0DF4ojuhWYPlRSXIY/YrjuFusKad
         bAHFi+9BOdJSYI3SiAArRmNyWUY/DQSdm07w+iw8tj2IW1C9nP9q6ss5JdFDGU6dqt6E
         ZXXK7h54u1K8ly10CgjqV14eixvf9cIaot0Yf3W8d5J6drm6r6pacukcQFnpQ3BNZCda
         LhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lYWP7zytKnpdVNeZVRSceMLc6JN66P/+OOZqYOKvOUw=;
        b=ZapjVN8PKSb8O4oqU/dxKfBwxaoFjKpDNitXLKtC609jnXRJ0Zh8ueyGTh2rjrJXnf
         mYlkMuy/zMC3FXMacpNqtYGgmjHUWOBt/DESTOdtlaVSXxdi+vvk7DSfQc1aLzOvnYh0
         6FWpF0pSbvH4ENiAAftVJiBmD8Nb/M8GIGz6ivEISBZM0pLmqgX8wX5KOW1xS6bK2zFv
         RPG/X32jyxVUR23vMm40ZTSiF2voNxPow5HqmowtvxvyN/PlJLlk0SKIAf5WKeIFSu/V
         25tVrTqer9De4fGuSiMUHlILBZC0hhS/6PeuK5bSQcx63Fxyoze3BAkcL9hk/svM9A/e
         xhPA==
X-Gm-Message-State: APjAAAX2cWF+IHYicST04YQtWyNIsJdm1zIsDSFHnAgjum94EyU2vXHH
        pyaAAEmMqPLte+22M72gCf2XTlPS
X-Google-Smtp-Source: APXvYqy33aPRjft3yCKru3Uh3iHw5wJaGEdVutWBqmYrn3a9UjFbYTyaOCnYWxymdH8kO2GSbdbUNw==
X-Received: by 2002:a17:90b:4391:: with SMTP id in17mr5280823pjb.33.1575091863374;
        Fri, 29 Nov 2019 21:31:03 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:02 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        hirofumi@mail.parknet.co.jp, jlayton@kernel.org, richard@nod.at,
        stfrench@microsoft.com, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 0/7] Delete timespec64_trunc()
Date:   Fri, 29 Nov 2019 21:30:23 -0800
Message-Id: <20191130053030.7868-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series aims at deleting timespec64_trunc().
There is a new api: timestamp_truncate() that is the
replacement api. The api additionally does a limits
check on the filesystem timestamps.

The suggestion to open code some of the truncate logic
came from Al Viro. And, this does make the code in some
filesystems easy to follow.

The series also does some update_time() cleanup as
suggested by Al Viro.

Deepa Dinamani (7):
  fs: fat: Eliminate timespec64_trunc() usage
  fs: cifs: Fix atime update check vs mtime
  fs: cifs: Delete usage of timespec64_trunc
  fs: ceph: Delete timespec64_trunc() usage
  fs: ubifs: Eliminate timespec64_trunc() usage
  fs: Delete timespec64_trunc()
  fs: Do not overload update_time

 fs/ceph/mds_client.c |  3 +--
 fs/cifs/inode.c      | 15 ++++++++-------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 30 +++---------------------------
 fs/ubifs/sb.c        | 11 ++++-------
 include/linux/fs.h   |  1 -
 6 files changed, 25 insertions(+), 45 deletions(-)

-- 
2.17.1

Cc: hirofumi@mail.parknet.co.jp
Cc: jlayton@kernel.org
Cc: richard@nod.at
Cc: stfrench@microsoft.com
Cc: ceph-devel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
