Return-Path: <linux-fsdevel+bounces-7471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081EE825564
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D2B1F211FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41BA2E62B;
	Fri,  5 Jan 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwqqz/a3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F622DF92
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704465227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NRYq/WkDD42V/k3bqpx3sCCWkCz2IyRzqVBfkSoWhg=;
	b=Bwqqz/a3LX3z/lCw+1auxhr9lu6+80TgTPYD82vRw0JC05LUbG2Xzo9BtJ8bDaLfWUkwDh
	0Qn5wRCZ8CMWI8VMdMibIlDjxlE13E0o4bzazgtBbLgsq6wYmDrvSYvWFCivN9uFrrsN8C
	yD7u41cudfYKTMqr7OiFAYTykvbRKjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-VfUF81KUMeapj_uVOz0uBA-1; Fri, 05 Jan 2024 09:33:42 -0500
X-MC-Unique: VfUF81KUMeapj_uVOz0uBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDC45863067;
	Fri,  5 Jan 2024 14:33:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C82BC1121306;
	Fri,  5 Jan 2024 14:33:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZZeLAAf6qiieA5fy@casper.infradead.org>
References: <ZZeLAAf6qiieA5fy@casper.infradead.org> <2202548.1703245791@warthog.procyon.org.uk> <20231221230153.GA1607352@dev-arch.thelio-3990X> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-38-dhowells@redhat.com> <2229136.1703246451@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Nathan Chancellor <nathan@kernel.org>,
    Anna Schumaker <Anna.Schumaker@netapp.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix oops in NFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1197167.1704465212.1@warthog.procyon.org.uk>
Date: Fri, 05 Jan 2024 14:33:32 +0000
Message-ID: <1197168.1704465212@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Matthew Wilcox <willy@infradead.org> wrote:

> This commit (100ccd18bb41 in linux-next 20240104) is bad for me.  After
> it, running xfstests gives me first a bunch of errors along these lines:

This may be related to a patch that is in linux-next 20240105, but not
20240104 ("9p: Fix initialisation of netfs_inode for 9p").

David


