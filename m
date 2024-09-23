Return-Path: <linux-fsdevel+bounces-29822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5197E665
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 09:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4711F21662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2212450EE;
	Mon, 23 Sep 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiqfskaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB71FDA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727075554; cv=none; b=h3IkQ5s5XRlyHMhXac7geq5EUysjDQH15i6uhfcxV+SXCOdEVhMb64R7VWsdDmRScuLv4YioXuAwXuH4VszmqjA8pfBPKqBg2KEQNDNCVgSMmcCqDv5HST0zEQRRAFbk5FYzwy2BQzEPYZ9wCHQ/2AqMLCwgJ9uBXzwrXnVJgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727075554; c=relaxed/simple;
	bh=fkZNeFuPSOC4vkOBo7pLVMQrJchoOMHZAH9Io4Wvs6w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=MAXoF7vB9uYUQHmmfH3D+gdpaMW72PJp8843kctAKk9Z4gJMjMQYWqJNhZGlPTJVCyJ+uY8ShA4UyweqaQVUD52jnt3u2OgHTHs0C7qbaNBOYA6WlXbfgr1gdrpkxALt3Ej1Kh44fZmW8usWuYX0nigbBNbUFnxHhqu4f7FqE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiqfskaM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727075551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkZNeFuPSOC4vkOBo7pLVMQrJchoOMHZAH9Io4Wvs6w=;
	b=MiqfskaMQ20Z/TUjbx1NKeHsM5Mu0al+PTLlnarxf4gqxwJ7sZGIQs/RM3tBz33FJ6BAdM
	aoNNmLkj7UIpsOMIuUHLN7yHVoz0uEuqnKD+PtKI0/e4jRelfm+KIgXPujENyPTYJn6rOy
	3Qxgoor67K6+YbeKRLTwGSD4YRhO7ak=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-mzblnrthND26R9sZBvRIqg-1; Mon,
 23 Sep 2024 03:12:27 -0400
X-MC-Unique: mzblnrthND26R9sZBvRIqg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAA5C190DE27;
	Mon, 23 Sep 2024 07:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7D693000235;
	Mon, 23 Sep 2024 07:12:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zu4doSKzXfSuVipQ@gmail.com>
References: <Zu4doSKzXfSuVipQ@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <743843.1727075543.1@warthog.procyon.org.uk>
Date: Mon, 23 Sep 2024 08:12:23 +0100
Message-ID: <743844.1727075543@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Chang Yu <marcus.yu.56@gmail.com> wrote:

> Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix
> a KMSAN uninit-value error in netfs_clear_buffer

Btw, is this a theoretical error or are you actually seeing an uninitialised
pointer being dereferenced?

David


