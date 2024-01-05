Return-Path: <linux-fsdevel+bounces-7447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10C82518A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785E22825FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6625115;
	Fri,  5 Jan 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1StD7iI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B924B49
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704449586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogjygCadqZqQPF0RXbXaEDph9fgsETZY7v/OnrLD3js=;
	b=i1StD7iIATqSAKMXcHGre/9paMnzNs9zDOEuIPlm8eHCZ01WHp+R/+eZQ5dHNymDFZE5II
	gJvjjgwtIr3HLC4JKMxpqo0HrEbivOpAJSvp0el6WK8orWp5dmuFYSrgrKwSuoN7t9x4M1
	+D6XsEih2ct+du6hiMRxBUDr7vjCZXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-4WUKZcOBNQ-J7NNVXyZBEg-1; Fri,
 05 Jan 2024 05:13:01 -0500
X-MC-Unique: 4WUKZcOBNQ-J7NNVXyZBEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC9E41C05148;
	Fri,  5 Jan 2024 10:12:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96FAA40C6EB9;
	Fri,  5 Jan 2024 10:12:56 +0000 (UTC)
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
Content-ID: <1094258.1704449575.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jan 2024 10:12:55 +0000
Message-ID: <1094259.1704449575@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Matthew Wilcox <willy@infradead.org> wrote:

> This commit (100ccd18bb41 in linux-next 20240104) is bad for me.  After
> it, running xfstests gives me first a bunch of errors along these lines:
> =

> 00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-=
00037-g100ccd18bb41/kernel/fs/gfs2/gfs2.ko: Exec format error
> 00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-=
00037-g100ccd18bb41/kernel/fs/zonefs/zonefs.ko: Exec format error
> 00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-=
00037-g100ccd18bb41/kernel/security/keys/encrypted-keys/encrypted-keys.ko:=
 Exec format error
> =

> and then later:
> =

> 00016 generic/001       run fstests generic/001 at 2024-01-05 04:50:46
> 00017 [not run] this test requires a valid $TEST_DEV
> 00017 generic/002       run fstests generic/002 at 2024-01-05 04:50:46
> 00017 [not run] this test requires a valid $TEST_DEV
> 00017 generic/003       run fstests generic/003 at 2024-01-05 04:50:47
> 00018 [not run] this test requires a valid $SCRATCH_DEV
> ...
> =

> so I think that's page cache corruption of some kind.

Is that being run on NFS?  Is /lib on NFS?

David


