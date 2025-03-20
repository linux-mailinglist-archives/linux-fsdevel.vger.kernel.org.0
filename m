Return-Path: <linux-fsdevel+bounces-44557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D3A6A4D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFAC3A9826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B821CA04;
	Thu, 20 Mar 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTpkC+Ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6027701
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469733; cv=none; b=ugymxtS24IrhPhhIEk/SA59egVA/fx/SoHJBE4ZMrBZUJOio0bm8kV7VfRUDPFlXhn5ofMz2ziiD7ua1X91I6MaYoZMsNxNu2tYt1udBoUguoEUkDjRZvH5eq29ZgA5bNtQg3tIvnv4Cg3zIvb+z0fN1VPSC7cD+mxQENzsc280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469733; c=relaxed/simple;
	bh=q5zEUGXnD0lNMoljVZsPKWn5xlIwHet/lPuKwYE6AuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQbuXX6xkSLuBHXDPyuTI4oYWFIF95WA1PhHW+Ym8ABuxCS+/z2hzjDktk75ivAGwW5Ct7AZZjRfxa2LJPXaCiFhbL89Ls7i9136tD7YKwP7AqShOHFS6tpFBKzbcj2zWJtzaQy6nlqhlnEru0gyQYrpO+9mub4ZzIPMmU5dWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTpkC+Ay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742469730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5zEUGXnD0lNMoljVZsPKWn5xlIwHet/lPuKwYE6AuM=;
	b=WTpkC+AyjOgpgVBokFMplXKQJ2FDNQct1PhzFGsGDQYsKazJzQUpQFAc+eEriiagImoQe8
	YB0FQQTiOpDF8AZWCLtWHJgU/QS0W9P2obFZKxBe1F9GL3PTUi5n61b8O41HINmJ7DsDhc
	5+L9ZDqPcfgPDDIIG1v8NSEbDg2uevk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-QF2Vm6U2NWSrfMDYSThqMw-1; Thu,
 20 Mar 2025 07:22:05 -0400
X-MC-Unique: QF2Vm6U2NWSrfMDYSThqMw-1
X-Mimecast-MFC-AGG-ID: QF2Vm6U2NWSrfMDYSThqMw_1742469724
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9823180025B;
	Thu, 20 Mar 2025 11:22:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 599A93001D1F;
	Thu, 20 Mar 2025 11:22:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Mar 2025 12:21:31 +0100 (CET)
Date: Thu, 20 Mar 2025 12:21:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320112126.GB11256@redhat.com>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
 <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
 <20250320105701.GA11256@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320105701.GA11256@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

And just for the record...

Consider the simplest case: a single-threaded not-ptraced process
exits. In this case do_notify_pidfd() will be called twice, from
exit_notify() and right after that from do_notify_parent().

We can cleanup this logic, but I don't think this is important and
this needs a separate patch.

(With or without this change: if the exiting task is ptraced or its
 parent exits without wait(), do_notify_pidfd() will be called even
 more times, but I think we do not care at all).

Oleg.


