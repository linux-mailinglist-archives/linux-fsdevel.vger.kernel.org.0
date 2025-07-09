Return-Path: <linux-fsdevel+bounces-54371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C2AFEE7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B17B406E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED01FBE9B;
	Wed,  9 Jul 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDKWeJ/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9571C3C04
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077052; cv=none; b=GYNMGDCsm/wd0BKb/2qyNcOZbcozwANuDTerOojdlhloayB1cDGlrDnlla/zLbfLsY0DwPaS3e3JUsvF88zwqrwB4aQV03Q1Qd9yW/YxYxzTdYCsz6UQ3LQvl94rNQPQ/DHK7eiLEmvgMAXChyq53w+o9028/KPH20/W2MEYJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077052; c=relaxed/simple;
	bh=i3ZcrxUeGN+REuzZS1FQahN/BXcB/ZZRuCI1JLJJIJQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ApjCUp8vF7eRUKDacXtInU391istL11FXAWzu4KJY8TW2NkkXjAiDPhGzHwTI5k5uWji6UHEM/FQ9+oD7e3huQeKM9URQyQiIYkrCeri7ghzdr0haiRUnrkmdTavWecf42yawvLZojoZm/NqbZ0F4w2KWywragQRLhFob76utDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDKWeJ/w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752077050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3ZcrxUeGN+REuzZS1FQahN/BXcB/ZZRuCI1JLJJIJQ=;
	b=jDKWeJ/wpghVrVI/ZN2UEKqpLuWHVPcurAPP5ZeCJ0n17rX29Dq/FhMw3xnwBJ369s7gZE
	bMfm5pTZBPLjoKC/xx/O/vFZeOEEoQ8WYAOoNEVBwBULaq+6VsQIKqn4SE5Osxc7/1EQOE
	NrBdpTR0oXGYQY9JD4Mgzr3cxWdeJ0A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HYXudR29PqKtraIOeLv7Wg-1; Wed,
 09 Jul 2025 12:04:06 -0400
X-MC-Unique: HYXudR29PqKtraIOeLv7Wg-1
X-Mimecast-MFC-AGG-ID: HYXudR29PqKtraIOeLv7Wg_1752077044
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16261955EC3;
	Wed,  9 Jul 2025 16:04:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 327E719560AB;
	Wed,  9 Jul 2025 16:03:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
References: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    brauner@kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, wozizhi@huawei.com,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH] cachefiles: Fix the incorrect return value in __cachefiles_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2731906.1752077037.1@warthog.procyon.org.uk>
Date: Wed, 09 Jul 2025 17:03:57 +0100
Message-ID: <2731907.1752077037@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I think this should only affect erofs, right?

David


