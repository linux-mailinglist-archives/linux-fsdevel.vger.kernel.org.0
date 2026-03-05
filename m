Return-Path: <linux-fsdevel+bounces-79450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gYZNCszNqGn/xQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 01:26:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9A2096A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 01:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5319E302A6FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 00:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A631D5170;
	Thu,  5 Mar 2026 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bwz3LwiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C71CEAA3
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670392; cv=none; b=Q2ws6xjqmPWMNnWl3l5gAlhcT4j4BrSwgzSEpw6o7ASrbSEoY9NxCDIhS7qicsoVO/L1JczscSRwafD3S6Gw1eK5lkyxkU0x+uij2PaEqHD8fdPfXeH1O8vCx8UxOKjB73PUNjK5qUrHm+PLbh1Bsspe6i6ZX0qO7lA/JeOGZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670392; c=relaxed/simple;
	bh=siBOwpjEWwiGhUXIyJm3bBbtUTxKXumNlmnFK+ghYPk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NmjyijhB3raYLiDUoViJTGr0w6UXYNTGrbnpVqO5wv84YJBmnW+Aja4IN8sXICBiPlT0txmLhw1GEoXir4OxWOU3HUoJDqkoRDTumK7EvfzyN85nM2jx8Ie3spaCPN28AuflEoBe9Xp5UexAEvBwV8SGBDdJyubTN2ktVF5Efyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=bwz3LwiT; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: f3409b05-1829-11f1-bea1-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f3409b05-1829-11f1-bea1-005056992ed3;
	Thu, 05 Mar 2026 01:26:27 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f33e1055-1829-11f1-b5ce-0050569981f5;
	Thu, 05 Mar 2026 01:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=YanWl1a9AWErXbNkoHv3ziVOFRDMEpA+c/FP3r2Rp/g=;
	b=bwz3LwiTrfaAAU7DVI8RdvZylR3ZIDlgqHKU2rXpLyTxpArftBGCDjQqaR+mvvqSvrGMlB1Yu15Iw
	 5s2fEo55ctXCjGA6iViVWdWxy5S6OtHmO7dqW1+IgEGpa3wwdADqhQKplNfR8nscx0qjiX6fJlp2LV
	 +0qnFSILKxmtmXwwYZBo2HetcQbXIKdP2bi3ZJ7uPOmDAIdnNBg6BuAeOKV9JPzjCZK/Bv/+lpWuOV
	 PMBMZV0pPzDAACU7Af4m/sh4kq9yBOxVn+NJ+spOFKO0K+wDoPBgj6pTjR42MYybnUn55XpwKWOkHM
	 /v0srYdEm4NhXDrEpK4/GQt/9za20nA==
X-KPN-MID: 33|AQP8h18ztzlni7DzxZPoY0cLkFUi+1bJ1ToNcVSq/lGISMy06Ss0UWFhea6N645
 WSMVTHH/kpYVUvIS9aSbk8lcMGABGmWou87plTsMPF0g=
X-CMASSUN: 33|J75UVtVGOhoYRRIeNRS/KZM8Q27vkkSvZ3bccljtsLA/rrH8hN0D611JR3kVUJ+
 YX3AJmnq5xRQICZnBkdxvYw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f3349625-1829-11f1-b8d7-005056995d6c;
	Thu, 05 Mar 2026 01:26:27 +0100 (CET)
Date: Thu, 5 Mar 2026 01:26:27 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>
Message-ID: <904087099.452089.1772670387819@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260304-larven-wiewohl-dba04626ded5@brauner>
References: <20260302131650.3259153-1-jkoolstra@xs4all.nl>
 <20260304-larven-wiewohl-dba04626ded5@brauner>
Subject: Re: [PATCH v2] vfs: add support for empty path to openat2(2)
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
X-Rspamd-Queue-Id: 8BE9A2096A7
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
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,oracle.com,suse.cz,gmail.com,vger.kernel.org,cyphar.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79450-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


> Op 04-03-2026 15:03 CET schreef Christian Brauner <brauner@kernel.org>:
> 
> I forgot to mention this cautionary little nugget in the last review...
> 
> The legacy open(2)/openat(2) codepaths currently aren't able to deal
> with flag values in the upper 32-bit of a u64 flag parameter.
> 
> Basically, by adding OPENAT2_EMPTY_PATH into VALID_OPEN_FLAGS that's now
> a u64. That has fun consequences:
> 
> inline struct open_how build_open_how(int flags, umode_t mode)
> {
>      struct open_how how = {
>              .flags = flags & VALID_OPEN_FLAGS,
> 
> This will now cause bits 32 to 63 to be raised and how.flags ends up
> with OPENAT2_EMPTY_PATH by pure chance.
> 

Ah, shoot! In my head I read flags as an array of bits, and it didn't occur to
me that it can be sign extended when you do flags & VALID_OPEN_FLAGS if bit 31 in
flags is set. So it should be enough to cast (unsigned int)flags? Or what would
be appropriate? Is there a particular reason that flags are mostly signed? Or is
that legacy of the definition of syscalls like open(2)?

Thanks,
Jori.

