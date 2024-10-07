Return-Path: <linux-fsdevel+bounces-31182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E316992E96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E099F2850EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA592433CA;
	Mon,  7 Oct 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFIyXdcd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9351D2215
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310547; cv=none; b=AWUc4qCSEYQ5utpdYl9PLfJVGV59jz9T+7IH/tQ82LCNzmW7+MXA3ak2IlMUWvgpj7B6EUvE5oT2BUVLrGiW264Gy2647pt9IjdPKIT6fXAAQyPvKrSjqAM6mk/AV73p8m++WM8UhwU6FzsuEUkcMtj5ttQf/qxXy9xPlZluZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310547; c=relaxed/simple;
	bh=u9Q5bVkvq10QvTQ6G6ja1bbV5lDfbeoFGQtptLKEB8o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=osr1mLp/k4WKgxG7EEfmeJSPCatmML+PrLX4gMNuQ/KQ/atbHz+muy+yCgP3jzYuujkd2RlSxTnLkT+QadCvBjLfAuDzOX2yzAJhO0YbHwnV1kT6ji/ONagKo/fciGuj1tf3yglikFRD2ZvuxJW/Fhq11tXNQ26T89tqKLXBVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFIyXdcd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728310544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9Q5bVkvq10QvTQ6G6ja1bbV5lDfbeoFGQtptLKEB8o=;
	b=jFIyXdcdHdHEe2X13OL5BMiwrU387C4+PazsYa6xSV2wzGmM3zVv3caN7ef3cd0HGTmCOO
	r9Px1YSN9kATg0QDzZfR/iNdVp792luRX3obh32H3bqr94aa3cANmBsAO+NN/v01jNR/lz
	jQmJN4sLlwc4Ad/5aN3G3oVgs4ORyP0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-xfEkQnyUNpCo8-GS5Mx3fw-1; Mon,
 07 Oct 2024 10:15:41 -0400
X-MC-Unique: xfEkQnyUNpCo8-GS5Mx3fw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA5011933195;
	Mon,  7 Oct 2024 14:15:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CF3B19560A3;
	Mon,  7 Oct 2024 14:15:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241005182307.3190401-1-willy@infradead.org>
References: <20241005182307.3190401-1-willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Random netfs folio fixes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4027775.1728310537.1@warthog.procyon.org.uk>
Date: Mon, 07 Oct 2024 15:15:37 +0100
Message-ID: <4027776.1728310537@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Christian,

Could you add these patches to vfs.fixes?

Thanks,
David


