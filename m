Return-Path: <linux-fsdevel+bounces-56968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6DB1D58E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6811883988
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2322586EA;
	Thu,  7 Aug 2025 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGlN3aiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D422A1E1
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561670; cv=none; b=fY9V5PqrNyMq0F4ofwY5+8BP3JWxHHsCNg8S/+VJIVrKZliwZMMimCpHUskS9bxgL19nwIeqDktsIppljcdI1skbXaznO95iJWW3waS0v9k/dk5DFojDczo9lZjcwcDkj1Q4IbW9UDbe85G6D80DUX3J0t6DRv/MSQtHRagissM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561670; c=relaxed/simple;
	bh=qqgetxXoB79LbqPMFDraeWtm6ShkuPtCd6FJzkqn344=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=cH/yuzYSs5DY+jDbVJlZ/7DINXgAPsLIY+iqiiARR2uTZ593kviHfQA1P89YLX3FPsF5dvA2Pb3rx/Ke5QcOIZK9cEDQJRhGCvDIEQgOwDHBao3qLSsKFRHtkny1CkTqXm0VfpYaM0d1JuCw5y3BSKpPdeWZSEsGjtKrhPM/Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGlN3aiS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754561667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqgetxXoB79LbqPMFDraeWtm6ShkuPtCd6FJzkqn344=;
	b=AGlN3aiSscOoMq0oYfNnWvXo6Th1Vmw0z5OTiSaOiD1G5SFfGeNymXi4TwGdKoZj74zzfw
	UKUwXCETAGIOXhOtg7kGf8G1tdU6xurJJLHBMLrmvfNUb9mUYABCWXnSGimDKiyaWl/oK0
	plyX9Ysl4QK8c7lpm61HWz7whIDOQ9M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-ZtUGMtRfPeaSw6lW-81MFA-1; Thu,
 07 Aug 2025 06:14:22 -0400
X-MC-Unique: ZtUGMtRfPeaSw6lW-81MFA-1
X-Mimecast-MFC-AGG-ID: ZtUGMtRfPeaSw6lW-81MFA_1754561661
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 934D11956050;
	Thu,  7 Aug 2025 10:14:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BCF2180035C;
	Thu,  7 Aug 2025 10:14:17 +0000 (UTC)
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
Content-ID: <2577379.1754561655.1@warthog.procyon.org.uk>
Date: Thu, 07 Aug 2025 11:14:15 +0100
Message-ID: <2577380.1754561655@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Stefan Metzmacher <metze@samba.org> wrote:

> > + smb_msg->msg_flags = MSG_DONTWAIT + MSG_NOSIGNAL;

And whilst I'm sure addition works, I would much rather that be bit-OR.

David


