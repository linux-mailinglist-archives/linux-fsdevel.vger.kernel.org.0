Return-Path: <linux-fsdevel+bounces-44884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932AA6E0BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A683ACF85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E116263C80;
	Mon, 24 Mar 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiM3nsi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A24A05
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836826; cv=none; b=XQrR3tekQU7ShabR/NNWpD94Zj8jZFojrnkG4ZA7Zj8vTjR8gg82oqjKR4eAmdm3Pm6cCTfFxzQU5pH9IaFpW1GmrQ1UYtqnWIojKUaOP0PpTzjIH+4eR0GhtrYI6XLnJX8HK88bIsr/x5AawEPSJGfV/IES/ONfASSwiqIRT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836826; c=relaxed/simple;
	bh=ZtmpJe5UmizFvXG7n1tdSRicx8fTVmgWbi9HNSwN61k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9tKWWhH4oAm9KucWUBjolwCnZ9veOBcvlrc/qpKNd4VMkDYVZ9ZLNialrXurF/Ao7XBGJfxi+T1v1kUQyle/gGYAiXj/erDcS/4np3aO8IH8cUDrER21jXvkFWpuDPkbMkJges8Ajl56PRfvVckPM886ybVe3+OYDMun0WGS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiM3nsi/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742836821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+oDXUIXg8nAiFVBBnecTSuv3LyI3NVkikIpKUQFqcY=;
	b=eiM3nsi/rO6FM2xqx4AYBv0k2V91tcIqlEVyaiQBv8Aod/9RukXi2QXPR9gZZx5KPdILNo
	dnFFEt6H/ONyyzoU0vqI8umQnkoK9m5usDeBlDy/vMW7pCNLIFL857XpPsulCjwzoxgx+8
	6sV9CQueD3QeztwRfCPQKVVjz5cTFK0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-7qJBLD_MMb6DMIdZmqdELA-1; Mon,
 24 Mar 2025 13:20:20 -0400
X-MC-Unique: 7qJBLD_MMb6DMIdZmqdELA-1
X-Mimecast-MFC-AGG-ID: 7qJBLD_MMb6DMIdZmqdELA_1742836818
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B4BD1809CA5;
	Mon, 24 Mar 2025 17:20:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C5F5819560AB;
	Mon, 24 Mar 2025 17:20:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Mar 2025 18:19:45 +0100 (CET)
Date: Mon, 24 Mar 2025 18:19:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: [PATCH] exit: fix the usage of delay_group_leader->exit_code in
 do_notify_parent() and pidfs_exit()
Message-ID: <20250324171941.GA13114@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Consider a process with a group leader L and a sub-thread T.
L does sys_exit(1), then T does sys_exit_group(2).

In this case wait_task_zombie(L) will notice SIGNAL_GROUP_EXIT and use
L->signal->group_exit_code, this is correct.

But, before that, do_notify_parent(L) called by release_task(T) will use
L->exit_code != L->signal->group_exit_code, and this is not consistent.
We don't really care, I think that nobody relies on the info which comes
with SIGCHLD, if nothing else SIGCHLD < SIGRTMIN can be queued only once.

But pidfs_exit() is more problematic, I think pidfs_exit_info->exit_code
should report ->group_exit_code in this case, just like wait_task_zombie().

TODO: with this change we can hopefully cleanup (or may be even kill) the
similar SIGNAL_GROUP_EXIT checks, at least in wait_task_zombie().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index d0ebccb9dec0..4a0604f5cedd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -267,6 +267,9 @@ void release_task(struct task_struct *p)
 	leader = p->group_leader;
 	if (leader != p && thread_group_empty(leader)
 			&& leader->exit_state == EXIT_ZOMBIE) {
+		/* for pidfs_exit() and do_notify_parent() */
+		if (leader->signal->flags & SIGNAL_GROUP_EXIT)
+			leader->exit_code = leader->signal->group_exit_code;
 		/*
 		 * If we were the last child thread and the leader has
 		 * exited already, and the leader's parent ignores SIGCHLD,
-- 
2.25.1.362.g51ebf55



