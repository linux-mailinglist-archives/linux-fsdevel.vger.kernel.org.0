Return-Path: <linux-fsdevel+bounces-435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646997CAE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AD91C20B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2B30CE3;
	Mon, 16 Oct 2023 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ6Hmrzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4C30CEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB6A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697472578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqaZ7DcM+18tUsVRQeG7YQZoHIt0T3tkZ81YQtekvTU=;
	b=HJ6HmrzsUMK0pI+077KZF/rumSN+shQOf/B5K0hqBcuiH9apcwc24+DMLmeN0up2VDV5YX
	hspoi5SjKCclzHSb8uaUaNmtDhpny3IFW172dLC94mVDU/5UaS5sY4DeV6nNOYDO7ZM+3g
	bi97G4/4e9nkiJfEOmBj3/b92D5deoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-XkDUqMmGO5qnLyDuWfP0Dw-1; Mon, 16 Oct 2023 12:09:34 -0400
X-MC-Unique: XkDUqMmGO5qnLyDuWfP0Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A2E800969;
	Mon, 16 Oct 2023 16:09:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.178])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F03C111D3DC;
	Mon, 16 Oct 2023 16:09:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <e1351696345351cb3d168fb41c54a1ef8ccf0b16.camel@kernel.org>
References: <e1351696345351cb3d168fb41c54a1ef8ccf0b16.camel@kernel.org> <20231013160423.2218093-1-dhowells@redhat.com> <20231013160423.2218093-10-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [RFC PATCH 09/53] netfs: Implement unbuffered/DIO vs buffered I/O locking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2840728.1697472569.1@warthog.procyon.org.uk>
Date: Mon, 16 Oct 2023 17:09:29 +0100
Message-ID: <2840729.1697472569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jeff Layton <jlayton@kernel.org> wrote:

> It's nice to see this go into common code, but why not go ahead and
> convert ceph (and possibly NFS) to use this? Is there any reason not to?

I'm converting ceph on a follow-on branch and for ceph this will be dealt with
there.

I could do NFS round about here, I suppose.

David


