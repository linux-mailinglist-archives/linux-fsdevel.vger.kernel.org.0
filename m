Return-Path: <linux-fsdevel+bounces-45233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D2A74EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 18:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8443B6AFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEA1DC992;
	Fri, 28 Mar 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISBcWdlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502761CEE8D
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181266; cv=none; b=KHW21f3oQxUNv+ZRjVXgtVAzE9WwMiCJkPaTSNvKHvMr+5hut1qO8xTAicP5ySS5b2kFNRZq1sJKEOs5CW9biIa56j5pLtRHLLeQe+muhYNz1siBL+R1pTOgwe8/KTs7MwaxaP+Kc1qK2aIkosM32wo/AnedgZKd3G4l4DNuls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181266; c=relaxed/simple;
	bh=8vZPlKYoiDVu/ZqDtye5HIpQqq3I6+248ivhF2bbVt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr/6efIycPjVtL3E5RM2HvCp0O+6aBqM4ePJLkYBCzrXqBvrQPeIVandQAmdun2ukuL7P+mG0RQULbIbIvPntOEGXUTXKCR9cTeC1IvZffKoj3vbook6hJKbPHyKo0Fknij5Ut6xX4uYBYSub9e1A2vh4wFGZ8LSjjwDeAsFQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISBcWdlL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743181263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LT0qaEUfnYMcOQTzVI3n8CxDMyY8IlHmNxm90hGgZaw=;
	b=ISBcWdlL7kNHtPNcgX5uac+klx0j/xI6ONmvqslnx4VlNiyhDfLltx1M73ywhMBqM7SNoP
	Go8PrGGXN9HNY5lhn69qfl9dnJgtMT7qCI7LAfkxgZ3H2r9/nL9GATbhuM0h8a8fwaQCTX
	Vqb3izC+tV5exHWAZWedNSevLFnpg6A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-xoSlig8ePheeYzStYDGLTw-1; Fri,
 28 Mar 2025 13:00:59 -0400
X-MC-Unique: xoSlig8ePheeYzStYDGLTw-1
X-Mimecast-MFC-AGG-ID: xoSlig8ePheeYzStYDGLTw_1743181254
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 022B31809CA6;
	Fri, 28 Mar 2025 17:00:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B8F230001A1;
	Fri, 28 Mar 2025 17:00:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 18:00:20 +0100 (CET)
Date: Fri, 28 Mar 2025 18:00:12 +0100
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
Message-ID: <20250328170011.GD29527@redhat.com>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Dear syzbot,

On 03/28, syzbot wrote:
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
> Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Thanks. so the previous

	syzbot has tested the proposed patch but the reproducer is still triggering an issue:
	unregister_netdevice: waiting for DEV to become free

	unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

report suggests that upstream/master has another/unrelated issue(s).

As for the patches from me or Prateek (thanks again!), I think that
the maintainers should take a look.

But at this point I am mostly confident that the bisected commit aaec5a95d5961
("pipe_read: don't wake up the writer if the pipe is still full") is innocent,
it just reveals yet another problem.

I guess (I hope ;) Prateek agrees.

Oleg.


