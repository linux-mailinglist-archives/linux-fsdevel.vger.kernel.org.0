Return-Path: <linux-fsdevel+bounces-37886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144469F88F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 01:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F31A16B2A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C412B93;
	Fri, 20 Dec 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOWfjlG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E704C85
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654024; cv=none; b=gM5WMv5WknJ8GsSZEAaJoC6oH6HT8a1eqqse3tj8ijEtVRQ52Rgu1q+yXUq0wijdH9ELf0kYU/TgBCga9wpLoS4getCnHp3i70y11W4E2GfLarQ3raWOP1TYE0wvkS+C1J+Cyuy0pGMY75xVuku3YKKolj93qFbgQbaq20O9L9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654024; c=relaxed/simple;
	bh=DfMHV2IQIaWJPMMsIlcisvm705/jPDt8I0LyiUe6Xng=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=LnQaas6FPD+95AU8sqEXKs62NiiZkiot7qVgacRisuViStZgLPUUMAbAG/p79CGLnEAwp2n3tIVC/3XSUuYbsr0l2wqIHfvQ9hMJIY2WLKIsBc+2ZiBFRFzCXCISHYih5z5ihH83N9CBSlU0h1UgNH+qH/enq09lwEBGOoMvl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOWfjlG5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734654021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ic3A7eG9JHu/DrEjhMPDax03g0VDSgGCPnZ/3jQzBsk=;
	b=dOWfjlG5HFaueeB2jUZ+lV5C3jsrrkq+RmUgMflAPa1ed+EatBXFWYYzSF3bQdJa6Bsqot
	yA7X/Q+c74vfT0vNxwSDhX6Ip8X8h5VP3uks/9so6oUVUVfOuBCP2wGXIC6vgaN2ln2ZLO
	KJ4ZYofC6cSvRKADT4npDX8nP3scNqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-IeA08SuXPpaDvBfXWVqBDA-1; Thu,
 19 Dec 2024 19:20:18 -0500
X-MC-Unique: IeA08SuXPpaDvBfXWVqBDA-1
X-Mimecast-MFC-AGG-ID: IeA08SuXPpaDvBfXWVqBDA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 875B619560B1;
	Fri, 20 Dec 2024 00:20:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76649195608A;
	Fri, 20 Dec 2024 00:20:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <fb54084d-6d4e-4cda-8941-addc8c8898f5@paulmck-laptop>
References: <fb54084d-6d4e-4cda-8941-addc8c8898f5@paulmck-laptop>
To: paulmck@kernel.org, Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: [PATCH RFC netfs] Fix uninitialized variable in netfs_retry_read_subrequests()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4059209.1734654011.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Dec 2024 00:20:11 +0000
Message-ID: <4059210.1734654011@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Paul E. McKenney <paulmck@kernel.org> wrote:

> This should actually be considered more of a bug report than a patch.
> =

> Clang 18.1.8 (but not GCC 11.5.0) complains that the "subreq" local
> variable can be used uninitialized in netfs_retry_read_subrequests(),
> just after the abandon_after label.  This function is unusual in having
> three instances of this local variable.  The third and last one is clear=
ly
> erroneous because there is a branch out of the enclosing do-while loop
> to the end of this function, and it looks like the intent is that the
> code at the end of this function be using the same value of the "subreq"
> local variable as is used within that do-while loop.
> =

> Therefore, take the obvious (if potentially quite misguided) approach
> of removing the third declaration of "subreq", instead simply setting
> it to NULL.

I think you're looking at the old version of my netfs-writeback branch tha=
t's
residing in Christian's vfs.netfs branch.  I've posted a new version of my
branch[1] without this problem and am hoping for Christian to update the
branch[2] so that Stephen can pull it into linux-next.

David

[1] https://lore.kernel.org/linux-fsdevel/20241216204124.3752367-1-dhowell=
s@redhat.com/T/#t

[2] And hoping he'll remember to drop "[PATCH v5 26/32] Display waited-on =
page
index after 1min of waiting" for me.  I forgot to remove that debugging pa=
tch.


