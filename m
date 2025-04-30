Return-Path: <linux-fsdevel+bounces-47737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836FAA514C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B17B9C1768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495212620D1;
	Wed, 30 Apr 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STyYxt1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871825A2CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029694; cv=none; b=Ag/eyvbwz3inI1Ok6PDVK6u0zCXempUPfaCQAY14UCkbLtlkFpaVpRdK9cUAPA636Jv3YPk52qOLE1dkwpOEAfc0syrCINhWjdyVaYyuyAXkSVEOuIsMlcpcM5DFXUENXmXG2Is3MCsWttT/RFnM4hR8d1YcLp8YKlhNL+4OCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029694; c=relaxed/simple;
	bh=qs92COqpC4pCd3KIbcBy7O9vgKzWZA/ZaUTJSh7536g=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BvdASFK4CjlFAxZh+LM01P2j/eygM/zhvFPLMW1fV/K5sG8ZPyO7kxV5DNqQNhborAXJtLhBV0Nvg3Ut82ew35umoOIbEH68934d03A0TwsTUMBRL9QQu+ourzMg6xE1EhNTcj2x/kutva/gwAmIzozoblyi4uGUD9zIAVKH9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STyYxt1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746029691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VAYR5mvAk9M7BK/RzMAURMsugmQJ8HxsAPL+QsOA3Q=;
	b=STyYxt1Oaqkn4rP9f1tFq6RUo0xbe6tvXSkOUUPh/m56rYFySQDOdSD9AJGWt2LlcWpLrD
	MUg8ufy91lb3WgZG1wvvnTdY9tJzQONCwZ+nGIs6IwE3X3zqPQeQs4/6QFXC/hK/lfF8L8
	UFrssG2na3GZbViLECrA1VHhZQYW8yA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-9S4uJLLmMsOIofyzCCL7gQ-1; Wed,
 30 Apr 2025 12:14:48 -0400
X-MC-Unique: 9S4uJLLmMsOIofyzCCL7gQ-1
X-Mimecast-MFC-AGG-ID: 9S4uJLLmMsOIofyzCCL7gQ_1746029686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36EA318001E0;
	Wed, 30 Apr 2025 16:14:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9C1E18001D5;
	Wed, 30 Apr 2025 16:14:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <473bad0c-9e38-4f8b-9939-c70c52890cd2@case.edu>
References: <473bad0c-9e38-4f8b-9939-c70c52890cd2@case.edu> <433928.1745944651@warthog.procyon.org.uk> <3d19dc03-72aa-46de-a6cc-4426cc84eb51@auristor.com>
To: chet.ramey@case.edu
Cc: dhowells@redhat.com, Jeffrey E Altman <jaltman@auristor.com>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Etienne Champetier <champetier.etienne@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
    openafs-devel@openafs.org, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <666532.1746029681.1@warthog.procyon.org.uk>
Date: Wed, 30 Apr 2025 17:14:41 +0100
Message-ID: <666533.1746029681@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Chet Ramey <chet.ramey@case.edu> wrote:

> Well, except for CMU's report.

Do you know of any link for that?  I'm guessing that is it was 1992, there may
be no online record of it.

David


