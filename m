Return-Path: <linux-fsdevel+bounces-3263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6C7F1DEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BB21C214A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1E374D5;
	Mon, 20 Nov 2023 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQPgeOPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39CCC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 12:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700511578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H2AukUqWSZiqaAFj2u264/6PVKSFcwl+GsaA16JCZnM=;
	b=AQPgeOPpGeg310ni8OqxKiEzJ6qAsLCCcLZ4EytXbhH/nabLKmjnvkt9PnAM8clOGdq0ze
	JHfAS34yZ9q/9CiuGKH8c0IRL2hunbW09Ij8caE8H7OrvmwzuI2tAkNNi2jPzNVnbd5pcC
	CKsaD25ytMGE5hJOvs+XBdAttQW7lco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-2tok77_rOkWoEPyNIj7jMg-1; Mon, 20 Nov 2023 15:19:35 -0500
X-MC-Unique: 2tok77_rOkWoEPyNIj7jMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FCA785A58A;
	Mon, 20 Nov 2023 20:19:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C012C1596F;
	Mon, 20 Nov 2023 20:19:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxhNhmGrb7_Lwp9pt-hyaBUQz9++PH0KR1r3=cjKVCJJfQ@mail.gmail.com>
References: <CAOQ4uxhNhmGrb7_Lwp9pt-hyaBUQz9++PH0KR1r3=cjKVCJJfQ@mail.gmail.com> <20231120101424.2201480-1-amir73il@gmail.com> <20231120165646.GA1606827@perftesting>
To: Amir Goldstein <amir73il@gmail.com>
Cc: dhowells@redhat.com, Josef Bacik <josef@toxicpanda.com>,
    Christian Brauner <brauner@kernel.org>,
    Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
    Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: move kiocb_start_write() after error injection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2457304.1700511572.1@warthog.procyon.org.uk>
Date: Mon, 20 Nov 2023 20:19:32 +0000
Message-ID: <2457305.1700511572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Amir Goldstein <amir73il@gmail.com> wrote:

> I'll use whatever the maintainers of cachefiles and vfs prefer.

I'm working towards testing your patch.  Using IOCB_WRITE as a flag like that
does seem a bit weird, though.

David


