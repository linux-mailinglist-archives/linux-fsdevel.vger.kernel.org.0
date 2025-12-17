Return-Path: <linux-fsdevel+bounces-71559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB4CC7692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47DA3019362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4633BBB6;
	Wed, 17 Dec 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baGqVakP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5333ADA3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971968; cv=none; b=BI/0NOoYwPFIx09IIPMWzFEh4i6122Sa8JBfaG8JAtZ3tyPoWKsRxmICxXyv6xF6pdtOX9lD7B8ApZlHuwS6MB1tR8DavRY0OqEShX4O/WffyNxp1DEk6wvBXbs4JMRfruFJJWpqSxP7NOf7YrBayJEQ4mV/6onxSUwySZ9+2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971968; c=relaxed/simple;
	bh=k5C4PCRHBCFORfIUqUPm1ZUbvuoiqabupGCdY0sR8A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWIDtplbPQPT2gLr8kq93c8hij/nbxwyg4pzl9h6NLl9V5pulEwgqb13WexmiCb3hl73HeJ2Yfd9M4W5am6oO6C3LT0P45dlvd4sw1yof8+BjaTyA+oY3jJ1BDgyCo1GQA3PTN20RXw52jVUj6Ve7/9pr5XYkW3tvEFLeS0kVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baGqVakP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79af62d36bso81068466b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765971963; x=1766576763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MucoKGwoWy3eymG+YJWr3Rul0bS919FO3cHOK78ilk=;
        b=baGqVakPi244yuaODN4CSwuuKQOcMzPXEi4wNarBEy05cDRo0a8bLz8PE4m+6AERnu
         lPFkdQHHBZHJoeGjb1VJZLVOiOnAzdB0bWHfKSFy+8mNLkgqA5wHSoetqSqGDT3/B15p
         iEPkFc1UIRhufvvtVI7KAcYgy6uFc/FUaLlerjB2aF/O4HlYJQqlwyZ++IOsHyWmqJJ+
         0VkqgZbcubY5IjJ6QzaMyMtNwjWCBm7OSCIw6PDK4jdq99AQSMVw/60ovkX07s89sT0U
         fuIESH3asLnnhigaivpvSzAAsADewcDWs5xMRrtmHTfoEN07TCYizfxLkAA1+yEOLNA0
         H2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765971963; x=1766576763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MucoKGwoWy3eymG+YJWr3Rul0bS919FO3cHOK78ilk=;
        b=iFXEZh7qU4t375vBG10CDzN+W/rmTkelHn600ESGKdhkMl00XZ8UsOmblo6DZ2Y0lr
         p//THCzk37GGencMZVVX2lW+loQzSr1TrdAdFy6xfNyh9DwDP1QreYGCInvshp54iWWL
         hLntbQBnAjbYvqVvSw/9+dS6sNv8HEGeR9qxuMhPrcfhMvTIFym6kYn1F02jbnlT00Jn
         g4EeChk1bDaM2R6IDzjHr/XLYTjERGnL+6uVeFtmsAgJn07GYsdO/7YNBdXzxMIUas4+
         PgSOTWmMLrCaMMoEsEgBqKqiK3mrskRdjvoEPMhA1/7JtqVumw4Wrd4ZEMU3P3qf8RQn
         LoyA==
X-Forwarded-Encrypted: i=1; AJvYcCXelyQiZmi2AJszDHp6yWkk/zjiA4U8KTF4uXRiOai4waWvPUKkiUhWxsJUTZ5cx0OgIyxc4jnJNz47h7LR@vger.kernel.org
X-Gm-Message-State: AOJu0YwzTGdzq2fg6iQcWZocA9DhhjexQexoxNO67mhC9iqg6Yn5QtA7
	8ooz9JZxiNB6Q7GmnGXqyuOrO58L6p6CUvjOmvKbhaP1+qjJadihYtZUoAwSpzuenZw04CGT9KT
	3tzemwm6nzDlJQbkx56U3fo0dmeNN6wc=
X-Gm-Gg: AY/fxX6iwBKe4L1tUqxIH8HEcWAS+X9iGpbcubnsSfGfrfD2JckCDZWjSKfZ3XOC5rx
	zA+tYOIu8wEwda6EDS0L+XBFVQPKJf1PczcAGCwC3eSuCdV18xi+qbM1ABzpL4hSrFN2jNA6ZXG
	hpK37rSgl93aFlt43nHQengKbVSEsOKChtP/tvmZMm6nmsNC1Zb28/spE8+ew6vbJ9P436+Dxvg
	nlcHMLoeRhjSjFla7cq8QKb/mRpx0eF+gZ2/NhLEk9ddaX7TwU2/ySrEkf8xrgvqAiv0A/zok2j
	H29JkNzN3NGZ8ZBgc3mAC6biUec=
X-Google-Smtp-Source: AGHT+IG4HkXQ45S1Ql1JplogTPqcsihf24p8aZprxQcpn5BiidXcXMMm/2ft4yMnTdbo54YT4tGWxnG8MVQqM3YYNk0=
X-Received: by 2002:a17:907:9689:b0:b7a:6178:2b4a with SMTP id
 a640c23a62f3a-b7d23669847mr1761684666b.26.1765971963084; Wed, 17 Dec 2025
 03:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217112345.2340007-1-mjguzik@gmail.com> <20251217113827.GW1712166@ZenIV>
In-Reply-To: <20251217113827.GW1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Dec 2025 12:45:51 +0100
X-Gm-Features: AQt7F2rSJMQ_qGiPxC9R7thtc3YXz6pgjt7epZfFoGKz4uFcBlT1T_7CFWG1NYE
Message-ID: <CAGudoHEZ=H=qhn4SXzNts0Es5xtsaYB0-XuimLkwMVOLcpjfxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fs: touch up symlink clean up in lookup
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:37=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Dec 17, 2025 at 12:23:45PM +0100, Mateusz Guzik wrote:
> > Provide links_cleanup_rcu() and links_cleanup_ref() for rcu- and ref-
> > walks respectively.
> >
> > The somewhat misleading drop_links() gets renamed to links_issue_delaye=
d_calls(),
> > which spells out what it is actually doing.
>
> IMO the replacement name is worse; it doesn't say anything about
> the purpose of those "issued delayed calls", for starters.
>

Then name it something else.

I don't care how the patch looks like for the most part, as long as
the crux is retained: dedicated routines for both rcu and ref walks
provided which completely take care of symlink clean up.

> > There are no changes in behavior, this however should be less
> > error-prone going forward.
>
> I disagree, but at the moment (6:30am here, and I'd been up since 11am ye=
sterday ;-/)
> I don't trust my ability to produce coherent detailed reply.  I'll reply =
in detail
> once I get some sleep...

A good night sleep is something I could use myself. ;-)

