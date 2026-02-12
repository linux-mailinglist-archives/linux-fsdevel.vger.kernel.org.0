Return-Path: <linux-fsdevel+bounces-77035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHEPFzIOjmmS+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:30:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF712FEDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CAD1304DF3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7F254849;
	Thu, 12 Feb 2026 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XIy3TT71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BB710785
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917292; cv=none; b=S9xIbcgdT38mcU2+zYkTJ1DG2jwRvk5rz7VSGBTBhXAR8bYMMFmtjlbdi9b5X4UiLFCKdTUmXdL/ItZKp7SFmc+kf2eTLLaQ2NNKXhMtJwxJBNCVJ1x9LQ3Gnthr3DBODYTX2JxT9pzNKU8cX79MNy5CNY1Xdd4aq6rj3+kLYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917292; c=relaxed/simple;
	bh=9dFXQISDxL93Ll0tQt1xHxOXQRq59lDegTnGV4eIz+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG+ApBb2oBPHu13FSMHJxCVqOmCgC3DuUFyDEs5zTZpbd0P/+16U7vrRsopBWMvz/m+8LPL9JUwNjTSIQNCpAO1enen2lMNQU1dbucPrSQFxVYC6iFHTzd3J/7VRAie2PcsWFourUTDdNKi9vUP3/8UoY9XHZ1VU8BAKzj4+o/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XIy3TT71; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so8130a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1770917288; x=1771522088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVJ/CuM1fMI5SkVoKZQh228Ino+XF61yJs8+K8VHNN8=;
        b=XIy3TT71RO1yugM6DnyUsFJV8XTwJ3N2GwAjVJ0RtqMfwxLkdPC7Xot/aauQtuDY3J
         AuuRs0OZsolA5C38PQWvPxCuE20Z8tPtsgoiKrgO5QdfuzM80tToZ4VZaqUGZhpNGgrs
         5OuMh9FaEMqhpEWpOfC65OTln2EJ1MQtBzSLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917288; x=1771522088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVJ/CuM1fMI5SkVoKZQh228Ino+XF61yJs8+K8VHNN8=;
        b=hLincv/wsYn/u5UYqAwQ/jZf/B4Jnf7gvKya1oEqTDDFDq1OeiLB9pvhi8aT4YPij7
         n6eCaKl0rAqzcixnAob1EQ7gI2N+SkqB3d5Hzu8jINTb/N12N0CJ6j3u4DyTgPea/WQE
         P9P70OPkFlyAUA505dQXFM82GP+GcvaWX7aH0n2QUZce1Q1Z0IuCy2cODGy4KrJJmn4O
         z3BbSUVo6cr4IUkcLXPxRwdYkAeDhNce0Uu8l4Ra530YLpVbgATgnfIRkq6ejbtbcIGn
         hyKu2UupgcOxAjzl0PMUv2vkWnp1ng80mg/uTDse86ALi86AO9iSBRaP0mVuMbEmXhCV
         Rq4A==
X-Gm-Message-State: AOJu0Yw+HRunjXs/XrgRBMgabUYjBmGSClFuAIZmZ7uhxz0xCqPPMQnl
	JRK4o/vNSNj4jn4rZJJMjXklF+ie9MSUW1FZY9ffgFJwiRTpq7XWeiLK9ljXVY9XA/sYfEPd6k/
	/jEQgoi8=
X-Gm-Gg: AZuq6aLJJsqC5tbQC9hxYejhF4C6tFp5+4qft5k7tUXZ4Lrt04SQvV6vdea529o+489
	TMg4YSf9M8SjwEgOopl64JTKgCfZE7ceJRnAOe58Npib/TNt6ee5yE1NqmmueaFAPebjjBPoawg
	5zdBP2RlsNKfPUBUgPcbvtmGPTgJid1+eSsVgG2rrkehysCmClIJjCnOzc8QVSP8OR1NZbXE1ev
	+XxdwfUNI6wHPPVKfWD4ZL8LsfUmGQ9x8rz7j809KV+EmIu7a7ayVjO2Z/ooZIDPaejY2JGskIZ
	WZorntzzZ364s9b+TPhUpDHwvxvSjbrle6zIk1oaQv+OKXzixuyV/oYRfcnKgUTTZ+xozlTWebV
	YURgdqVE2DOm/NgkkQE3zLmXR2p3HEvUcDQIe0c13kczDH01KQ8zs0vfyV/PyEh8BBNK/k/pnz+
	8bCkH4vMfdXBIs3X2HNQLUJvgZhvj28lCXjg++C4OA1H8V1V5WvyiNECxFLmEnOwAv/BvKlQin
