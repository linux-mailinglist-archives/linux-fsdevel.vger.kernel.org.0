Return-Path: <linux-fsdevel+bounces-10424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B484B019
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0BD1F21E68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5920D12BEA2;
	Tue,  6 Feb 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn57VMLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C3405DE
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208750; cv=none; b=BW1lXhBZPUCeeoLsvEk6E5LpR93iilFIpP5FIFeA+OY1qUmehW43Z/6p/y4YjuCfWOVeg73i3I1/ETCVgjg2jyxoKMHqdPSXgZlJRLx03tfpk0KNSQ0P6MV02d/UfG25BMFpV3bkDF5LIMDk77NDa02n2YXrZ/p0uAsDbyi5H54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208750; c=relaxed/simple;
	bh=l+JMszkFYy6lH6a9tczp4WqafiooarXArqiBuWtq2nA=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=UIkHQUSb++r7hFUr8yzh7DdS3S8CHMs5hYGmJGPNuajClmvuFsjYbqiCUipAdb1iVy2McXyQ+TBzWwl4LJvHedrhk2nErMZmEpHu6nwKXXyuI9WI4QwauopXJ1ePk6t+I5WKARMhjCgKCfvDheHgjtDsHu9JUqMt4reirUoy4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kn57VMLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707208748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVAaAYx+uRJrIVM9VYECDgmw/4CaprkfGNuPI6DSTlw=;
	b=Kn57VMLdPa5ezyHuJ4Rw7j3q6HVtf+MfyQfje5pnfpsTX5bXUkLEUqDWojyJNOAzLd6kpk
	5Pfs6/6VJfi7gVzZTlqcWE3+n/oToUip+tKp45D77RVF7IV8lHWU22Ym9NGVDvziKAtcol
	+KdobRn7RvwhgIAHaKra8gNXPRLXZks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-cq73PueiM7GdY63RPfS8Fg-1; Tue, 06 Feb 2024 03:39:04 -0500
X-MC-Unique: cq73PueiM7GdY63RPfS8Fg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1158383B7E6;
	Tue,  6 Feb 2024 08:39:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61BE3492BF0;
	Tue,  6 Feb 2024 08:39:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>
References: <520668.1706191347@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Gao Xiang <xiang@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
    linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3114773.1707208741.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2024 08:39:01 +0000
Message-ID: <3114774.1707208741@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

David Howells <dhowells@redhat.com> wrote:

> Disconnected Operation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> I'm working towards providing support for disconnected operation, so tha=
t,
> provided you've got your working set pinned in the cache, you can contin=
ue to
> work on your network-provided files when the network goes away and resyn=
c the
> changes later.
> =

> This is going to require a number of things:
> =

>  (1) A user API by which files can be preloaded into the cache and pinne=
d.
> =

>  (2) The ability to track changes in the cache.
> =

>  (3) A way to synchronise changes on reconnection.
> =

>  (4) A way to communicate to the user when there's a conflict with a thi=
rd
>      party change on reconnect.  This might involve communicating via sy=
stemd
>      to the desktop environment to ask the user to indicate how they'd l=
ike
>      conflicts recolved.
> =

>  (5) A way to prompt the user to re-enter their authentication/crypto ke=
ys.
> =

>  (6) A way to ask the user how to handle a process that wants to access =
data
>      we don't have (error/wait) - and how to handle the DE getting stuck=
 in
>      this fashion.

Some further thoughts stemming from a discussion with Willy:

 - Would need to store the pre-disconnection metadata as well as any updat=
ed
   metadata.  When performing conflict resolution, userspace would need to=
 be
   able to access these in addition to the current state (local) and curre=
nt
   state (server).

 - Would need the ability to include extra stats, such as the AFS data
   version, that are used for cache coherency management.

 - Would need to provide an API by which userspace can access both states =
of
   the data, possibly including the original data if we still have it in t=
he
   cache.  That could be a number of ioctls on the target file.

 - Would need a range of resolution options in userspace, not limited to k=
eep
   local, keep remote, but also the option to stash one/both somewhere.  M=
ay
   also need to provide app-specific resolvers - merging git trees for
   example, but also what do you do about sqlite databases, say?

 - There may be bulk changes that the user would want to resolve in bulk,
   perhaps by "everything in the subtree" or pattern matching rules,
   e.g. "disard all .o files" or "take the .o file matching the newest .c =
file
   in the same directory".

 - May need to change how expired keys are handled so that they aren't alr=
eady
   garbage collected, but can continue to be used as a token off which to =
hang
   cached access rights.

David


