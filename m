Return-Path: <linux-fsdevel+bounces-585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCE7CD297
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 05:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D41C209FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779D46BE;
	Wed, 18 Oct 2023 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6PcEUsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96951FB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 03:16:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF7FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697599013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNOG677PLDM35qlf3oa8HmbCc7NNWIlZZfhXqpVgxTI=;
	b=P6PcEUsnVY2E5uNkwbkvglXrcFMOP+d2B/cilVzwLRNDSj0OOLLdQJDZocL3XznArJg2aW
	9keZw1IqJcMi/N/pE2u15yzmR7yrDsA+zzDTS6hAWoh0kPGO9RfXEnlaUy1Ox8fRoqWY5k
	anvjjT/AqlP9grHf50CfcTnD3fWCmHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-sqhNt7EjNA2prCEusHuBeQ-1; Tue, 17 Oct 2023 23:16:39 -0400
X-MC-Unique: sqhNt7EjNA2prCEusHuBeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95B2C882387;
	Wed, 18 Oct 2023 03:16:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 60B3B1121318;
	Wed, 18 Oct 2023 03:16:33 +0000 (UTC)
Date: Wed, 18 Oct 2023 11:16:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <ZS9ODABLaRVcI5iy@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:48:21PM +0200, Christoph Hellwig wrote:
> disk_check_media_change is mostly called from ->open where it makes
> little sense to mark the file system on the device as dead, as we
> are just opening it.  So instead of calling bdev_mark_dead from
> disk_check_media_change move it into the few callers that are not
> in an open instance.  This avoid calling into bdev_mark_dead and
> thus taking s_umount with open_mutex held.

->open() is called when opening bdev every times, and there can be
existed openers, so not sure if it makes little sense here.


Thanks,
Ming


