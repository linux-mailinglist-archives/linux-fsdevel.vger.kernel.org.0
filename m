Return-Path: <linux-fsdevel+bounces-9969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6A846B42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAE61C215CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD9604DA;
	Fri,  2 Feb 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRBViAH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEB17BCD
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863894; cv=none; b=YkJRPI6Vjd3JDs0tWepRscZvh98dEHR5nHt/rg7xuvk8DhSRcCyYGTV4lCXFL++uxYPlZn7aCd20lwDQhDu29xhqmWJn1FCreE4mlT0IA6SPeCqASiUmxFzGKfR+v6lPq+fKbcHRS6738i/MdzaGXgYtoyH9V4FyxF074ful/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863894; c=relaxed/simple;
	bh=PG2zgEJDFQ1/8J6qd/Sv6uwo0RbEngsGO7IWR1dFojo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=qqAbqWGft6ktBbM8lrtgKN5DA0MkAucoRgzo6PfNiSmfLQ3f/lajmskxXlfNQeLxnfEXuzukSjrz9PZq4wO11AQNpzdoO6iEq3dcwcJMXZsh/0gk4guXpMuvR+7B0tu8UbYd1BR4t/fD+2VE9y/IPtM941w91PZU99PHOsUaL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRBViAH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706863891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=F6Prs1QlwLvlmms9iMnqYJXnd32DxIjB6bHAEUH6zXI=;
	b=jRBViAH1Uq9CUGQk6gM27A38ctpH3qOM/CYZFMpVsfh8NdoMWbNzfr0gKDMiEgwQ199YlN
	clrI5bgQUEGFDcsFAtklrowreUIGCNgJfAm1Ef0fC1JXmYNOX+OPhXl2LexaNQ7xrp+ocE
	8W7/btog6c61UQ20lx7ySd/tyw5yaUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-T_-YDuHrPHuHADsnKQu_5w-1; Fri, 02 Feb 2024 03:51:29 -0500
X-MC-Unique: T_-YDuHrPHuHADsnKQu_5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8492585A58B;
	Fri,  2 Feb 2024 08:51:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D4F72166B31;
	Fri,  2 Feb 2024 08:51:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: lsf-pc@lists.linux-foundation.org
cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions of uninterruptibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2701317.1706863882.1@warthog.procyon.org.uk>
Date: Fri, 02 Feb 2024 08:51:22 +0000
Message-ID: <2701318.1706863882@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi,

We have various locks, mutexes, etc., that are taken on entry to filesystem
code, for example, and a bunch of them are taken interruptibly or killably (or
ought to be) - but filesystem code might be called into from uninterruptible
code, such as the memory allocator, fscache, etc..

Does it make sense to replace TASK_{INTERRUPTIBLE,KILLABLE,UNINTERRUPTIBLE}
with begin/end functions that define the area of uninterruptibility?  The
regions would need to handle being nested, so maybe some sort of counter in
the task_struct counter would work.

David


