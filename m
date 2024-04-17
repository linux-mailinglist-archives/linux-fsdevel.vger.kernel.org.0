Return-Path: <linux-fsdevel+bounces-17119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E948A810D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DA31C20A78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FF13BC18;
	Wed, 17 Apr 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRL0KbW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0D13BC1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350190; cv=none; b=HHjvqgy8lgxvU7ARYl3CO6huDzzEczCwmnZiC5Y/aTjIQaxoSllR/7KMSslERcLEZEbnf6/8qsEK5UlHlDphvLmJEMbuvOViuX3660tlH5qtelC9Z837VIz/tn8sJv0nAh4/vs7a0CghyeFLy6+QDi8JOvPxrk9829/I6uuwNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350190; c=relaxed/simple;
	bh=l3AYSJ/+mdg3v48SneVucrIzOcn2/tdaJ1WQ9uXh3tk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Wos8O+8k1Y/ILNBzRq7oGqVK+uSrMSw3CKJkp7C1si8dp57h91+TLc9nvNsFkmJCLb5Y1UxWD7J2jK1rFalo5SpDOG7CrFSNVRJtmc7L5HMGuaFqt+pVHbzs46tNIEbQia94AXTdLji0XYo0Wm8EpDCjOPrW5KyE5O3Qt9Ow9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRL0KbW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713350188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oIJdAoOJD1/uhXCiQOPpdfvotOmhyFiedfiW/yeHsWQ=;
	b=eRL0KbW89Ztk9vb0p5alR/Zgg6mdJS2P2Bf2TTQPMlDXnJ4ZwjHWEFUJXJRqiUFinByxyf
	dWENAj0IErApDeVAuGodmiFHfh0JWfE/0picOnQtJSxOLEsM1aofeR9G9vu10HxGfq/n3g
	iFXgzjU7WVeLUSojUlmElDgrjyNsiUI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-tzkEwGWLMWac2hfcSazMmA-1; Wed,
 17 Apr 2024 06:36:24 -0400
X-MC-Unique: tzkEwGWLMWac2hfcSazMmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65AB738041CC;
	Wed, 17 Apr 2024 10:36:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FDF82026962;
	Wed, 17 Apr 2024 10:36:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87d451ff8cd030a380b522b4dfc56ca42c9de444.camel@kernel.org>
References: <87d451ff8cd030a380b522b4dfc56ca42c9de444.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-25-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 24/26] netfs: Remove the old writeback code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98240.1713350175.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 11:36:15 +0100
Message-ID: <98241.1713350175@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Jeff Layton <jlayton@kernel.org> wrote:

> #23 and #24 should probably be merged. I don't see any reason to do the
> two-step of ifdef'ing out the code and then removing it. Just go for it
> at this point in the series.

I would prefer to keep the ~500 line patch that's rearranging the plumbing
separate from the ~1200 line patch that just deletes a load of lines to make
the cutover patch easier to review.  I guess that comes down to a matter of
preference.

David


