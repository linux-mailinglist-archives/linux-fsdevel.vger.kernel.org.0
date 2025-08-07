Return-Path: <linux-fsdevel+bounces-56967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A251B1D58B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9EB18C681F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599A231A55;
	Thu,  7 Aug 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1dpzp/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A82EAE5
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561589; cv=none; b=Q7ko+qNWMV/5CvB5c0mgznSaYs2MSfQnY2t2YQP8joxbFXA0jcxqSFCT3Te39GWHCWbZicchtt3wwWOvVf4+uT1zsqGwnSv7aHdMUsUo0ainU1aeIS+i5CM0m7NFHPMuWkTQZf3f930ymb9maX/HToquTAO/HphPlWiinv6T82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561589; c=relaxed/simple;
	bh=CPopPMj8LioWRHIyzGaFGr8Mw1L+UeJSVDEyIKNC7HI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JTgxaN1MVCURaVbWJ0Mop3h6yIMMv31TZDsxM36pyJnCFeIQpEaEqTXq+zaVBX0gOxSl92OhwW0VysRXPyc9Gq03FXIK9ufAxzBZuB7hR1cW00ilSnS2cKWD/etIsMx6LLduJFJHG1Fjt7uOueNQBwLchDgk2ERV/ban5skYlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1dpzp/n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754561586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6s2qakK1H83v7JhO0KIXmutVDDo4HtQJtj7wpDCCMpc=;
	b=e1dpzp/nS6WG82eNP1KgQz/yuj/yF6p7TUW4ZjfxLIjiRTfVDCnv8uMT26M3YyFEKqlisN
	lw/yfKxhaRK4SqyeWcMKEoXUgwXoSIRti1oUz3LPaAv08Nb3w5/3a+MiGKH0pVFuV4tX4A
	3WxJCZr8SCO/xMECdWXqrO7zfWJ9PQQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-zWALXjYdMTmhEIpmzFinXw-1; Thu,
 07 Aug 2025 06:13:02 -0400
X-MC-Unique: zWALXjYdMTmhEIpmzFinXw-1
X-Mimecast-MFC-AGG-ID: zWALXjYdMTmhEIpmzFinXw_1754561580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED5D319560AD;
	Thu,  7 Aug 2025 10:12:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A8A93001477;
	Thu,  7 Aug 2025 10:12:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1b3e0ed3-35c5-46ce-932d-02de9ba17ab6@samba.org>
References: <1b3e0ed3-35c5-46ce-932d-02de9ba17ab6@samba.org> <20250806203705.2560493-1-dhowells@redhat.com> <20250806203705.2560493-17-dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Wang Zhaolong <wangzhaolong@huaweicloud.com>,
    Mina Almasry <almasrymina@google.com>, linux-cifs@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 16/31] cifs: Rewrite base TCP transmission
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2577279.1754561571.1@warthog.procyon.org.uk>
Date: Thu, 07 Aug 2025 11:12:51 +0100
Message-ID: <2577280.1754561571@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stefan Metzmacher <metze@samba.org> wrote:

> > + if (server->noblocksnd)
> > + smb_msg->msg_flags = MSG_DONTWAIT + MSG_NOSIGNAL;
> > + else
> > + smb_msg->msg_flags = MSG_NOSIGNAL;
> > + smb_msg->msg_flags = MSG_SPLICE_PAGES;
> > +
> 
> I guess you want '|=' instead of '=' in all 3 lines?

Well on the third line.  msg_flags is 0 on entry to the function.

> I also think msghdr should be setup in the caller completely
> or it should be a local variable in smb_sendmsg() and the caller
> only passes struct iov_iter.

Yeah, makes sense.

David


