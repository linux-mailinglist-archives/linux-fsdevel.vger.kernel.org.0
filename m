Return-Path: <linux-fsdevel+bounces-8928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAD83C611
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AAE1F23042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF26EB5B;
	Thu, 25 Jan 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Jdqtpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FA1F5F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195234; cv=none; b=GrDMVRpqT1giZSHJ+JrmKXMfwYP7Kpt9UUMTwn5QujEMLkzNyEEtKhgHtN2klTAENLj1cShEDcd1IfXE9rZEQbpN51FnQvnwKf1C8ZNhpJBBfXh7imeHgmakB+K2U0EfbH7eCaEpvNYNtE+i4Xi3ChJoC4GB4mLsW1cHSw9Bmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195234; c=relaxed/simple;
	bh=WNIz1pM1nip4d96uZ6FyoK3kb+lo8a/ChWuGHglRprg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pek2TAc4M0wKtBVD0XBNc13qIlcTO+T5FvGMKok241MpY+PtTe1+YCVzBfRAenA+02/1w0t93slIN7AWXQhsW3Qms2SaqnTUgkbbrPidWAPgZ4VFd+7+L56y1EoPQ+tPrFfKR9HNGN4kUeTrPG/s2vPOMmoZtLlg73Bx8GZZrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0Jdqtpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706195232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAZlY5FFShoqY2jzLb0BK5KQwuTtjmp0YybmXSZUEAw=;
	b=L0Jdqtpq9WuhOjZQulyXgdl4RNpVQAT0C24jPvlhgjGKzkJY/Y7f9m3SoxqsfslRo+r59d
	uB3mluXP6iurR7SJuB98NBts9dQimzxpjCYXhI5QM5eqL402zMBEpIN0euaE6CwSnHMAAr
	75FTvR0668uJkSHvE4t/ghGXyy2y5iw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-c9iSLK8_Pc6WcUKnO_R9ng-1; Thu,
 25 Jan 2024 10:07:07 -0500
X-MC-Unique: c9iSLK8_Pc6WcUKnO_R9ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9553381AE4A;
	Thu, 25 Jan 2024 15:07:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE6F1121306;
	Thu, 25 Jan 2024 15:07:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
References: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com> <520668.1706191347@warthog.procyon.org.uk>
To: Benjamin Coddington <bcodding@redhat.com>
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
Content-ID: <524117.1706195224.1@warthog.procyon.org.uk>
Date: Thu, 25 Jan 2024 15:07:04 +0000
Message-ID: <524118.1706195224@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Benjamin Coddington <bcodding@redhat.com> wrote:

> > NFS.  NFS at the very least needs to be altered to give up the use of
> > PG_private_2.
> 
> Forgive what may be a naive question, but where is NFS using PG_private_2?

aka PG_fscache.

See nfs_fscache_release_folio() for example where it uses folio_test_fscache()
and folio_wait_fscache().

David


