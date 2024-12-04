Return-Path: <linux-fsdevel+bounces-36456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71A9E3B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC5716430E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C71DFE1E;
	Wed,  4 Dec 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyNjLskW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FC1DF997
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319711; cv=none; b=I9GKN7kkVVH+jXfn3efUKYVeBcHLxLgA8CVj3lMJU9PZIbzboNj6fbKwuGWm3O97UXV9mr4fFM85Cf+6aBOh8cL4c/VmgPIt2NGO0aibhfTgiR/hkRk8Cf1OpxHqdfpRhBvPM8Pvpq77F5WSz6JCG1pG7agJfnx3pzq34K0x7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319711; c=relaxed/simple;
	bh=//IOCXU9YYt4/q/x0hx4GJcgqWywOZM6O/P4V+hgsa8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YL9ui7jY36OFTHo4J2rAhlSzfzemSOXiXLw9EHRNYwvQiDuTjG0p1V7vFFNL/sQ5JJs1ILs2nsh84ZWV8XA8AQ19qqgeZ40V130YzkHHEf2GTve20/de4ojnSeUvPJA95/FIs5X/ru1WM00nRGbHueGRBwUOusWjr//DW5f4vFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyNjLskW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733319708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Je4LoQU1rSuWE8wImIWJKAiOgPVmQRuJjQd+HMY9Y0c=;
	b=OyNjLskWkUeOfx/x36fAOSppazxp5dN7/4dKvs/ujrT2dgGmK7aQbPAXBRpsD1Z6dEUm/i
	RT2VBetCF027Vp2nIW36ro8u9QvRGA1xPZ/XzAT9FHQWVF21ULoXExz5WVRyQSgDzea3Ch
	FuQiI1wBglveKkcGNBLsZ+wYhxXt6yQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-SJNa59pBOM-nAAPG5E9uHA-1; Wed,
 04 Dec 2024 08:41:44 -0500
X-MC-Unique: SJNa59pBOM-nAAPG5E9uHA-1
X-Mimecast-MFC-AGG-ID: SJNa59pBOM-nAAPG5E9uHA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 785F11954B09;
	Wed,  4 Dec 2024 13:41:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 358B119560A2;
	Wed,  4 Dec 2024 13:41:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com>
References: <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com> <20241202093943.227786-1-dmantipov@yandex.ru> <1100513.1733306199@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Dmitry Antipov <dmantipov@yandex.ru>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org,
    syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Subject: Re: syzbot program that crashes netfslib can also crash fuse
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1127212.1733319697.1@warthog.procyon.org.uk>
Date: Wed, 04 Dec 2024 13:41:38 +0000
Message-ID: <1127213.1733319698@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I seems to work, so you can add:

Tested-by: David Howells <dhowells@redhat.com>

Please don't mark it as closing the syzbot report as that pertains to
netfslib, not fuse.  syzbot attached both reproducers to the same overall
report when it really ought to have split them.

Note that a reproducer zombie is left behind and the filesystem can't be
unmounted as it is busy (which may be due to the zombie).  However, the zombie
goes away and is replaced with another if the reproducer is run again.  I
wonder if I'm seeing a systemd bug as systemd should be reaping the zombies.

David


