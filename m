Return-Path: <linux-fsdevel+bounces-24873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BAB945F44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7869283091
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B06F1E673C;
	Fri,  2 Aug 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VybMJdUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BB1E4F1B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608305; cv=none; b=aA/JBDs8ifSpuDUcOCk3bC2n3DIhVi1iUNbNEelBX693Sx60RkffZty5zxfE6k7m2C27Dokt+3Q4AXrPhmpykruSQ9Rn6J+VRPnJi8/QrURozv0ZGCnmYdFKrVElPz/327TGMBs6gNqDYYL3M/iCcSc/FS5n2TRNzYQY4o2oxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608305; c=relaxed/simple;
	bh=Z5c5T9SO1qEs+S4zGxk90PSnPZppHdEyEZ6FALk8OgI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=N2gySjsOenknbvO5xhprqJWS+Mb/tD7pyAAXGtu/HeuCtO0l4lM4BQ/ruWb8Q855sWP+wzI44zz5fdd3/XoYhH1l7qsoBUKWuQV60YTk6sLEEKi8ynIVervDMSC2mv/H9vn6dZ2hdyGiJitsiAFKGE9p68TFN6B9NCKg0oypRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VybMJdUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722608302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIDX8cy8H46a6mHnpLua2nDQ7obthpcuLcvJcSVXyfU=;
	b=VybMJdUa0ND5vs/nPLrwnK9KggR9uMuhA6kn5bX2u40SVGs/qdpGr1WTGZZ+gFtCmUU0mB
	0j0Uw07eR53gpEnqr4CGkm7BRwiLITCm9lmYEujeGQyukKQ6CWX8ZQ1tR+FVGauxTOYtd1
	Bei6mlvKi1MvkakhSsJsskf1tj1vTfg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-oNOQTMjXPXOFGGA7YhgjQw-1; Fri,
 02 Aug 2024 10:18:15 -0400
X-MC-Unique: oNOQTMjXPXOFGGA7YhgjQw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 378B61955D48;
	Fri,  2 Aug 2024 14:18:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AFCD19560AE;
	Fri,  2 Aug 2024 14:18:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240731190742.GS1967603@kernel.org>
References: <20240731190742.GS1967603@kernel.org> <20240729162002.3436763-1-dhowells@redhat.com> <20240729162002.3436763-19-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/24] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <117845.1722608282.1@warthog.procyon.org.uk>
Date: Fri, 02 Aug 2024 15:18:02 +0100
Message-ID: <117846.1722608282@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Simon Horman <horms@kernel.org> wrote:

> If the code ever reaches this line, then slice will be used
> uninitialised below.

It can't actually happen (or, at least, it shouldn't).  There are only three
ways of obtaining data: downloading from the server
(NETFS_DOWNLOAD_FROM_SERVER), reading from the cache (NETFS_READ_FROM_CACHE)
and just clearing space (NETFS_FILL_WITH_ZEROES); each of those has its own
if-statement that will set 'slice' or will switch the source to a different
type that will set 'slice'.

The problem is that the compiler doesn't know this.

The check for NETFS_INVALID_READ is there just in case.  Possibly:

		if (source == NETFS_INVALID_READ)
			break;

could be replaced with a WARN_ON_ONCE() and an unconditional break.

David


