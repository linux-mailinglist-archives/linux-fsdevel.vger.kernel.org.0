Return-Path: <linux-fsdevel+bounces-48220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240C7AAC157
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E801C074C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5E2777F2;
	Tue,  6 May 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4IahJjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716026B956
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527210; cv=none; b=KDw0zfayM9qNvQeBWq30FW6Weo/W8lUIhSNB+Gjt7rg/BJ2dl8bJGmvPWUY4BIuqrAwb1V+80VlbHOU3jGVIuE3UNlL0nk6cFsDwdCo65qbsU1Kl8dz4P6w4sjifLlH9lZRvzRuif2+BnZZX6vM5/b78zufajbdZ09pmtrvgHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527210; c=relaxed/simple;
	bh=1Ivtt5aDW1FFmaK6JlMxYyI8tpl1f+b9vgZYtmbilvE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BSX5LrpehckmQDXobnOfFi561FuZca+FNTGplnlwdnlTJ/9vZsLGfnxxgBsK6NJK5JNoX9FgcpaH4chR8EnE6dNTPlpr14ZDx96OiDPhAkmxZXNdhq58nOZykisQhZOvs62xypvUibUlMTl5Uek3T/VXMhpEUrHdfnWYpMOI8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4IahJjG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746527207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldh2ZjQIYGdGGzK49enEKH+FzA5Hf8dgiRrydZ2YEkY=;
	b=Q4IahJjGpQ7aVNpC3p2vdx7NBsw5bZ01ri2yl5Y3I0phL30hOAWQjnaDLfgyj6YDbiYXUA
	0yOuI1J3RuxCuvdVANha0+DVRoFA5J0fE7VL47jGpKf51vizcayBbHSTOsoKZABys8dTT5
	EsRUTZjW2rdHfWlfyOY5mW/eZQJS9gE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-Owsc9BgwOOK2xVtAbikYmA-1; Tue,
 06 May 2025 06:26:44 -0400
X-MC-Unique: Owsc9BgwOOK2xVtAbikYmA-1
X-Mimecast-MFC-AGG-ID: Owsc9BgwOOK2xVtAbikYmA_1746527202
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1EB1955D52;
	Tue,  6 May 2025 10:26:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15C0519560AF;
	Tue,  6 May 2025 10:26:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
References: <20250505-erproben-zeltlager-4c16f07b96ae@brauner> <433928.1745944651@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Etienne Champetier <champetier.etienne@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Chet Ramey <chet.ramey@case.edu>, Steve French <sfrench@samba.org>,
    linux-afs@lists.infradead.org, openafs-devel@openafs.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1209710.1746527190.1@warthog.procyon.org.uk>
Date: Tue, 06 May 2025 11:26:30 +0100
Message-ID: <1209711.1746527190@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Christian Brauner <brauner@kernel.org> wrote:

> > However, the bash work around is going to be removed:
> 
> Why is it removed? That's a very strange comment:

Because it makes bash output redirection work differently to other programs, I
would guess.  It's actually a simple security check to work around (just retry
the open() with O_CREAT dropped) - however, it does expose an... error, I
suppose, in the Linux kernel: namely that the VFS itself is treating foreign
files as if they had local system ownership.

We have the ->permission() inode op for this reason (I presume) - but that
only applies to certain checks.  The VFS must not assume that it can interpret
i_uid and i_gid on an inode and must not assume that it can compare them to
current->fsuid and current->fs_gid.

Now, in my patch, I added two inode ops because they VFS code involved makes
two distinct evaluations and so I made an op for each and, as such, those
evaluations may be applicable elsewhere, but I could make a combined op that
handles that specific situation instead.

David