X-Received: by 2002:a05:6402:354b:b0:659:40a9:713a with SMTP id 4fb4d7f45d1cf-65b96d74ce1mr2041866a12.12.1770917288410;
        Thu, 12 Feb 2026 09:28:08 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65a3cebd31asm1922890a12.8.2026.02.12.09.28.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:28:08 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so26308a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:28:07 -0800 (PST)
X-Received: by 2002:a05:6402:4489:b0:658:b9e9:5769 with SMTP id
 4fb4d7f45d1cf-65b96dd0d4emr1981946a12.20.1770917287580; Thu, 12 Feb 2026
 09:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOg9mSS9BFayavpGQ=MWYR1HoUX=SSQ01JPYTRcJDVXbzsGAUw@mail.gmail.com>
In-Reply-To: <CAOg9mSS9BFayavpGQ=MWYR1HoUX=SSQ01JPYTRcJDVXbzsGAUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Feb 2026 09:27:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5Frk61ez=5buGrdG0UqWp7ixR9QiCttzGwruczqKqsQ@mail.gmail.com>
X-Gm-Features: AZwV_Qhn01HIl-FAckypkEGFRlL5YvqyL0zj9T7pC5zWio5lKAsyRD-sKzd06-g
Message-ID: <CAHk-=wj5Frk61ez=5buGrdG0UqWp7ixR9QiCttzGwruczqKqsQ@mail.gmail.com>
Subject: Re: [GIT PULL] orangefs changes for 7.0
To: Mike Marshall <hubcap@omnibond.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77035-lists,linux-fsdevel=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-foundation.org:dkim,omnibond.com:email]
X-Rspamd-Queue-Id: A7EF712FEDF
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 at 14:41, Mike Marshall <hubcap@omnibond.com> wrote:
>
> orangefs: fixes for string handling in orangefs-debugfs.c and xattr.c,
>           both sent in by Thorsten Blum.

So I've taken this, but I actually think it's done in a particularly ugly way.

The thing is, strscpy() is the only *properly* designed string copying
interface I am aware of, if I say so myself. And dammit, part of that
"properly designed" is that it's actually much easier to use than what
this code does.

The code does "strlen + memcpy + special end handling + different
string strscpy if overflow".

But strscpy() returns the resulting length (or error if overflow), so
it's all kind of pointless. And you don't even have to pass in the
size to strscpy() these days if the destination is an array that the
strscpy() can figure out the size of itself.

In this case, you can't do that size simplification, because you need
one extra byte for the added termination, but you could still just use
the nice sane error handling and the code could have just done

    len = strscpy(k_buffer, kernel_debug_string, sizeof(k_buffer)-1);
    if (len  >= 0) {
        // Add annoying termination
        k_buffer[len] = '\n';
        k_buffer[len+1] = 0;
    } else {
        strscpy(k_buffer, "none\n");
        pr_info("%s: overflow 1!\n", __func__);
    }

and look, you're all done.

It's still not *pretty*, because that extra termination logic makes it
all have that "sizeof(k_buffer)-1" thing, but for saner interfaces you
can literally just do

        if (unlikely(strscpy(dst, src) < 0))
                strscpy(dst, "overflow");

and it's all safe and really easy to read because strscpy() returns an
*error* for overflow (in fact, it doesn't even know the full length,
because it will also stop reading the source string and not overflow
that either!)

And so no 'strlen()' or 'memcpy()' games are necessary, and the above
is actually safe even if the source is modified concurrently (well,
you'll get possibly broken data, but you'll always get a proper
terminated newline because the 'len' is always consistent with what
was copied by strscpy).

So I just want to encourage people to use 'strscpy()' and take
advantage of the very useful return value it has, unlike pretty much
every standard C string function.

                 Linus

