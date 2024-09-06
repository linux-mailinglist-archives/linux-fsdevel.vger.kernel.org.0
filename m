Return-Path: <linux-fsdevel+bounces-28847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436796F6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176361F25A10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B91D1739;
	Fri,  6 Sep 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaeMTnCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF311C7B9E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633290; cv=none; b=F6rkDwqRT2VXQWMpatqc89CR4laf5jZiDoW8Fwwt4SVFW/eROZfXsP6Lzd6PpBCZ75OnkHCBD2OUX6bM7qBZ/C98hx7F84PmrsISeua2Z1AVuclAgOcc1sytd/uIrV9++83DeXBaHhkvQhvFFp0c51mCXeLvZ9pqXyaQpJ6uYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633290; c=relaxed/simple;
	bh=gZpqgyEz/2MM6908txuz6sKK2S55j3sELDC0KhKmTnY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=S5IWgGahOlibKQ7VbiAeBHXdxlj/pVV7I42Ca0ciTT19gtTkcpxGJl3RtnC0ChCHMnS7WUCQPaK6FRJo1dKd/n/ouQ5xpgfDxgpK0y5FYd1VUpDSUdGom8jAeZ0T88Uhtd9IkF3ufu9wddzyZWHlF6/cYtfMxhaICJ8weQRgrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaeMTnCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725633288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZpqgyEz/2MM6908txuz6sKK2S55j3sELDC0KhKmTnY=;
	b=QaeMTnCADqkXOiFEk632WMv/J1Wtjhd2PCOHbptj/yX9MTYChRnSZOhas9JxLoV0x9KLMV
	M0cxDR82lwHgu4fKttoSHVIcEuQOo4pL+wpmS6VkvRzk4A201b5wpAwLX5B+rvveIZ2IWT
	51CCY5rPZkPal4hRT8x3NMt3I4GG/J4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-re_ZW_wJPmW5P5LbNbTwrQ-1; Fri,
 06 Sep 2024 10:34:47 -0400
X-MC-Unique: re_ZW_wJPmW5P5LbNbTwrQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87D931956096;
	Fri,  6 Sep 2024 14:34:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9047719560AA;
	Fri,  6 Sep 2024 14:34:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000000a78120620f2fc2b@google.com>
References: <0000000000000a78120620f2fc2b@google.com>
To: syzbot <syzbot+b02bbe0ff80a09a08c1b@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] possible deadlock in lock_mm_and_find_vma (2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <121385.1725633282.1@warthog.procyon.org.uk>
Date: Fri, 06 Sep 2024 15:34:42 +0100
Message-ID: <121386.1725633282@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Is this using a cachefiles cache?

David


