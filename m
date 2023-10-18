Return-Path: <linux-fsdevel+bounces-582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FA7CD24C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544401C20CF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 02:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD98F69;
	Wed, 18 Oct 2023 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz5OV1fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC48F4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 02:33:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575BF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 19:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697596422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+c7XWwfI5su+KU5JFMXH8S0BZEAJVg6AFCq5tfYLl9A=;
	b=Wz5OV1fi0TsxJHgTZp93KTaW4KYIgG0OzJRBxpPkJZtZs7eVKeWHAaAPr4OXU2HiM76oFc
	ZzqNmhVbtLdLvu1B+ZxBI3u1at64bAHTkIprE96mgijq9LQXB4Z9+t/9he5atmD+1QwHe3
	lK8gluhEbRV3ug8nmpBf7j9HxWEDP7U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-EXWTGxTeMoudEzIsDeXLoQ-1; Tue, 17 Oct 2023 22:33:38 -0400
X-MC-Unique: EXWTGxTeMoudEzIsDeXLoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C7EF10201E5;
	Wed, 18 Oct 2023 02:33:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6698440C6CA3;
	Wed, 18 Oct 2023 02:33:33 +0000 (UTC)
Date: Wed, 18 Oct 2023 10:33:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] block: simplify bdev_del_partition()
Message-ID: <ZS9D+LDJGHnP6BKi@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:48:19PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> BLKPG_DEL_PARTITION refuses to delete partitions that still have
> openers, i.e., that has an elevated @bdev->bd_openers count. If a device
> is claimed by setting @bdev->bd_holder and @bdev->bd_holder_ops
> @bdev->bd_openers and @bdev->bd_holders are incremented.
> @bdev->bd_openers is effectively guaranteed to be >= @bdev->bd_holders.
> So as long as @bdev->bd_openers isn't zero we know that this partition
> is still in active use and that there might still be @bdev->bd_holder
> and @bdev->bd_holder_ops set.
> 
> The only current example is @fs_holder_ops for filesystems. But that
> means bdev_mark_dead() which calls into
> bdev->bd_holder_ops->mark_dead::fs_bdev_mark_dead() is a nop. As long as
> there's an elevated @bdev->bd_openers count we can't delete the
> partition and if there isn't an elevated @bdev->bd_openers count then
> there's no @bdev->bd_holder or @bdev->bd_holder_ops.
> 
> So simply open-code what we need to do. This gets rid of one more
> instance where we acquire s_umount under @disk->open_mutex.
> 
> Link: https://lore.kernel.org/r/20231016-fototermin-umriss-59f1ea6c1fe6@brauner
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

inc/dec(part->bd_openers) is always done with ->open_mutex held, so this
change is correct.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


