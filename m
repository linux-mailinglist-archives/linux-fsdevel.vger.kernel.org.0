Return-Path: <linux-fsdevel+bounces-71730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3BCCFCC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C8830F4C2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6BB3242BD;
	Fri, 19 Dec 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc94ZLnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAB32340D
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145825; cv=none; b=bRpg55JMBLh4JRZXc1NLbiEl74g1rHafvU9RHyw/iUmp5/RMQ7MP0ljKu8MlrND0t8S6zqFyAd5hlXYITlg6/eLOG2Kh5BlSFg3sHZIHBlH/7VbloiWrdlHJeq0hFLfF65nGDKDFJiNCzLM6NYliNNjUM/964UF3Bnh4q/st9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145825; c=relaxed/simple;
	bh=YFvGT7PS5q3O7lga4AU1uPhY7KUKky+K5vEq8RBLbQo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bj09r1vvdjrFo8vaTyl6I2mYVIWKMd6zagZXWgW+IHmy+SG1mw3lWboYeH0h77l4Sb0mWfy2ceb1eCSGirButDdT+kL1d+4LRe9riDXXnyiMEi0T9IUir6L25b2zYAMaO7gKi/v4KTFQ8HUIDDq62cT4GzNm8FTgub3xqLjZcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc94ZLnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766145823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EYx76SgRqxLyI8UZcz48rb07fztIJOHbJHyqiMlG2Fk=;
	b=Hc94ZLnqwo6J5xgb1HUJT2z/GfDT2+yIA6/6XmIlidjmrtd11oJg/qq75sY7I4Qnx1Jeiu
	kYjA0dzzE4xdRgi8jd1hErTgXTazsvYgOiITpk7GqxVJP8GBR83KnTHrwzDUiHjl0yonBT
	aaFM+0lp6cElTZ8IZH3JHXF28KxSwWM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-f8gBi4v-NUS77fblkdUBmA-1; Fri,
 19 Dec 2025 07:03:39 -0500
X-MC-Unique: f8gBi4v-NUS77fblkdUBmA-1
X-Mimecast-MFC-AGG-ID: f8gBi4v-NUS77fblkdUBmA_1766145817
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE8501955E75;
	Fri, 19 Dec 2025 12:03:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 620E11956056;
	Fri, 19 Dec 2025 12:03:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aT-59HURCGPDUJnZ@codewreck.org>
References: <aT-59HURCGPDUJnZ@codewreck.org> <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org> <aTkNbptI5stvpBPn@infradead.org> <aTkjWsOyDzXq_bLv@codewreck.org> <aTkwKbnXvUZs4UU9@infradead.org> <aT1qEmxcOjuJEZH9@codewreck.org> <aT-iwMpOfSoRzkTF@infradead.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
    Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
    Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815090.1766145812.1@warthog.procyon.org.uk>
Date: Fri, 19 Dec 2025 12:03:32 +0000
Message-ID: <815091.1766145812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Dominique Martinet <asmadeus@codewreck.org> wrote:

> FWIW I tried logging and saw ITER_BVEC, ITER_KVEC and ITER_FOLIOQ --
> O_DIRECT writes are seen as BVEC so I guess it's not as direct as I
> expected them to be -- that code could very well be leftovers from
> the switch to iov_iter back in 2015...

ITER_FOLIOQ should only be seen from buffered I/O.  For unbuffered/direct I/O,
user-backed writes are extracted to ITER_BVEC; kernel-backed writes are
sliced, but the original iter type comes down.  For the moment.

David


