Return-Path: <linux-fsdevel+bounces-52966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E7AE8D11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A994A1254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD702DAFD4;
	Wed, 25 Jun 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtfL29jz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CD1CAA7B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877599; cv=none; b=mXLcW0uN9Oxn9fGeX7Tt4+ZiggrXrc/hEYoA0N45PqyeuBgC57qcIVqovsuCrSqwMeiZW063jFGnTrqNb8VuTENTRkaeWaCwloJCUFP8+AaRY6G8VX0I3zRKkP9z6QmdM96KFOaTe+sdzeBKBiNGYVrxa/gEkPqQ3PWT84tW4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877599; c=relaxed/simple;
	bh=bS8vPhhMVwxzJT6/BNkoc7Er8p13AErTd9yG5dAIq5s=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bkAUwbPoIWhO1bZa/jcZi2e/sYWTbw04HES3bgKqN9jpEKoHM43cMhLMShzE8hDjBkDq4lvljQTRQcBaq1R/cER9LlJSKWE3GMvAyUWsM2k5u7JoIWMAZHFVF5y5+bKqbCJjQFmAn+qSg/Hsy8RGP3W5ZJ14Xdhw4DPvOYEb34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtfL29jz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750877596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6E8oLR88JXaGJ+0hThZ0Yw7Sb6AqN89mXhCvOuzvaE=;
	b=NtfL29jzeJwXt8UeJlwJadp66wJ75PYPvDYkAeeUcrmhll8RzYAAFwpNbiAWw7rG27rXoW
	09bREkdjzFeT/1DZPGakV6jN7fzhocU3LB845o+5djfjpgBRhsOIkAZRVg+mIC8qDPIdhK
	FxAMj7yb0LLN4nNDbIClztxyRVSyiOk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-ZroNxM6hP7Kh0pBASYoOhA-1; Wed,
 25 Jun 2025 14:53:13 -0400
X-MC-Unique: ZroNxM6hP7Kh0pBASYoOhA-1
X-Mimecast-MFC-AGG-ID: ZroNxM6hP7Kh0pBASYoOhA_1750877591
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6664219560AA;
	Wed, 25 Jun 2025 18:53:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8738C180045B;
	Wed, 25 Jun 2025 18:53:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9e58524a-856c-4efe-80c5-195bc7b55743@talpey.com>
References: <9e58524a-856c-4efe-80c5-195bc7b55743@talpey.com> <658c6f4f-468b-4233-b49a-4c39a7ab03ab@samba.org> <20250625164213.1408754-1-dhowells@redhat.com> <20250625164213.1408754-13-dhowells@redhat.com> <1422741.1750874135@warthog.procyon.org.uk>
To: Tom Talpey <tom@talpey.com>
Cc: dhowells@redhat.com, Stefan Metzmacher <metze@samba.org>,
    Christian Brauner <christian@brauner.io>,
    Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
    netfs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Steve French <stfrench@microsoft.com>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 12/16] cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1425469.1750877586.1@warthog.procyon.org.uk>
Date: Wed, 25 Jun 2025 19:53:06 +0100
Message-ID: <1425470.1750877586@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Tom Talpey <tom@talpey.com> wrote:

> 
> Shouldn't there be some kind of validity check on the rfc1002 length
> field before this? For example, the high octet of that field is
> required to be zero (by SMB) and the 24-bit length is not necessarily
> checked yet. The original code just returned the decoded value but
> this sticks it in the msg_iter. If that's safe, then ok but it seems
> odd.

That should be a separate bugfix, I think.

David


