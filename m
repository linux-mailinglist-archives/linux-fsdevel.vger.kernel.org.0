Return-Path: <linux-fsdevel+bounces-47334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A823BA9C410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA20921DCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE621237176;
	Fri, 25 Apr 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNwR0Ys5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E8221540
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574236; cv=none; b=XVB0AAGDmI1Cxre00b0faMmqNrdtC4eZ1R4a7SRtCyg45r1JHU16I+Ndp3eW7DBrAjktBGuJGTlMQaRZoF//r+nArHaOI+57S4KDlRlc9BMFzgBr/noxZmPYuWrdMkfjdWUo0PumWWxBLhdIsgt6XTwtYiJdqKg7I7MOWpdhmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574236; c=relaxed/simple;
	bh=bOHZCU29aYU2ruSDQcNzuiOVNPD3DC1c1fbQCYrTXaY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sYvBb5gbSZreuNxSpSS4I4qdPnurK6x8u0xCZm4FVH3xV0UvclyoMYPdM7ueMqYOTWSl3YFcRWGo2jS53PwCJyQK0cUS6dlPax/jrCSdup4lefCf459rNc5Lx2wLn4DA/GKnKNXnV/Qy7yhXB6kom7/qflAEdAsTB4GensyoJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNwR0Ys5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745574233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FpU9yg73MLhDi4cgcJs60rCajnYVaSA96rYIRaVBKA=;
	b=eNwR0Ys55egSbl/roif0jisOBaOLFAiTLVnyUsG5gIc6sX3JvrgtXV6K3q6t2NoOIMTP8Z
	hw3ZB9LD5LDBcBUwQtMSYZH5AWb6kv0Fr2byxMNV5LSrc36wUneBiE+ZOB6gQEYfTDuHMv
	jBJm3ljmFWy4ySUa4dm0TCgnAuqiENY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441--HVbqfltNde2DXDlyeasXg-1; Fri,
 25 Apr 2025 05:43:49 -0400
X-MC-Unique: -HVbqfltNde2DXDlyeasXg-1
X-Mimecast-MFC-AGG-ID: -HVbqfltNde2DXDlyeasXg_1745574228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D567D1800877;
	Fri, 25 Apr 2025 09:43:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0336419560A3;
	Fri, 25 Apr 2025 09:43:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250424060845.GG2023217@ZenIV>
References: <20250424060845.GG2023217@ZenIV>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org,
    Steven Rostedt <rostedt@goodmis.org>,
    Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [RFC][PATCH] saner calling conventions for ->d_automount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3616486.1745574223.1@warthog.procyon.org.uk>
Date: Fri, 25 Apr 2025 10:43:43 +0100
Message-ID: <3616487.1745574223@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Al Viro <viro@zeniv.linux.org.uk> wrote:

> Currently the calling conventions for ->d_automount() instances have
> an odd wart - returned new mount to be attached is expected to have
> refcount 2.
> 
> That kludge is intended to make sure that mark_mounts_for_expiry() called
> before we get around to attaching that new mount to the tree won't decide
> to take it out.  finish_automount() drops the extra reference after it's
> done with attaching mount to the tree - or drops the reference twice in
> case of error.  ->d_automount() instances have rather counterintuitive
> boilerplate in them.
> 
> There's a much simpler approach: have mark_mounts_for_expiry() skip the
> mounts that are yet to be mounted.  And to hell with grabbing/dropping
> those extra references.  Makes for simpler correctness analysis, at that...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

You can test this by installing the kafs-client package, telling systemd to
start afs.mount and then doing "ls /afs/openafs.org/doc", say.

Acked-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>


