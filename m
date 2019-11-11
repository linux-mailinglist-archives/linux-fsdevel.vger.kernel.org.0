Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A774F80FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKKURD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:03 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:47321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKKURC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDhth-1ieTNm3gZT-00AmNk; Mon, 11 Nov 2019 21:16:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/19] nfsd: use timespec64 in encode_time_delta
Date:   Mon, 11 Nov 2019 21:16:31 +0100
Message-Id: <20191111201639.2240623-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zBEHU7LOQ8BR+RvLscuFxq5Q8uP7KpIKmRblB/0JRwtkA5oax2n
 vTwmcYsK8Belkc2C9pPRkpxv9FO+mMRz4UGcaVU1rtmz641TyQdeWBICy8LAW2WMHOUZay2
 GwlOYDJzKFtZm7mAL5WBUfqjdYDxR55pYrhyv4E8Hd0fs6UiP21IceExVdpjEE44XEV02An
 hNZoR15EcnN6SPGGexKFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+4sYNMt7F9Q=:M3AyrELI81yH0KXCinQXj1
 izGRACW/Q+P5BQUA/EHio1Y0Qx5vawQ4Ti0Hsahd/my+mlXpfH7XisKxbIDUbEW3cpMMT3wuc
 7tTX1zrpkLfYXAyTVdYFKuYz02QN3fgFtfNsOLzKqxB3JEfsy4V/ihvWinx+mascGq7FyuxkP
 IqfE2VSPFUJ/dIgVlR4tYeieXQ9E0UMu8iVrGAge/rR2HJbQbJOPBXPsKTkdwEoFpRjI1ZydA
 o+DllKKIYDaxAsz86d0VtZgjDXEyfnkbCbMDDiATRR1ZNBrwv/d4GpcT6OLXbZtzi8wcMv2rh
 TKpvekjvUJ4OlF2HrwoRxcCV+JF4VPYz7pjgZKvxHTtnbMnrS1z83tPJGjmwIE9/eI+Xfp4Ca
 sM9oesbDfuyzqVY0VH65JtBvdlKiHJQ0mIW0LRgTZWymcMoJqfdcOghXaI1iLJYHX1/ZODNsW
 P/B26nui60xr3mIUHJHOMBrGAEnsUuFrGbZYek+pN7bzUi1zX+EDY8yzl4ix6eB9ecU3p/Y1J
 Zokb7/hFED6sYkosupilI7GHPO36mX6G5EZrCWu18DvQcon9qm9EH+khNLIuiP6XpNdHVs4xz
 aSKkEMHpg8YDAt2iCuPZIOIqfNQ7Mv0oThau/CpKEeKAH3QGkVLsZEyooQD06S4W731YGxbp/
 LJWZnI25MxEH0SUqa29hNl4Oa8BbR2jbgSmrxqIZe05b/QUbqH/ynTQN0dEmGDFNQ5bHdxZ38
 Iq0tOOGp5a7VlL0A7d/A+Jf+3m5+V3tUxAmkhLv8S2jJ9bGQSVDoviyVUJozmhExYi7KLiE+b
 QHzMENIaZV7xDkQkCQ6q1gXSYZlV5WjW4Il+PjgzDTtt96dhvnXyd1dSGylKI+95DkpmJ1C1B
 r1KCi0NYqNlg8KpXnXXA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The values in encode_time_delta are always small and don't
overflow the range of 'struct timespec', so changing it has
no effect.

Change it to timespec64 as a prerequisite for removing the
timespec definition later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 533d0fc3c96b..d8234d9e89fe 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2024,11 +2024,11 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
  */
 static __be32 *encode_time_delta(__be32 *p, struct inode *inode)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	u32 ns;
 
 	ns = max_t(u32, NSEC_PER_SEC/HZ, inode->i_sb->s_time_gran);
-	ts = ns_to_timespec(ns);
+	ts = ns_to_timespec64(ns);
 
 	p = xdr_encode_hyper(p, ts.tv_sec);
 	*p++ = cpu_to_be32(ts.tv_nsec);
-- 
2.20.0

