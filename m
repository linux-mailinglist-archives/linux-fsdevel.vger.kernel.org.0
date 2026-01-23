Return-Path: <linux-fsdevel+bounces-75267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JOrLKlec2l3vAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:42:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18E75431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89AE53074B9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54F37FF60;
	Fri, 23 Jan 2026 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+2PV+JD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179636C580
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168249; cv=none; b=TpP2RvC/0So7b9eznW43SBcel6eC0deM8pdpqtJq/OEy16T9HF2oquY93uKQotGNJE+8QxgQSNFjnruAFNbGQi7Wu2x2MPUFYVM2Km1CGg035pUSU8mkDb81dxpAX4+is7bPCYC7LhsbDpIApNJl+mkdawNbJH+bo6bRdRDrumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168249; c=relaxed/simple;
	bh=e259cDOR2x8y2PNY1VZBUyduw1cVUirqqxjpTqnIsNA=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=LaMteiC+ArThnG9WF3FvHa6unXBMVsMH7YCxH6l+SvfyffToQQniFdDp+GP2ocRW9+APTuV9fLPMS3DBKEygATzWDPTcl/pt7qGhCcl52QPed4473Qb5WW4N5Ia16kN4yr5naqLWU2j18Zt7uRpHZa8iZbEkDak2HCvg6RqMqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+2PV+JD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769168246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xs0Vg5nji+dUGsW7zgyizne5BIyRwd0ccrRHXi+VavY=;
	b=W+2PV+JDf31XJIExQ2gQFYdoxvGstUyeSH1PZ7k2eU/GEL3kCkoVaqmxcflPfu67FELVrj
	4nkJOA3+/W1ZwT+tbw7elnw3z8D1SfMJ/qyiYjtpkHhFcvlYqYzmjyM+OxtNsJ/7NvxcCk
	C/ItCLTH6FFcdHfvY2lgKKtYHeIMAj8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-cxzqkuf4OhGk9R5ZCIISSw-1; Fri,
 23 Jan 2026 06:37:23 -0500
X-MC-Unique: cxzqkuf4OhGk9R5ZCIISSw-1
X-Mimecast-MFC-AGG-ID: cxzqkuf4OhGk9R5ZCIISSw_1769168241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D8AD1800342;
	Fri, 23 Jan 2026 11:37:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDB1918001D5;
	Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20260119074425.4005867-4-hch@lst.de>
References: <20260119074425.4005867-4-hch@lst.de> <20260119074425.4005867-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Christian Brauner <brauner@kernel.org>,
    "Darrick J. Wong" <djwong@kernel.org>,
    Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
    Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
    linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1754439.1769168181.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Fri, 23 Jan 2026 11:37:17 +0000
Message-ID: <1754475.1769168237@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75267-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 5B18E75431
X-Rspamd-Action: no action

Christoph Hellwig <hch@lst.de> wrote:

> +static unsigned int get_contig_folio_len(struct page **pages,
> +		unsigned int *num_pages, size_t left, size_t offset)
> +{
> +	struct folio *folio = page_folio(pages[0]);

You can't do this.  You cannot assume that pages[0] is of folio type.
vmsplice() is unfortunately a thing and the page could be a network read
buffer.

David


