Return-Path: <linux-fsdevel+bounces-45236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A10A7504A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AC1188E81A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7E1DF97A;
	Fri, 28 Mar 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVa4RYbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5371D90B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186064; cv=none; b=GXZ8vT16xSdV8elm+Un3ojqBGqYPv76L9MUSQQ5D62r32KVQHg2FuSkyAdUzrdEIhI1YKf2yYKQRmbMGaDwD6cmBvxCtV4iFsT83kaMsapfOVxgoQPy/R6pyB1MFuJnyNTE2DXPWlPa9JlHZKBXc8o2/L3xUMe+QmH71gXm22+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186064; c=relaxed/simple;
	bh=RflAqQK0UiKASqVIdkZflxaWM7HtW92Gh/JZzSfUr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poTV3OA1cgLhwPnhrISvEAscs7EH2w7sDmTo86X9cJhHtfZLlJwWtEJxyvXK/we7f8TAlsV7e8geX7NZjHUkW0F5MJ5N+NdXQU34Fnx85QjidyL/KL5+O5iGnZVYMxTFm4Dn34WjMa30AbjrdOjhGRvmt5Q3+y6a0dV4Dmn8eLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVa4RYbA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743186061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RflAqQK0UiKASqVIdkZflxaWM7HtW92Gh/JZzSfUr6M=;
	b=hVa4RYbA97xStx6Jo9EoYNSdE/ZLPm3EsYNZiR3cEJHvMraFcncmhxPur2nK94QH4qFEaI
	X6K9CqN2Sr5D0wvLfOCGkK+EWs8jOX7a3itWP4y9F4I+fttvYpfRdLjEjLm4/RcbGyUhhF
	7bM4VHsU2HnKIobWnraB0rSDSzG1zGQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Dw06vJc5P6KLU9A2zMXTdQ-1; Fri,
 28 Mar 2025 14:20:57 -0400
X-MC-Unique: Dw06vJc5P6KLU9A2zMXTdQ-1
X-Mimecast-MFC-AGG-ID: Dw06vJc5P6KLU9A2zMXTdQ_1743186055
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2029C19560B1;
	Fri, 28 Mar 2025 18:20:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 21A4E30001A1;
	Fri, 28 Mar 2025 18:20:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 19:20:20 +0100 (CET)
Date: Fri, 28 Mar 2025 19:20:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com,
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250328182011.GE29527@redhat.com>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
 <314522ae-05a4-4dfb-af99-6bb3901a5522@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314522ae-05a4-4dfb-af99-6bb3901a5522@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Prateek,

On 03/28, K Prateek Nayak wrote:
>
> Yours is the right approach.

OK, thank you, but lets wait for 9p maintainers.

but...

> If this gets picked, feel free to add:
>
> Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

No!

My version is just a slightly updated version of your initial patch.
It was you who (unless we both are wrong) actually pinpointed the
problem.

So. If this is acked by maintainers, please-please send the updated patch
with the changelog, and feel free to add my Reviewed-by or Acked-by.

Oleg.


