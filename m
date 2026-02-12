Return-Path: <linux-fsdevel+bounces-77020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGwVOM3UjWlA7wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:25:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DCE12DCA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B8D3041793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 13:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847735B63A;
	Thu, 12 Feb 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA7BgUpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929E3502BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902702; cv=none; b=rTJnrNv5PV6WctWM5vspfYd1uuhIDzPa9QJ+7Zk/48XtjexG3CVTJbYVqmZFvpEaCso148KiGsIlIRQQZwKZrLDyV1NfGwGKD1Iq0Qbu8NH3HjhiI+oPLrILdxx2qA5FxKcdPKryaO+iqKZOOsZ06z5h87O0YWDAbzb96qE307Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902702; c=relaxed/simple;
	bh=+DYKXQauR3nB4yX2uHCxu0HuJ2O1mEp0E6LkWxhgksQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPAwrqkPNzTBxKapP7sY0AeuNtMrm476vGCKr5Py9CP06rjDMviWb34dpHAxIbIehAVTqyFVtLRSYuP5/uja9WdeYcxspHT6d73slIwK7az9uqWIoH29CR3k8Bq2bPr20NBpC8c0/IATpOwZdgPwv1ZqziwfyfR58b/lLSsUKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA7BgUpR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so27610345e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 05:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770902699; x=1771507499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxGZjqTUQYu3jpxwqyR9IQh+E84a4FvQmTfK5i6E7iw=;
        b=aA7BgUpRvdmWkLOJ6hQTSVYp3ltd+V92bXaYZxf7fhY+xS2AWRdPshgHXP0oKeAV2i
         WTB8U8v2PGfO1HfqN3i0zm/fQ9fic4oDRjltXWs/QJgFZWcZ09RgnxA6J44cWCf7jRAi
         dN0uW/KUtwcJxmOKj34KKHmZcBaysEkC5xLIlfYxJUgvqVLrQCczZLWGMQL1QpP0bPW1
         Gjh0tGtIixDDal4g7ugTmzEuvdO9+/3LD7KTuly6mZd57CtwdKCuVsfXioRHh4nSESAL
         olBvPWuJBWlIrBrfQmKqC8Q6Z47Shi7NU/JYlAGqKD3eT+pr+W3kIU1sESwf24WXe/Vl
         BnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770902699; x=1771507499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxGZjqTUQYu3jpxwqyR9IQh+E84a4FvQmTfK5i6E7iw=;
        b=SgOKgc2i1iZm5vgjU6ESVatDQF6LznuvCY/L5r4VVva7JBXpx7xbN6KEM7m0ysGkZU
         aaEs8m3WZi/VtjB1yU5s7Nf14i+iQBINFQ9AaLvb/DyYZJckVsx3ATTfzo4TzBOAgWHc
         mWnwrt0yKwDQBNmV80xY76pRY7LPlpAPrVZ6ogADWRXlZ0NwFqLjoyUYqtu2HAN0xX4c
         ywIKrTSIUGTYsieiSeIfb6xsJQuwOJAqj/S03OLI9YWXNUAb/a54Y4Srjk+3bN39DGhQ
         AxlRMDvcDyLnrkj32Ih7/52zyXCJKRFXP9bDXPVx/t3UpJTIxCXOyK5kn93VE/xRfPv1
         PQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXQZfOwUieiXc720lHk7QlxpmKZ17PqP3Vux4H7Ti5RHai3f9ZwqTphzuQbIgh9kJgGU6s/561Bm+6CX7BN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjr6nCdnHved7Rq6+gboKP33B5s1TQgOs7ofA9sd1Jmr5Lu4+0
	94XH7qd6k3lgRRRw8g0079vBpYPFv0MXBcVQhhy0inHKx179mxI1BSpK
X-Gm-Gg: AZuq6aKIDiJAqvkRbKj72C2YQxM0xY40v+bLU3HLRkfv2JzoSIT63CfFs2XNlQSEMwv
	oW8+6Ud26d5lPWu54JgQov3Ii9u4Kzu4t8/ok9ozC4hgs5SrY0OuOhtJc/fehqlqkxptYwGE+/M
	/IJcSOZ0QAjY3RmsQGqlAkR2ViNjhQY5d5EXzw2OWnb4pOZAfVbZkVaFbP+/pX12wlnvDbDHNe4
	2Zpfw8/+Dy4qZ35skJPxSozza4nVfvwTcDhUXinQ09wqxKrX/uelwm8YqzhhGGAUjuOHObcMhs0
	zZ2x7FXfu+avLdp1LmWdquT0b6U7n5kkBuwGXRuwEkJOAEyON9Dj4+5lPx+BVhwgpS77gNvhe7T
	JQfjEMirfCs3C+bSkUEkiBPnlitzK9hHUf94a65sSo7hz789b/hOWZF7ceEXXWj+DvoCwkJJva5
	uIRp1PQP10WORm1fYJrh46
X-Received: by 2002:a05:600c:3e8c:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-4836716b6ccmr37153115e9.31.1770902698659;
        Thu, 12 Feb 2026 05:24:58 -0800 (PST)
Received: from localhost ([87.241.147.184])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4835ba69115sm40759475e9.11.2026.02.12.05.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 05:24:58 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: christian@brauner.io,
	hpa@zytor.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Date: Thu, 12 Feb 2026 16:23:45 +0300
Message-ID: <20260212132345.2571124-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209003437.GF3183987@ZenIV>
References: <20260209003437.GF3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77020-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 59DCE12DCA4
X-Rspamd-Action: no action

Al Viro <viro@zeniv.linux.org.uk>:
> The interesting part is whether
> we want to deal with the possibility of errors at that point...

You mean that finding topmost overmount of root of namespace may fail?

Current code in mntns_install indeed can fail, at least theoretically:

https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/namespace.c#L6243

But I argue that this line is unnessesary and should be simply replaced
with call to topmost_overmount (which, as well as I understand, cannot
fail).

As an additional benefit, this will allow us to remove LOOKUP_DOWN
(this line is the only user of it).

-- 
Askar Safin

