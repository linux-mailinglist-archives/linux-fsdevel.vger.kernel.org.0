Return-Path: <linux-fsdevel+bounces-64845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEBBF5A8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DC5189F983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E22EBDD7;
	Tue, 21 Oct 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb8llk/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B38283FC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040638; cv=none; b=E3SWaVriPblyIdVK7jPJ4t934Zmt5hBqjmLB6+t+1f7AQVPWsfB423H80/Ddm0/3fl1tLRGZBYq2z/D6GyvJWxGAhx94NbVYaWG3GT5JW3eiWj88buxi7wmecIdhYM3rwtk7VYQL1tgCUiqausN5gLfpIsig6QZiVNGSCNHlYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040638; c=relaxed/simple;
	bh=I6pbfqSQUl+DjgnQthnXu/sYVH7A8EPpq9zQ0gYEGUY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FKkSenMRNmcC0i2fP+bMaOi/UgSbnOn5iLI2SL/iBFztAyF/AeCmfmZIr24He6BxDKJrnAviACBdQ8llxlefn0u5Z2qamQddw0ry5W19bTGEsiTrfZvvu0UpBI6rTzHt3vxe+P+czat0WcyZ68YEL/rv5QvHl4iKKY8AJr4UcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb8llk/P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761040636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6pbfqSQUl+DjgnQthnXu/sYVH7A8EPpq9zQ0gYEGUY=;
	b=gb8llk/PyoHUaxwdd8mOFYDHzK8SvaV98NOvCDby6wnjt8kaZZFwaF6YhozisYA3TAEZwm
	VMUIvlHb75GPJ36cc2Rvu3fNeKSt8goQzPWyst9xEvSJnLg8r9T9D3MDIO3ZY7m5Jt+cAa
	XwqlxyWZGPnIUzf2QZOwNoFM9gcMC1M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-hTsYYNwTNP2h93CzYBQ35g-1; Tue,
 21 Oct 2025 05:57:12 -0400
X-MC-Unique: hTsYYNwTNP2h93CzYBQ35g-1
X-Mimecast-MFC-AGG-ID: hTsYYNwTNP2h93CzYBQ35g_1761040631
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2726E1956086;
	Tue, 21 Oct 2025 09:57:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B925A180035A;
	Tue, 21 Oct 2025 09:57:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251020081733.18036-2-alessio.faina@canonical.com>
References: <20251020081733.18036-2-alessio.faina@canonical.com> <20251020081733.18036-1-alessio.faina@canonical.com>
To: Alessio Faina <alessio.faina@canonical.com>
Cc: dhowells@redhat.com, kernel-esm-reviews@groups.canonical.com,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [SRU][B][PATCH 1/1] afs: Fix lock recursion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1475046.1761040626.1@warthog.procyon.org.uk>
Date: Tue, 21 Oct 2025 10:57:06 +0100
Message-ID: <1475047.1761040626@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Alessio Faina <alessio.faina@canonical.com> wrote:

> To: kernel-esm-reviews@groups.canonical.com

Did you mean to cc everyone on this?

David


