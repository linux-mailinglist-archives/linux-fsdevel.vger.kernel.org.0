Return-Path: <linux-fsdevel+bounces-58145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37922B2A0CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B283E176676
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BED22A7E2;
	Mon, 18 Aug 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Clt/vjFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5012B73
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517538; cv=none; b=hZ4JAgMgLCJnxeGlIrz9qu3rc7T/rGYE1XorZiHwA+fp5xHzNirtXShc3X/jJN26egLf5oApw3mO8PDnWQ4RZuCSVpGADYudZAH29XA9k80olDGp9tsNj68K+ZKl1CQ301Ozd+EEw0d9U51AccQhgf2BP4NEYwiwh/WCFsPaPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517538; c=relaxed/simple;
	bh=N6vVdefW3pSbSLSiqJ1cgn6YSq+wOvI4zR40amLdBCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV7qi+UHn7Zdiwt4jVvkDUyUyjCnoD9FJIP/QTUetwVIP34qV8KSgTXJG4JMugIRM+hqROuBs2nPSvZqFGSnZw31b+tCQ4eO5bMQRj88ifhmYkDnqL1X3r1Bu6yO7SFd8RHswvQnlVlresuG9Vkx76SJybjw+RkpI4kkmTEplzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Clt/vjFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755517534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fu4mWedunRpepQK4vPdF43r3Z2WEFaYWndiALSzs5Lw=;
	b=Clt/vjFHKw/NooW81DcAGvlp4S/VvxE62xU3W1riqSl7mIVpNZUCvBmU7UjdxKVtWCYEwd
	H7PXAQzb01kNBo0STcMzkggxod789LxH92Kv3qmwPVDYrl/ZN5CmLWLSour2oFHC29LfGE
	Y51a/g5Q9bf5g+tpaH2UIcrTSjXPLe8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-GUL-TeqQNc2gGJcAky-ovg-1; Mon,
 18 Aug 2025 07:45:31 -0400
X-MC-Unique: GUL-TeqQNc2gGJcAky-ovg-1
X-Mimecast-MFC-AGG-ID: GUL-TeqQNc2gGJcAky-ovg_1755517529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ADC3180044F;
	Mon, 18 Aug 2025 11:45:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 48FE7180028E;
	Mon, 18 Aug 2025 11:45:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 18 Aug 2025 13:44:11 +0200 (CEST)
Date: Mon, 18 Aug 2025 13:44:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, dvyukov@google.com,
	elver@google.com, glider@google.com, jack@suse.cz,
	kasan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in v9fs_file_fsync
Message-ID: <20250818114404.GA18626@redhat.com>
References: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/18, syzbot wrote:
>
> HEAD commit:    038d61fd6422 Linux 6.16

#syz test: upstream 038d61fd6422

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 339ec4e54778..474fe67f72ac 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -666,7 +666,6 @@ static void p9_poll_mux(struct p9_conn *m)
 
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
-	__poll_t n;
 	int err;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
@@ -686,13 +685,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
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


