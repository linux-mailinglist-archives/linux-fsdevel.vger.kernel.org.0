Return-Path: <linux-fsdevel+bounces-31532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26F9983C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BEC1F256D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99731C1AB4;
	Thu, 10 Oct 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+gcU4+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85019E7D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556515; cv=none; b=bl8xY4zI+ApmqJHhykuYsZHfvM1Sf/No2u+mJRpo8sAfILvBIqi+VwXBaOUG/ChCequUVVHNqoePy6vtIOATnU8kyW9W+bbGra2FBFp63p32gZ93AC1EPJZZaraZ4afBF8hUOAGZJG71OFoF+Wf14gfnr4fQepxaRxsxzqL4T7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556515; c=relaxed/simple;
	bh=Dq0XgAclNRaJbXT+vHvoLMbbmE+OqMekcNjkPra9cUI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=AEkrINq7PWfYAt8nZvlYphfKG+im4qEkFrya1YEBO5iSox9Z/S9JFM7YO8yH8ryA/bPfdRHAw84e7j2rdfxP+3rzD4RTv0MxQpFQmi5SnWOdCCMOeVk/YzhC6DjqCSMp0n0fFDI9nmdgz4HPB3Kiozc7s0nTHSaJ3SJQjUCJCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+gcU4+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728556512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx+kPV8292G/Dzt3BTlua2EqMJ9Klq9hxRZJVfmtfTU=;
	b=h+gcU4+FEJkni+BQ0j1xQNOe/2M0p3Wtm6dyHyTx1P/jbIPoyAuUQb87chkHZ3b4+jbSYu
	C6DmM02HP8NVJgQIT3jvL5bPjKG2k1J6JIUBem7+s6cHb0a4IOo2w9JKLjLDH/XQ0NLZrH
	ytIBY1Cj2b2h1FLfU8g3M1cvuYxdC6U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-dLh36eegOY2DWn475u0HWA-1; Thu,
 10 Oct 2024 06:35:08 -0400
X-MC-Unique: dLh36eegOY2DWn475u0HWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 518751955F3E;
	Thu, 10 Oct 2024 10:35:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08CA11956089;
	Thu, 10 Oct 2024 10:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-2-wozizhi@huawei.com>
References: <20240821024301.1058918-2-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in __cachefiles_prepare_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <302545.1728556499.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 11:34:59 +0100
Message-ID: <302546.1728556499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the __cachefiles_prepare_write function, DIO aligns blocks using
> PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
> cache->bsize with the requirement that it must not exceed PAGE_SIZE.
> However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
> count will be incorrect in __cachefiles_prepare_write().
> 
> Set the block size to cache->bsize to resolve this issue.

Have you tested this with 9p, afs, cifs, ceph and/or nfs?  This may cause an
issue there as it assumed that the cache file will be padded out to
PAGE_SIZE (see cachefiles_adjust_size()).

David


