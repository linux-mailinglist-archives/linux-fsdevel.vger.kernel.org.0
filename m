Return-Path: <linux-fsdevel+bounces-24184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14F193ADC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACCD2812DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508701411C8;
	Wed, 24 Jul 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KshO/ni0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8401B7E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808723; cv=none; b=HCKgha5IzuKQ4VQHDZR32YBDrw/1hQTp+gVj6M3q/RoiOTBcSQsGnfqmYV1hEoEECNzr+RjMszGbuU5t0x0HzVm/jvZYsvn6uCDHIdwYtJrIwU9Kjeu+6pBXCYf5/U8ufEAeyTeC2XEv3B/1rAeGrdU3M4merVHRcwQJFy30Nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808723; c=relaxed/simple;
	bh=s7hhqchaxiQuHgy5U50MusziEH9As6ZvAjpUDnWXGJo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=XH+n5c5rPC4LgQjEnVF2qMdx3v5StwSNq2JOr8CTNA3mRsYnKnj/G7H4Ar+rOpZfUMDkC4Sm0xBC+rVV6OVruinKjxj++2HZjtNZf/BW2b0vVAdslEtSI/ghFCj28dwJeCdKaVFKyc/xkj2SJSVkISlpifDuK8JI1pbyDWZPVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KshO/ni0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721808721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jyvRNlCo7H0nMKeExwfupCt0YeZsChO27NKXONbPwMM=;
	b=KshO/ni0U8Vok8yTgSW1+5dnAFDH2x49eiiQe66XjKPxvamoDRlgWNw+thT+yO4kkiwTUs
	xwwzr8POjnPRDltZBeFMxqa+kXuJk5zb2F78lTaOUuoy2AEo5cw7Rh3HbNmIuJ7Xv1y0hZ
	QUya7EXVAENEZ/TZwL0NNnkjzm1ptkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-93UXihc1OoisumPKDlRIJw-1; Wed,
 24 Jul 2024 04:11:23 -0400
X-MC-Unique: 93UXihc1OoisumPKDlRIJw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A00C19560A1;
	Wed, 24 Jul 2024 08:11:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92B4B3000197;
	Wed, 24 Jul 2024 08:11:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240723125710.mtnfaycuvdi4dpdy@quack3>
References: <20240723125710.mtnfaycuvdi4dpdy@quack3> <2136178.1721725194@warthog.procyon.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr() and removexattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2237317.1721808676.1@warthog.procyon.org.uk>
Date: Wed, 24 Jul 2024 09:11:16 +0100
Message-ID: <2237318.1721808676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Jan Kara <jack@suse.cz> wrote:

> > +	error = strncpy_from_user(kname, name, sizeof(kname));
> > +	if (error == 0 || error == sizeof(kname))
> > +		error = -ERANGE;
> > +	if (error < 0)
> > +		return error;
> 
> Missing fdput() here.

Thanks.  I think Christian is altering the patch to use auto-destruction
constructs (CLASS()).

David


