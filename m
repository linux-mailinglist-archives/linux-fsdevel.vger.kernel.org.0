Return-Path: <linux-fsdevel+bounces-17084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E08A7824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 00:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECBB1C20400
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0A13B2B9;
	Tue, 16 Apr 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWfjcK5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949913A24A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307694; cv=none; b=K7MQAvwyQW2rAeOKAasPJcG6BgBLjuW4GD1QPHjw/pJ1JvI4/hb7HdYf1hj1ibaFUpnRYCfE+vjGSbJ4BJ2MxgDDVh9gn3FUh2P0eycfGhaWcX58+7J3GozYRUj1h7HBrVhiEAxyVED5HmSR8ufyUH/avNuZ9kpJCihAQOn65K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307694; c=relaxed/simple;
	bh=e0f7bSzmGtIK19I0RYLYT2KkAAvf40uPWF4pZ8AJVio=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Gl9mDt69fX03uhruNgf5E9lSllmbYSHZqAAqiTklX3508UABrtIbl7UDeoJIYjUPONDt4DWOYaW8RMK5ySvwzieCy+M8UNzwPCHYKfeuJYKmJIN4RxCroggDk/kSRdiqAZE87/x/BjzUAERGnTPKJu3BuzBmMwiet5GBFqCq0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWfjcK5T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713307691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQOrgp2MD172t9l6XQGW4lrZCkMqV6c2thjTwzveTuc=;
	b=HWfjcK5TqBkg6eEhTpJLXnV/zuMAhEMKWXaj7+RGN/tI6gwgDUq39EnNSBqreiz7jPYawu
	otIlyL798AuSDiRSv0ZwHpPCR5ZpMW2A/cSqTk1HmbLljPfd/i5MIc37b9eTmCuNQl18fL
	KNgxjUj6D9KGplfxXpgHdtlHzpZC6DY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-dt0tRQhmPu-rFZtjV6hU-A-1; Tue, 16 Apr 2024 18:48:08 -0400
X-MC-Unique: dt0tRQhmPu-rFZtjV6hU-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C46DD80A1B9;
	Tue, 16 Apr 2024 22:48:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCEA51BDAA;
	Tue, 16 Apr 2024 22:48:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b6b6f41b9de1fc4128c3b3fe5aefc82d07a2347b.camel@kernel.org>
References: <b6b6f41b9de1fc4128c3b3fe5aefc82d07a2347b.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-4-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH 03/26] netfs: Update i_blocks when write committed to pagecache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2755235.1713307678.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2024 23:47:58 +0100
Message-ID: <2755236.1713307678@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jeff Layton <jlayton@kernel.org> wrote:

> > Update i_blocks when i_size is updated when we finish making a write t=
o the
> > pagecache to reflect the amount of space we think will be consumed.
> > =

> =

> Umm ok, but why? I get that the i_size and i_blocks would be out of sync
> until we get back new attrs from the server, but is that a problem? I'm
> mainly curious as to what's paying attention to the i_blocks during this
> window.

This is taking over from a cifs patch that does the same thing - but in co=
de
that is removed by my cifs-netfs branch, so I should probably let Steve sp=
eak
to that, though I think the problem with cifs is that these fields aren't
properly updated until the closure occurs and the server is consulted.

    commit dbfdff402d89854126658376cbcb08363194d3cd
    Author: Steve French <stfrench@microsoft.com>
    Date:   Thu Feb 22 00:26:52 2024 -0600

    smb3: update allocation size more accurately on write completion

    Changes to allocation size are approximated for extending writes of ca=
ched
    files until the server returns the actual value (on SMB3 close or quer=
y info
    for example), but it was setting the estimated value for number of blo=
cks
    to larger than the file size even if the file is likely sparse which
    breaks various xfstests (e.g. generic/129, 130, 221, 228).
    =

    When i_size and i_blocks are updated in write completion do not increa=
se
    allocation size more than what was written (rounded up to 512 bytes).

David


