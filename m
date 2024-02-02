Return-Path: <linux-fsdevel+bounces-10000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B90846EDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F45D1F2229C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6113D506;
	Fri,  2 Feb 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN/uC2em"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823D13A273
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872947; cv=none; b=PcL32tDhvtuLsBUEG2+HdH0dfkOUly5viZJux/SUicbVkMvlqlsfq/6ER1xjVcFhlRgZ8M+I96/0KWpg0qKlyXb9rfSZ897BT98WeLlnglBdhpy4u8IUHcG1LjLxXfAIAZM5jMcr/iearsvuaKhvilZeVA/kd4D/G0kHchGphug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872947; c=relaxed/simple;
	bh=Aag6raK7hvU6x+VLLg0f33CenZ348rXkUJwqgKNZBwM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ePzluRFPrwAHYf97JaOieiv4an3UPjcZLzc6snHzU6j+uKOq0ePyfrk2e9gIRaWgUTWjGw7AE02kQRNPcr3/Hg/H3+kzMCeoFybI5nM9Ohi3ZjToSERlu1RmrA2dyHV3ZcRw2tpnEYJfjr8AVJdxa2g+MmhN+8aFAtllSiRfbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FN/uC2em; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706872944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phAeAzLfyQ/CrxIFbQUdpYZ4of5jPIIreKqGaxUEUC4=;
	b=FN/uC2em2u1VcpMJCHSOQ6fYeE/gMI4qdhdcei0+3K30VVBy1TXEkIo3N5n/2cBDTyacbg
	ksLWBmPW1cWnbt2HSUVN/NM8v72J3603q8PKuw6ijvbxLS71XQiLy09maZsMgeZf66R6wR
	Ji9lXQr6baCiHUJcBTEwzo8p1pPTmkE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-0nH4mioWNhGzdV6rQVrNLw-1; Fri,
 02 Feb 2024 06:22:21 -0500
X-MC-Unique: 0nH4mioWNhGzdV6rQVrNLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECE3329AA2D1;
	Fri,  2 Feb 2024 11:22:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 06A27C2590D;
	Fri,  2 Feb 2024 11:22:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com>
References: <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com> <2701318.1706863882@warthog.procyon.org.uk> <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com> <2704767.1706869832@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
    Matthew Wilcox <willy@infradead.org>,
    Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions of uninterruptibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2751705.1706872935.1@warthog.procyon.org.uk>
Date: Fri, 02 Feb 2024 11:22:15 +0000
Message-ID: <2751706.1706872935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Just making inode_lock() interruptible would break everything.

Why?  Obviously, you'd need to check the result of the inode_lock(), which I
didn't put in my very rough example code, but why would taking the lock at the
front of a vfs op like mkdir be a problem?

> For overlayfs it doesn't really make sense, but for network fs and
> fuse I guess it could be interesting.

But overlayfs calls down into other filesystems - and those might be, say,
network filesystems that want to be interruptible.

David


