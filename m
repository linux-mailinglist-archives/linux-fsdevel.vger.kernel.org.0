Return-Path: <linux-fsdevel+bounces-8923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1983C46B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB31228DD5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06092633F8;
	Thu, 25 Jan 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCbDN4lD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAC634E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191927; cv=none; b=tkVS/9UhdcNRZERywa/CYKGpDYL3rocEYKsoQwWDbN9Gt02z+QQ8Fq0txsHFyU5OX/sQiRLW5Q/Lnbo6JpHvRs674mggcvsVKfMTfdLod3JpWZqug4RWe1LaHcPVnIo4bYkErjJ4xN/e2pJPI8R/ChTfQlkZ5a4ZgKhQ5YGOwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191927; c=relaxed/simple;
	bh=E87yYMUmIZQHj4uCon05JeVlBr+VAITmiBQh7svNdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTDf3nLzx8+ydmKA/Nq/ffBWTfrfqYNvI8augxdNDrO8HYSqvEJ9siomV30Bmz1j9H2rpLP/NMgj7AIFOkyJX4ShStTWa/G5/JAr7nrZN170mpkwtdQ5V4e9g2NO2ksPD9JGaQxdB0g8Um84yAcAw1B7U0i2MQ9J1XbVxyCeHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCbDN4lD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706191924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACqcEjg537hZBJWAT4QAy+L6J3AJYKEx3L1s6N7xY70=;
	b=NCbDN4lDV0ZDO/cgCL2K/2cuFB8HDaFZSJPUbbw3Puw13+OS9Vh4KaO2+vyGqf3jGDZrCR
	jd57z6ERhww9gZpXomtp5zshpVk4TYEpUsj79M1bO8qknxTtCxxvRRBmFy3N48L01iQZoi
	dZOoALShpPvuhkACKOGsHTEXY1kl0vQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Ton7HokXPSWRswBc5p_IDw-1; Thu,
 25 Jan 2024 09:11:59 -0500
X-MC-Unique: Ton7HokXPSWRswBc5p_IDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A4A21C0BA46;
	Thu, 25 Jan 2024 14:11:58 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 060CB51D5;
	Thu, 25 Jan 2024 14:11:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Date: Thu, 25 Jan 2024 09:11:54 -0500
Message-ID: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>
References: <520668.1706191347@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 25 Jan 2024, at 9:02, David Howells wrote:
...
> NFS.  NFS at the very least needs to be altered to give up the use of
> PG_private_2.

Forgive what may be a naive question, but where is NFS using PG_private_2?

Ben


