Return-Path: <linux-fsdevel+bounces-48756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65673AB3B5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 16:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DBF188C92C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494622B8C2;
	Mon, 12 May 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cclw+Gxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D6E22A1EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061506; cv=none; b=MEmrkbHfaJPStTzMlTpYvRli8Mlp/DZV95woBauteVhPr2iiKPxTY9YJQHoH+lKhfdtHiX22p1XMKFctM6A4nNjt1bUlfZHvD0leAMp5xD38zVk0nqLuyqY4atB7sUvRdXaye5vXw+sLF0sCkb1LXjZnYtYCH09QHLWZHQ6BosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061506; c=relaxed/simple;
	bh=skKPBy1kNvIiJYBQKiVWoH27pofu9c5eyYPy/uPCdpQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ut61XSYASYMcBAd+znQcYOzCcX3Tw4P3OMiMBSAMIkTfZ5FBE+ZCAjyFYdIcI3tP/LHx0nrOWnrhAiL2xgUeLUHkXK1lUeH6LA050SDJhqT6exyh96MWfkAl9+YqjxZ2UNqUNysaY3zEkYIWSETaNcgDULNbzP191Td0YD8SXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cclw+Gxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747061504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymBHISBoRGTxFMCkiuee6KTKTNeCUMLWNl/W6hAI6Kw=;
	b=Cclw+Gxw0j0PPCRe2mu2zz6G+FpOOLIrPTUfykWOMk5e/fODW1DDLrIXcRbOboiRiuVsRj
	+9KRClTFuB9TnMlVgJnLWf91Zg+INo0gc19239sXoSJcqqQX6VJaqbXCvM61fe3X3E48s6
	Nj0w3AXR1ue4w2R8mcaOXvPLUP21GuI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-kDroPQX2Oc-xfnwc7e4WeQ-1; Mon,
 12 May 2025 10:51:40 -0400
X-MC-Unique: kDroPQX2Oc-xfnwc7e4WeQ-1
X-Mimecast-MFC-AGG-ID: kDroPQX2Oc-xfnwc7e4WeQ_1747061498
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 653311955D7F;
	Mon, 12 May 2025 14:51:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFD7030001A1;
	Mon, 12 May 2025 14:51:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1069540.1746202908@warthog.procyon.org.uk>
References: <1069540.1746202908@warthog.procyon.org.uk> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dhowells@redhat.com, Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>,
    Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
    Christian Brauner <brauner@kernel.org>,
    Al Viro <viro@zeniv.linux.org.uk>,
    Miklos Szeredi <mszeredi@redhat.com>, torvalds@linux-foundation.org,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2135906.1747061490.1@warthog.procyon.org.uk>
Date: Mon, 12 May 2025 15:51:30 +0100
Message-ID: <2135907.1747061490@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I'm looking at how to make sendmsg() handle page pinning - and also working
towards supporting the page refcount eventually being removed and only being
available with certain memory types.

One of the outstanding issues is in sendmsg().  Analogously with DIO writes,
sendmsg() should be pinning memory (FOLL_PIN/GUP) rather than simply getting
refs on it before it attaches it to an sk_buff.  Without this, if memory is
spliced into an AF_UNIX socket and then the process forks, that memory gets
attached to the child process, and the child can alter the data, probably by
accident, if the memory is on the stack or in the heap.

Further, kernel services can use MSG_SPLICE_PAGES to attach memory directly to
an AF_UNIX pipe (though I'm not sure if anyone actually does this).

(For writing to TCP/UDP with MSG_ZEROCOPY, MSG_SPLICE_PAGES or vmsplice, I
think we're probably fine - assuming the loopback driver doesn't give the
receiver the transmitter's buffers to use directly...  This may be a big
'if'.)

Now, this probably wouldn't be a problem, but for the fact that one can also
splice this stuff back *out* of the socket.

The same issues exist for pipes too.

The question is what should happen here to a memory span for which the network
layer or pipe driver is not allowed to take reference, but rather must call a
destructor?  Particularly if, say, it's just a small part of a larger span.

It seems reasonable that we should allow pinned memory spans to be queued in a
socket or a pipe - that way, we only have to copy the data once in the event
that the data is extracted with read(), recvmsg() or similar.  But if it's
spliced out we then have all the fun of managing the lifetime - especially if
it's a big transfer that gets split into bits.  In such a case, I wonder if we
can just duplicate the memory at splice-out rather than trying to keep all the
tracking intact.

If the memory was copied in, then moving the pages should be fine - though the
memory may not be of a ref'able type (which would be fun if bits of such a
page get spliced to different places).

I'm sure there is some app somewhere (fuse maybe?) where this would be a
performance problem, though.

And then there's vmsplice().  The same goes for vmsplice() to AF_UNIX or to a
pipe.  That should also pin memory.  It may also be possible to vmsplice a
pinned page into the target process's VM or a page from a memory span with
some other type of destruction.  I don't suppose we can deprecate vmsplice()?

David


