Return-Path: <linux-fsdevel+bounces-38588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60916A044CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6856B166051
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2A1EF08D;
	Tue,  7 Jan 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISx7G7Zw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132291E47C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264230; cv=none; b=RTX97D76XtrGrOBZzXkgTiEPirx06SyEmwy/ANy9xhwlsZ2ZJasXUYNBHJafxnTFHOAQmBloshbsW5A7c3YGr0CL+rnZvupdoALh4CnwhkVsUD+tis36DrQFwT4k/uTVUin40wZ/GcMVhMe442U13exf1sv9+C4E5p1ddT9YI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264230; c=relaxed/simple;
	bh=3xpYJ22SMNu5ts+grPlMGBBbjGQxKlz6GzX6VyIjZKE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rBUjyd0nVz6J8b/7Wz8zR3PvkYeMNE2WgWsweT7K+YAvb4KuLHs+ZyjeW1bGj6kj1ua1e9sNBzsKBu1OtVbA9EqGwYEOeb6+lOZVerqZxgXfkK/lkOiOyLMohnwvRrx1OgoPMohXAk6kuhlzWLJ7QekPPFbRAeWr5YWV+5BF0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISx7G7Zw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+DaO3ByFBW3QZLHAjOe04czPsMdMzVvjU3nYvjZ7wA=;
	b=ISx7G7ZwryEBb03A5967DtHR780laQpbsJNId3ZHHjAyGg2/1+uVnUDdIG42tn6QcObpRc
	Gew+3ak0HM36P5scsPM1ZV5jmwHjKLYsX+nJJJJpde0K8fsJqePXKs3clQCpXWTdP4d0yf
	osfEkaFyuSrVIM/Hqxin3zc8hxhzwrs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-lt2VrUzoPkqB49WNjlmEQw-1; Tue,
 07 Jan 2025 10:37:02 -0500
X-MC-Unique: lt2VrUzoPkqB49WNjlmEQw-1
X-Mimecast-MFC-AGG-ID: lt2VrUzoPkqB49WNjlmEQw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01EF61955EC2;
	Tue,  7 Jan 2025 15:37:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B45B93000197;
	Tue,  7 Jan 2025 15:36:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250107152050.GP1977892@ZenIV>
References: <20250107152050.GP1977892@ZenIV> <20250107142513.527300-1-dhowells@redhat.com> <20250107142513.527300-3-dhowells@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Make /afs/@cell and /afs/.@cell symlinks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <576575.1736264217.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2025 15:36:57 +0000
Message-ID: <576579.1736264217@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > +	dsymlink =3D lookup_one_len(afs_dotatcell, root, sizeof(afs_dotatcel=
l) - 1);
> > +	if (IS_ERR(dsymlink)) {
> > +		ret =3D PTR_ERR(dsymlink);
> > +		dput(symlink);
> > +		goto unlock;
> > +	}
> =

> Just allocate those child dentries and call your afs_lookup_atcell() for=
 them.
> No need to keep that mess in ->lookup() - you are keeping those suckers =
cached
> now, so...

Good point.  I need to do that for the cell mountpoints because someone ca=
n
arbitrarily create one by triggering a lookup of /afs/<cell>/, but for thi=
s
pair of symlinks, they're created before the sb goes live.

David


