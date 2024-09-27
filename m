Return-Path: <linux-fsdevel+bounces-30272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5BD988B49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516BB2813DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05A1C2435;
	Fri, 27 Sep 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFzzxslc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822D381B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469096; cv=none; b=imGIVrNl1cTaE09VwjdaKVl0Z8cQZyq7UrKWx4B/ILU46WsHpjkF6HxPUN7+TA2a68fqgGW/OT/4N5YlaQ57MH5Qh/4YwqiEdIn2tziam7CFxHKoa3JrC9wKyxY++TVcplzNByPMs882jp93Ile03ojzK2mdXf6e2+lpPkXeoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469096; c=relaxed/simple;
	bh=j9okCmyMMDKl1+WIsBb9/Jp2OC9bhokKiYD/X+kiE1E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=o5+uRssra3wj34rLN/nzDrn7oA/aIPiFAdLsUj8qcwUUnVhN/5cSvBebtac+CmRrv6Fj8/nPfC1pQqwQpz3ciXIjw0lCLmVb2AzTzNs19+h+NmcNSaZ+LG/x1yRiwDIok4yLTIKQh6PvIi8GBsKzD4dV7+xI4vE9x4LRFH7gnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFzzxslc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727469093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3rKtpAudpnbWXY9lBExbJgVRIH1wW0oKgKwXi+mu5I=;
	b=LFzzxslcB2FcPpez/76cdhU9t0u/fYefGW5F3/bKwpeH43KPUELQ809DTLzUZGN9RiRf/T
	sTksrU9NWz72q/C1s3MtFiCqWux++6PG8vzx0fDuKdBuAv12BFs94wOWY4Rt6F9EKYSlsU
	KV0HRT+aRGaqZJZJzwGgKQOrgPXuX2o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-tOllJRsfNWGB3_RsiNfh0g-1; Fri,
 27 Sep 2024 16:31:32 -0400
X-MC-Unique: tOllJRsfNWGB3_RsiNfh0g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6C981902727;
	Fri, 27 Sep 2024 20:31:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21CED1954B0E;
	Fri, 27 Sep 2024 20:31:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240927163423.GG967758@unreal>
References: <20240927163423.GG967758@unreal> <20240926174043.GA2166429@unreal> <20240913-vfs-netfs-39ef6f974061@brauner> <2238233.1727424079@warthog.procyon.org.uk>
To: Leon Romanovsky <leon@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2631082.1727469088.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2024 21:31:28 +0100
Message-ID: <2631083.1727469088@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Leon Romanovsky <leon@kernel.org> wrote:

> I hope that you mean that we have plenty of time before the merge window=
 ends.
> Otherwise, it will be very inconvenient to open official -next/-rc branc=
hes,
> based on -rc1, remembering to revert so many commits.

Yes, I'm aware of the time, thank you.

Can you please try the branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dnetfs-fixes

see if it fixes your problem?  It runs through -g quick with 9p over TCP f=
or
me.

David


