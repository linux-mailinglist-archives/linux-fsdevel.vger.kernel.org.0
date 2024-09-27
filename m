Return-Path: <linux-fsdevel+bounces-30284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D63988B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1ACFB230CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95711C2DC8;
	Fri, 27 Sep 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4EQhqTr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC51C2DC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470236; cv=none; b=VeFNQDrqXuqTtDNoV/y/VYQJVX0kzWRVRmJB5QtSO30Zm1gJb3hAvWmb6ttifDjdyq8XSZiUMLCbYPrq3zPsNb+J5gqNV7GZJ+EynpvYtgTc/HfhHXHcsbgqR0KNa6on+vmHcBTVCC8jIucsh/WoGjYQT6VQ/vV9ornNn4vE9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470236; c=relaxed/simple;
	bh=Ehr+2NKsngL7ZGsFX4D84MvJxLhbtVlSuY/MGkYSJZ0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sC1tWcYQXybZftddMD7T4cojmQwSng+AS/IGgS8bPQKRifCbIhilSurjsRx14S4pVa+vLX4X8rC8ORs4OUe+j/S072y8vHMaTFLT1GWd1r7N4L236yfF0R6IeX0aovn9JvqIbbT9OGxNa2BxqA99PDA1erkPWfPgOdKYRx4AH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4EQhqTr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727470231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ehr+2NKsngL7ZGsFX4D84MvJxLhbtVlSuY/MGkYSJZ0=;
	b=E4EQhqTru6oQ5IKYFUWuX8uIJH26XaLONrIfpbHXwC+X6rAdVTk4nNto7xviPl8FDzCA+M
	yKTyVO90fXjXDdVSv5PKwL5KhyOJKQ+6YHKnGTsPw1GSyFICNTSfRlyeTcmxsP78YkWabm
	C/rLtXxn8RcS8VzeGmWU8dm//2n65mk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-peQ0JcNLMAKLyO6YtwYCog-1; Fri,
 27 Sep 2024 16:50:27 -0400
X-MC-Unique: peQ0JcNLMAKLyO6YtwYCog-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C38818DEF1D;
	Fri, 27 Sep 2024 20:50:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A0421956086;
	Fri, 27 Sep 2024 20:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com>
To: Manu Bretelle <chantr4@gmail.com>,
    Eduard Zingerman <eddyz87@gmail.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org,
    ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
    hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2663728.1727470216.1@warthog.procyon.org.uk>
Date: Fri, 27 Sep 2024 21:50:16 +0100
Message-ID: <2663729.1727470216@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Is it possible for you to turn on some tracepoints and access the traces?
Granted, you probably need to do the enablement during boot.

David


