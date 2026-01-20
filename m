Return-Path: <linux-fsdevel+bounces-74723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF+rDvbrb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:56:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CF4BD50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 810AD8C560E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16A3A8FEB;
	Tue, 20 Jan 2026 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="cYLn52lU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C8E3A785E;
	Tue, 20 Jan 2026 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940369; cv=none; b=bBb/MhWZTA/Czk+4vCfNeQl4l47xUMzFMFi8J0uzi+YDdUo9f/dLCloMdVj0qR1O3C0DvFEdGhHXfkSkCQcac7zi/reWgbm00kVfUdeaF+8hgXIs4j24cfaUaKkqRmqhTiKIaFXnlhi/HDyHjrcmXpuy71ttatcJFOOR3TBIPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940369; c=relaxed/simple;
	bh=rSTqmCrg3gEEPKdwJLXT0tm9oK6BKvTh259cOmnRnmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5NFBKuLOzgu2VsO6QUMdK0OlsBX9NKGv1ulDH/pC98NabU7UfYcLpV2+wbyY81dGHqx5g6DjEF4SGVBFpPyarzFty1Sf81z8QYf2BccvMdUWKn9R5ROUIWTNCzYKQfBU4CyNJwtj7Ylpzho/iTm79Z/hKWAy7A2MZmklVwLEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=cYLn52lU; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 6C0F73C010852;
	Tue, 20 Jan 2026 12:11:02 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id srwYskAS9pBC; Tue, 20 Jan 2026 12:11:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 3E5003C0149E3;
	Tue, 20 Jan 2026 12:11:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 3E5003C0149E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1768939862;
	bh=IcdC2IC4PYFj9Dpfb8vBJpkEzy5B+N00two7JEBT+yk=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=cYLn52lUK7rOALrdwpeNnbkNYXb+ew6IT4zLX5eGcct2lbWQKrzJlhRBT/loBXyIE
	 pGmfrg4kJa3sLFtJo05orNF7rTZOCavyjg7tvSEn6qH5gD4lZOoKHsIEs0xFSkdxfC
	 CgzqMtY1h1yHal/a+s7lyVkuNhgMLk3xELq7ZL8Kj5Htk/sVMWFemkd8jpuQR3ipAU
	 rNrDAz0XRwKSyUmbuEfgrOuCFzuOBE+5AsqWXm9qNXPt1H7q2Ed6JnyrZEIWtWhOFD
	 zgYIU7SH3pm5xLy2gvI6cHR2TLc8CXd8slO+JFEhkiZtKWt00TexAeYRlmhUgPuXyf
	 g7KWNHlXEb1gA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Z0tVz95iQDTO; Tue, 20 Jan 2026 12:11:02 -0800 (PST)
Received: from penguin.cs.ucla.edu (47-154-25-30.fdr01.snmn.ca.ip.frontiernet.net [47.154.25.30])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id ED6E73C010852;
	Tue, 20 Jan 2026 12:11:01 -0800 (PST)
Message-ID: <20e66536-7f3c-4652-844c-5b5e9dde54bd@cs.ucla.edu>
Date: Tue, 20 Jan 2026 12:11:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
To: Rich Felker <dalias@libc.org>
Cc: Alejandro Colomar <alx@kernel.org>, Vincent Lefevre <vincent@vinc17.net>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, GNU libc development <libc-alpha@sourceware.org>,
 Zack Weinberg <zack@owlfolio.org>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <20260120174659.GE6263@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cs.ucla.edu:s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cs.ucla.edu:+];
	TAGGED_FROM(0.00)[bounces-74723-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[cs.ucla.edu,none];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cs.ucla.edu:mid,cs.ucla.edu:dkim];
	HAS_ORG_HEADER(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eggert@cs.ucla.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 685CF4BD50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 09:46, Rich Felker wrote:
> the job of the man pages absolutely is not "to tell people how to
> program". It's to document behaviors.

In practice man pages do both. When I type "man close" on GNU/Linux I 
see text like the text quoted below, and as a C programmer I appreciate 
getting advice like this when the situation is sufficiently tricky.

----

Any record locks (see fcntl(2)) held on the file it was associated with, 
and owned by the process, are removed regardless of the file descriptor 
that was used to obtain the lock. This has some unfortunate consequences 
and one should be extra careful when using advisory record locking. See 
fcntl(2) for discussion of the risks and consequences as well as for the 
(probably preferred) open file description locks.

