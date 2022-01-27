Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728BB49E710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiA0QIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiA0QIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:08:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B4C061714;
        Thu, 27 Jan 2022 08:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0D84B8013C;
        Thu, 27 Jan 2022 16:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C1AC340E8;
        Thu, 27 Jan 2022 16:08:32 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 1/6] NFSD: Fix NFSv4 SETATTR's handling of large file sizes
Date:   Thu, 27 Jan 2022 11:08:31 -0500
Message-Id:  <164329971128.5879.15718457509790221509.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; h=from:subject:message-id; bh=N4VlS+H+hXv1KsZpGU4bMU80ctTAGt7gsU/48u+j7YY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sN/1xgp/KJ1C4YDxiLct6MtQK0omHS36vYizANN +ybhZgiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDfwAKCRAzarMzb2Z/l+rnD/ 93FOAGWnqD74YWfrQDyd2lcxKetMuBKVq+ww3aV2BEueLU7SzY9jKaXLU551j0mIWvPQ+uhklzqmLp nWDqvMe/CaXtVT3ARGjAHw4pSSK16Hy4OjgJb166QgIU+yTCWvpmUmiuepnjsr6H2AIKF5zDbhsFOe KNKMfX5L0mt6wJVtlhyiS9H8/m6QoFtHTGM9VQ8pPzPBYNx2eVNstwYUru/kzbYIy0Z02LKOPAFCdI bwBtOx6eXRKv5rV/rz5aESClfzdb3yIhI3Bz6VNJB807VeYG3JZ3trQy0XuvkZfy1Fx1vUqSdvIyQz 81LW4yZDV7MVPafoCu3tygGbu+yGfYat+OEobWerovWbPEast+pbT40a8O07Ow/i8VKjB8qYvz+vNk moYp01PtJKMtsDdGemPMx7YPisE3VXIsb5ZXG8rYv/9dv5UaEkRyMWZv5xQ4I7uUMemNMp57J9knBl r2B2Aa4G72bFP1Zuc0vZVaCYFJxNIjgTji8JGIePFm1QomBwmz2iBn/srTv/P02w7sMtUwtfATcn5N Kcq5pDSmR+bG8Oy1czOHDACYwRMiKG3oDUFlCebu1aiNLqflvredSNL9MVebGEl58LssT1tNCBEwva 6apBn/zkx56uz0keNWjDv18LSms7xpzE7b4o0AuS2z45krJjW/tjA7DlqK1g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iattr::ia_size is a loff_t. decode_fattr4() dumps a full u64 value
in there. If that value is larger than S64_MAX, then ia_size has
underflowed.

In this case the negative size is passed through to the VFS and
underlying filesystems. I've observed XFS behavior: it returns
EIO but still attempts to access past the end of the device.
IOW it assumes the caller has already sanity-checked the value.

Have our server return NFS4ERR_FBIG to the client when the passed-in
file size cannot be held in a loff_t variable.

> 15.1.4.4.  NFS4ERR_FBIG (Error Code 27)
>
>    The file is too large.  The operation would have caused the file to
>    grow beyond the server's limit.

It's likely that other NFSv4 operations that take a fattr4 argument
(such as OPEN) have a similar issue).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ed1ee25647be..b8ac2b9bce74 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -972,6 +972,9 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int err;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
+		if (setattr->sa_iattr.ia_size < 0)
+			return nfserr_fbig;
+
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
 				WR_STATE, NULL, NULL);

