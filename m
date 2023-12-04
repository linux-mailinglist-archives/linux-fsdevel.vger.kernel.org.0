Return-Path: <linux-fsdevel+bounces-4725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE9802AE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 05:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA581F20F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4891EB33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhFhRnXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1227AB6
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 19:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701659979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/8NhmEkKsnS3yGp4kPzlQrXQUn9SGOxqKqcsuy2+78=;
	b=GhFhRnXJ4qZoENMoJY8g1gxaTjTnsCtZKvLNpCiwY3jK/y3QtVr60h/lJ3yzPEPOlSOZG1
	QFVDhenEsjnIi1teHP0T4WUdL9PVlxFi4yeCd3XIrTjvuCS9Nrw1HzEIxZ/Zp/QP81PFkQ
	7+u51o/geI9LzqdKWjpMYzr2EfQNbMY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-GsIBFQb0P16dN48r9X5BBw-1; Sun, 03 Dec 2023 22:19:36 -0500
X-MC-Unique: GsIBFQb0P16dN48r9X5BBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24CEC8007B3;
	Mon,  4 Dec 2023 03:19:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A2001C060AE;
	Mon,  4 Dec 2023 03:19:24 +0000 (UTC)
Date: Mon, 4 Dec 2023 11:19:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Message-ID: <ZW1FOFWsUGUNLajE@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-3-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
> We rely the block layer always being able to send a bio of size
> atomic_write_unit_max without being required to split it due to request
> queue or other bio limits.
> 
> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
> and each vector is at worst case the device logical block size from
> direct IO alignment requirement.

Both unit_max and unit_min are applied to FS bio, which is built over
single userspace buffer, so only the 1st and last vector can include
partial page, and the other vectors should always cover whole page,
then the minimal size could be:

	(max_segments - 2) * PAGE_SIZE + 2 * queue_logical_block_size(q)


Thanks,
Ming


