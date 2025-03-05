Return-Path: <linux-fsdevel+bounces-43295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C01A50C6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9B7A63B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4525523E;
	Wed,  5 Mar 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgyYUVhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6825334C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206169; cv=none; b=G5mC7XX5UxbOvBiObKyM588OnqT7qckwNejFYSAkydxE5LA7ZB5fA5N/yhWP5lfiQEAe/vrfOX38pbsPDf9Eu7QcZohekO50/qnaRAjlFEiGSp5ycJ/j1XVVvz1KvW20oOr0o+aTV2AgYs+EazR7taEoMDseR7eWMPVk5zrr7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206169; c=relaxed/simple;
	bh=qNPO4hyQMmjaunQVLRgcSEf+SPUNHvyhOBDgrhBH8es=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=T39gkJ9JpDVnkOAPJAHNeLw8PlZxEm6qvFLBvH6GCuTM/eOI6r8LnHQFpyZJaDCYQtgM4fyebUxcq9YgEeJS52Sv4R2YalK64q5SkYlnB0W3OZFUbdxPZPf9XTu8xcIqEjGN3heiMNpbGSKDh23y0tboZ5rilXZXGEQzRZHnAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgyYUVhO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741206167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ibRmp/JHXOv49f/n9ru2NwNSIc5HZ94H+M9mUxQIns=;
	b=QgyYUVhOLaTmhbJ7WMLWYcbUzpXiUpErwrTE21XcR0MTb6mkpJMtbQvfpxJGFI08NTjYrU
	ZiHZa3ndipYBxly/jnJVVETyAHIX1WmR3cz4h3SfZ5Ym9f7v5G7MtWkmym/dJo9s7WKj/X
	cbedur/H4y2MmrNdOQnAxBjATVkpTc0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-b_PK09FnN66rT4AdGjPT2w-1; Wed,
 05 Mar 2025 15:22:44 -0500
X-MC-Unique: b_PK09FnN66rT4AdGjPT2w-1
X-Mimecast-MFC-AGG-ID: b_PK09FnN66rT4AdGjPT2w_1741206163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A89F718001D7;
	Wed,  5 Mar 2025 20:22:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB8621800373;
	Wed,  5 Mar 2025 20:22:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
References: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com> <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
To: Alex Markuze <amarkuze@redhat.com>
Cc: dhowells@redhat.com, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    Gregory Farnum <gfarnum@redhat.com>,
    Venky Shankar <vshankar@redhat.com>,
    Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4177846.1741206158.1@warthog.procyon.org.uk>
Date: Wed, 05 Mar 2025 20:22:38 +0000
Message-ID: <4177847.1741206158@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Alex Markuze <amarkuze@redhat.com> wrote:

> That's a good point, though there is no code on the client that can
> generate this error, I'm not convinced that this error can't be
> received from the OSD or the MDS. I would rather some MDS experts
> chime in, before taking any drastic measures.
> 
> + Greg, Venky, Patrik

Note that the value of EOLDSNAPC is different on different arches, so it
probably can't be simply cast from a network integer.

David


