Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCC3416AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 08:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhCSHep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhCSHeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:34:18 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A8C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 00:34:18 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b136so10133096qkc.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=urQzhmgOX5AXOQJelfFx/ncldq6kmhxylYkJ5Acgg0A=;
        b=QOPJ+ioSziS+Wf9i0JARXPRnSFZX6sRlJV06RqmoiYGZJc0MdP5qz6mHzq1Driyviz
         4LtSeSyjUegPikBilpxWUqHG5cbI06J1boqmC93ApsaVy3OA1M2mI8dSlUuYs5/lZB1V
         uHXzh3mFxrz0Y5k6/TSvPX9jCU2ThvAPrPYo+t9TpX80dVBtoJjFrQlRfUgaU6WgDUFa
         XZr1LZeDCLhMPbkXUHbtcCgckzZmP74OlPBmy2/nBfUkJF3y+1LcbA5RQJxsLk4i1sem
         Jp9e3imzPycUqOlqWJrWv61tOAnTeeef87QwHPlmLRYxxygG+rvIeC8EXt/IoOjNt75q
         LwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=urQzhmgOX5AXOQJelfFx/ncldq6kmhxylYkJ5Acgg0A=;
        b=aNOjSJN9en5YpIQmHKKl7UgPjEHsvp1CaP2YAWjJiOqtjBS8QuHvIyWSW6Spm10brd
         rfUWL0v38NeMkOLTsk85uinfjObihZFA5vwrh1qHU0Ad0KtKpHdjJbZFgnyUAuEEM7IJ
         bMfoaftihf2KUqwrt2/jvwoKd1mTeeJ2SNtM0gYWkJPY/DEE16tDJKrig1jccFP5GbPH
         OCQDUOnbbUjDIeTbC3BZZIqUtA4bFFDQzhTNWZTSgDMFhtWP1gxS2/eStjKSwSH5g7oK
         nINqpUNTVz9WxOvi0YRT9Y7lAL2Ry3QJEF7uaQMut+3JsdJRmoZ8FTHTdPcFIwhVCh02
         G2aA==
X-Gm-Message-State: AOAM530F/1AuVm+qM4qEVR0qmHji2pj3OvgS7ivQr9lg2O5hTTdHCPVg
        QEPH0l36GJUFwDoiLr7vLbsFGiUREGQ=
X-Google-Smtp-Source: ABdhPJwy5IwhzBUxuVwRL9I5c7SyWw+SoJMjyf25SWTCFCyYeQD5/Qspx04SMnRws89ao6EHcSpGp4yIYrE=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a0c:8623:: with SMTP id p32mr8077081qva.23.1616139257477;
 Fri, 19 Mar 2021 00:34:17 -0700 (PDT)
Date:   Fri, 19 Mar 2021 07:34:12 +0000
Message-Id: <20210319073414.1381041-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 0/2] Reconcile Encryption and Casefolding in Ext4
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches add support for ext4 encryption and casefolding at the same time.
Since the hash for encrypted casefolded directory names cannot be computed
without the key, we need to store the hash on disk. We only do so for encrypted
and casefolded directories to avoid on disk format changes.

e2fsprogs has already been updated with support for casefolding and encryption.

v2 changes:
	When checking for 'fake' entries (which do not include the extra hash bytes)
	-Check for . and .. using names instead of position
	-Check for csum entries via file_type instead of position
	-Assume last entry in directory will be csum for __ext4_check_entry if csum enabled
	
	This means we don't need to pass along lblk all over the place
	
	-Don't use siphash value for find_group_orlov, just use regular hash

Daniel Rosenberg (2):
  ext4: Handle casefolding with encryption
  ext4: Optimize match for casefolded encrypted dirs

 Documentation/filesystems/ext4/directory.rst |  27 +++
 fs/ext4/dir.c                                |  37 +++-
 fs/ext4/ext4.h                               |  73 +++++--
 fs/ext4/hash.c                               |  25 ++-
 fs/ext4/inline.c                             |  25 ++-
 fs/ext4/namei.c                              | 213 ++++++++++++++-----
 fs/ext4/super.c                              |   6 -
 7 files changed, 303 insertions(+), 103 deletions(-)


base-commit: f296bfd5cd04cbb49b8fc9585adc280ab2b58624
-- 
2.31.0.rc2.261.g7f71774620-goog

