Return-Path: <linux-fsdevel+bounces-79408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEUZG5dNqGmvsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:19:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B896D2027E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892133052880
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29531AA87;
	Wed,  4 Mar 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Pyngn3af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910A31E837;
	Wed,  4 Mar 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637163; cv=none; b=FuEQXin1dSJWKte7xsCg/OQrAwJrpdlWcZzgA77L3haUiM67Sa/VRkmWa997lyvIeihhbSB7SYorPhSaQOvoGHBZg9yfsP96t0ou2QP3bOfoWU8W/CMCTiLKYhLQYMkMA53Gy1cfYdNxEsTHrDnLzMgwdedAB1rjPvlwvIknGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637163; c=relaxed/simple;
	bh=NP4yQpTfMiCiMqMHWpvb+nWALp4qXIG5+BpIrlEB63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDDaOXAOar4ACpLB0pYx3IrEZ/3FozTMiSX7t1E6DjpNzg5+CqjqcmcXFRzb/WLu3NVP5FYWHY2FgslcIyM0ZH+Pg82OHLv2+KkEOIGNnom1djgZE+M1Wc440zGxAkRWU/Vp1Y/I4crxi+EJ0u15AghpQ4NKOa3E5pHpIVTxLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Pyngn3af; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1772637156; bh=NP4yQpTfMiCiMqMHWpvb+nWALp4qXIG5+BpIrlEB63Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pyngn3afmeM/otdXbGqW4sCz6Ut9eVZrYqxzz/qZF1+T4Ky8a3sqypZh/FWep43VF
	 ikl/uLX7MGX6lvq+01gTFe3aTT5a9YsVX+qrvge2+3P6uL23wHwMKHL9U6EebYbGnu
	 aFByNNmN93Xq+J9C8kc5dkmTbihjnzbtYmElusDs=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69a84be4-2367-7f0000032729-7f0000018636-1
	for <multiple-recipients>; Wed, 04 Mar 2026 16:12:36 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  4 Mar 2026 16:12:36 +0100 (CET)
Date: Wed, 4 Mar 2026 16:12:34 +0100
From: Philipp Hahn <phahn-oss@avm.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Subject: Re: exfat: Fix 2 issues found by static code analysis
Message-ID: <aahL4icRtdiZIhwC@mail-auth.avm.de>
Mail-Followup-To: Markus Elfring <Markus.Elfring@web.de>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
References: <cover.1772534707.git.p.hahn@avm.de>
 <10c20860-e879-4679-b9fb-e65c301a0b24@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c20860-e879-4679-b9fb-e65c301a0b24@web.de>
X-purgate-ID: 149429::1772637156-BACB9E1F-1FCA24EC/0/0
X-purgate-type: clean
X-purgate-size: 997
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: B896D2027E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79408-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,avm.de:dkim]
X-Rspamd-Action: no action

Hello Markus,

Am Wed, Mar 04, 2026 at 09:40:37AM +0100 schrieb Markus Elfring:
> By the way:
> It can be helpful to number prefixes according to message subjects in patch series.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc2#n711

Yes, thank you for the reminder.

> > I'm going through our list of issues found by static code analysis using Klocwork.
> 
> Does this tool point any more implementation details out for further development considerations
> (with other software components)?

This was a run on our internal version of exfat, which matches
'github.com/namjaejeon/linux-exfat-oot/for-kernel-version-from-4.1.0'.

Klocwork found no other issues worth fixing in that version.

If my time permits I will run it again on latest 'linux-7.0-rc`
respective 'master' to see if anything "new" crept in.

I'll also report any other findings outside of exfat when I find them.

Philipp

