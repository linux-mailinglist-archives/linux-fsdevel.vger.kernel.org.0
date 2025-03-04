Return-Path: <linux-fsdevel+bounces-43054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C8A4D742
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C33AF822
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D381FF5F4;
	Tue,  4 Mar 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agXECyeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D871FF1D6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078628; cv=none; b=XSKhZU7RUo8dHqHaWKyKXolo5y3yHwx3dZw5ISO0MvxLJzbl7CidVOtYMB87Ocl4vNETxbFay94lDDpJKZCFhaX+uN8XeTawaHNEk/AJjt5CwxovPuWg3vJdT0nQf8ZC6dgViUs1wTK5JASvk4BkTsqV5yl1bSevtZR/HILNDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078628; c=relaxed/simple;
	bh=iIdv6eNzgkagVbJqygA4QNukH04qGBrDmzJ2SlgWYfA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m9nCbYJvi6PpCCQLIS7H/kGAZEDjrfOxLqbgAcufRaNFjvFRWu2MDmuSqelnHlPjDlGtKgc0LgQZt7aM4QHlZ9tumHI/vKIua0ASZ65QrynoiNoz8wXjvBC3dNZprMUWhadMyB9xrPjvZrWfj3mYVnzIhuzcQVaMh9/wS1WLMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agXECyeq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741078625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRWtDAlRoZ9ktZzzbYRiu+U+owxQoQLPZFPHwWfX9HM=;
	b=agXECyeqJzv24YcZ3yj9zoOXmopIWt3QEeUST3jjD9lJOz90IJJ77/aS682IxboF/2VoHf
	W+e73DtcH0RZx5By6ATsUi1MIcD4Ox4Wh6A8zlFAVp2Ai+UzXdU+efVF1yasDfBZKZXv45
	EIB5CjQ+yA64PeCdXMwEMMzwUckBM8Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-aWNY7MbwNASREKHFaVu91w-1; Tue,
 04 Mar 2025 03:57:03 -0500
X-MC-Unique: aWNY7MbwNASREKHFaVu91w-1
X-Mimecast-MFC-AGG-ID: aWNY7MbwNASREKHFaVu91w_1741078622
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB2051944D33;
	Tue,  4 Mar 2025 08:57:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42A6D180035F;
	Tue,  4 Mar 2025 08:56:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250303203137.42636-1-slava@dubeyko.com>
References: <20250303203137.42636-1-slava@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, amarkuze@redhat.com,
    idryomov@gmail.com, linux-fsdevel@vger.kernel.org,
    pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [PATCH v3] ceph: fix slab-use-after-free in have_mon_and_osd_map()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3896160.1741078617.1@warthog.procyon.org.uk>
Date: Tue, 04 Mar 2025 08:56:57 +0000
Message-ID: <3896161.1741078617@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> +	mutex_lock(&monc->mutex);
>  	kfree(monc->monmap);
> +	monc->monmap = NULL;
> +	mutex_unlock(&monc->mutex);

I would do the kfree after the locked region:

	mutex_lock(&monc->mutex);
	old_monmap = monc->monmap;
	monc->monmap = NULL;
	mutex_unlock(&monc->mutex);
	kfree(old_monmap);

David


