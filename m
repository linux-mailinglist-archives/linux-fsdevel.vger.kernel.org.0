Return-Path: <linux-fsdevel+bounces-78255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHiOCpSLnWn5QQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:29:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88850186471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447FA31B55FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED0837C108;
	Tue, 24 Feb 2026 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA1oCsCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E337BE8F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932229; cv=none; b=rl4e1cuZzchS365PHWTQ+YippQ2EsSMKEuIbfGoEsIsMQc97riYxiXtz5kED0IcC3b3MvptU9XGyMPyobsw3vrE2j18F/O49UTNwH5SYxCRfMHae+vjiT2Wu/SazQ3pxwClKmK6fQesPP6Gf5XnUBeBOd+sK/2YhSxUKH4pIpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932229; c=relaxed/simple;
	bh=pqbpubc3SgE/vzzLlA+7qoAjLDjHD6vu1AUhctqdf+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jDDJw1NRHCU3SvkURuR5Pv77DZUjPMiIACav0Z2iiidhi6dwrVZrT2WFuzROtiZZaXgsZ6LQId9/KHIuLxROEB058NkJSu4HNjWNAwaoVy7P+a38AtOB5L1daq2Xp70T3PFOrlz4aEj/m03X0/xnPvyChZGuxoi6j/gKPGFrJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA1oCsCB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771932227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfGKnBQ3ObbG8Yw8OpNOKHf6B/V3WX+Q13hI/DT1Aho=;
	b=UA1oCsCBG4vmSanjkbBgBz82u9J8w5k1rK8GXXCyN5XkaBmumwg7zDvZueRCUInunXJgh7
	cgC8N2miJPu6WxUL0Zk5Jmob/lUYQm3Sbi8mKDnVz2WwNZwkl6awZP3eiqzcB4L3FjBLhm
	FkFGlZTmVyV6P7GEqlBZ1+ZsVsyidM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-3rrS1RrGM3C4xJUdb9WXPg-1; Tue,
 24 Feb 2026 06:23:41 -0500
X-MC-Unique: 3rrS1RrGM3C4xJUdb9WXPg-1
X-Mimecast-MFC-AGG-ID: 3rrS1RrGM3C4xJUdb9WXPg_1771932219
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BC961956059;
	Tue, 24 Feb 2026 11:23:39 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.226.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDA511800666;
	Tue, 24 Feb 2026 11:23:35 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  Jeff Layton <jlayton@kernel.org>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Amir Goldstein
 <amir73il@gmail.com>,  Josef Bacik <josef@toxicpanda.com>,  Jan Kara
 <jack@suse.cz>,  Aleksa Sarai <cyphar@cyphar.com>,
 linux-api@vger.kernel.org, rudi@heitbaum.com
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
In-Reply-To: <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
	(Christian Brauner's message of "Mon, 29 Dec 2025 14:03:24 +0100")
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
	<20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
Date: Tue, 24 Feb 2026 12:23:33 +0100
Message-ID: <lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,gmail.com,toxicpanda.com,suse.cz,cyphar.com,heitbaum.com];
	TAGGED_FROM(0.00)[bounces-78255-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url]
X-Rspamd-Queue-Id: 88850186471
X-Rspamd-Action: no action

* Christian Brauner:

> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 5d3f8c9e3a62..acbc22241c9c 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -61,7 +61,8 @@
>  /*
>   * open_tree() flags.
>   */
> -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */

This change causes pointless -Werror=undef errors in projects that have
settled on the old definition.

Reported here:

  Bug 33921 - Building with Linux-7.0-rc1 errors on OPEN_TREE_CLONE
  <https://sourceware.org/bugzilla/show_bug.cgi?id=33921>

Thanks,
Florian


