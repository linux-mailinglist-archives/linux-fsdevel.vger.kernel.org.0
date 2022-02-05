Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED504AAA54
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380519AbiBEREM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39814 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiBEREM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C9B61113;
        Sat,  5 Feb 2022 17:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213FCC340E8;
        Sat,  5 Feb 2022 17:04:11 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/7] NFSD size, offset, and count sanity
Date:   Sat,  5 Feb 2022 12:04:09 -0500
Message-Id:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; h=from:subject:message-id; bh=DM1QaHmRpjPy6Ign/hGvQt5Y1V/sN/MDR2BRy4REImk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q4EQW+QVrEseeWFhB4GY0Hc+ulwA1eHB8gt2I4l qy2V7teJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uBAAKCRAzarMzb2Z/l08PEA Ca9J2QCvDEx03z/N5affl3PfU5YfFgm4u5NSYldmORBvsvi7gEFHfF8UBaSq25vyFWS6QiXzpwvTnw r7bHO3DFFiWIBtHmC5hozm27C2iRWjgbm2++Ntc+0BvXpwAK7wF7AjR2JPwx7A2sqNO1fOgu3O8qM7 I1dK5ibBnqddMALcnESG9+lH1fomlslXEW/w6JwI9e4D5Osd0uU4vrWaf+bsRubRrwarQ9IvO0Gda+ xO+x3xFKshI8qQ39AGmid9B5wqv1JKX58u+gcTxZBSRTNxNi2BHRtCaIlnUEM1zBCI+FK4l5KuoBG5 51KgZBN7bAOHuVWT0pXZQNLdKa6M9KHaWOxY7xiq3sssQaDthN+XUhsXWV+hs/vmFV+dCftouaaCqi q51Qtl0VGD87wD6I2lW+Efw3BgEYPOZdFA8fNSm9LML2lsEsKcvf+NFF5JcK9aPCaN6/i/pqW6PUt+ vO5HDLuy/1YB1WQbYprTaS5k6TcGjnJdM4LkMQA7UyyWeVd/xrG+cghmt+ZNsw7zB9N3wjI7CS/HxI dEXwUPceyXVjVlCpzUP4rn2Ys1jWQP5j5WnyNVNYIIza6I/aSdR16dnIKgJYkz9nXUJ3hfWvhk43GA T/IzFdGIo7/GIgZoZmDgFxw2bOMbR0x7XiX7NNOa/GbyTewnzJpzQA0g3WFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Aloni reported a problem with the way NFSD's READ implementation
deals with the very upper end of file sizes, and I got interested in
how some of the other operations handled it. I found some issues,
and have started a (growing) pile of patches to deal with them.

Since at least the SETATTR case appears to cause a crash on some
filesystems, I think several of these are 5.17-rc fodder (i.e.,
priority bug fixes).

I've already posted an update to the pynfs CMT4 test. A similar
pynfs test for out-of-range READ is forthcoming.

Changes since v2:
- Addressed concerns with "Fix NFSv3 SETATTR/CREATE's handling of
  large file sizes"
- Added fix for READ underflow, as initially reported; series is now
  complete
- Trace points now report wire input values before type cast

Changes since RFC:
- Series reordered so priority fixes come first
- Setattr size check is now in a common function
- Patch descriptions clarified

---

Chuck Lever (7):
      NFSD: Fix the behavior of READ near OFFSET_MAX
      NFSD: Fix ia_size underflow
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      NFSD: Clamp WRITE offsets
      NFSD: COMMIT operations must not return NFS?ERR_INVAL
      NFSD: Fix offset type in I/O trace points
      NFSD: Deprecate NFS_OFFSET_MAX


 fs/nfsd/nfs3proc.c  | 19 ++++++++-------
 fs/nfsd/nfs3xdr.c   |  4 ++--
 fs/nfsd/nfs4proc.c  | 13 +++++++----
 fs/nfsd/nfs4xdr.c   | 10 +++-----
 fs/nfsd/trace.h     | 14 +++++------
 fs/nfsd/vfs.c       | 57 +++++++++++++++++++++++++++++++--------------
 fs/nfsd/vfs.h       |  4 ++--
 include/linux/nfs.h |  8 -------
 8 files changed, 74 insertions(+), 55 deletions(-)

--
Chuck Lever
