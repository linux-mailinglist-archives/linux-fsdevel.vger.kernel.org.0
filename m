Return-Path: <linux-fsdevel+bounces-5622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F680E49D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 08:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD93E283C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256416427;
	Tue, 12 Dec 2023 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFZFzOH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A9BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702364638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ugA+dgRKXupJQ3FSbhSO+8qa+aTwoDRrWz+Rab04D0=;
	b=iFZFzOH85Yro6RLoEC9ebIQoA1kcwUliCdhX/C0HFr6akEB7B1snk8KIUBxbTisS5JbDR3
	+FfIaq8ATmiM68EdoVtD+oT77Fb1yQm+kS2JViEJYv+Q2YTJBEt0ciRsFybY/gneWhzLaz
	Q0Fk4+WkbDwoMEYFKvaWmdFM6NVy2mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-o0IAlGikPiKu9sS4Jxl-Kw-1; Tue, 12 Dec 2023 02:03:54 -0500
X-MC-Unique: o0IAlGikPiKu9sS4Jxl-Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85D97101AA4D;
	Tue, 12 Dec 2023 07:03:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DB983C25;
	Tue, 12 Dec 2023 07:03:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
References: <ZXf1WCrw4TPc5y7d@dread.disaster.area> <20231208013739.frhvlisxut6hexnd@moria.home.lan> <170200162890.12910.9667703050904306180@noble.neil.brown.name> <20231208024919.yjmyasgc76gxjnda@moria.home.lan> <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de> <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name> <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name> <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
To: Dave Chinner <david@fromorbit.com>
Cc: dhowells@redhat.com, NeilBrown <neilb@suse.de>,
    Kent Overstreet <kent.overstreet@linux.dev>,
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
Content-ID: <2805884.1702364631.1@warthog.procyon.org.uk>
Date: Tue, 12 Dec 2023 07:03:51 +0000
Message-ID: <2805885.1702364631@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Dave Chinner <david@fromorbit.com> wrote:

> I mean, we already have name_to_handle_at() for userspace to get a
> unique, opaque, filesystem defined file handle for any given file.
> It's the same filehandle that filesystems hand to the nfsd so nfs
> clients can uniquely identify the file they are asking the nfsd to
> operate on.

That's the along lines I was thinking of when I suggested using a file handle
to Kent.

Question is, though, do we need to also expand stx_ino in some way for apps
that present it to the user?

David


