Return-Path: <linux-fsdevel+bounces-39658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AEA169A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E66E3A1169
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC319DF60;
	Mon, 20 Jan 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzygW1cZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC91474DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365644; cv=none; b=laFre/wHO6U7rqEwvRUpO738IA29DRjmqhD0IJJA75S3yfyryJIQ0ydXbZ0dCcQVEkrfnj+Ppp5uxFDArs2UstIO8dpo9+WpU0bNOfETcQhLfp+nyAB2GdUvTy2HXUxtP4yNq3stry9COEEZd5Lw6ENNCfdCBII8Cb6GZ7Zlvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365644; c=relaxed/simple;
	bh=wiTAH2GKEgRXgdP9UrVipIj17tsh1yaq3Uk0hXycfcM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=jWW8UaNM/AgdLVXiQqtHEY+rpqaBdDe0e5Uq2oVpHwBCNxkbvIePYgrm47WtUAh3A52x0EckQDZ6TaRgsh6W6f/jDknG5Mo4gA1Fl1lVms/vrn9XzisP/TicLt8fO8T2gAVxapHKI8gucEY7YknRBhekv+yzWQK7tmMurOsO2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzygW1cZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737365642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4gZM4W6ZprnN5j7PopZsAUanJG0f6CvmCJLisUicdc=;
	b=YzygW1cZh5kHuGgMaV1vVZ1n1ClO6GLMJBEifvi8sdaLg3KFF+ohB+uFGZ3aA/e5xWQ4zx
	JIXF9wB3R4JpGQ/wHSxiXgyI8ALMtPzTWF8kLMaQ7aKvhFLk8sylKv3zx0bCjnkW3gEQPb
	kGDxjIRJt8361uo3AiG8HCmUru/IqxU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-n-ijY6MkPGK6rFX-nfCK7g-1; Mon,
 20 Jan 2025 04:33:58 -0500
X-MC-Unique: n-ijY6MkPGK6rFX-nfCK7g-1
X-Mimecast-MFC-AGG-ID: n-ijY6MkPGK6rFX-nfCK7g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 380A719560A2;
	Mon, 20 Jan 2025 09:33:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B26619560BF;
	Mon, 20 Jan 2025 09:33:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250117035044.23309-1-slava@dubeyko.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com,
    linux-fsdevel@vger.kernel.org, amarkuze@redhat.com,
    Slava.Dubeyko@ibm.com
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <988266.1737365634.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 09:33:54 +0000
Message-ID: <988267.1737365634@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Is there a way for me to test this?  I have a ceph server set up and can mount
a filesystem from it.  How do a make a file content-encrypted on ceph?

David


