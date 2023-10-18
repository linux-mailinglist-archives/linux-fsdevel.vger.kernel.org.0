Return-Path: <linux-fsdevel+bounces-597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171D7CD8A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB921C209FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4B18649;
	Wed, 18 Oct 2023 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOO9Kuk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1C18049
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 09:53:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF3B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697622815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/9KDbwRJFqBl0mAH+HE56sreJMIIRxOC1082s49hO8=;
	b=XOO9Kuk65SYaKqx+P2gLyFRcJmPehcdgktgmd5pUfCStxOZolbKYu+BaRVLi3/ULFNJWii
	aELJdq+AROgO8u2X7RNvVn9Fg+wcf30yTi8YVQL/oXxfm3ymYIYdTHk97gDr/lY5BYBY7Q
	guzNIjqEm5OZzNwEx+vGzl7Oo037aQA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-BEyT9dudPFW-u9DdyhfEMw-1; Wed, 18 Oct 2023 05:53:34 -0400
X-MC-Unique: BEyT9dudPFW-u9DdyhfEMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D38C23C1CC3B;
	Wed, 18 Oct 2023 09:53:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 041472166B28;
	Wed, 18 Oct 2023 09:53:28 +0000 (UTC)
Date: Wed, 18 Oct 2023 17:53:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: assert that open_mutex isn't held over holder ops
Message-ID: <ZS+rFPhDoS5yuvS2@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-6-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:48:23PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> With recent block level changes we should never be in a situation where
> we hold disk->open_mutex when calling into these helpers. So assert that
> in the code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming


