Return-Path: <linux-fsdevel+bounces-29739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43D97D214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1515D1F22F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8965C55E53;
	Fri, 20 Sep 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkD6VF9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BB55897
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818969; cv=none; b=p/KK9VNXDghd2ToYmLVbNpBVDZ03GIks/8Uox1QLv2L3Xnp2Zh69iTc0wQpQTCXHDcFIp/FwDA9QyZVQu6kRg3kdSh9OEZzNC430p00Gcj/Aw4icMlgb6+o7SvktBXXp+jmrG+0bwBp/CsOHAajdg79h8FBoGHtCUshkkWdcQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818969; c=relaxed/simple;
	bh=C7IDua6EawjdEcIJaE7LTAA+4As55cS6y6AK6voJ8s8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=U0Q/c7G33LiMloWfUhOm2J98gDt1TQnyTN+J1rMS+ndtCcxA+SXOPWWhQLtFsZgY7syhk9wylT2i9YNEewW3kGlU4fv+VlgaYV0G2SIkd2jZc7/yg74NZGy0164vWaootk6rDgwFXtLoyjobMgoJX0xe5ODEhJP8sl8HpB1ezbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkD6VF9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726818966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+vleRJLK4k0OA6401hU7KovWoC/9SiI6aj+djeXR6g=;
	b=EkD6VF9nm/6/l5SMpYcq/h0ErbEV3zfaUuLeovVyY+KdZT3Ugo/Pn7sxJB9xFEfn4paf99
	ti9CuQ3M7dCP1wKetC3Wa8QgenXmpSEH6B5MHAAEVEo98GaKlkYlSWAohA7zCL4KKWZY+n
	xFebLy1WpbaYg14Ep+TN4/7cOZUVF98=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-EJRZRXN7NvG8DCM7XRUOfQ-1; Fri,
 20 Sep 2024 03:56:03 -0400
X-MC-Unique: EJRZRXN7NvG8DCM7XRUOfQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7244219792DD;
	Fri, 20 Sep 2024 07:56:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CEA11956052;
	Fri, 20 Sep 2024 07:55:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zu0X6JWpvxhzT6/x@xsang-OptiPlex-9020>
References: <Zu0X6JWpvxhzT6/x@xsang-OptiPlex-9020> <ZuuLLrurWiPSXt7X@xsang-OptiPlex-9020> <2362635.1726655653@warthog.procyon.org.uk> <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020> <202409131438.3f225fbf-oliver.sang@intel.com> <1263138.1726214359@warthog.procyon.org.uk> <20240913-felsen-nervig-7ea082a2702c@brauner> <2364479.1726658868@warthog.procyon.org.uk> <2537824.1726730090@warthog.procyon.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Steve French <sfrench@samba.org>, oe-lkp@lists.linux.dev,
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <137582.1726818957.1@warthog.procyon.org.uk>
Date: Fri, 20 Sep 2024 08:55:57 +0100
Message-ID: <137583.1726818957@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Oliver Sang <oliver.sang@intel.com> wrote:

> have you enable the samba with a /fs path? such like:

Ahhh!  That's what you're doing!

> > > > Can you tell me SMB server you're using?  Samba, ksmbd, Windows,
> > > > Azure?  I'm guessing one of the first two.
> > > 
> > > we actually use local mount to simulate smb. I attached an output for
> > > details.

I was misled by your answer here.

Okay, thanks.  It doesn't help, unfortunately.  I think my test machine isn't
oomphy enough to trigger the race, but I know someone else at RH who can
reproduce it, so I can work through them.

David


