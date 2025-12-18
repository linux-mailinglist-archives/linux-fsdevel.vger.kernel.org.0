Return-Path: <linux-fsdevel+bounces-71665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC5CCC0E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 14:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA5B30C05B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BF3375DC;
	Thu, 18 Dec 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMPO7uOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83032E735
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064994; cv=none; b=JMrcqrukKMBnKp6a0xKexElnj5RHvazN+yvFSCyrcq9zWhNteT2EtD8016qEzYhp2evNz2p8D+macKxX6hjZKiFQW+olkLFkZ+596T4rVBLO3MXVuNhkCMlwGV9s+E6JbOypfvvzFseJq3rMRL4a7bJyGY8GK3Cminmbsqx0efo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064994; c=relaxed/simple;
	bh=EnK/e7n0jfeqHE0rDLdKfLzHElXnURxxkoLBhU7kCo8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Wt1bCMGIbL+3gun7nUmlZB68cS0Re6rTmMh3XmMLvGo8JjX5iYIf0iHj/oPxwWq6ASuf48qjb8ytXys5adv2cS5MGYSiPMkVcspcNPPg/lMlMcTiSm2Jka+2pR3RBmBRzvwlMCan4bck/21AHUbrGcev5oXt5VFyAoXgRTwIyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMPO7uOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766064992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55MmONxQZjmCUfCxJczkWnRcFykYRDUdv6M6mibkb3w=;
	b=bMPO7uOoxelieuPR6uxOLDlY4gXOoZa4uiCS6TgbAuDBOGTTOMFXyS2sw6ETX1wl7Ia3Dg
	1SC3imwdVArF1FDSSqys9hb/pxVtV3EZNaTcv3jRI3MUUSLz+wEksu6QEztpj9L5kXuPir
	lXjvq/i82yWDEn1p6YRhK1Ei/DmPjfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-jb7mSw0INWy30PEt2GpQtQ-1; Thu,
 18 Dec 2025 08:36:28 -0500
X-MC-Unique: jb7mSw0INWy30PEt2GpQtQ-1
X-Mimecast-MFC-AGG-ID: jb7mSw0INWy30PEt2GpQtQ_1766064987
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80AF11800245;
	Thu, 18 Dec 2025 13:36:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7242180035A;
	Thu, 18 Dec 2025 13:36:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com>
References: <CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com> <20251201225732.1520128-1-dhowells@redhat.com> <20251201225732.1520128-2-dhowells@redhat.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Stefan Metzmacher <metze@samba.org>, Tom Talpey <tom@talpey.com>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] cifs: Remove the RFC1002 header from smb_hdr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <611043.1766064976.1@warthog.procyon.org.uk>
Date: Thu, 18 Dec 2025 13:36:16 +0000
Message-ID: <611045.1766064976@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Namjae Jeon <linkinjeon@kernel.org> wrote:

> Why did you only change smb client after changing smb_hdr structure in
> smb/common?  smb server also uses smb_hdr structure to handle smb1 negotiate
> request.

Apologies, but I was under the impression from Steve that ksmbd didn't support
SMB1 and was never going to.  Further, I'm pretty certain I have been building
the server and it hasn't shown up any errors - and Steve hasn't mentioned any
either.

> Also, Why didn't you cc me on the patch that updates smb/common?

You're not mentioned in the MAINTAINERS record for CIFS.  I did, however, send
it to the linux-cifs mailing list six times, though.

David



