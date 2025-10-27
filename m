Return-Path: <linux-fsdevel+bounces-65717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F7C0E678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC1C3BAB2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7AF307AC3;
	Mon, 27 Oct 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehE6hBRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F21E32D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574616; cv=none; b=hRW0h+ue4gPnZ8qZNvPId4bPvzSJhptrUyrHgijmhBchJF7ciy+EXtsyPQBjuzgexq07kaTsoKiTL1g3+0O/AL7RE/8kUXeQ2n67B1AU68AgCTfo8LxbZsVag8nGnv1hrYppGj9tHv0sNuDyVZX0ybKulP6/G86ff9g41cLJ3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574616; c=relaxed/simple;
	bh=Dw07KsxDMWK6q+1bhz3mU9heARrzOdVTlBmyFJYnSmI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HjNOit43REE8Wb0cGpoEAAQea77w6dyD08oA/AvruUruC5ikKfeLZYT9UOFqQccxd6+4XmoeQPbZ9m0HNu0DGN5vDNhFrCay0Hc7DYnBKYOd/Ss3or9CxxEgB0rmoVMfA/gFygRZxWenSeK84Qye/Cc0PeRVC1zuFAP+J3zkqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehE6hBRE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbCNymmtAjHzkTy2SVLqM8Su4bRxtmTnw/VNxtUHjlM=;
	b=ehE6hBREeHAtHmlYZkBnp0e12sycqiRQcPlySH8Ps1Ec6cQa4+xP3ibNkZiSExKfpNzUbJ
	fSDfPTnG0C5/VOjkCORnIyrcfyEc0gBXz5MzNJUSzRZaQ+ITNK6fGvGT/YpVUaT5e+jnbZ
	tKIs6p2Ie1YsbACFvg2/AgOmrsR3GFA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-NKKEwCypPy2h8Oh52ec7Xw-1; Mon,
 27 Oct 2025 10:16:50 -0400
X-MC-Unique: NKKEwCypPy2h8Oh52ec7Xw-1
X-Mimecast-MFC-AGG-ID: NKKEwCypPy2h8Oh52ec7Xw_1761574609
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E9C6180121B;
	Mon, 27 Oct 2025 14:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE84919540EB;
	Mon, 27 Oct 2025 14:16:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251024170822.1427218-9-willy@infradead.org>
References: <20251024170822.1427218-9-willy@infradead.org> <20251024170822.1427218-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev
Subject: Re: [PATCH 08/10] netfs: Use folio_next_pos()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2253015.1761574605.1@warthog.procyon.org.uk>
Date: Mon, 27 Oct 2025 14:16:45 +0000
Message-ID: <2253016.1761574605@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.

Should that be noted to the gcc bugzilla as a missed optimisation?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Paulo Alcantara <pc@manguebit.org>
> Cc: netfs@lists.linux.dev

Acked-by: David Howells <dhowells@redhat.com>


