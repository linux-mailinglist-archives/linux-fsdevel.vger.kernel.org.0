Return-Path: <linux-fsdevel+bounces-77226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAtfNJPdkGnodQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:39:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F113D27A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E97E530160E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADD2FFDFC;
	Sat, 14 Feb 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VQqxb2he"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1314F70
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771101582; cv=none; b=lVX0BPF1vzt41jn+y8Q7Mer1G5YFRPJHz69hydzkqWFgqY4czii/wU+aKGig4pEBd23AGdSgcdbVgD+EJvR7k8C7pjFEepYVRwFQkdTE4jcYMiPcvhYwPb2Lx7fJ9duvHZgRg+MCxqp+0oBRrsF3Yl14FIO0C7kvZPPEAF8bgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771101582; c=relaxed/simple;
	bh=UNuLCaseZhQmbcd8cNZc/hV2jVRYkUeP9KxTuzf6zu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fndHipvRc7YOPM1ZslP9rKSHA1HwVBPjnD0d9tMZbyj3r6H/S4WMNNNIgZ9BVPEKmjb0wPnVpo7yX8DR+2Wvl6JHpPyK2BAVwYN9VUlUoawDsOKwqBoIXMjCQhCE90cOZNp4xy01N7i6rK3Zvrcx5nbs9ZtlnlWGWSu67omhj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VQqxb2he; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b883c8dfb00so360781766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771101579; x=1771706379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xobni0Kui4RUZeyiNPg7YdinYh9j2rSDgpyUC3GHngQ=;
        b=VQqxb2heYADMkBTflWtccVz+OACaO1RDG6RZTaFxPWBwjpK+3vZBrllczKGjiPEJGc
         V11tBNnEsLKza53+0VoQ0TkZKyh4Fhsgaraeizz8QC/PxemP6mtpw18vKbqsqtRXpnWv
         hQAfF6Nhb68Pek4eiCR9Kf8EgftNKj7dAJfV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771101579; x=1771706379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xobni0Kui4RUZeyiNPg7YdinYh9j2rSDgpyUC3GHngQ=;
        b=wNO4KMzdHIPRNAmFG21TbnKk5i8XEAS/k0tgeQh15zp7/bvprhikq57xOy5N3bNMnN
         omToBgQpZafLZly4Qu6Pk5pteUkmhg5vaOpU4ReObrsdW4B8DiI0cjnJXRpBzaoystD5
         QQuD6FjbaQM/pH5vwt/07PnQ6R+cELCdFNkXx2E2njzdHRvTDvgdw8ylus85qm/e/lHo
         IEzevvO5Uu8nVZK1N6kGXv4UTz7t699adq4wNF+42XQhWS+lQUsvvPZS2tqWFzOxD5wt
         J2XF+2Y6C7fqXklPgfx39HcEBg5Gfz4vbnKptCSc7CqhzkFR5mrMuKU6icjkOCwcPhyH
         5cDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQvsgtlo8QFK/0IQR0iiN8MNj/ANjDG+kKvNbUHRbKz0IEdwJFBjzv9k3fvbaMwnv0DINFzblcd24rZ9bx@vger.kernel.org
X-Gm-Message-State: AOJu0YzdB+z0EPW/TsKTwuG6cnzsxCt7GfWxzHYIcDIgfZqIF7MaPONS
	POCfiZ72Jf1dpB6WRjIBevUcBpQ5glBgZE3otIUbisy9RiyH3PMUanDsWw3bCHS2N/nmp06QIWe
	r3YUDvCQ=
X-Gm-Gg: AZuq6aIBQqQGQHYQVT6EUhjZsOV63uf0FIVcF3U7zbtHxXlbJ0iUMDBKTSDxMYAjqik
	IJ2/PmtOpao7qIzvVEr1RA22TEkYpZSj2aYdPuD4ibyWTpqPCidpVs+WQg5e0ss4vnnsCazLVG8
	Yt2yuhep/wM4I2JExWg9z8YFAaLRT01s0VK6AddY5nNpvZOJsLCCDs8FmXQUWDu0hqvaznUAbJp
	GdDpgFvfUnTfG0j9Vvy9rOKSpiGRzj0z6SW52BTMnhZJEv1Iw/+z4WNwwHGJr93RcpBKuDr6LzZ
	gA0cz6lmDRBE7/LrtDSrgCX6alMyliobKlM/290FCIbK4o82GOPHqAoPecvUT+jTloNXuM5RLp3
	hUtNJHGNL9PAM3CvrCBOGqapcaFamwMK5rlHjTlHmBj/5b9KuEI/+gpg6la36OvVa1gjbHnzgEa
	0eJI3Zmkv3xgjAPDLdyMb/cUED5k5jFaOjZwQrLYT9Q884yqi2uLnWV8sQc/2P1Pz5GC05AHcJS
	02u+oBuk1w=
X-Received: by 2002:a17:907:988:b0:b8f:8bea:6c5b with SMTP id a640c23a62f3a-b8fb4462d1emr332125866b.32.1771101578875;
        Sat, 14 Feb 2026 12:39:38 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc766554bsm99152866b.46.2026.02.14.12.39.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 12:39:38 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b883c8dfb00so360780366b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:39:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrgreAqE8WEHb6Ux5+qy2eUfUKWshm5C6V0iszwOpwBm20npo0E4bdPAR4d1fEU4HukKyGjmEQjyuVFQO/@vger.kernel.org
X-Received: by 2002:a17:907:3d52:b0:b88:16dd:d835 with SMTP id
 a640c23a62f3a-b8fb4149eaamr307827166b.1.1771101578249; Sat, 14 Feb 2026
 12:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214203311.9759-1-ebiggers@kernel.org> <20260214203311.9759-2-ebiggers@kernel.org>
In-Reply-To: <20260214203311.9759-2-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Feb 2026 12:39:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com>
X-Gm-Features: AaiRm52N7qTCMNkbWXl0IrwYY7YFxDkuplThSymslcU1mI1J-WYgkUTlm-Kk_bI
Message-ID: <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77226-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D8F113D27A
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 at 12:33, Eric Biggers <ebiggers@kernel.org> wrote:
>
> -               if (fsverity_verify_page(dic->vi, rpage))
> +               if (fsverity_verify_blocks(dic->vi, page_folio(rpage),
> +                                          PAGE_SIZE, 0))

This really is very wrong. It may be equivalent to the old code, but
the old code was *also* wrong.

If you use "page_folio()", you need to do the proper offsetting of the
page inside the folio, unless the filesystem is purely using the old
legacy "folio is the same as page", which is simply not true in f2fs.

It might be true in this particular case, but considering that it was
*NOT* true in another case I fixed up, I really don't want to see this
same mistake done over and over again.

So either it's the whole folio, in which case PAGE_SIZE is wrong.

Or it really is PAGE_SIZE, in which case you need to use the proper
offset within the folio.

Don't take the old buggy garbage that was fsverity_verify_page() and
repeat the bug when you remove it.

                Linus

