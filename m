Return-Path: <linux-fsdevel+bounces-43356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB72A54C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7187617521F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24B140E3C;
	Thu,  6 Mar 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKi0mvBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D433FD
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268929; cv=none; b=lU0Z+wK5I1XXnMqj1zyT1h5vRSDbel89YRJzifltgRle4Kf8WMOkUsD3rUIDrhZ4pzg/iLNXzEAzLjdihH8fLBhkDEdRkQ7AsFVHzZ8LE5ktB2rf3bV5ICCl3dDCeo6tRsWI6Wq3AccVVl6JQ0mkR4b1S8aYiFxinbsQmb/9+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268929; c=relaxed/simple;
	bh=+o6WkqIB49XPWTR3gth0aOKsZCX8yZfrhX1MeQVcCuI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HluMFgBMkyLsbf8eZLAw2J+HpUcXOsfAmTUfLj408ZZ+ZhBO37yqHsFQUFtq3pgfffmMw6NiPHhj3lD0p3MLZz1rWcq96LgU4tn8sdPsxqnwzGUhUCkWE26TnM/mBJWo3AnrN0p0Wqfi10MJW/PL9D9hr+DvcNWstevs2irBIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKi0mvBo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741268926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOJn3sLvhIcVBzGvoXPLfCNWG4W5Sr8ulGI85ofafqY=;
	b=jKi0mvBoTDRqHek1IiwWgdREao/WOFyy6U363uuehv8LaB+q2i+yMkN8MT/4wC93jPgTSc
	8nXm6C9ZK3ItQ439rkaPkBWm9od6maPqlS9khsmN2XbRHU4WrSIx1Ke54M6fWk5XS3y1ik
	WhvggFu4bRTeQGCtugw9RcDXxGafQfo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-wRgdpZh3OQWfdXVYjM5HZg-1; Thu,
 06 Mar 2025 08:48:37 -0500
X-MC-Unique: wRgdpZh3OQWfdXVYjM5HZg-1
X-Mimecast-MFC-AGG-ID: wRgdpZh3OQWfdXVYjM5HZg_1741268916
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1921956053;
	Thu,  6 Mar 2025 13:48:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50DE11955DCE;
	Thu,  6 Mar 2025 13:48:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAO8a2SjC7EVW5VWCwVHMepXfYFtv9EqQhOuqDSLt9iuYzj7qEg@mail.gmail.com>
References: <CAO8a2SjC7EVW5VWCwVHMepXfYFtv9EqQhOuqDSLt9iuYzj7qEg@mail.gmail.com> <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk> <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com> <4177847.1741206158@warthog.procyon.org.uk>
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
Content-ID: <127229.1741268910.1@warthog.procyon.org.uk>
Date: Thu, 06 Mar 2025 13:48:30 +0000
Message-ID: <127230.1741268910@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Alex Markuze <amarkuze@redhat.com> wrote:

> Yes, that won't work on sparc/parsic/alpha and mips.
> Both the Block device server and the meta data server may return a
> code 85 to a client's request.
> Notice in this example that the rc value is taken from the request
> struct which in turn was serialised from the network.
> 
> static void ceph_aio_complete_req(struct ceph_osd_request *req)
> {
> int rc = req->r_result;

The term "ewww" springs to mind :-)

Does that mean that EOLDSNAPC can arrive by this function?

David


