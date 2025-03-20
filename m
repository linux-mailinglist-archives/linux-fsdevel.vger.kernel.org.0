Return-Path: <linux-fsdevel+bounces-44604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F168A6A9E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1829D3B36E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847CB1E98FE;
	Thu, 20 Mar 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJxquCEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E11E8320
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484380; cv=none; b=faEWf1B5FjbMdoH49M4pH+ncufqtLNeNpvcSd7T0Suls85UuoiLdPssaTZGCQKlB+vjhTU9hrwS8NoAbUmMD4nfq2+gxkzDGV5DsG2TYd+S6bt707jVrBd25GcBJVsitgTrPKf6QRsb8pDijd/i9AOaUOQSLur71R0jcnHb7M98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484380; c=relaxed/simple;
	bh=TR1eTBA7fRTupQfcNBL8gfm9cGkD0wK7jgIIEFhsD/I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D3+Kj5QwEmjJnc43Mb6bTPaW4VrhVV6584vooGUsH87HUHHj9JO6tUTPCwwbRs/VAZzg9Qc0q5d0X9sr897657rC8y1GPquZdP8LO7hHizoJ9U7J2mcacw7MLFThf7HboVYLzai8+3ZC568xRwh/mHv3prHEQfL9OKSPyY/ta1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJxquCEr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742484377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79P3Rj9ZIxn8gB2XJc6nRUWm/vSrFhJbw3HtD7EvGj0=;
	b=UJxquCErJ4k1QHr6MOnVRJ1z004sjZhWeFEurYSk1HN+oJYA9rgzo2M7mm9Ymx51AnrZc4
	ygWLaiPv8+ndKEdzg1C7fEOqJZWLko7Xs0IZqfYlVXAXnMd9yjCvO5ACm+g+kKxkVaPcit
	p033+wb074ohw7Szwq92zu7J6CPP4eA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-0M1WztXYMpy43it4VearTw-1; Thu,
 20 Mar 2025 11:26:13 -0400
X-MC-Unique: 0M1WztXYMpy43it4VearTw-1
X-Mimecast-MFC-AGG-ID: 0M1WztXYMpy43it4VearTw_1742484372
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC3121828B26;
	Thu, 20 Mar 2025 15:26:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4B3C19560AF;
	Thu, 20 Mar 2025 15:25:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b31f451e2949e7c07535accda067178238f7e1bb.camel@ibm.com>
References: <b31f451e2949e7c07535accda067178238f7e1bb.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-33-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 32/35] netfs: Add some more RMW support for ceph
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3173769.1742484356.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 15:25:56 +0000
Message-ID: <3173770.1742484356@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +	rreq->buffer.iter	= *iter;
> 
> The struct iov_iter structure is complex enough and we assign it by value to
> rreq->buffer.iter. So, the initial pointer will not receive any changes
> then. Is it desired behavior here?

Yes.  The buffer described by the iterator is going to get partitioned across
a number of subrequests, each of which will get a copy of the iterator
suitably advanced and truncated.  As they may run in parallel, there's no way
for them to share the original iterator.

David


