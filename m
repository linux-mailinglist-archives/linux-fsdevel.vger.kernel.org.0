Return-Path: <linux-fsdevel+bounces-31544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC599984F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFF71C2410C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965251C331C;
	Thu, 10 Oct 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4/ZDpfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5E1C2DD4
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559586; cv=none; b=W13ISv/L5mjBibhJ/gmlAwdrYH0xXjXdZVIWmJ+xtVpANz2B9aB8IPXnmyH6g/h/tgVcWXbD2NL0w3R6cxLlBDgs0rweb2Hvf9ChhxUk4HItlSYQwWhSoIMwN9ZsxZaapstVJmzY1h9kpXxyUdG90wEHdksGcEvuDe2dJ4FIURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559586; c=relaxed/simple;
	bh=10vTDP77W6iT8wnZVG2NLG1W63L7dkmUAZsW2OhEe4U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PEDqVPo+F+IYKnPEA0lFEXumV2yWMLGyCLdjeiKROxhY2quj5AlUVI1ZMs2GxVo5iP6pYwCtF7wYh00wAi8D4QcflVVthuoGXkPdaPakgpuf2kv8aRNAtttuT1pbdv/+3ndlZG+yFRx5UnFBXExAWlL9CbPT+M5hzAtJTTWeDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4/ZDpfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJUmRu+1qjEf0r4E7oHDRAPSAR+s1Bygz5pulK3ypfw=;
	b=W4/ZDpfJvKMG/o0oL7IOPnpFeHUMpQCQtJlBkUha+xiUB4CJqbSUOiPsz+BzyzVUo73LbI
	Azrq09NrXecqotYqU3RqLCEzsJ5XTsPaMl62lm9XWw4C+Thr8d1CLvjhodb2vBX4GyFlpl
	UvVR8D5PajrjOXJcymaY3lT5xxrsYbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-NFOnjL-PMtKPIBAhYDEK-w-1; Thu,
 10 Oct 2024 07:26:18 -0400
X-MC-Unique: NFOnjL-PMtKPIBAhYDEK-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD0E419560A2;
	Thu, 10 Oct 2024 11:26:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B56781956086;
	Thu, 10 Oct 2024 11:26:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-8-wozizhi@huawei.com>
References: <20240821024301.1058918-8-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in object->file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303976.1728559565.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:26:05 +0100
Message-ID: <303977.1728559565@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Zizhi Wo <wozizhi@huawei.com> wrote:

> +	spin_lock(&object->lock);
>  	if (object->file) {
>  		fput(object->file);
>  		object->file = NULL;
>  	}
> +	spin_unlock(&object->lock);

I would suggest stashing the file pointer in a local var and then doing the
fput() outside of the locks.

David


