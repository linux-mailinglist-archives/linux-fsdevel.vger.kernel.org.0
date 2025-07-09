Return-Path: <linux-fsdevel+bounces-54389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B43BAFF2E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C771C22325
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8220245025;
	Wed,  9 Jul 2025 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcqVFIA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB974242D78
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092566; cv=none; b=MuY8huxkfz1Isu1nagS4UMRc93lNJ9kXLnMGvRwKb2H6S2Ah9CVAfwIRzlQdbIPQkh4nr0Fy+aIR3xKeR+HsWd3s8FU/Pcrxj960oOo068p5Okinr+QFLd8Jse32E1z+EVQfJlKDvH2NMAsXikx7qwU+gFYrkqzhVU7VOLWmbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092566; c=relaxed/simple;
	bh=/9Kns4ZXz/Qn4PrGGI5OGogJEIPcnnOmSvL0JleJ6ik=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kU1Cd2S9Dn4TalMiCDxMiAF+TZgoSRc5ZMpsal4bqNjS0Nwq6gbYqX8PkrS8t75l7ybRq33TfVZAUELBBbrTQI7x6JckPnfJpOyW5TUjEZal4Jhon/Vkd8CFGWclNRfmEnM8YfC24wOMJcv6ZRQ5Vi30BvCX9kdfFyCD8LajudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcqVFIA8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752092563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDiGMlKKETCealBEfy16p098aY14pQYAB7sWpWAIJfI=;
	b=HcqVFIA8VWkBi1CFM24kVvXEFcmZ+sdPvl9/DJKh5D4P1G4IJpDVRZ77g6zzguJfilrPfu
	UJasySGgFtIH16XRR4drdVaFZqCp+/pN6FFlFkBTfONBAOAAgq7qVi4/IfyNFJaZn1fVnK
	BqQENbNGRmIzl9lIJlZrmXZOr0kh9n0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-lFtj-QW-N8iv7MzdbQf7tA-1; Wed,
 09 Jul 2025 16:22:40 -0400
X-MC-Unique: lFtj-QW-N8iv7MzdbQf7tA-1
X-Mimecast-MFC-AGG-ID: lFtj-QW-N8iv7MzdbQf7tA_1752092558
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF21B180028D;
	Wed,  9 Jul 2025 20:22:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 989511955E85;
	Wed,  9 Jul 2025 20:22:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
References: <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com> <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com> <2724318.1752066097@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
    netfs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2738561.1752092552.1@warthog.procyon.org.uk>
Date: Wed, 09 Jul 2025 21:22:32 +0100
Message-ID: <2738562.1752092552@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Max Kellermann <max.kellermann@ionos.com> wrote:

>      kworker/8:1-437     [008] ...1.   107.149531: netfs_rreq:
> R=00000065 2C WAKE-Q  f=80002020
>
> ...
> (The above was 6.15.5 plus all patches in this PR.)

Can you check that, please?  If you have patch 12 applied, then the flags
should be renumbered and there shouldn't be a NETFS_RREQ_ flag with 13, but
f=80002020 would seem to have 0x2000 (ie. bit 13) set in it.

If you do have it applied, then this might be an indicator of the issue.

David


