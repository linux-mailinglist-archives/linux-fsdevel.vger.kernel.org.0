Return-Path: <linux-fsdevel+bounces-42089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADCA3C560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FD3A62B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FE213E86;
	Wed, 19 Feb 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOlWwE6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E94212FA5
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983566; cv=none; b=CxCmuodAVDWv3xLwhvf5toaEzg7Yv27nNYfxmSdRxDHkZ610NB6PB264VfnperAk76RG4Ths25iiJr5MlS+XIKPzUpKcxmmnUTeUP3V8lZ94fTuUfeDj0nzznGYjUk9WGPOejG/cka6S80SxDWtUOPaIcEaRdIBVCe4iyiMNhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983566; c=relaxed/simple;
	bh=v1yRgYJsQ7J4k42qHoWdDVW+iptJtlXtIZxiE97lz74=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bAqZVK+gW6OjXOHr4OWE1T3T6ANs1EsgKYEnh3RxG5Oc/bOuYTo6A00RaGLxGfsF8C3zWuXau75WmWlDPlJ3El+u/sD25MiBYQx7KeR0wq6+nkkZTbTuLBlUwXPgQSzMm5wT1xj77X11Zc+YHuN+lG534vQkHOKLHopF1SSanQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOlWwE6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739983563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJGZ0v/kaRUAXJWrbnyu79+Ej9Egr9xzXmnL9S/JVEo=;
	b=NOlWwE6fMEmzn4lPTvfvDi5vLpWdPhVRTHrrYG9pCqU2JXV+TSr/1Fhuw4AZIoEM96mO5/
	rANGjWF85UspMNfuhReXI6ExM2d+mv5VfBUBWEE0wtEAVbcDcuO59Q6psNzyC+dw+Ct0Sj
	d+Ae23NyEs84vViZt0yl6F8fICd7nPY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-Qg_Db64mNuisbJx-PiWHQA-1; Wed,
 19 Feb 2025 11:46:00 -0500
X-MC-Unique: Qg_Db64mNuisbJx-PiWHQA-1
X-Mimecast-MFC-AGG-ID: Qg_Db64mNuisbJx-PiWHQA_1739983559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05300193578F;
	Wed, 19 Feb 2025 16:45:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEBE61800877;
	Wed, 19 Feb 2025 16:45:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mvgkPdLQ_oz_faa=4CVCaHNDcNVZfqBbdKTENrW5COSTA@mail.gmail.com>
References: <CAH2r5mvgkPdLQ_oz_faa=4CVCaHNDcNVZfqBbdKTENrW5COSTA@mail.gmail.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
    linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: netfs read failures with current mainline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <527283.1739983556.1@warthog.procyon.org.uk>
Date: Wed, 19 Feb 2025 16:45:56 +0000
Message-ID: <527284.1739983556@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Steve French <smfrench@gmail.com> wrote:

> I see many "Couldn't get user pages" netfs errors running cifs/102
> regression test (which tests for leaked file handles) when using
> current mainline from today (which includes the recent netfs read
> retry fixes).  For example many of:
> 
> [Mon Feb 17 14:08:31 2025] netfs: Couldn't get user pages (rc=-4)
> [Mon Feb 17 14:08:31 2025] netfs: Zero-sized read [R=32f]
> [Mon Feb 17 14:08:31 2025] netfs: Couldn't get user pages (rc=-4)
> 
> Anyone else see netfs problems when running with current mainline?

rc=-4 is -EINTR.  I guess this is because your test is hitting a request with
SIGKILL and iov_iter_extract_pages() is failing.  The above is probably not a
bug, per se, but rather some logging that wants cleaning up.

David


