Return-Path: <linux-fsdevel+bounces-31181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D588992E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D65728513F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F51D54DC;
	Mon,  7 Oct 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8lQeKyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031C1D433B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310470; cv=none; b=p5ZeqkFkZDge6RDPVvpxkpsOSp65oonRY+aK+SBGukR+XHWeNaw+EJoI//gTm5cB97t3Hw+W+7orgLKbDLs+hUqapcEoepR5PQ9XWMF5BKiDsdx+ZOWJ12Y7eozASJUsTLxvZWnq0YYlpPV0aW0/4ULHbWDYlblGpPkBJGQqPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310470; c=relaxed/simple;
	bh=cJemGfwZyHNY1kxySOVnHRQQ2tTifsH9BibEDnrtH2k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EKQIby2g5etl6CIFLqFSvJGIqvdEDsWuC7Lwu5ziKXB4Lq37vCRRagkZKDurgrChXFg/+QQilLuPitShlxiEf3Htx1j7rbZxCC4J5PYTxJgA4qjY3AT2FaNcyAyBu7oYqgDQAeiOH9f+eCXkMu5XW88t2JLphpfLWvhxpqtcUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8lQeKyt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728310467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB5U/JK8RuMoT89COtVe77/CsHzJ8bZXi54dT2da9hU=;
	b=I8lQeKytyLeRZgOkLVHNDO/7M4DMrqiG9ImW3eJGBeNmPtCjVvcIOPXYkaY5AAfSRvTvmF
	2i9RopUF656Clh5kwCww/HbSVAbGIRWGyBvt8HcBP+mbnNNEyKSJAkNcVLM3FMaw7J4nse
	lDfW9Q+vGqQ7dNSnSLLiICeSXNOoF3I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-dQw52g0WONa9Qnn2giiyMA-1; Mon,
 07 Oct 2024 10:14:22 -0400
X-MC-Unique: dQw52g0WONa9Qnn2giiyMA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D87061955EE7;
	Mon,  7 Oct 2024 14:14:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B530E1956089;
	Mon,  7 Oct 2024 14:14:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241005182307.3190401-3-willy@infradead.org>
References: <20241005182307.3190401-3-willy@infradead.org> <20241005182307.3190401-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] netfs: Fix a few minor bugs in netfs_page_mkwrite()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4027712.1728310458.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2024 15:14:18 +0100
Message-ID: <4027713.1728310458@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> We can't return with VM_FAULT_SIGBUS | VM_FAULT_LOCKED; the core
> code will not unlock the folio in this instance.  Introduce a new
> "unlock" error exit to handle this case.  Use it to handle
> the "folio is truncated" check, and change the "writeback interrupted
> by a fatal signal" to do a NOPAGE exit instead of letting the core
> code install the folio currently under writeback before killing the
> process.
> =

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through =
netfs_page_mkwrite()")
Acked-by: David Howells <dhowells@redhat.com>


