Return-Path: <linux-fsdevel+bounces-5632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B980E719
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE51C2137B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F55813D;
	Tue, 12 Dec 2023 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlogEQEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1EC7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702372254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7ZVrBJyXKr/n09YqdF0KAlAORhTC6QEemZm9T0wEqo=;
	b=VlogEQENOI5ZdXOmfRHFYBbBZfwTYeNHWqR0GVh/aj8wosdVkaHcwnl7gcqq4tBYLFjt2y
	0Pg8dPmQTw1ncxSpgjwFEmirE3FrTYQaG0a3B8/aL/8v/fjAwLyIPHESLz3ULHlv3QycuU
	LYKbHelYygg/vlnn5BatRZGN58CobqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-s5QyglmjPAiXL-CyQoXkHA-1; Tue, 12 Dec 2023 04:10:51 -0500
X-MC-Unique: s5QyglmjPAiXL-CyQoXkHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6884288B783;
	Tue, 12 Dec 2023 09:10:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75DDD492BC6;
	Tue, 12 Dec 2023 09:10:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231212-impfung-linden-6f973f2ade19@brauner>
References: <20231212-impfung-linden-6f973f2ade19@brauner> <20231208024919.yjmyasgc76gxjnda@moria.home.lan> <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de> <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name> <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name> <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name> <ZXf1WCrw4TPc5y7d@dread.disaster.area> <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Amir Goldstein <amir73il@gmail.com>,
    Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
    Kent Overstreet <kent.overstreet@linux.dev>,
    Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
    Stefan Krueger <stefan.krueger@aei.mpg.de>,
    linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
    linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and snapshots on muti-user systems?)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2810684.1702372247.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Dec 2023 09:10:47 +0000
Message-ID: <2810685.1702372247@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Christian Brauner <brauner@kernel.org> wrote:

> > > > I suggest:
> > > >
> > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have t=
he
> > > >                               same inode number
> =

> This is just ugly with questionable value. A constant reminder of how
> broken this is. Exposing the subvolume id also makes this somewhat redun=
dant.

There is a upcoming potential problem where even the 64-bit field I placed=
 in
statx() may be insufficient.  The Auristor AFS server, for example, has a
96-bit vnode ID, but I can't properly represent this in stx_ino.  Currentl=
y, I
just truncate the value to fit and hope that the discarded part will be al=
l
zero, but that's not really a good thing to do - especially when stx_ino i=
s
used programmatically to check for hardlinks.

Would it be better to add an 'stx_ino_2' field and corresponding flag?

David


