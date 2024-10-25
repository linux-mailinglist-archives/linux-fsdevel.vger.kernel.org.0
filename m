Return-Path: <linux-fsdevel+bounces-32859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4B9AFC04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F428567A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAEA1D0BA0;
	Fri, 25 Oct 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEm/0lZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640C1C4A28
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843564; cv=none; b=D76WKMsrGPdygyZ8FacFTaO6I4KSLIH/KrL5QWVhpbdU0WKjYxA905el7GCeB73OvMhwSPp1C+/xrBoteoKZFQoQPo5fL3jDXAwNDeCwo+F6fsZ9YnfjoJEXX50XjDvyxn4yqS3nxE0V4kMtILOlzwUQNYQWi2nwLU8DXFC0R38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843564; c=relaxed/simple;
	bh=ATaXUh+6mRM8+DzD6T9X0xAxW2Dm2ynHKp1/NJ1ZYS4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CLXx51IgQ66m7TebzpRzoYGbKiVuLwBiGtGstIf9NHmNgQoBPBDQNGZoW9fUj/IuZnDzHvrt/tfBIwZ7otVwy4fUUy82nf64AGDwkb1YJrG2J6T8eFSZn29jsK9QCFRSu2xn6At5ml43orNKeYsBfJcrtc2LXyOXevYSb48ovcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEm/0lZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729843560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJJHsXrgapppl7p0/PyNGlnzqEqHhWtD8NkXnb6nj9g=;
	b=YEm/0lZLlBot4MWk83gdtLs6TIGdaFaBwfotMRQqLDzyahVjiTwhOobaK0+NKIiJvj5pdh
	g7r3802j9ZsTY4bzCu/kZiXtLuM1PG8ko/DTHn0h3S6TLrnyecxYzGAtx+XCKNIPr90ZlM
	I4ktZkqLbr+er0EGELqZNApnbiwBND0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-FPE0XAzzPNeTRp9zwS178w-1; Fri,
 25 Oct 2024 04:05:58 -0400
X-MC-Unique: FPE0XAzzPNeTRp9zwS178w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1383A1955F43;
	Fri, 25 Oct 2024 08:05:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B461C1956056;
	Fri, 25 Oct 2024 08:05:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxshMEW4U7MTgQYa@gmail.com>
References: <ZxshMEW4U7MTgQYa@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Add a check for NULL folioq in netfs_writeback_unlock_folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3951591.1729843553.1@warthog.procyon.org.uk>
Date: Fri, 25 Oct 2024 09:05:53 +0100
Message-ID: <3951592.1729843553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Chang Yu <marcus.yu.56@gmail.com> wrote:

> syzkaller reported a null-pointer dereference bug
> (https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
> netfs_writeback_unlock_folios caused by passing a NULL folioq to
> folioq_folio. Fix by adding a check before entering the loop.

And, of course, the preceding:

	if (slot >= folioq_nr_slots(folioq)) {

doesn't oops because it doesn't actually dereference folioq.

However... if we get into this function, there absolutely *should* be at least
one folioq in the rolling buffer.  Part of the rolling buffer's method of
operation involves keeping at least one folioq around at all times so that we
don't need to use locks to add/remove from the queue.

Either the rolling buffer wasn't initialised yet (and it should be initialised
for all write requests by netfs_create_write_req()) or it has been destroyed
already.

Either way, your patch is, unfortunately, just covering up the symptoms rather
than fixing the root cause.  I suggest instead that we patch the function to
detect the empty rolling buffer up front, dump some information about the bad
request and return.

David


