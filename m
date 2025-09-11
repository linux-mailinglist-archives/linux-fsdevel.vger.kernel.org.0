Return-Path: <linux-fsdevel+bounces-60889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33FB52868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591AC5679AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4B25487B;
	Thu, 11 Sep 2025 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5EzIF9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70723253F05
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570395; cv=none; b=WJk0kSqgEa4BeI0pVAmud/N1JQLnnZ1rT2bdfT8a3pvFGzQhkXKJLruGjAkhsSyZ85dNLuYaZwBdZmI8KOdnhoCODSuIJboIZmSkefPysEJeGCcRDFfjRgvK0ZPTnwDTgL7ajHQwXTgQBx8PrvheDtGEEnHkYrZdxf7kWZvRJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570395; c=relaxed/simple;
	bh=YLJ7E8D39ZQye1/XBWf2REKukXkr7dKknYd/ulrZr5w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=cVP5riYbmj0LNsEd022TPFgeb81NUS1StYYKmiRUYWL/s45ep/l0MUiB0WAu8FxGRfJ/Um06InbpfL6qD53NznmRu7gzmRl+8GR/XYo/ipdRo0RHBCOEdYkP34JXAgX3JZPK4ZkbbXvlJK6vRkWnx3IfKmMLh7WxG9PArz1bFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5EzIF9U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757570393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvIv0Fme/12Gy6QkmPve1p56d0YuJiZc9uDe1Fge2qw=;
	b=f5EzIF9UBmRb44WRf5qdOgLBrr8LlLqq9jtpVDez0+nnP7rAyae1dBO2joEfBGT8oXpCOi
	WCHQdlBB0IK8uEY+GW4Rfub08EyNyv2AVOqOudDJi/cUfG0IbNqCY0YKvtoO2stUdoOlin
	AnpVRi4p5S/iyimqbWTA4rrljvA2Z5E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-thmt30oePk6tg_klA7gfxA-1; Thu,
 11 Sep 2025 01:59:50 -0400
X-MC-Unique: thmt30oePk6tg_klA7gfxA-1
X-Mimecast-MFC-AGG-ID: thmt30oePk6tg_klA7gfxA_1757570389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 876411800291;
	Thu, 11 Sep 2025 05:59:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12C46300018D;
	Thu, 11 Sep 2025 05:59:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250911050149.GW31600@ZenIV>
References: <20250911050149.GW31600@ZenIV>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    NeilBrown <neil@brown.name>, linux-security-module@vger.kernel.org,
    Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCHES] simple part of ->d_name stuff
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1910270.1757570384.1@warthog.procyon.org.uk>
Date: Thu, 11 Sep 2025 06:59:44 +0100
Message-ID: <1910271.1757570384@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Al Viro <viro@zeniv.linux.org.uk> wrote:

> 	Rules for ->d_name access are rather unpleasant and so's
> verifying that they are followed.  There is a relatively simple part,
> though - nobody outside of fs/dcache.c has any business modifying
> that thing.
> 
> 	So let's make sure that all functions we are passing
> &dentry->d_name are taking const struct qstr * and replace
> ->d_name with an anon union of struct qstr *__d_name and
> const struct qstr *d_name.
> 
> 	It is *not* enough to guarantee that another thread will
> not call __d_move() right under you - checking the requirements
> for that is the hard part.  It does make it easy to verify that
> nothing else accidentally starts changing it.
> 
> 	This stuff lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.qstr
> Branch is -rc4-based, individual patches in followups.
> 
> 	Please, review.  If nobody objects, I'll put that in #for-next.

Reviewed-by: David Howells <dhowells@redhat.com>


