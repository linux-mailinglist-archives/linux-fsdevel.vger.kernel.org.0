Return-Path: <linux-fsdevel+bounces-5600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D480E038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096342814FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE8816;
	Tue, 12 Dec 2023 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URJSr+uj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817331BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 16:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702340721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dE/L1p12DsePAH1U47j78HD42kv4ryjF7faWGJKyav8=;
	b=URJSr+ujGLBsiZYpb5/pXuzjz4KXCKQ43ROgTf1bcTS3jzMTuG5M21B/5cygS1i156oNjP
	o/2Katik25O0GzPt054CzzqbGAO0oyXLkR78NsrTKEmbdfxUtKh8J15ZBdmpzg+vuGFNHe
	PIqqlrFYC/5yvP+szsuATBNnPEnwTzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-IyPzwy6NPZCIMC-8vAs2WQ-1; Mon, 11 Dec 2023 19:25:18 -0500
X-MC-Unique: IyPzwy6NPZCIMC-8vAs2WQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCCCA83BA86;
	Tue, 12 Dec 2023 00:25:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABE2C3C25;
	Tue, 12 Dec 2023 00:25:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <170233878712.12910.112528191448334241@noble.neil.brown.name>
References: <170233878712.12910.112528191448334241@noble.neil.brown.name> <12f711f9-70a2-408e-8588-2839e599b668@molgen.mpg.de>, <170181366042.7109.5045075782421670339@noble.neil.brown.name>, <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de>, <170199821328.12910.289120389882559143@noble.neil.brown.name>, <20231208013739.frhvlisxut6hexnd@moria.home.lan>, <170200162890.12910.9667703050904306180@noble.neil.brown.name>, <20231208024919.yjmyasgc76gxjnda@moria.home.lan>, <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>, <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>, <170233460764.12910.276163802059260666@noble.neil.brown.name>, <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
To: "NeilBrown" <neilb@suse.de>
Cc: dhowells@redhat.com, "Kent Overstreet" <kent.overstreet@linux.dev>,
    "Donald Buczek" <buczek@molgen.mpg.de>,
    linux-bcachefs@vger.kernel.org,
    "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
    linux-fsdevel@vger.kernel.org, jaltman@auristor.com
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and snapshots on muti-user systems?)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2801136.1702340715.1@warthog.procyon.org.uk>
Date: Tue, 12 Dec 2023 00:25:15 +0000
Message-ID: <2801137.1702340715@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

NeilBrown <neilb@suse.de> wrote:

> I'm not in favour of any filesystem depending on this for correct
> functionality today.  As long as the filesystem isn't so large that
> inum+volnum simply cannot fit in 64 bits, we should make a reasonable
> effort to present them both in 64 bits.

The Auristor version of AFS (which is supported by the in-kernel afs
filesystem) has a file handle (FID) that consists of a 64-bit volume ID (which
is arguably a superblock-level thing), a 96-bit vnode ID (equivalent to the
inode number) and a 32-bit uniquifier.  I don't think the capacity of these
values is fully utilised by the server... yet, but I can't support them
correctly with the UAPI that we have.

Allowing some expansion of stx_ino and/or replacing that with an stx_fid would
be helpful in that regard.  That said, getting userspace to be able to handle
this is I think going to be a large undertaking with lots of auditing
required.

David


