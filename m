Return-Path: <linux-fsdevel+bounces-76873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANrHOpWDi2l4VAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:14:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BF11E8D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FF53300809A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF538B7AE;
	Tue, 10 Feb 2026 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUXXfrcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0632B996
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750861; cv=none; b=V/BMngrWN0k8ujS521p82OryQQtPmLVdIgt84Fkjy8icnP0NospVVQ2eLL6DpQRHR1SO2KkMDOKP6PHyYdqY6vRk2sem2OtBf0wnhIUpdkjocx2xIdZM0PBpahS8tlgEhcSweL5CtxxGXseaTjiQBGNWpjwPCtiQUoD1ZHKfrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750861; c=relaxed/simple;
	bh=a2MedpXYJ/WWBxJR4ZubXioWf8I0yl8QMk755YFCpWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5ciLjeXuHQ6AH1/0cntYwJDnNnyROrlLJ0ZGUpcYJCv2TLaAkhWOKtNz54dgVC/MfVW4irkuxtxebe5or9rvxXnd3HIxmPqnLdW271jTOcT0n1O9+kqcO5bci9GCzw1AN5ysx/3+1lUrhuONlPn/sKbkwsGJ9k6ixwDiEgQirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUXXfrcl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770750859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dcj/eGMjgm49uADtPlV4T2MT7+Gx/kjw3bCB2opkvMg=;
	b=KUXXfrclazYzdkh6iYCg4/m1NJ6tctBXezAD/RSJ1p3juY1A4aYynD2AoKGEkjLDBXWlwr
	H9AkPL+QwsZoqgS+mXgnqFkm3fVOacXjVCnJGISG+vcXH69EmbmIKRlXIGcM6gCpC9QUk8
	uucVEJ+pkcB7bzxRD5SC+PxDaoujTFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-h6J-58aiOkKKK2UjE9g4mw-1; Tue,
 10 Feb 2026 14:14:17 -0500
X-MC-Unique: h6J-58aiOkKKK2UjE9g4mw-1
X-Mimecast-MFC-AGG-ID: h6J-58aiOkKKK2UjE9g4mw_1770750857
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 043761956095;
	Tue, 10 Feb 2026 19:14:17 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ED5119560A3;
	Tue, 10 Feb 2026 19:14:15 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:14:13 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aYuDhQj_xw3ByeD5@bfoster>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aYtZtuqy72C0VvnQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtZtuqy72C0VvnQ@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76873-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F33BF11E8D8
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 08:15:50AM -0800, Christoph Hellwig wrote:
> This looks sensible to me.  I'll add it to my zoned xfs test queue
> to make sure it doesn't break anything there, but as the zoned
> iomap_begin always allocates new space it should be fine.
> 
> 

Thanks. As you've probably noticed from looking through the rest of the
patches, this one is mainly a lift-and-shift initial step from iomap to
xfs. Let me know if anything breaks.

Brian


