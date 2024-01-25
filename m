Return-Path: <linux-fsdevel+bounces-8912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF083C01E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ED61C234B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C36BB26;
	Thu, 25 Jan 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY2jYz6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE76A342;
	Thu, 25 Jan 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179549; cv=none; b=ruYztx8zIE9tGS2MdsexIx4qlclah1PVWIM4beIlXB+7L3Vm7CQbJXDGD8oa7u8W3s+QHm44QlSXWzyTLDo7NzOpBCDN59PNFPuivnz/J0Ivsgs+HyCIesqk/Kg8DTvB9W7kCad2lMES2Mdz8UQqRNL7yNzdWRxW6gSAO4UPANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179549; c=relaxed/simple;
	bh=G9BOoRq++Sw2YbrbW/95QUnmVcX3vxyUZDkKAXYykAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfj3y0fmKTPHiw2AoNLhyZcJDV6HGYWGwG5rmTZuod1dg8wNmvMx82ewewexwXsf4EkRMxHBKzdC14G+P2Ct9Pek0QC2qSqqsinwVCHfU2s7gFM8v1a796WRwOxtA78z7yDscl5NuqX7WB2ZQMVkjp5XeSfYoNx3OzEAO/CAcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY2jYz6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB410C43330;
	Thu, 25 Jan 2024 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179548;
	bh=G9BOoRq++Sw2YbrbW/95QUnmVcX3vxyUZDkKAXYykAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LY2jYz6Rxo7D+0gDJglGAXW6KGtlC1rXt5lgkLnes6I2YvssXTNhA9laYoQPEPUT5
	 bC+Sz7O4p0dTFvO0avzTdXOxmI0vmwbVf7luOI/WqzYL8d+GaYXLIOjEJw2wytBffY
	 hkKoANSopbnFgkCNnRx2TJ4q2NTtRC8wNOi8uM75xFtN2CRcoZfGt0u81YXMgsF+Tu
	 F0CS7Gcpfb/kj/fmEYAChw4WmMM1IW/r/i5fxkeSy2oeaKcZEQap/IwyJDfxwjLTFu
	 HzSEDCKKRvQkyRHmK01Hdx2HA9DX6LeE+LK2PC9kcehkMASxDGtvQBO9lSgIN0IrQv
	 M5ARrQSPcAgAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:21 -0500
Subject: [PATCH v2 40/41] filelock: remove temporary compatability macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-40-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=G9BOoRq++Sw2YbrbW/95QUnmVcX3vxyUZDkKAXYykAM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs/+453DhxkRf5wpA43V9S/9gV3iK0g1dXpM
 mbY/v7QW/eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PwAKCRAADmhBGVaC
 FZRlEACDwT3dVqXb+oQET+6QILfwC2tb09JYXv6cQOPYtITnxSavUtIsQS6FwkFoi2vcC1JpsZJ
 DE5u+/2KqUw9PhKWTWxT3RUovP1MYNvQiz07ucCOo6KqMAQccZSYFMaEEEwNwoYAh42WtsBKxSo
 Y9lUhS0JsZV7jtYi5185xRr+OSKHoC+UwSvPAr907sKxizzN8TMAIOlGt8LADnOSEnQp5S9/Kzr
 SV3hmZv6FT7SPOAwsfDobJIePC5mOwM0SeWxwUWy8yHUFvAm1aiBerXNp4OUNE9ap1dWhoYvama
 hEQVI0879qhO16qUu5ESyel5fdENYgM2lCk71Im0ve5iNR5XT5sAyilUU/6+h2K6ZFJicWcrJcT
 hYMcu5OiVbWsga3xgywyESnngu13DbLvBX+fPEKqw6jU1IBMwELctf3vpIgziJcxCwBjMOeruqr
 Jqu9sn41cjpJ1jOnqWoLCqeWOERD0uvVO/J9AWgrfKykyEhMJKHS8X7VuzH7035xWF0506cxSdQ
 erQFuqT8c4bK8o3KfSSP/2GwsXlpNRzXWl42ANwBtxMcissl/zBBVq/aeNaq1Uy360RzbTmrTfl
 JBYJvOA/58En0VQeW2K/j61hukmD35dcwgPedhTnH5/hoVdbecgd6wEJ6yNLtjex/cK9usSzyuH
 2vR+dw4gcHAWCwg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Everything has been converted to access fl_core fields directly, so we
can now drop these.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/filelock.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 9ddf27faba94..c887fce6dbf9 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -105,22 +105,6 @@ struct file_lock_core {
 	struct file *flc_file;
 };
 
-/* Temporary macros to allow building during coccinelle conversion */
-#ifdef _NEED_FILE_LOCK_FIELD_MACROS
-#define fl_list fl_core.flc_list
-#define fl_blocker fl_core.flc_blocker
-#define fl_link fl_core.flc_link
-#define fl_blocked_requests fl_core.flc_blocked_requests
-#define fl_blocked_member fl_core.flc_blocked_member
-#define fl_owner fl_core.flc_owner
-#define fl_flags fl_core.flc_flags
-#define fl_type fl_core.flc_type
-#define fl_pid fl_core.flc_pid
-#define fl_link_cpu fl_core.flc_link_cpu
-#define fl_wait fl_core.flc_wait
-#define fl_file fl_core.flc_file
-#endif
-
 struct file_lock {
 	struct file_lock_core fl_core;
 	loff_t fl_start;

-- 
2.43.0


