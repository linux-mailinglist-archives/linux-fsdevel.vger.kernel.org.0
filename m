Return-Path: <linux-fsdevel+bounces-5628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BB80E700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18931C20D2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778A58122;
	Tue, 12 Dec 2023 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY+n3vRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C126B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702371794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kXfjl/vlm5PNTtLk2bLz+UFG60aKKQyTeA8UKaXlhT4=;
	b=VY+n3vRtyMuZRFuvaRKVK75L9zu9ALACBm4GJ73qe1+GC4VRupQ3CR8ez+nWvMYYvLzGyx
	uSzMsIW3KgZJLfUM0/wZAlyh8mRxnn9Y7aBMNF4qj0WcuR7nMcsp2kWwSvdLVjQWViN9mz
	lp+ZBQgdJpHDrsjUq/W7k/V1rbdzLdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-tvCXtk4aNqyFcX2GvVdYhw-1; Tue, 12 Dec 2023 04:03:08 -0500
X-MC-Unique: tvCXtk4aNqyFcX2GvVdYhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 859B788B789;
	Tue, 12 Dec 2023 09:03:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F79440C6EBA;
	Tue, 12 Dec 2023 09:03:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com>
References: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com> <20231211163412.2766147-1-dhowells@redhat.com>
To: markus.suvanto@gmail.com
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS lookups
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2810522.1702371786.1@warthog.procyon.org.uk>
Date: Tue, 12 Dec 2023 09:03:06 +0000
Message-ID: <2810523.1702371786@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

markus.suvanto@gmail.com wrote:

> Reproduce:
> 1) kinit ....
> 2) aklog....
> 3) keyctl show 
> Session Keyring
>  347100937 --alswrv   1001 65534  keyring: _uid_ses.1001
> 1062692655 --alswrv   1001 65534   \_ keyring: _uid.1001
>  698363997 --als-rv   1001   100   \_ rxrpc: afs@station.com
> 
> klist 
> Ticket cache: KEYRING:persistent:1001:1001
> Default principal: .....

Can you "grep rxrpc /proc/keys" at this point?

> 4) ls /afs/notfound
> 5) keyctl show   
> Session Keyring
>  709308533 --alswrv   1001 65534  keyring: _uid_ses.1001
>  385820479 --alswrv   1001 65534   \_ keyring: _uid.1001
> 
> klist
> klist: Credentials cache keyring 'persistent:1001:1001' not found

David


