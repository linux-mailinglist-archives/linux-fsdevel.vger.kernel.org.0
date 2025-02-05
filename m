Return-Path: <linux-fsdevel+bounces-40925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D0A294F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359F71888272
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9C189F57;
	Wed,  5 Feb 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddyEG8EA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FA16EB42
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769625; cv=none; b=XgNRniCxNCiKDseJAXzZ08R62JAlWBJ/UJLHUBpmuOXfEGrP4JPnVHOUUhdiTcqIPvwHZIL5fLdID+ua8XssvU1MAs7QmstZdwlDciCYXxn5Q77bbSrEKP51SyqtlxUtDXM0KgRAxsysUrJkGForpUz8S4HznIC7gdvEXPGqvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769625; c=relaxed/simple;
	bh=AWa/PF1zQB2/dPaRc8Ti9/FbYVqS3cCyv6Jdx9Col40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iA5JJUQDwdzQ3k7O6ydZ3RfoDBXlE1davTwFaXlQBTJNWo/UE95afKsFK1zW+z39LmmNu8rFzlCdf14FYclvUCb/8huDDabxpOkpfASEvDaknyqrR/e3I4peThns51M02x+fcS/t5wqGDLHRfVyCpehCCEjWtWJ10+nJMUzjdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddyEG8EA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738769622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=i03PoXttS1I4daOyY6s1DIOLnM2DqIsRXTcb7XjoQ0o=;
	b=ddyEG8EAJT+wN2fSWSVDHqVsZb20+4nKp9q+sq7OYKOBwxXGieY8PgG1RscgVw02B4+oqf
	rLj7ce6vFH9m0gA2fvAbhec3jFBN64f9f/m99vA4z6bKnz7/wOxZOakDBSWnjQdZPCCzdq
	QGTmVGI052NfNIpxU632RiVYOYvOgPM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-V_ZdS8JXMAuA32eweckj_g-1; Wed,
 05 Feb 2025 10:33:39 -0500
X-MC-Unique: V_ZdS8JXMAuA32eweckj_g-1
X-Mimecast-MFC-AGG-ID: V_ZdS8JXMAuA32eweckj_g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 071991800341;
	Wed,  5 Feb 2025 15:33:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5CF86195608D;
	Wed,  5 Feb 2025 15:33:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Feb 2025 16:33:09 +0100 (CET)
Date: Wed, 5 Feb 2025 16:33:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250205153302.GA2216@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Not sure this makes sense, but after 1/2 we can also split fifo_open()
and pipe_poll() to factor out the wait_for_partner/wake_up_partner logic.

Link to v1: https://lore.kernel.org/all/20250204132153.GA20921@redhat.com/

Oleg.
---

 fs/internal.h |  1 +
 fs/pipe.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 15 deletions(-)


