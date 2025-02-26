Return-Path: <linux-fsdevel+bounces-42698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BBA46473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157FF1759E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE0226887;
	Wed, 26 Feb 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXTNR5Rs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2AB224B04
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583292; cv=none; b=JWOHaCeQqJcmXcoYLoYVYUJRkDYB2cYkbb7WvxRUajalhLKnm+1UIvDckTmmCHjLtPQV0czglXWqVDSXtK8Jlc5m3V8AphIXyZoZ6HR6Hstiev+iB+1kCsjj7HyV1YG1XeEzW4IxZfNVBRO7BfNe6VMf39mB7OIAFSv8WAF4GBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583292; c=relaxed/simple;
	bh=kGuDluKlBGVXw7uhB+/9lut/CvhX3J7r0WIB6MvbzaM=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=bfmhFTbnf/6sysAgWMjZFIIygJ95nT9djn0k0nMjrxEgYXCTg9x9EPJOPMQ0MtH4yMs+rKfxJ4QmWoWuhnNj1/M8EX4kidGqYMphp0Z1oGOBE8dOzmC8JPBKVwYMVoPGc8X5noQTuSE3aTBVB/1ihzKekMPtv15C6eX0UQVgyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXTNR5Rs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740583290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXbyCdmoziShPeJAChKxNKhUqohQ4PH+KJxEBCv0dis=;
	b=DXTNR5RsVAidg7RAGlraB8yoTS6CTZ7fM886a9addn76PPUE0+lHT0V8SGfw4LAvuKuoPD
	ThdMFaCW+3NRjXecAOtgLJliK3w5eLga/ckg754UYgVNbnF2/p+YvvmJb29Ik7OrWnldt9
	YJ+CkaTlK2G+eoSQFnCECeyjC2Adc7A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-iwyn0p17N66pFYe-_2Gb-g-1; Wed,
 26 Feb 2025 10:21:25 -0500
X-MC-Unique: iwyn0p17N66pFYe-_2Gb-g-1
X-Mimecast-MFC-AGG-ID: iwyn0p17N66pFYe-_2Gb-g_1740583283
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48D2E1800264;
	Wed, 26 Feb 2025 15:21:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66FA3180035F;
	Wed, 26 Feb 2025 15:21:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <2602345.1740576046@warthog.procyon.org.uk>
References: <2602345.1740576046@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Steve French <stfrench@microsoft.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ihor Solodrai <ihor.solodrai@pm.me>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    v9fs@lists.linux.dev, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix unbuffered writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2616590.1740580941.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Wed, 26 Feb 2025 15:21:17 +0000
Message-ID: <2635841.1740583277@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

David Howells <dhowells@redhat.com> wrote:

> Fixes: 9dc06eff2097 ("netfs: Fix wait/wake to be consistent about the wa=
itqueue used")

Actually, you can ignore this.  It's for a patch that's not upstream and c=
an
be folded in.

David


