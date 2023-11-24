Return-Path: <linux-fsdevel+bounces-3765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D927F7D17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919711C2114A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9893A8E1;
	Fri, 24 Nov 2023 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwFNlk1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D039FFD;
	Fri, 24 Nov 2023 18:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE9C433C7;
	Fri, 24 Nov 2023 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850078;
	bh=QZjHIs+EqSuj71ccHBGqKf4hy0LZdJnSHf4jHPi4zt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwFNlk1EShI6ZgvS7JpKdgTHEz3uNXHP6jpnNlmknnzN/6ZXUjAfg5jLCpTijK04P
	 SOKZUvUgGnVcJKh5XUlPyyqBRoMiOjQVuN8dRBTG95XcNs0PrvWpPRVEJSg7c2+zGo
	 q582Zj9G5EXPYxvM8rj8BlM36M2n78XSASnlpcqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damian Tometzki <damian@riscv-rocks.de>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 429/530] cifs: Fix encryption of cleared, but unset rq_iter data buffers
Date: Fri, 24 Nov 2023 17:49:55 +0000
Message-ID: <20231124172041.137400231@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 37de5a80e932f828c34abeaae63170d73930dca3 upstream.

Each smb_rqst struct contains two things: an array of kvecs (rq_iov) that
contains the protocol data for an RPC op and an iterator (rq_iter) that
contains the data payload of an RPC op.  When an smb_rqst is allocated
rq_iter is it always cleared, but we don't set it up unless we're going to
use it.

The functions that determines the size of the ciphertext buffer that will
be needed to encrypt a request, cifs_get_num_sgs(), assumes that rq_iter is
always initialised - and employs user_backed_iter() to check that the
iterator isn't user-backed.  This used to incidentally work, because
->user_backed was set to false because the iterator has never been
initialised, but with commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74[1]
which changes user_backed_iter() to determine this based on the iterator
type insted, a warning is now emitted:

        WARNING: CPU: 7 PID: 4584 at fs/smb/client/cifsglob.h:2165 smb2_get_aead_req+0x3fc/0x420 [cifs]
        ...
        RIP: 0010:smb2_get_aead_req+0x3fc/0x420 [cifs]
        ...
         crypt_message+0x33e/0x550 [cifs]
         smb3_init_transform_rq+0x27d/0x3f0 [cifs]
         smb_send_rqst+0xc7/0x160 [cifs]
         compound_send_recv+0x3ca/0x9f0 [cifs]
         cifs_send_recv+0x25/0x30 [cifs]
         SMB2_tcon+0x38a/0x820 [cifs]
         cifs_get_smb_ses+0x69c/0xee0 [cifs]
         cifs_mount_get_session+0x76/0x1d0 [cifs]
         dfs_mount_share+0x74/0x9d0 [cifs]
         cifs_mount+0x6e/0x2e0 [cifs]
         cifs_smb3_do_mount+0x143/0x300 [cifs]
         smb3_get_tree+0x15e/0x290 [cifs]
         vfs_get_tree+0x2d/0xe0
         do_new_mount+0x124/0x340
         __se_sys_mount+0x143/0x1a0

The problem is that rq_iter was never set, so the type is 0 (ie. ITER_UBUF)
which causes user_backed_iter() to return true.  The code doesn't
malfunction because it checks the size of the iterator - which is 0.

Fix cifs_get_num_sgs() to ignore rq_iter if its count is 0, thereby
bypassing the warnings.

It might be better to explicitly initialise rq_iter to a zero-length
ITER_BVEC, say, as it can always be reinitialised later.

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Reported-by: Damian Tometzki <damian@riscv-rocks.de>
Closes: https://lore.kernel.org/r/ZUfQo47uo0p2ZsYg@fedora.fritz.box/
Tested-by: Damian Tometzki <damian@riscv-rocks.de>
Cc: stable@vger.kernel.org
cc: Eric Biggers <ebiggers@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74 [1]
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsglob.h |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2143,6 +2143,7 @@ static inline int cifs_get_num_sgs(const
 	unsigned int len, skip;
 	unsigned int nents = 0;
 	unsigned long addr;
+	size_t data_size;
 	int i, j;
 
 	/*
@@ -2158,17 +2159,21 @@ static inline int cifs_get_num_sgs(const
 	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
 	 */
 	for (i = 0; i < num_rqst; i++) {
+		data_size = iov_iter_count(&rqst[i].rq_iter);
+
 		/* We really don't want a mixture of pinned and unpinned pages
 		 * in the sglist.  It's hard to keep track of which is what.
 		 * Instead, we convert to a BVEC-type iterator higher up.
 		 */
-		if (WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
+		if (data_size &&
+		    WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
 			return -EIO;
 
 		/* We also don't want to have any extra refs or pins to clean
 		 * up in the sglist.
 		 */
-		if (WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
+		if (data_size &&
+		    WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
 			return -EIO;
 
 		for (j = 0; j < rqst[i].rq_nvec; j++) {
@@ -2184,7 +2189,8 @@ static inline int cifs_get_num_sgs(const
 			}
 			skip = 0;
 		}
-		nents += iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
+		if (data_size)
+			nents += iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
 	}
 	nents += DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_SIZE);
 	return nents;



