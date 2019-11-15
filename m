Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB0FDC51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKOLdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 06:33:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38582 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKOLdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:33:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so10036721wmk.3;
        Fri, 15 Nov 2019 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WVAyemlXsXlMvV41BZPCoGDONOK22/z0rNw7NJEMON8=;
        b=VRbxYm0c8TPs++KneumEbQ9dluTQCd8513kCHhtxJ3f3v+8+ERxXpLgyBe6Y5C5gQ5
         sqbMV9BK7O2vd2ghTt3888WG29T8NV4MGudsMy0qOGCOzMqFDVEUnNvLTd/bHgGMPvmS
         Yd/iN/e1j2QBx+bKC9vM9mgZ6hTgAksFppTTkyfTQeoMon10zqfIPi3LaOSqty10AQLI
         +MVXztBDXvimL8jF7ZhyX4n+eS+9p1kTGqi/R6Qp67fniUaKNKFrSWHs2ieQGnVRfjm9
         ujtA353spxtAI6ZNbrN/vOfpndbjqAtN+YsamRoQJG7V7jsLwxMnKuXBQu+3NZEZXkyj
         yz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVAyemlXsXlMvV41BZPCoGDONOK22/z0rNw7NJEMON8=;
        b=V/DzJxI0xhvUJ71OyGQe4oXtOKbCStqR1EdIh9la+8xgvi1SDRY8nGlKmzDMLF6J1W
         10JIgyYs54LE/DSTsCB6N3astNJJJgfGAz3yot9XXq1A+Ree4WF+a+DWcKvbKnkUS/wU
         4yCn+eJ2aCI+ljR/gkPRTtGziXhGwf3jC26fT8NK4ot1AdLGSLrvZH5Eou5ZI9c81iYG
         13HrxdBEcEcU9t9JUV0b7SYE1pKzcdcu1yyryqjM/+5HgCf+seKHxfrJeOxLKgakckdM
         5Qz/FEQfQvC0DoiQXOFK/VLGdSC4F0zWTB84+SkKll2GB0SbELJAGpONlXKEaFaLur0p
         DHPQ==
X-Gm-Message-State: APjAAAVznKUrPLCx9BLHIOPuM9GBhKHN45sQlV4auK4LtBSxDSzfxkbK
        ukt69FGRXKjHavDbYMJ1PJUgkCoP
X-Google-Smtp-Source: APXvYqwmMhllNEwySPStvxsHY5q/idhL6bCn9WWF8QmHH2AZRLJ460+ZxDwmFst4hWJfWkX7ZSr00g==
X-Received: by 2002:a05:600c:2389:: with SMTP id m9mr14439931wma.65.1573817591657;
        Fri, 15 Nov 2019 03:33:11 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id l4sm9225181wme.4.2019.11.15.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 03:33:11 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix misaligned ovl_fh
Date:   Fri, 15 Nov 2019 13:33:02 +0200
Message-Id: <20191115113304.16209-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

Beyond the regular tests, this has also been tortured
with my ovl-nested patches and tests.
Those have been very useful in flushing out nfs export bugs in the past
and they have also flushed out a few bugs from the RFC patch I sent
yesterday.

Thanks,
Amir.

Changes since RFC:
- Fix bug in ovl_verify_index()
- Open code ovl_dentry_to_fh() [Al]
- Zero buffer in ovl_encode_real_fh() [Al]
- Support decoding old (misaligned) file handles from the wire [Al]
- Add patch to simplify memory allocation in ovl_encode_real_fh() [Al]

Amir Goldstein (2):
  ovl: make sure that real fid is 32bit aligned in memory
  ovl: don't use a temp buf for encoding real fh

 fs/overlayfs/copy_up.c   | 53 +++++++++++++-------------
 fs/overlayfs/export.c    | 80 ++++++++++++++++++++++++----------------
 fs/overlayfs/namei.c     | 44 +++++++++++-----------
 fs/overlayfs/overlayfs.h | 34 ++++++++++++++---
 4 files changed, 124 insertions(+), 87 deletions(-)

-- 
2.17.1

