Return-Path: <linux-fsdevel+bounces-9776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3EA844C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5580F29EFB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4690715144C;
	Wed, 31 Jan 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+aGpgb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831581509BA;
	Wed, 31 Jan 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742319; cv=none; b=gAYXjPo1zD5lgPocGolrKfd0Kn86hCrF6ZBrFtXggYP5XQf73RbQwrX9XOWnEcBp8NSo9nR1EGtp2FpZ1uX8oanQ7j2K+o0py22dsBgvpBj+Wz2FYULoniqlmKRJPKQuWlBWE5QHH8R/d36ms0lqgv6W6frYT8MCguyfYTQVHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742319; c=relaxed/simple;
	bh=NRTNvfYzJhWCISK6xsDWFgjLErWKIlLXxycd3FFBTl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjxWAFXhu2s2zXsGEYXhIpQLUSCr74BdrkXBU6oXC35pe9EgtSORnivTVYOyHVDXHiYmg1y9rTv6BAp20YAiSgvY+xFVxQZSPbQisp4fqaUD7uW3/MAoHaRKzgSVsGKgXQlYg3HIpz4Dd8eQJfT106iqwW5o7UzyeKW3i8qmUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+aGpgb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46808C433B2;
	Wed, 31 Jan 2024 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742319;
	bh=NRTNvfYzJhWCISK6xsDWFgjLErWKIlLXxycd3FFBTl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y+aGpgb2Unk/gV41krYQCk/Jqe6UgIkbP1bJrrGty9UeJV65nw0OofWRpE2FhP1Pj
	 4VsjDoyjZ9l6rZIYA4p7hAAurX/gI67vBsarXd1rU9QKQLTSTZSgQVMGqz80D1pMSS
	 vPm4w7Q9M3l58BR6N85gP875BbtrkakOyxNkyaweF50kaQi+vApyDzNtzYu1Hr79Im
	 eGUHs5E6CIfMOcIW9b5K6DAsIDMf7Sqwn8FovQ7eWTH/u9sTY8Of9qDzK5R1toKrYn
	 OCnnBjxnf6jUlp3gRQ0j7FSp0kILeqvcv9+vhmgsZSL4PEH934u6FkWV11wdW3FvSa
	 hxVomYvwdh96w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:27 -0500
Subject: [PATCH v3 46/47] filelock: remove temporary compatibility macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-46-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NRTNvfYzJhWCISK6xsDWFgjLErWKIlLXxycd3FFBTl8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutF0gSmAh8+8tid3AXw9RQWwE+u6uoVXJW7lY
 jDF7bWamYCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRdAAKCRAADmhBGVaC
 FXDOD/9sMyPUyrYmkh/C8uyIyT+mf8wRTolXvK+tYFkcTlPro0Vjsvsk/XXJn7tmAQGaDWw3JAo
 OI3ow2Lw5kK5I0Ilv3snawyv7SB05HjlYU5UJrHiq1a8U1zblLetbXpxa1Wy0U7hgxrZV+1mb1v
 sshrQHS0XmC3gnrwPX0To7aLcSs6bsqNWFtlvyshxVxTrRP9MPKCsmchr4yRu0UmiUwWt7e815X
 tp/dZ+WGqnuomXft4ayW0VWrd77AINGcGjDJkX+6IipDufYXAg6OlANYTL6yJCov2NnBfPOFKNl
 LqbFH8K2t5j1LjZImcP7FSYtLkbZ6TxUhfFLIZMJ2QXUOacjNdIYlpL0ozTJlFMywTfqDwIPTcQ
 9g574ueE7TPZtcv7wqCl9HzUcY7e8Bm5bGY++8wuisGl0iLPyWZvqRoaFcWK7bQHRt+8cgvLyAR
 h2BHFxw8lkbmnqpJHi11oQzljQXwF9rIz5Q7nxqM7wjeJcH3HY4HqCMqOljFx3ehSJicWgd+RB6
 CztHzmE+BmvNv1E7IZgeD/9frf47tbIk4678Euf7W47+9y8rtC0NCNTriOhzN4O6qNfIVAPck7M
 9DUAzphg4iR16jEgm4i6NWbkLES4rHTIFtocKIY/eRGmlFPdz/E+HjyZ33yH8yXZwKSEFL84K/B
 lanfoj4Uz7xmhGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Everything has been converted to access fl_core fields directly, so we
can now drop these.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/filelock.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index fdec838a3ca7..ceadd979e110 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -131,22 +131,6 @@ struct file_lock {
 	} fl_u;
 } __randomize_layout;
 
-/* Temporary macros to allow building during coccinelle conversion */
-#ifdef _NEED_FILE_LOCK_FIELD_MACROS
-#define fl_list c.flc_list
-#define fl_blocker c.flc_blocker
-#define fl_link c.flc_link
-#define fl_blocked_requests c.flc_blocked_requests
-#define fl_blocked_member c.flc_blocked_member
-#define fl_owner c.flc_owner
-#define fl_flags c.flc_flags
-#define fl_type c.flc_type
-#define fl_pid c.flc_pid
-#define fl_link_cpu c.flc_link_cpu
-#define fl_wait c.flc_wait
-#define fl_file c.flc_file
-#endif
-
 struct file_lock_context {
 	spinlock_t		flc_lock;
 	struct list_head	flc_flock;

-- 
2.43.0


