Return-Path: <linux-fsdevel+bounces-16011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3872F896BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5568B2E8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC6138494;
	Wed,  3 Apr 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRoW4T+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF26136676
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139081; cv=none; b=o2Utohie5jLSLYzSeEvG85n4Gt5DdyuOO7gN71GmxaAnvBnuX+I/OHjEj20/UZ7/9Oi4yaz7HIo2AkAtMzMZEIFpe5aS6bxaJqNSd/9bYmcMJAqC4RnCD4MJGC6BBmzu8JyK120yeEUSUdNfGoK4C4kT/7Y5eYevhOW4kyiPrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139081; c=relaxed/simple;
	bh=q5PvWHwoWD/1a3RxU9EydL5cEmke/jqCAXYn/kIe5KA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ukf3N5R3iFpc7zKFkYdYWG006JP23Ma3PcLm5lg+fs3U+CQDjrcomB81RsSUnFn56+RhtYmJ/mGvch2ibkY+57GjnOdSUgxrc9qVTTVT9YySnjIU9mVlg4E8ZOhZh7gN6QYc7xZYKedL3SEV3gnFrElcoLzoGOtSFiPUEdRMu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRoW4T+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712139078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q10XbPWbwPAYz3tVe+780L2sWGchjiaH8ntssWQEh20=;
	b=PRoW4T+bI+hd+yrOvE8dyb6/BQQ/G7YKn6yHhb0YT0RWe43XKbH4c0yhCHVYruAhC+isES
	B2A1wQlmkFumaYX2WWzJ3BTHYrZ9qfI1f9gHzryST+uR8O2p77D/WQ875T/3ka26nGcqHM
	uFDHPnWBiT5p/twJVdTAjRm9bfI5MlQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-n6tZ6td_NZGxPdmOiGxErA-1; Wed, 03 Apr 2024 06:11:13 -0400
X-MC-Unique: n6tZ6td_NZGxPdmOiGxErA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD06C185A784;
	Wed,  3 Apr 2024 10:11:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51AC140C6CB3;
	Wed,  3 Apr 2024 10:11:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240403085918.GA1178@lst.de>
References: <20240403085918.GA1178@lst.de> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-16-dhowells@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
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
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3235933.1712139047.1@warthog.procyon.org.uk>
Date: Wed, 03 Apr 2024 11:10:47 +0100
Message-ID: <3235934.1712139047@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 28, 2024 at 04:34:07PM +0000, David Howells wrote:
> > Export writeback_iter() so that it can be used by netfslib as a module.
> 
> EXPORT_SYMBOL_GPL, please.

That depends.  You put a comment on write_cache_pages() saying that people
should use writeback_iter() instead.  w_c_p() is not marked GPL.  Is it your
intention to get rid of it?

David


