Return-Path: <linux-fsdevel+bounces-77157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMJVLW5hj2nNQgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:37:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3CE138B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1F903008251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E021B9DA;
	Fri, 13 Feb 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQn1MuDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589032C3254
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004268; cv=none; b=UasOr/FCgxqLu4m9IfNh2zYrcFRjn4mX0pmQz23rHYq6AmhVGuwTKh1xn9fHER5KxjCqJQ+7FrHJSq1zKwZaHNHRr0dQobVnMtZhEQG8yh6p6cZgKDfmqOqsD1OUodgY4KhyVaCD5xiDiICpOaBIkVuuKvM57h4MfrZbf0nExnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004268; c=relaxed/simple;
	bh=EgBwpWeLwz1UrQO0dIKzUCCaqbsJxHb//WLTogd6Dno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAWq30dUKEy9O/TlzoOVHDXP39LHOqQjKlPonTBo1BW+mSp2jKlzCI0Ta0f1uR+efGpkGLavFxXwKHS89M+q8qqaAbEhoURjXvH5No3x9IwZMCB/PY1dR89uVhX9YVqM6vbVQhvSI3GIQ1RE8nJ4DhMx4+fINJsITp5+T0nYd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQn1MuDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771004265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rsDR/ET0lYEpRK5loeA/7Ts7ePUXyHDXnuCGcmA5rlc=;
	b=NQn1MuDeN8/jQz7xgpBuQJ/TTz/HKAqyoPlL3EzrULk6Xn0TL2s1Rsq6WUHgApDJoKNStb
	7TkvL+CdMMyi58mav2dVvOqHoYMQ/uVheN54xwcPE8Kl1hmLSddp32N+6b/cExUwXyXWdO
	qMYZ+kBhzHNQkS0aq8+QxswVIFEU5xo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-qz81QV6TPKmg0igwDDprTQ-1; Fri,
 13 Feb 2026 12:37:43 -0500
X-MC-Unique: qz81QV6TPKmg0igwDDprTQ-1
X-Mimecast-MFC-AGG-ID: qz81QV6TPKmg0igwDDprTQ_1771004263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7861180061C;
	Fri, 13 Feb 2026 17:37:42 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 337B919560B9;
	Fri, 13 Feb 2026 17:37:41 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:37:39 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aY9hY7TwgMXJNzkI@bfoster>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aY6_eqkIrMkOr039@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY6_eqkIrMkOr039@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77157-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C3CE138B30
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 10:06:50PM -0800, Christoph Hellwig wrote:
> This patch makes generic/363 and xfs/131 fail on zoned XFS file systems.
> A later patch also makes generic/127, but I haven't fully bisected
> the cause yet.
> 
> I'll see if I can make sense of it, but unfortunately I've got a fair
> amount of travel coming up, so it might take a while.
> 
> If you want to give it a spin yourself, you can just add '-r zoned=1'
> to the mkfs arguments for the test and scratch device.
> 
> 

Ok, thanks for testing and reporting. I'm a little buried atm as well,
but this isn't the most pressing series anyways. I'll dig into these
tests when I spin back to this..

Brian


