Return-Path: <linux-fsdevel+bounces-77046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOvsIhUmjmlrAAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:12:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000E130977
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8324830616F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117D27F759;
	Thu, 12 Feb 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CcOVIrGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99A22D4DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923536; cv=none; b=MWxSiQdjRHhc3+dXFLfllFSluQtoJGoHCfVG2NdkF3QwagTd3uI2KfCSj3DbOcneqS+LfzizmVMBGNkbW9p7KQSzsj4w3AY+CJukQbKGEmx4NZMp5XOr5ePDBgdkWqhr7TMciobQzl4sbVu6wUlFJIFcPEJcE+uO07brgoQbs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923536; c=relaxed/simple;
	bh=dI65QvbU5DpBgSnIfWH9AIY93bCm6JKcDE6orPQi2so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twkciC4tEOE+Im7pF3JJYMjzpkWQdFVmQPVMPrQejZGdim0P6G4IYQzxSP2iAP7AjOVolSyDvazAUFjpjuEyh5h5mfO5/lwVcU3syAotcG75tS3XZS4LgORzZcnbeqSYG8VNQ11mEKwa1M98JbTxPz7YcS0cSV3+K5qoi4SdBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CcOVIrGU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so189396a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1770923533; x=1771528333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ah4/OahimGWcet+5fwbdLNY92sXyrqTWJRx1deZTYZs=;
        b=CcOVIrGUmCJ19vooxztnMUVryfa/o8FO0Mxgu91nP5K2a4u3X+Wv3n4oafs6hC7iZk
         HcHdnuaghvrhASx7Op0mr5/zWAjydJ6+AbYKz21/r4fWm/a9VOMBqPzUf6lKzoXiLtJD
         4yc6vxt9ZOYtJNbu6cnxZwlO9NrJcPYtD6kco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923533; x=1771528333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah4/OahimGWcet+5fwbdLNY92sXyrqTWJRx1deZTYZs=;
        b=HpljMGflL3od2vobt589VA2PH4wxkeDsLODU3gmm+o8/iCGzcm0j1PNRKTA3P4oLxu
         ZHS5kX5Ejp5tARRZWatiXEnjjBWTbDnMkBwe0azIy7+N6U75Bo1O+oQo0k9wP8uuv7wT
         ACY0WMQQb2lyBdXpNBNKQF13g0lLGC1zBWhs4fMeSBJ5goM6aHMP9OGDV+VODRnEniUH
         fTXvN6bKzgYUPv7pVJ1h8afq4SRs5vENI1GMWbVBQJIyAXp3lIaEOxj264OidjbUgPUt
         RtS/SJv+aBXSXxZTgyrnllyNzWNWZl+bP24C8Fz5RNfiGpb7KEnEaqWdSTlAkKHQUBcM
         w8JA==
X-Forwarded-Encrypted: i=1; AJvYcCWrpPg6XcbznNjG9CD6uYSg/AyHqAdFmZwb+clAlw5hU71mvDaHyObyS9jMXJ5vN8SPpqwcWhGaEWmvLv7s@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+vwn/yPvXSZzHmZoVJZGigumsTlEIXepXls5F+Ph6194ix1J
	RwzGZyaCe6JfBtuIDkINBcQfGdG9obXp3jkFnKKW5IXVy4a3jvAF+3U/kj/VrGcfBbGs2/sTbyx
	eSUMnDeE=
X-Gm-Gg: AZuq6aL2xqAA1Cv8gudgT++5Av6I7xvQ9J6Iq2mnymqk4lIBmpkEAaUazRHUWB9TnrO
	XSEXCThMqpyTf19ZkBNOSXrC/awjtqwhK1VyszOyK9hSj0DAEl2gvbX4Rjb1h3kpm7t27Fdn91e
	sytN3rAFZ69XWqoDn9JjZ/N+QDmtV5nSZV6DjnTQ1N7Ink4PhcSTa9wlA2sQMBhMy+tzM4AFXae
	yWg4/BuVuoQJfhm2TOWfJDL5F/fVtO5BodFydgSNmkjgTE8LWPNdmqOZAKNTNyTs7Od8NNSyMrN
	ImEi9btK4UQPCCE8GkQclYfkg9woRLTNdr92c9PTpy73YloZXfO57S/i1DcwqXDkLsg+CNKGqoD
	6SBD1TzNEDVmdPP8zOleUgId006HyjA0n/jErrZubls01xuUfL4npYP413aC7xDQrQjgpQf7wAe
	jslsoQ0nm/8JEkIHW0fWk0uZLV3qdKNXfmtOeg1zNrGXM682mUzyC7Op6x8pNMfR4Oh4X2Vx0Y
X-Received: by 2002:a05:6402:1448:b0:658:d18e:d9 with SMTP id 4fb4d7f45d1cf-65bace45744mr28590a12.21.1770923532781;
        Thu, 12 Feb 2026 11:12:12 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d826sm5807a12.13.2026.02.12.11.12.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 11:12:12 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so161948a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 11:12:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWdSJhJMwtsJzwqvypSM42I9QHTH/zQrdS9dQN1zIYL+odIcb1Yq78lA8qXKTHl0FxxulRABujJl1a/yh0@vger.kernel.org
X-Received: by 2002:a17:907:3cc9:b0:b8f:a323:bda7 with SMTP id
 a640c23a62f3a-b8facfeb5a8mr3553666b.46.1770923531583; Thu, 12 Feb 2026
 11:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
 <20260212171717.2927887-1-safinaskar@gmail.com>
In-Reply-To: <20260212171717.2927887-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Feb 2026 11:11:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
X-Gm-Features: AZwV_QjFh0ORTagGyfiLFufEzvBeXlYuNRRxfMF3kD7fkEBd5E_etgF1LZvi-6s
Message-ID: <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
Subject: Re: [RFC] pivot_root(2) races
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, hpa@zytor.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	werner@almesberger.net, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77046-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0000E130977
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 at 09:17, Askar Safin <safinaskar@gmail.com> wrote:
>
> In my opinion this is a bug. We should make pivot_root change cwd and root
> for processes in the same mount and user namespace only, not all processes
> on the system. (And possibly also require "can ptrace" etc.)

Yeah, I think adding a few more tests to that

                fs = p->fs;
                if (fs) {

check in chroot_fs_refs() is called for.

Maybe just make it a helper function that returns 'struct fs_struct'
if replacing things is appropriate.  But yes, I think "can ptrace" is
the thing to check.

Of course, somebody who actually sets up containers and knows how
those things use pivot_root() today should check the rules.

               Linus

