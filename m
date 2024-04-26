Return-Path: <linux-fsdevel+bounces-17868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E318B31DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26D41C219D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964613CABA;
	Fri, 26 Apr 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DthkIkvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7413C903
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118444; cv=none; b=OOxML6mwpBdeU7z4cQ63pXJ027lUkKt0Y/W1q27vDagsD0k2Qw4qwlG5IMaZpR6NFMuiJT026WieNz2RUfvIHXchmHgzJ08cDQtOsmn7qJihI69kVNt/0MJD+L2/T/DWqNfCqAlhKqaGWqwD32OMISKYlJgwd6kfaHjwbMQBLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118444; c=relaxed/simple;
	bh=8moJHIF915kF9JPZZi2hSy1ahaIWtygA+5VPkH7e8r8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PKK5kT4cOUQDMNC9QNeRF09VD1vPqcNSohgPQjnmdJZsDEfU8uVCDR4TXojAS2aD6URnVjIibTM8ETZ+horcG8J1I52cxrS8l94qy5I+Ek6d3cVwPkKetIWda404m6hk6psz+YEq6oPnNUZYbA6aauMNJ/9cbiVc/69lLF+XoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DthkIkvj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714118442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIFFxT8ZyW309/4jPgibBUS9mKjAZgteIkx/pxryLuo=;
	b=DthkIkvjr3CwlIX2FtQWnIvf15oQZS/O7nxVr5+zu8WvQKulzHBu9NUwabCX9aGSsRTD9+
	5wh2CSpN3I+lxjERz0QK0XLLMGr+nHDLw1TJTlc3rw+KxY7Y3yC/51iMNQ+xAgTNkxYuch
	2jFRsgqrjcV4S3aK+D00M+avVB38BOk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-mr3uO8cZOamc3ageCNO_lw-1; Fri,
 26 Apr 2024 04:00:37 -0400
X-MC-Unique: mr3uO8cZOamc3ageCNO_lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE0893811701;
	Fri, 26 Apr 2024 08:00:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16B5016D93;
	Fri, 26 Apr 2024 08:00:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240425084537.6e406d86@kernel.org>
References: <20240425084537.6e406d86@kernel.org> <1967121.1714034372@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    netfs@lists.linux.dev, linux-crypto@vger.kernel.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Fix a potential infinite loop in extract_user_to_sg()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2101063.1714118434.1@warthog.procyon.org.uk>
Date: Fri, 26 Apr 2024 09:00:34 +0100
Message-ID: <2101064.1714118434@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 25 Apr 2024 09:39:32 +0100 David Howells wrote:
> > Fix extract_user_to_sg() so that it will break out of the loop if
> > iov_iter_extract_pages() returns 0 rather than looping around forever.
> 
> Is "goto fail" the right way to break out here?
> My intuition would be "break".
> 
> On a quick read it seems like res = 0 may occur if we run out of
> iterator, is passing maxsize > iter->count illegal?

I would say that you're not allowed to ask for more than is in the iterator.
In a number of places this is called, it's a clear failure if you can't get
that the requested amount out of it - for example, if we're building a cifs
message and have set all the fields in the header and are trying to encrypt
the message.

David


