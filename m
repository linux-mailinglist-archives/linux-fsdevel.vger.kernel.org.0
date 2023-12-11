Return-Path: <linux-fsdevel+bounces-5595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105780DF99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC1D2826A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9025676E;
	Mon, 11 Dec 2023 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="En3FVU8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8FCF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 15:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702338023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obt9erShmifbxfTVwB/4/79H5BqitQ1XmDr9oZuepQo=;
	b=En3FVU8HeKQZo1k+DTJ5OYFe8C+bWH1tt3c1pkR2XHIEvU0xi4o5PpUfq27WhrwYQ8Gk68
	6NjsrkV8sSyuhDhcXKNzs7+ZqCSC+9BRXRSI7uTWGnkcLeYNYMA3r0c8TawoLZMIhTTNTz
	y3FIylKC0fd8ZOTmrfT9XW1m4sFZ+Eo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-QWupS-0EPHKHCPioHCt1xw-1; Mon,
 11 Dec 2023 18:40:18 -0500
X-MC-Unique: QWupS-0EPHKHCPioHCt1xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BFFA3C36AE6;
	Mon, 11 Dec 2023 23:40:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A50F2166B32;
	Mon, 11 Dec 2023 23:40:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
References: <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <12f711f9-70a2-408e-8588-2839e599b668@molgen.mpg.de> <170181366042.7109.5045075782421670339@noble.neil.brown.name> <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de> <170199821328.12910.289120389882559143@noble.neil.brown.name> <20231208013739.frhvlisxut6hexnd@moria.home.lan> <170200162890.12910.9667703050904306180@noble.neil.brown.name> <20231208024919.yjmyasgc76gxjnda@moria.home.lan> <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de> <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: dhowells@redhat.com, NeilBrown <neilb@suse.de>,
    Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
    Stefan Krueger <stefan.krueger@aei.mpg.de>,
    linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and snapshots on muti-user systems?)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2799306.1702338016.1@warthog.procyon.org.uk>
Date: Mon, 11 Dec 2023 23:40:16 +0000
Message-ID: <2799307.1702338016@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Kent Overstreet <kent.overstreet@linux.dev> wrote:

> I was chatting a bit with David Howells on IRC about this, and floated
> adding the file handle to statx. It looks like there's enough space
> reserved to make this feasible - probably going with a fixed maximum
> size of 128-256 bits.

We can always save the last bit to indicate extension space/extension record,
so we're not that strapped for space.

David


