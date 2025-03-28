Return-Path: <linux-fsdevel+bounces-45241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B79A7509B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAFB3B27EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A61E32D5;
	Fri, 28 Mar 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfd/p+vy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA511E25E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743188517; cv=none; b=JL9Z6A8LEdwgs7mGRlhadOWyvRbT/y2gTpLxS0WwZ/EHdQ7sm8T9EhHMFUiPV4sKSBWFA5sqS81Q1l+NDvrzdFjtaWomSxEwiuMg0JOycN3PDwq1EXqJn2rOgl4IQpXkM775ruzZ26MwifgWqr917fbAPP4sznWFVtyXy14QEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743188517; c=relaxed/simple;
	bh=2cBMWVGWCchoLb9AEch3jY9Z+FdEJvnB3gT3jLkXoas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ3+5yEqanG2fscKHzGLT59SYY14r+cwl/VzUtdZ7iGwf0YXQoiSfRMNXYJwH8zpiCU2maJUs0wOc9iOOkVsFQsy8AxVS1UiyvFhOiguGH9JpYNkqRPeABv/tvNOSdIokYd5LfGU1xjkbmKC0yzPR0TgcEu5bqzkwTs/17cn09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gfd/p+vy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743188515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6g2WKjbAVNgQnHPCX7LsNqMxHBI1GRkByIrxb7zLDc=;
	b=Gfd/p+vydZBtIoblp4Gm8GAi5+dffqHDs3iDdI5CDSWmnfLlHtqHyvlyRvTk0SiV++h1h2
	bRL3cq7PtfhUVZKLIFfML7RB+osJoR6OUPfyMMxdw68F5rf2/HyrwMq7Xu2BgJCB//1QDf
	Bgc//ZrjUZej+di512yzHPqcsv2PKY0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-bOjK8HIlMr6F9CYdPL19uQ-1; Fri,
 28 Mar 2025 15:01:47 -0400
X-MC-Unique: bOjK8HIlMr6F9CYdPL19uQ-1
X-Mimecast-MFC-AGG-ID: bOjK8HIlMr6F9CYdPL19uQ_1743188506
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C093518007E1;
	Fri, 28 Mar 2025 19:01:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E976D1808869;
	Fri, 28 Mar 2025 19:01:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 20:01:11 +0100 (CET)
Date: Fri, 28 Mar 2025 20:01:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250328190105.GG29527@redhat.com>
References: <20250323184848.GB14883@redhat.com>
 <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
 <86991.1743185694@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86991.1743185694@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

David,

I know that I will regret my email tomorrow, but

On 03/28, David Howells wrote:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
>
>   There's inconsistency with some wakeups between using rreq->waitq (a private
>   waitqueue) and using clear_and_wake_up_bit() (a shared global waitqueue).

Too late for me, I didn't even try to read the "netfs-fixes" changes.
And if I even tried, I probably wouldn't understand them ;)

But, afaics (I can be easily wrong), the curent logic in net/9p/ doesn't look
right regardless of any other fixes, no?

Oleg.


