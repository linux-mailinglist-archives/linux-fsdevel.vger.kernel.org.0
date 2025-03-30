Return-Path: <linux-fsdevel+bounces-45292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A550A7598D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9FF3ABCC4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3911B4243;
	Sun, 30 Mar 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLfiT1dL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9D1AF0C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Mar 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743330112; cv=none; b=rEL/C8M+tEKL9hrIUl2UrAiPMOryJmpdpku+maqIr8p6pV63X4EjSLZ1shP9qjmSFMKT44lSwCDhaTPVJymmYM3O/0zHvWfyW348ZBBXDPpQscjtf+GYji7gGHIufpnv0xwLApoE3bX7LlTZYHgJFHgsWz+G0DInVcnnJdRlJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743330112; c=relaxed/simple;
	bh=UVBBuui5NICDkR3OU6vriDXZkhA1yImgRzPJ2LwgD28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSmiUyn16ib6x4vXRRuL9BHf4CbmHx7GNjzw44cuTQR+3VDd0NE+pz9eX8JVxlwbvw0suayQx6DY+GyK6gS7RXrtr420En7yXTYe6JtEao1cGiQtvhszMKWnMdDw/oXXkXPvc6b5cJcPvq2v7Dmq3sRcjAnptHc/YAcN3bLhi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLfiT1dL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743330110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVBBuui5NICDkR3OU6vriDXZkhA1yImgRzPJ2LwgD28=;
	b=GLfiT1dLiKe/jYbubmUywmmFecrzpYM3atMWBUYyf7vlYLeTX2ndWOoSLEY7QdtbY5fp9/
	TDVPEzGcShZv8Oxsnqq7mxfDq+XD0ET+y4ZNgNJG+SQ2PJduzuK+Sovfc+Rs8Tx5tgibCA
	6fR+FeoOx8ICPjNc4NPWIfD0sB7kLA0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-KPmozHXwMwClNqb5a6PUfg-1; Sun,
 30 Mar 2025 06:21:46 -0400
X-MC-Unique: KPmozHXwMwClNqb5a6PUfg-1
X-Mimecast-MFC-AGG-ID: KPmozHXwMwClNqb5a6PUfg_1743330104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 046591800EC5;
	Sun, 30 Mar 2025 10:21:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6EE371801752;
	Sun, 30 Mar 2025 10:21:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 30 Mar 2025 12:21:09 +0200 (CEST)
Date: Sun, 30 Mar 2025 12:21:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: asmadeus@codewreck.org
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250330102100.GB9144@redhat.com>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
 <Z-c4B7NbHM3pgQOa@codewreck.org>
 <20250329142138.GA9144@redhat.com>
 <Z-iB5QkZyayj0Sua@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-iB5QkZyayj0Sua@codewreck.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/30, asmadeus@codewreck.org wrote:
>
> If David's patch also happens to fix it I guess we can also just wait
> for that?

Sure, whatever you prefer.

Thanks!

Oleg.


