Return-Path: <linux-fsdevel+bounces-78262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOlZA8+onWnRQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:34:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7278187C1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC1423067E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9A39E180;
	Tue, 24 Feb 2026 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeID7xlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF53815C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939848; cv=none; b=HCQ1cR9ytG219wPqvTQJEMbuvoG4F6Ri9bo5dw7EXvMGyygHK71HHvUWkAX6YG3j2v1BWbfAINpSzFdpaXowb3LXe3bmo+5lwUk4KSoJreBClHgPg9uThoRw6QoecvJoCehv+EMkLj3dWltkPsT0bAnJthY0w4KS+y61jVhRAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939848; c=relaxed/simple;
	bh=/TZ/AG5Kc0xtO9W0moZJcN0I9hdCsXW6hBm9rKTSrZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YgdBqMk0m9e+lUSG8VwgxxaT0WK+yF96Acp5VhmGU2xA3aKqyiAClQpn5TaHqwNUf4MQLXBNVLR109d1DBoDWbh5eZczfNwR/Bws0zdxVuPQMa64p0WWpbZwgamL2Hz16Yifr4uFE2gJqYqZEiMSAJDE+FoysiBVFgxi6H0chJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeID7xlx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771939846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6c20ZLI9McCTXb0oIWc48mGaBegUBJyrFiDcNdbceSQ=;
	b=PeID7xlxn1ZOO6VqkknPSbguF74JAcAOQ8MKyeMGP5kYwwq2NNPv9tt1NBxkF1FNPd33XJ
	4I/2Fl6ItJnmXDDzC4lxV8cjLNax8Xe6HG9VCmQfP+l4YonCDjcuWjmo+PzweyOcSrM2dS
	2TQO8ZuLLzE4QG0WANJoxX1KXCeiT9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-EUYAjSEyMPmasDyasY9NEQ-1; Tue,
 24 Feb 2026 08:30:44 -0500
X-MC-Unique: EUYAjSEyMPmasDyasY9NEQ-1
X-Mimecast-MFC-AGG-ID: EUYAjSEyMPmasDyasY9NEQ_1771939843
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAF951800758;
	Tue, 24 Feb 2026 13:30:42 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.226.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 968FE19560A2;
	Tue, 24 Feb 2026 13:30:39 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  Jeff Layton <jlayton@kernel.org>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Amir Goldstein
 <amir73il@gmail.com>,  Josef Bacik <josef@toxicpanda.com>,  Jan Kara
 <jack@suse.cz>,  Aleksa Sarai <cyphar@cyphar.com>,
  linux-api@vger.kernel.org,  rudi@heitbaum.com
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
In-Reply-To: <20260224-erbitten-kaufleute-6f14e3072c5d@brauner> (Christian
	Brauner's message of "Tue, 24 Feb 2026 13:05:12 +0100")
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
	<20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
	<lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
	<20260224-erbitten-kaufleute-6f14e3072c5d@brauner>
Date: Tue, 24 Feb 2026 14:30:37 +0100
Message-ID: <lhuv7fmxo8y.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
	TAGGED_FROM(0.00)[bounces-78262-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: C7278187C1D
X-Rspamd-Action: no action

* Christian Brauner:

> On Tue, Feb 24, 2026 at 12:23:33PM +0100, Florian Weimer wrote:
>> * Christian Brauner:
>> 
>> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
>> > index 5d3f8c9e3a62..acbc22241c9c 100644
>> > --- a/include/uapi/linux/mount.h
>> > +++ b/include/uapi/linux/mount.h
>> > @@ -61,7 +61,8 @@
>> >  /*
>> >   * open_tree() flags.
>> >   */
>> > -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
>> > +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
>> 
>> This change causes pointless -Werror=undef errors in projects that have
>> settled on the old definition.
>> 
>> Reported here:
>> 
>>   Bug 33921 - Building with Linux-7.0-rc1 errors on OPEN_TREE_CLONE
>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=33921>
>
> Send a patch to change it back, please.
> Otherwise it might take a few days until I get around to it.

Rudi, could you post a patch?

Thanks,
Florian


