Return-Path: <linux-fsdevel+bounces-3302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090387F2BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86435B21BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC502495C2;
	Tue, 21 Nov 2023 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIZji/dp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FD154AB;
	Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D49DC433C8;
	Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700566534;
	bh=jp5zupYC3dqga+xgTeyhYepRQqFBsm6KYR9/rvlBnN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dIZji/dplIWVDXMi5aBydWZfQhkFwV/nQTmfrcl5/mRjnQ8IwILaUeQ8UPm68icfC
	 BsNwKKAwD4Mt8tE9ffWVfx1acO6caUc3cLcE1auhL942JCo1YnOknjqMijgAQ3md2l
	 ipf6nYQyBGaPajGL8CPKy5nivCYpEgv3R+OvqSc4pFVWR5zaU/RJAxRIvw9VtWyJm+
	 moul2uap0yKQviiDETrNBqVLLbDy/7dCgoamJCUOROKkRWe69TcFLVcHavj5SmRmNq
	 2J/fEQslz4sF4ShNOxte6T7bRzX7xXuGTALwkaLpxH9Id+yqFjnoxOcJGJnEMHeB6e
	 ugUfPIxZsvl3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED04C61D92;
	Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 21 Nov 2023 12:35:11 +0100
Subject: [PATCH v2 1/4] cachefiles: Remove the now superfluous sentinel
 element from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20231121-jag-sysctl_remove_empty_elem_fs-v2-1-39eab723a034@samsung.com>
References:
 <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
In-Reply-To:
 <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=SGTnhgVPbRkVEntdcKFq1I6E3blB6PSwrb9JaawnFFQ=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlXJYE8Ks+z491/DTBZVtz2um8J4jG1nLsD8a3B
 DRhcSRgUfiJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZVyWBAAKCRC6l81St5ZB
 T4IADACOW9MROZFdSM+dnh5/wed5cgaNXnrVn0LBPeHAVDiTQemiyGOrKQAda+vo5Xdn9YTJKCa
 PoC+nOKAf7TcIW5+lSdngPBDLY10Rc+onNncfJVs/pcfUcS7fvUdAe7Oii7yRE0pWXLEO8Yi/bl
 ZQddbvSPByuXt05zL+cFNSFJ6o75hORSBWUkTFgcExgCr6JtZHXh8JGoupxp+6NYOo7KGwZQCir
 gkJt7LSjyMQBBxQiG1wv3Oj3xAGIHT0r5K6FbTYG2CKIShmPRQDSLhCwjGE/Yk5oTfToxFyfUZR
 wtRrWYjHIRxQ2NkgszSSTyHULK6/XiQNiTOBISGnR4JeKsg6f2GnYke60yAYM9PEXCijJqfHNpb
 XP4426A5j7PtMZusLfCzoo/RiIvU0lLYYLW4JMuIj6tCKXVpBnxubPiW+7/0D2mysQGJzwu1Q1h
 2BdXU/cbiWKRzPziKe1iPiDUEN1EizspV1wiEqbmZV51Sz42b2uFSBfcXRFn/uWc0eKXs=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the empty
elements at the end of the ctl_table arrays (sentinels) which will reduce the
overall build time size of the kernel and run time memory bloat by ~64 bytes
per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from cachefiles_sysctls

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/cachefiles/error_inject.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/error_inject.c b/fs/cachefiles/error_inject.c
index 18de8a876b02..1715d5ca2b2d 100644
--- a/fs/cachefiles/error_inject.c
+++ b/fs/cachefiles/error_inject.c
@@ -19,7 +19,6 @@ static struct ctl_table cachefiles_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec,
 	},
-	{}
 };
 
 int __init cachefiles_register_error_injection(void)

-- 
2.30.2


