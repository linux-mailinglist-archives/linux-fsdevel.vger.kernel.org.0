Return-Path: <linux-fsdevel+bounces-14392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93987BB95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F5228642C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BE16EB56;
	Thu, 14 Mar 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZEmklKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444D6CDCE
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413746; cv=none; b=KrRyNr+ugG33oPhL6K1E5dKgmKwOddfHhlJzDUHGIAM7GJDiNK/JD+e0nYctihuxjof28mD/ohEQEEk0CdYzGUYNTJkz8/t1E30oRXKm/Re482jX0YN9HdImUIwaDLFSqgdzHbZBdXY6IV4jx/8971ywPQbYOsWQDrKK8QwMzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413746; c=relaxed/simple;
	bh=ww+Q4Z3TN7Zkf8AUEmHnJJZgYQfS+2qGhI9YQcA66HU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=e62wOuabfliAGXOW+w40owMte7ICyOJhd/KKrKP90P8QVsRHaMOF4cZm8eFeTBBILMH0wOtlToPeudqeMEp3I6WVbwErfGdvyV++OoiS5aM9A6c0jlS9fgiIp43hSXbzgB49qjChGi4HrVrS3erOeizME3wwg041pi8aTHQVWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZEmklKf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710413743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gzZJrL9co+94ItPuR1/5KXAlp4bS/UQfJI3lmQi3hg=;
	b=KZEmklKfajbprxtN2SMdOk50rjwRe9tSpZ0Y3NR9yMARuyyb1s7ON+deDYGcjIJXkiqWvg
	F5zKqtlskCgGT8HB8oI9t77Dv8vtQhShDXvbaH7KEs+ahMyf/aZtA3LCDeqo6nIoDOpYt7
	6xLYHhVO8p/4IztjT8eZ/RAtzzSasLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-mMtlPRr8PrWZv3wqqdl8xw-1; Thu, 14 Mar 2024 06:55:40 -0400
X-MC-Unique: mMtlPRr8PrWZv3wqqdl8xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB07E101A588;
	Thu, 14 Mar 2024 10:55:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95F5E111E3F3;
	Thu, 14 Mar 2024 10:55:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org>
References: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org> <3085695.1710328121@warthog.procyon.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3341491.1710413737.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Mar 2024 10:55:37 +0000
Message-ID: <3341492.1710413737@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Randy Dunlap <rdunlap@infradead.org> wrote:

> > Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/00=
8102html
> =

> Not Found
> =

> The requested URL was not found on this server.

Erm.  Not sure how you came by that.  You lost a dot somehow.  It's in the
original submission:

https://lore.kernel.org/linux-fsdevel/3085695.1710328121@warthog.procyon.o=
rg.uk/

David


