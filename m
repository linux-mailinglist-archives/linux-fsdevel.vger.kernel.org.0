Return-Path: <linux-fsdevel+bounces-36621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA29E6C8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 11:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70762818B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA3F1FA261;
	Fri,  6 Dec 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6yHh4bX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F31B641
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482286; cv=none; b=ZoTeY170FpG2t6b8ZISq4/C+WmBxJg763ifLGwVx/SU75ydtvsOOmatKYo3ufSruxTttN+qE6lrjFbnI19jHilWwBZf5eRYmLdxofn5nhsbFrlgFAqWgDTOe/y/kMP1hT5Qd5VzVQ+1hz+0KkcxvnVWvhje+kzTe89uDdIGnsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482286; c=relaxed/simple;
	bh=oTsPUDgDN6bcnZ0E8n6dRKgzyMJp9vgjIScGMRZsCxE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QG5JJ4/4BG+9PQUPfIP+U5fRspL6LY0u9oNMTdps4C+nOTzw9Mh3EsIEZYBfZa2CaUxm7AdtwRS1B2SZARuvqUVigOzGFY89MVyHm2W9yU2qQ1vgUEZ4scLyGI7kgDg27Z1WZrRnwlUeP/QVR644VqEzl3augRGwoklQy8zF0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6yHh4bX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733482283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NST6jts8YNbGPQLwjh+xfRvv0/reS6QmYyob3J81Hkg=;
	b=M6yHh4bXzNGZop8ydvWG1bnFzxSOS65UNhY6A1/FDQlwkQmipaMSOMVrPoPW55iLmbQGdH
	kEVZaUIN5Kygl2bt8kerOiBuCJxhMMzFdLZ8qOgKTckH1t5IhE9aCrTHDuNY/TNO0aW5d6
	qqOStCYExaRpRXJrbKxCBH9YyGxJ+R0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-j4uGIcJqOo-pktNsHs93Kw-1; Fri,
 06 Dec 2024 05:51:20 -0500
X-MC-Unique: j4uGIcJqOo-pktNsHs93Kw-1
X-Mimecast-MFC-AGG-ID: j4uGIcJqOo-pktNsHs93Kw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 323EE1955F38;
	Fri,  6 Dec 2024 10:51:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE0991955F3F;
	Fri,  6 Dec 2024 10:51:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241206071315.2958512-1-zilin@seu.edu.cn>
References: <20241206071315.2958512-1-zilin@seu.edu.cn> <ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: dhowells@redhat.com, mjguzik@gmail.com, jlayton@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, xujianhao01@gmail.com
Subject: Re: [QUESTION] inconsistent use of smp_mb()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1977685.1733482274.1@warthog.procyon.org.uk>
Date: Fri, 06 Dec 2024 10:51:14 +0000
Message-ID: <1977686.1733482274@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Zilin Guan <zilin@seu.edu.cn> wrote:

> Since the code does not need the fence, should I send a patch to 
> remove it? Commit 2df8654 introduced this fence during the transition 
> to a new writeback implementation. However, the author added this fence 
> as part of the changes and did not intend to address a specific CPU 
> reordering issue.

Sure.

Thanks,
David


