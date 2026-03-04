Return-Path: <linux-fsdevel+bounces-79323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIGbFtjqp2nelgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 09:18:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F951FC6AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 09:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8360030D0D73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3155389114;
	Wed,  4 Mar 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="WnReWmhV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B534C139;
	Wed,  4 Mar 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612023; cv=none; b=CGv5qg4mDqwOMBk4JBi/hAFyfGF9mFZDafh6rFaZJVVqD1FFJeb7SA5YR0IPoQdML5BYgqQqlrXJ2Y3EAqDNlsk58N68MRg0beiIsnROqqtyHyAP2Uf8Ke3FV5JYEaCQIjWZyylkcvnrDwsg62Z8EXAu585Ro0pqwb813MNA8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612023; c=relaxed/simple;
	bh=P9GJZeFpPX7LbX740rbXsIsxqHudijGY/adjBMcpt5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enFxVW4WM9ksiWvTV+vtPaNd0+Bi0zvtEOoGhP/6W/rlKWv8v0cDN6EkiLxWvoC5gm7LVdIMQ1K35tkYsfrWtEptKJnsESqvaytQdQswOikUkko41OWTqdKYifNH83xvr0+N7bF5tPbh+oDO3PHUnD1gpwInmwXOYUkrbkBrQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=WnReWmhV; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1772611671; bh=P9GJZeFpPX7LbX740rbXsIsxqHudijGY/adjBMcpt5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnReWmhV+02mCZj5vG4N3gT59a7+Bbt/bMRU6gwCVcjmUd/E9DIFB1jhaN4i0sWFv
	 QhAsL3wmx+n0E6cZgBUhEhLHb/yyJ1iEeDZV4bFNpaCRos+Zk5yzkhbNh2w+CZhwPQ
	 0Sbh9pc6UPIxVWWTY8uALpsELA9rlZtfA9fnIA1c=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69a7e857-e508-7f0000032729-7f0000018504-1
	for <multiple-recipients>; Wed, 04 Mar 2026 09:07:51 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  4 Mar 2026 09:07:51 +0100 (CET)
Date: Wed, 4 Mar 2026 09:07:50 +0100
From: Philipp Hahn <phahn-oss@avm.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: Drop dead assignment of num_clusters
Message-ID: <aafoVtFAmeWufmRO@mail-auth.avm.de>
Mail-Followup-To: Markus Elfring <Markus.Elfring@web.de>,
	linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <36b3573bb3e4277ad448852479f2cfea7a8ba902.1772534707.git.p.hahn@avm.de>
 <a53ff72a-6464-438c-8210-01834dc27512@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a53ff72a-6464-438c-8210-01834dc27512@web.de>
X-purgate-ID: 149429::1772611671-F46199E0-E01D280E/0/0
X-purgate-type: clean
X-purgate-size: 241
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: B0F951FC6AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79323-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail-auth.avm.de:mid,avm.de:dkim]
X-Rspamd-Action: no action

Hello Markus,

Am Tue, Mar 03, 2026 at 12:50:07PM +0100 schrieb Markus Elfring:
> > num_clusters is not used naywhere afterwards. …
> 
>                            anywhere?

Yes, obviously. Thank you for spotting this.

Philipp

