Return-Path: <linux-fsdevel+bounces-78263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPI8Fm+qnWmgQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:41:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D71187E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F9E31AB2D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5302A39A806;
	Tue, 24 Feb 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="BkgfNWYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5236CDF4
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940058; cv=none; b=hZNK5d9Wab8V1LeeWq1vncfu1hM6qfABC4npPHTXrXi4XC4BLRU2WZRjIpIX8VKUg7NOFQyHFbHOs0Mktux/xiFmeJSDu9dgRxdQMBiAw5Z5RfNgJBJJHiAol78tA/PemnSbi3Z4NvG2sXDw33Vzhw48to91ajb/KEg7E5qAcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940058; c=relaxed/simple;
	bh=pbJuBwrGiFvLSeEEiP9VFTHTVlzvnp9pgTmeouYlAEE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=G5xHv74mgow6kgN1oAYNCS0J/j9mk3QAUhqShU/nSMerQ4mG+gL96dQHJarL3PRH3WpLOoVwjNGg4yV7CywjO1kDdhsvj2KoME+38J4wBjBXOL9uB2UjXXcxsAmqMyqAuhJSqAXLYD/YoOTDYpXS6cM6H6/zLP7vdHIshNxOOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=BkgfNWYD; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 5a32b4b3-1185-11f1-be9e-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5a32b4b3-1185-11f1-be9e-005056992ed3;
	Tue, 24 Feb 2026 14:33:06 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 5a2fcbc4-1185-11f1-99c4-0050569977a2;
	Tue, 24 Feb 2026 14:33:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=aGyipz4pWmEYX0gvkICTkbhmS+Eai5y36qsPUexYHBA=;
	b=BkgfNWYDFAd01i/lfMygeS5TZQW1PEpotQK4p2Fr01Mdst5o039/SnyUPI0vIqLYckQUwwvatFxV4
	 4Ewot/OpvpiXIm+TR8g8D6VDV5uYklnRCIVcBkqLM5gD2DVoHIqjwTNOeHQrfOxnJWTc7af5+kXOma
	 D3volotf2ZqQllXQodITd7+qKtuuAq1ewiACk90umSh7Oi+BaM8gT3Ow2AZAWllP41T9D3hlSLCmU2
	 d2iAsgS2ysv94QRR5Ul15Iv6hB3ajdg9ElEa319z+uSRskUEFq+ceCJM3bAQwycmIRYbF2lYBLdZTM
	 mUnkKx3c3w7SB6l5iRz4DGIioEslP+A==
X-KPN-MID: 33|IA2rdwJDq5taCllBPzP4wVegZ5vJdixpi6dfJsZrtOsCRJ8dXfSs6Rh/1M7rlVr
 g4dFbBcAzUFF62HhgPS5QYQ==
X-CMASSUN: 33|1CBd4L86Up2sAQuKGWPuQ64lLnNDWUZ1T4ZSZXzOnnGORDxrVg/S8xOqxj/rtLD
 ++xymAe8/+yIhrIAy6272eA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5a25f500-1185-11f1-b8d7-005056995d6c;
	Tue, 24 Feb 2026 14:33:06 +0100 (CET)
Date: Tue, 24 Feb 2026 14:33:06 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com,
	viro@zeniv.linux.org.uk, jack@suse.cz, arnd@arndb.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Message-ID: <1215721492.1952426.1771939986592@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260224-vorfuhr-spitzen-783550d623a2@brauner>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
 <20260224-vorfuhr-spitzen-783550d623a2@brauner>
Subject: Re: [PATCH] Add support for empty path in openat and openat2
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78263-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kpc.webmail.kpnmail.nl:mid,xs4all.nl:dkim]
X-Rspamd-Queue-Id: C7D71187E25
X-Rspamd-Action: no action

Hi Christian,

> Op 24-02-2026 10:30 CET schreef Christian Brauner <brauner@kernel.org>:
> 
> Out of curiosity, did you pick this taken from our uapi-group list?
> 
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#at_empty_path-support-for-openat-and-openat2
> https://github.com/uapi-group/kernel-features/issues/47
> 
> ?

Yes, I took the advice you gave me at FOSDEM to heart :) . I should have maybe
mentioned that this patch is in reference to the UAPI list, but forgot that in
the patch message and did not want to send another email about it.

Best,
Jori.

