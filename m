Return-Path: <linux-fsdevel+bounces-45218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DCA74D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A897A5E2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F21C5F29;
	Fri, 28 Mar 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOX2EOR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457B21364
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173420; cv=none; b=UB3b/5AM+felUoc8pbkVx5q2uu/KOdqT167YYDzP2fNaqnIpODfY3wzlvh1Xu1yCR53Pc0Kt8Z5kdTlveMYHjkxKYfDnkSCToPWY7Dadtqg1f44AZ+TUCggtUa+2V8CYeXWOarOZh1Y8JMjFG4LZ1joCJUb59tChVh6fKnUk/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173420; c=relaxed/simple;
	bh=RpZwkFsJMVj3IgV4ResMHNR65Ry7yNtxeYsBHyLQ+os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frAmRkOzENrCKbe/gji24mL69Zg6oDJZrNVT68bSPjMBZha4SPgol2BQl9PiT91nCRsORcKsaAdif+MFTDCQSzc+92koWXzsnaq33sM8KfiUHnYpOSATqR8FXffxfZWJGDaZVYVIMDgVKIoar0vvNnAKNSWpLpGZHjtDlOPybm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOX2EOR/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743173417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/9LyAVE5c7oB3rEdELb5gAK+dBdPA0z3HyLPL0kUCo=;
	b=DOX2EOR/iTR/AE6Yuf3pajxyfSUyQt98Bp5DaxlIqvHc3jIqROFAZwPQNJvUlrXlJ2VPCF
	tSewbuUMqjQ7QcCAZDfjXQL3swObj0PemivtzqeNK0nXsrNM434JA+/aIjr82wwnVNcbtS
	EshG4R04+1FmitcEp8kCwRaCs1PxfFo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-hUzKdYtWM92KFOntriwGMQ-1; Fri,
 28 Mar 2025 10:50:14 -0400
X-MC-Unique: hUzKdYtWM92KFOntriwGMQ-1
X-Mimecast-MFC-AGG-ID: hUzKdYtWM92KFOntriwGMQ_1743173412
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42A451956078;
	Fri, 28 Mar 2025 14:50:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0BF671801A6D;
	Fri, 28 Mar 2025 14:50:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 15:49:37 +0100 (CET)
Date: Fri, 28 Mar 2025 15:49:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com,
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org,
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, mjguzik@gmail.com, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250328144928.GC29527@redhat.com>
References: <20250328132557.GB29527@redhat.com>
 <67e6a8ce.050a0220.2f068f.0077.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e6a8ce.050a0220.2f068f.0077.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/28, syzbot wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> unregister_netdevice: waiting for DEV to become free
>
> unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

Looks "obviously unrelated", but I'm not sure about anything anymore.

In any case I leave this to 9p maintainers.

Okay, just out of curiosity:

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7


diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 56e62978e502..aa9cd248a243 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -669,7 +669,6 @@ static void p9_poll_mux(struct p9_conn *m)
 
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
-	__poll_t n;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
 
@@ -687,13 +686,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 	list_add_tail(&req->req_list, &m->unsent_req_list);
 	spin_unlock(&m->req_lock);
 
-	if (test_and_clear_bit(Wpending, &m->wsched))
-		n = EPOLLOUT;
-	else
-		n = p9_fd_poll(m->client, NULL, NULL);
-
-	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
-		schedule_work(&m->wq);
+	p9_poll_mux(m);
 
 	return 0;
 }


