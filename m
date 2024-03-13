Return-Path: <linux-fsdevel+bounces-14272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482487A464
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369151C21B85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936141B5B2;
	Wed, 13 Mar 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpDvttiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A41CA80
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320324; cv=none; b=KYeWwd00EdpfL4DEZXip0SgjfSUJp0Zj0D7U7cnSwu0+PXusSfOfPPaNlT0OhQ0oRv+vW4CjDhcD07h+mFA1++RkS8l0eJisOGDP5y7Z9V8lw/Y3gK5ykY73izz4ANJ4C2dUam7icRa74M2J/w7MY/DcrbMPhIPLUNGe6PHjBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320324; c=relaxed/simple;
	bh=cEL99aSk6iGK9iIhaqoNdRsfrJe94zJvfu2DyDWlqIk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kErA7HWS/L8oym009QsoP5jmSVVaC+otx5Q0nYefezdhVwSOixiUrqvmVPjfYMuVhV43khQ8viQ2daBkCOMcnkP4vnu9/6bn1vVnJJfjvz+icyFCpxfAOOz+1Z8ueAS7kg0DzmeaetFKdsDHfAhTHnEbgY1NBPzZZ6GsxLMaZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpDvttiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710320321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEL99aSk6iGK9iIhaqoNdRsfrJe94zJvfu2DyDWlqIk=;
	b=hpDvttiR6EiiD3cc3Yn+UkuSZ/sKtoloicW8TXKBoLi1FKbCYc8nJpBt1jM++ZfQ76sduA
	PwPCq1/p9T/q144M+NhqmUBoQt+KcAbuNVbGXz5Mw8FCu4FLgSn0KZt4bJj0Jbuj05KvbP
	hvhRlFk6So7ArvsdHermh+tjPE1/zYw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-uWH7YBmqM6q60T-RNlxmrQ-1; Wed,
 13 Mar 2024 04:58:38 -0400
X-MC-Unique: uWH7YBmqM6q60T-RNlxmrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79CC528EA6E7;
	Wed, 13 Mar 2024 08:58:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15B042166AF0;
	Wed, 13 Mar 2024 08:58:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <00000000000070f071061376a5b6@google.com>
References: <00000000000070f071061376a5b6@google.com>
To: syzbot <syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_alloc_data_txbuf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3070358.1710320315.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 08:58:35 +0000
Message-ID: <3070359.1710320315@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git rxrpc-iothread-20240312


