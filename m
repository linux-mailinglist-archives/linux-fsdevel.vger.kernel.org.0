Return-Path: <linux-fsdevel+bounces-30487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDB98BA86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100761C23155
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FC1C7B67;
	Tue,  1 Oct 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqhWoLr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1261C6F67;
	Tue,  1 Oct 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780384; cv=none; b=m+P57GVxJiFloHxOHVYSQ1ZLjE/EM7aJqLSZpSYqztZDoidSCS95Zq002Rq0nEzbMz1Yb5g0wpcTNNV2JFaTS63p6eqqd/zpsMBEWKpcfKXyK65uAiHcU3yIOuYYJo0/3UaDDHQPKruAxrC44j/ydlyZme69201ooG3jqPZoRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780384; c=relaxed/simple;
	bh=vfABgeY7uP8db917PbV1dpj3MLFQbmpQZkOBbve6x6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPH6kTSvf8NXNPmlagRC+plNrs0Msnr7RRSPv1ogFMuUDKfIcunSdMeqb+tCx//3J7N0oe4plvBfFnmqqXhWujG2lYTBYz7071JZ96PgOPbUZMK/elm/oxtIgXcifuJYW5BdDvpRYc5NyPmrBbBHIDOvePyMmLp3SGCidwo5e2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqhWoLr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428E1C4CECD;
	Tue,  1 Oct 2024 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780383;
	bh=vfABgeY7uP8db917PbV1dpj3MLFQbmpQZkOBbve6x6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NqhWoLr2qLRQdOkLcMCIBUNS616yE7Wsn2Do3FYKCPxTNAtUhlMY/8vPDqL9CORJ8
	 gawIrH/IWI+r3aob9UJ951bTu/BMDqZyz55vv0Dwt75DKG3XVFJh+t15nLMHHgmMbn
	 96Izn6X94VrbCOjG3imdMEt1RCnZa7cVICavqgsbX/cY5RAUpWFPvAf367i7Z/eUkH
	 fV3g68UZZQ5YPZXcLa396R8kWtFuPbB7nD86sjo58JBtkRSEyAc54RJQT5xRH6ebl3
	 h/caq+ZGm7/fH6u2XMHwCQ3JTm55c66IdUVEDyJC+VNQhN/gDSUWfHmV3q+IsazEps
	 HUQADV0X3MASA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:59:06 -0400
Subject: [PATCH v8 12/12] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-12-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vfABgeY7uP8db917PbV1dpj3MLFQbmpQZkOBbve6x6s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X7QDV7gFcbV+IsKkmQpXurd3+vww+OClJdZ
 SSWm3r5Cg2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+wAKCRAADmhBGVaC
 FV6PEACdz7xhqHbN+F1/z0hQRO4/mNdSl1k7n8dBoxQIuT87EzYxjm+op9ZONXBq7Wi9B7zpVO4
 +yg18nLaWlVJ/wyVOFlsN9AyY3M3qJ0E1xVqYGkg+D0siO/CKOYvUIi6DTP6n5rxvjrgB96B6be
 3qVtF/YPIEC6ZXkd5pBa1nyA5B8NYkHJNp1mM1DLxDSyui4SfSdOR42NDEYGBB7AYXZHL8I+fGu
 VN+hVOpC0sW/rp4dEYSNd0rYKNGEc43bN+N6wG8SurCZMFMQYaGXkcTCti3PhldmzKH1WfFX9TG
 MqF0eshQ5RDGJP7c94SJeYoZrHOoDAV0ad9MDFseXziUXUbJewSI/WdpUbQbcPDdCRw58Qy1gDG
 VkD2HVjbK9ty8Rpe5GtkhmudPY3sb7BLC9DRg2W++B4uXM5qJO4GPZwHSJ9buzL9grC/6q28BRo
 lGEJN8oAh0jMElH6cjMSnFA9Kw4waaK2pCj0337UyhmARAFHrE1yXon1oqS6j9XmT68wrXeLw4m
 bQhXGdsxvFGNn91k35C9P60R3dKONLg5/DcccX8F8HSwGDDH65KbRzt65ICP7217BznAXCP8VQY
 ywjpwBUVXttEZ9/AGCiJLXq/xZnoaRs6Ss+0JHgEbIbzV4eeXQ5bfTjomIrl9R4boIUCfbf0/k3
 JXXFUvScYgNP0ng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4f11b5506363..3444efc275b1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4951,7 +4951,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.46.2


