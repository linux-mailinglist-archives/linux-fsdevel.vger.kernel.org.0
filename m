Return-Path: <linux-fsdevel+bounces-77218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OQrMOGgkGnkbgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:20:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C82A13C757
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE9B13007B81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332272EBBAF;
	Sat, 14 Feb 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6yXC/9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDA84A35
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086046; cv=none; b=VlWOzNpwfwG2/ch+tR6fSZsPZKeAIXEGR4btDAWQmN10IwSzLYIY6VuL3hcnnH6ZDqTElu/DnHzOQ7YP4ivV1riJYuii36QgiDRonG36DAWwtEAzbkM964PSuDrEFL4Gnsk4JDNF/UV6BpPqoxQW6DyEn3nyhXWc/E+iLVZYzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086046; c=relaxed/simple;
	bh=UI7sooPsXbrVAuiyqch0KNnpR/3UOgYhTChFURVAo1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGR3w15km8Xufizkx8bOTTxozktiEyAhx9E1utbu3QOf1Q+jF6rd/5t/vrOm1jq8AZnZlpi6B07j3Dc4m/QvVeQwexHXOfZXoJ9arXmB1C+5I7mfgSEkM78MusfSMLCibERjFQlx7BGSfm1DQ14Ioun04E3seMwvMNy050UZogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6yXC/9o; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-435f177a8f7so2010330f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771086044; x=1771690844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBQMSXG65XT2S7uQJqqG0M3iDU3PdphL5J3VO7mJgHI=;
        b=b6yXC/9o27gqKRlA9BziqU8KgcM1WqEh/xX0t0UJMK2qQhRWO1fzUANFvRVnp3bLkk
         2U1Q2pLicK/YpbDihSi+bke/+glcPkZplBfe3kk8hNoljOj47FZ0X1BuO5iTWw6k35j0
         er1rnyHgct2+6l/6Ct+Mi+mBnA4n2JR2MdVaZgIakwk9RZoPJO2C6Yp84h6VquBYSfuF
         zOGWfEwPcH/YO3s7QLJYKNwngsT42fHQsCtT3S3sHAxmymZob51mn+oDLnncGX6bulV4
         9uUuUYwrU8YAHV8WP3skPgVUOSJy9H2xr02NkyeVJjIA0w3+NrRmhxdKK0ONn+MSIGNp
         Ne0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771086044; x=1771690844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBQMSXG65XT2S7uQJqqG0M3iDU3PdphL5J3VO7mJgHI=;
        b=ox3RAaRcpT09E4Ft3r2Lq/xHoMaVqwyFOKNetXAN+LjDngjI9jTfnmIc6Gu0H4tmUY
         iKghMiFLEu5iH8pFuB0bNooawIrwax+bnubPp+xyA9RKKMGW0TbLQFojR2fd0RSIg82W
         4Hob0SBdxM7dTVSodNR/dMwsToqWGPum5PPUZRdVsXrZsgkP9+0MTPPXwj03/pPrK6rt
         7YkrjR6WV1JBlJU+S1oShvmiIw2ksu1aJce1GiQAC/D0Hx5lEThCgWhm3xqOK63Kq14U
         +UqC+uwdkCFUYYm19FAOYqm/ZwukHWpscTE6+W9gmKrHWGqXOG0DbOYN+Fjhu8j1thEQ
         ZpDA==
X-Forwarded-Encrypted: i=1; AJvYcCWW2rmJcXviZKbuvG1SKCqcQ6hg0AzIrUbwNJYLiGaiCIvynPfx3qKqUhJed/oW4/syb10/HuEYWH4Hhkul@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlzsCzWyF0xXMnxaRCa9OOiOKypUlhbbotEdXfmOts7xe3sTg
	bKEzH0FzpXOKzkd5WpPwl0vfdcMtcj+Ak/FZtv8i8PILGs8a7TS2bEJT
X-Gm-Gg: AZuq6aKqxjZ817MHkmR4fOdhsLUeJU7KCUuSq098uVFBD58e5V14pGK8yrMQTIur3y4
	iJFvI+2YDV5sw+yACbTgZdGnSFttu42kXUtK+CzYkvGxfXQ0h84kzaSP9Ri4jmnVojox7PtfeJ/
	o9RmQ7y2oSEQaOkVikGmSpWfXDaFGfhXXrqw0gEQsVb8iqlN65HY9FWEtFbXaXzX0UW88jQg3SS
	W+pLU9IbeNXtdxjLFJsIbgtauXH26qVEe66Lxc3Ib3ctf2MB0cX866fYyYEUTufgmr5UjHKxZES
	j7ErrK92KcS+gL/z3Zj9iOypBI7hirsDHTDluVLon9gM8xNlF83WQQ6T6iapYZX9zMRCFqckkw1
	LXD4wz6ILjXja+npw5G8J5Kaj285yGaXebwAdYpunDQbtSZ/C4MPNqD1MxpnwTAwBI62EJWX7Su
	skpACwqEYip5Io/ujBUf0xy/R6zNZWXg==
X-Received: by 2002:a05:600c:310b:b0:480:4a4f:c363 with SMTP id 5b1f17b1804b1-48379b9f174mr49801225e9.9.1771086043635;
        Sat, 14 Feb 2026 08:20:43 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48370a4ffafsm44105005e9.5.2026.02.14.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 08:20:43 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: hpa@zytor.com
Cc: christian@brauner.io,
	cyphar@cyphar.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Date: Sat, 14 Feb 2026 19:20:39 +0300
Message-ID: <20260214162039.1388837-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
References: <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77218-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C82A13C757
X-Rspamd-Action: no action

"H. Peter Anvin" <hpa@zytor.com>:
> Well, it ought to be easy to make the kernel implicitly prefix /../ for kernel-upcall pathnames

If some kernel thread executes user mode helper /../sbin/modprobe , then
the thread will execute right binary, but still with wrong root (so modprobe
program itself will likely misbehave).

-- 
Askar Safin

