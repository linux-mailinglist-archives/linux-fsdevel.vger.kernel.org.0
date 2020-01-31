Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43B14EBFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgAaLuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 06:50:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728423AbgAaLuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580471417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T2z+DkKj1ID1NxByo8HKHzT75W1sdkuwiaCsjlxgCO0=;
        b=hEaGR/c6v23mGdEHuvN/rVrFVjy1dXTxxLO2B/X9OtKSCywP498jxsv3Ic7FtW2qwj+8e/
        fW9DOenv771Lk9P2OcRcqXgvl+GGlE9qAn2yxCruYSu4uHrTi07U0XcNfk3TSGEbEoJFcu
        WYxj1MvUD/fe3O+/m6XtjM6vnGz0Zog=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-jvu87QNSO32BI5Yn7he7hg-1; Fri, 31 Jan 2020 06:50:14 -0500
X-MC-Unique: jvu87QNSO32BI5Yn7he7hg-1
Received: by mail-wr1-f69.google.com with SMTP id h30so3243659wrh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 03:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2z+DkKj1ID1NxByo8HKHzT75W1sdkuwiaCsjlxgCO0=;
        b=tQHkGSRqMFd4Oa11V1PMyik2KOYl1jT7yQ3ERHw9pr4kn0em+lt7FdEuv5h++/kRbv
         syST/iv8NXpaGX2O+cVQ7m9rxo4njRoM/4CUIvvFs8EFR2Ct9UaJ+XDuE6fhHsU3NdDg
         jFb0fr/ZQ9lT3CJElncBqq6N7MMgB15JcERD8aZJOhIz9P8nSWVxJD/KLXkyOkVQtl5Q
         r0lAnkC4s2XaxIiY0HQRfYplmSkhQ2wQ/0Z6jYxAyN1vZ0C8VKWr+8VDsPVP4fd98kPT
         N8vcde9B8az9P6uSwnd1R4wGPSON/pKwxiMn4QAOMmqa9yeNXn0i0WU9htVV5Y48217z
         Rlgg==
X-Gm-Message-State: APjAAAXzhol67fbrzDPlQNbdQUjbIlKatLNFWh6Xvrs39e6s11VDGzCL
        89t4RUOQQaKAveA2Q0xSsm1fBHuGMduTZTyKRL7ih5swVNSA2p+eDIpZfbqQlI8yvnFH78lnooc
        SDshVZljsClXBB/yd1Fbf4RrIuQ==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr12251489wrw.277.1580471413430;
        Fri, 31 Jan 2020 03:50:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhL9S+8NlRwy97bIb2vvtvOsoiZnCiMBm8m/dH9p2y6mxAG+gItOR9SR9h5j0QAY73ljbxcQ==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr12251469wrw.277.1580471413244;
        Fri, 31 Jan 2020 03:50:13 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (84-236-74-45.pool.digikabel.hu. [84.236.74.45])
        by smtp.gmail.com with ESMTPSA id s1sm2746622wro.66.2020.01.31.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 03:50:12 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-unionfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/4] ovl: allow virtiofs as upper
Date:   Fri, 31 Jan 2020 12:50:00 +0100
Message-Id: <20200131115004.17410-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of this mini-series is to allow virtiofs as upper layer of
overlayfs.

Applies on top of #overlayfs-next (commit 1a980b8cbf00 ("ovl: add splice
file read write helper")).

Git tree is:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-remote-upper

Thanks,
Miklos

---
Miklos Szeredi (4):
  ovl: restructure dentry revalidation
  ovl: separate detection of remote upper layer from stacked overlay
  ovl: decide if revalidate needed on a per-dentry bases
  ovl: alllow remote upper

 fs/overlayfs/dir.c       |  3 ++
 fs/overlayfs/export.c    |  2 +
 fs/overlayfs/namei.c     |  5 ++-
 fs/overlayfs/overlayfs.h |  3 +-
 fs/overlayfs/super.c     | 90 +++++++++++++++++++---------------------
 fs/overlayfs/util.c      | 18 ++++++--
 6 files changed, 68 insertions(+), 53 deletions(-)

-- 
2.21.1

