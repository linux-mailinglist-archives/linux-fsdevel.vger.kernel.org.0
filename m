Return-Path: <linux-fsdevel+bounces-30402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519F98AC21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B21F21781
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404C19925A;
	Mon, 30 Sep 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkQOw5kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CEC43AD2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721320; cv=none; b=d9xUUQqa6EJmsLyR+t8EtFmkb89+SeupBjW5CFryHQwjwi0qdY7/Ikt7+JX9VRaaDdW+HIdjGJr3aHeG4eSx8codzT2BtUK1cIDU42aLU8dR/CKQuIMlKmpCBYzY0nH6BsKVwvIrT30uIlvQYHMOutqzr+dHxouF8gzt4mhP4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721320; c=relaxed/simple;
	bh=u/r1gsK3d9HgHSLkwy9YD8P0OsrJDIi+1lCKi06YOU0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EcrVn74+EGZE2scOx6xZcr7nze3qeGfYb44yyaJKHOTckiX8BWhOwarYD/ua8EnSHH3SaADRay//hULJr39rQoqEhfohd/3bUkM09huOUHQij1GaUQ0pbke5+zW6H/libCZxI/6euiwYMu3XJfVzWuaGQHUvnq8I4sp1mxfcjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkQOw5kt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727721318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7X8o4DowsqGONQ/4kasxk3OiTMOAJHVfF5+gN/kqpqg=;
	b=WkQOw5kt70R/WrIEdj2b5mUT+hMkUkKd1zw3+SQlm684xmNjgEdlKh6YEnR1NcV+AAGQ5a
	XxgkF0eCyqq9ff6s50XZKg9WFgamqjdUntt18PbzCzGFSJZ2Eztsi1vobHDwXhOfsPZObu
	JqdLvxAGYhKaNQteBTmxuJ5T7UQoPBw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453--d_Kp97WPyK6rMA1zpyZig-1; Mon,
 30 Sep 2024 14:35:14 -0400
X-MC-Unique: -d_Kp97WPyK6rMA1zpyZig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59638196A10F;
	Mon, 30 Sep 2024 18:35:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10E771944CF6;
	Mon, 30 Sep 2024 18:35:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
References: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com> <2968940.1727700270@warthog.procyon.org.uk> <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com> <2969660.1727700717@warthog.procyon.org.uk>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dhowells@redhat.com, Leon Romanovsky <leon@kernel.org>,
    Christian Brauner <brauner@kernel.org>,
    Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
    ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
    hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3007427.1727721302.1@warthog.procyon.org.uk>
Date: Mon, 30 Sep 2024 19:35:02 +0100
Message-ID: <3007428.1727721302@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Eduard Zingerman <eddyz87@gmail.com> wrote:

> Are there any hacks possible to printout tracelog before complete boot
> somehow?

You could try setting CONFIG_NETFS_DEBUG=y.  That'll print some stuff to
dmesg.

David


