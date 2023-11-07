Return-Path: <linux-fsdevel+bounces-2228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3507E4089
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD71C20CB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4130F8C;
	Tue,  7 Nov 2023 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFTJ5WLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B21EB44;
	Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 936E0C4339A;
	Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364686;
	bh=Xj/qeNJ1fWTZ5t8tG8CiKkqyjuOspbgdeEVbMKEatVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oFTJ5WLB7vlFQRcquJ5uh9QbuamVM8WKMIV/pw4Xd8rfT0VxGp+9nySvqMUfIT85k
	 jeZzDs7dDrDim5hsFqidsuy7UIvV4+jJ8yJeFGlLV83K7sDhPAon3CEgZJe28WiXU/
	 LCCN6o2VK85ipkpLoSjRiVG2tzpPv+FOSrsO4eRFSJoUoW7g7aTr0WMK1wrFzoVIf5
	 eUzraECuGYMnOa6MdeEofoNcsrUFgxtcDEMxuGxEZdMd8h2zRy59/0RLFbWB8FzaES
	 /8eIG/5UkIkvcZK0M9b80kKzZcpJGZWOqfOTinUOONpBFnwDeWlR8PZXMrAKgx/LlP
	 VeXIYRw5LcYvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0FC4167B;
	Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:44:22 +0100
Subject: [PATCH 3/4] sysctl: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20231107-jag-sysctl_remove_empty_elem_fs-v1-3-7176632fea9f@samsung.com>
References:
 <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
In-Reply-To:
 <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, 
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, 
 David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, 
 Eric Biederman <ebiederm@xmission.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
 Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, Iurii Zaikin <yzaikin@google.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu
Cc: linux-cachefs@redhat.com, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
 ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev, 
 linux-xfs@vger.kernel.org, codalist@coda.cs.cmu.edu, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ep6ig3KsG/haTwVjLCKKm4Kk60+leb3CQTaGMwbdTjg=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9MqPIIARlpG1B3CB33QBqVpFDk5COfTwoWh
 HqFk8BAtBKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/TAAKCRC6l81St5ZB
 T8o5C/9te1uxNMdDRUp6GfQqK8yJSbjVLxDs0abTPfEjp57TX/AOdFOmrwiXgdAGkwDUpVY5rKg
 qp0gHNnyXGtehooFW3SxZUwwtjPSVXxpquEnkv8gCjhenPHbGBAmOakMeL/KnhQXmtTWdZmkUDx
 iQU5SlQjl1a/Gz8IFzQ1MUTKrwEwlvA6K1ytVD+PbkS+gTi8OuUnZcIYG/2j/B+n3xMKoPjIjq2
 tda2fAiMgQpMxzcedyBjpK3EF4br8IF9NRBk+2eRARZ4TZBQbe3+d8x8c12d6nE8l1Dl6+v8XmC
 bF3irI5j7i0eA+ybQNI9qLEKv+ajjVTiVPDvndJhtvbFzP/002Ok8AvVDXnWNAfiNPPCg561Shh
 0Fa85geyCxUZXk6Kn1GwDdUYeMmie6vRU3YJtYdyrXeujBUHq5VE2iTh29hNEoI5869gs2nrZBZ
 h/Kx8YXwlg4ru1KYYeSbg04EcMK0N8fGC5qDPrdmtWsu3hksyO0KsYOGOz4r0PfP2pK9E=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove empty sentinel element from test_table and test_table_unregister.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/test_sysctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 8036aa91a1cb..9d71ec5e8a77 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -130,7 +130,6 @@ static struct ctl_table test_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_large_bitmap,
 	},
-	{ }
 };
 
 static void test_sysctl_calc_match_int_ok(void)
@@ -184,7 +183,6 @@ static struct ctl_table test_table_unregister[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 	},
-	{}
 };
 
 static int test_sysctl_run_unregister_nested(void)

-- 
2.30.2


