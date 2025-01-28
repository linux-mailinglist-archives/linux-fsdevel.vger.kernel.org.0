Return-Path: <linux-fsdevel+bounces-40239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14BA20E27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D344D1884292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB91D6DBC;
	Tue, 28 Jan 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7OJtjV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0A18C011
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080828; cv=none; b=pPK+GZ03RIUfFWB7au1wPA+bBZDqAJPWk0Z+4RSAvNjGOyYnGIV5kwByUC/TgagJKb6Q6VhStkusEXSGWvobZpIH8qldTePSy0YLOS3d5GgMEqLSB1SQRA/U0UQjNVkhFGTD/zGnOhI+CHzAnm9oEeVtR/uXyR8FiaxvgAR+JQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080828; c=relaxed/simple;
	bh=14UwwRp6UvUzjoqirdhunA9rJKHVPrU0AtD0B4IGNMs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=odH0vL9nhiGsCm5yUiPTj0Wq4R1aQq6q3r77M8Gzf4QYpNaObh6FlSnTCG80DJuokwuPEShCc/CRr5RTqaBWZzFtrpdjr1R4ySWQE7PUkkpr6Sg8y6zAhrvwOXAsveXLwOJun2Ckmb/uEHC1Am1b3wpJCwj9nBQ1/Yj4Vo3M9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7OJtjV0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738080824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V+jtKXwGOD3Qh6du0GCp3L8kV2VDQJzJRmQX+/Nkww=;
	b=L7OJtjV037z2itwSqvmqrFml2LD2FrWTUQvV0YvQFUW3Ag6/Kpbx5eDHjDxneKtDTaa3u9
	IOL184mgSoeGPrlLKhMKTsAxWl2Ah9irXhbAUn2hTpCcFO7+IRIyJSq6/oWwhhPlW2CN/h
	UfVuXEDpRDhH8EHU9KZAEiW99/6lkUo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-pQBC0ppNNNS9NsXHuPlyKQ-1; Tue,
 28 Jan 2025 11:13:40 -0500
X-MC-Unique: pQBC0ppNNNS9NsXHuPlyKQ-1
X-Mimecast-MFC-AGG-ID: pQBC0ppNNNS9NsXHuPlyKQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05CF7180189E;
	Tue, 28 Jan 2025 16:13:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.56])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01DAA19560AA;
	Tue, 28 Jan 2025 16:13:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com>
References: <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com> <20250117035044.23309-1-slava@dubeyko.com> <988267.1737365634@warthog.procyon.org.uk> <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "idryomov@gmail.com" <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3406496.1738080815.1@warthog.procyon.org.uk>
Date: Tue, 28 Jan 2025 16:13:35 +0000
Message-ID: <3406497.1738080815@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Viacheslav,

> So, is suggested fix correct or not? If it is not, then which solution
> could be the right fix here?

It'll probably do.  I can't reproduce the issue because I keep hitting a hang
(which I'm trying to debug).

David


