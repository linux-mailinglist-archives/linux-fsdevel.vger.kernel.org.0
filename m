Return-Path: <linux-fsdevel+bounces-78881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HNMDHhjpWmJ/QUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:16:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E57401D63F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAB38301F6BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90239E6DE;
	Mon,  2 Mar 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWz/wJq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD55399000
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446552; cv=none; b=Jn8MAHsZwkTECxm3rzNXdoETJeDKycbk1pt3/ObZxWY1+/ScWxmEBf08KOZWve4JpmsmN6cmFhpDLBkGL+uPHUI/suLmtVOz/rfSx+BMyATEwzcDtW+PVEWnx5lHbnv/icGfofDsxXDQi4NHYIH5hkKEJdcaXmYifwMnTWUbpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446552; c=relaxed/simple;
	bh=I7ttot40u9IpsWOSgKrSBYUTZtG6k/1UaMnoq/5aYcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glL0qCnTN3KlcinJi1qF+5OUNt+hhpTn/VWeoktDWOyzQQcEM62o7YWssC8eK4hvEm93x/AWFBIRAFkVRRCBmUH0soAD5DQ/xyCv+NtPTgnbevIP1SAHhhlIx+4nZMW9ODpLQXhf8BibfUbBNlInwrP6Xl/CuRXUS821nLxJDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWz/wJq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772446550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Nt9u/V9Fc/ykFf+eRLO4mIzzqQz1u88ZtONS7n3Oag=;
	b=BWz/wJq1wbg8xYefll/7XwIQLNwor9HqQvEUdHDjHFtNMhUj7OFElOO79Nlwyjy9yhdZ4+
	cf1fuMO6EF4G+tJ0DXM9cJSybTz8Es9yFL9T24jBtFdzRWO3ksoTcaLEq+hrCu2OmZImoM
	eNpNl5hCtEtE/RS274GJboN5J7G8HzI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-RsymwK4INuedX1EllCx00A-1; Mon,
 02 Mar 2026 05:15:45 -0500
X-MC-Unique: RsymwK4INuedX1EllCx00A-1
X-Mimecast-MFC-AGG-ID: RsymwK4INuedX1EllCx00A_1772446543
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BFE61956056;
	Mon,  2 Mar 2026 10:15:43 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07E6930001B9;
	Mon,  2 Mar 2026 10:15:39 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  Jeff Layton <jlayton@kernel.org>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Amir Goldstein
 <amir73il@gmail.com>,  Josef Bacik <josef@toxicpanda.com>,  Jan Kara
 <jack@suse.cz>,  Aleksa Sarai <cyphar@cyphar.com>,
  linux-api@vger.kernel.org,  rudi@heitbaum.com
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
In-Reply-To: <20260224-kandidat-wohltat-ae8fb7a57738@brauner> (Christian
	Brauner's message of "Tue, 24 Feb 2026 15:33:13 +0100")
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
	<20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
	<lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
	<20260224-erbitten-kaufleute-6f14e3072c5d@brauner>
	<lhuv7fmxo8y.fsf@oldenburg.str.redhat.com>
	<20260224-kandidat-wohltat-ae8fb7a57738@brauner>
Date: Mon, 02 Mar 2026 11:15:37 +0100
Message-ID: <lhuqzq2fsfq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,gmail.com,toxicpanda.com,suse.cz,cyphar.com,heitbaum.com];
	TAGGED_FROM(0.00)[bounces-78881-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sourceware.org:url,oldenburg.str.redhat.com:mid]
X-Rspamd-Queue-Id: E57401D63F6
X-Rspamd-Action: no action

* Christian Brauner:

> On Tue, Feb 24, 2026 at 02:30:37PM +0100, Florian Weimer wrote:
>> * Christian Brauner:
>> 
>> > On Tue, Feb 24, 2026 at 12:23:33PM +0100, Florian Weimer wrote:
>> >> * Christian Brauner:
>> >> 
>> >> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
>> >> > index 5d3f8c9e3a62..acbc22241c9c 100644
>> >> > --- a/include/uapi/linux/mount.h
>> >> > +++ b/include/uapi/linux/mount.h
>> >> > @@ -61,7 +61,8 @@
>> >> >  /*
>> >> >   * open_tree() flags.
>> >> >   */
>> >> > -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
>> >> > +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
>> >> 
>> >> This change causes pointless -Werror=undef errors in projects that have
>> >> settled on the old definition.
>> >> 
>> >> Reported here:
>> >> 
>> >>   Bug 33921 - Building with Linux-7.0-rc1 errors on OPEN_TREE_CLONE
>> >>   <https://sourceware.org/bugzilla/show_bug.cgi?id=33921>
>> >
>> > Send a patch to change it back, please.
>> > Otherwise it might take a few days until I get around to it.
>> 
>> Rudi, could you post a patch?
>
> I'm a bit confused though and not super happy that you're basically
> asking us to be so constrained that we aren't even allowed to change 1
> to 1 - just syntactically different.

I'm not happy about it, either.  But it has happened before, for the
RENAME_* constants I believe.

We are already including <linux/mount.h> from <sys/mount.h>, so we can
work around this reliably on the glibc side, regardless of header
inclusion order.

Thanks,
Florian


