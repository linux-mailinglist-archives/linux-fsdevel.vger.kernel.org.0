Return-Path: <linux-fsdevel+bounces-10545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4A84C1F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499ECB24BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DCC2ED;
	Wed,  7 Feb 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHA6Ugd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EBD512;
	Wed,  7 Feb 2024 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269901; cv=none; b=mmdoWHDVdsCip4El4P/UKawE1qjFASeHfDixcGYom4klyFsvJ+ByM6ZllkiEAmd0ikdrTYtcQ1VivizsAV2RsLwHJKntyv6vzMzxkKnwuXXK2KWNPovfEYE7tW/OjZ9veiHFSselNbSuPSclpeQUFm9/R1qLeRuP4zBZjvDddjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269901; c=relaxed/simple;
	bh=xpaKR2Ymf+RGZn7q46X1z3os3aiQmugyN7+r1CRoRL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed9OvKh7DkxWADMQWa+bXiGsBJb0EmA8xngW3Upm7kAqIRSAQEp5u52jLNLQwsNI4gr4BPrEEkPYQCoR5bKfOj9pnCSYx8cL+pippst8MUXB9mIxUuVtF4RpFS3ioXoygzjLgVlX7IFrJMoEsmB9GLhgONZuR4AyHF+IPy7gUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHA6Ugd1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511234430a4so174246e87.3;
        Tue, 06 Feb 2024 17:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707269896; x=1707874696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRR8PzYQmgmoJFN6j49S/WzNDY1me1I/s7STh3i5jTE=;
        b=eHA6Ugd1904R2xqe0+A8JvC0NOitrCvMjr0gMUn2H1zYOOvL4FFlXGxXU9//JDqu4J
         hV0UmQ9NuSkWZ8beUKhhjB9FLiBELD0v0zDZhoEBkGSvBQEEO02dcaSfRdy1fUdz4tz6
         gdDsSBZ2WYeplNnObYFERSMRIpDTEXcLY8zIjofGQZub8fT3KvjXagwq/KCSPE940W3K
         RZOrJawAIM8LOWvV3AL7/SCaXeGhECZ7HpN3JdjN/lHVCjq5HvrBREBGr1MnaWwDSsBS
         M8j7AJd/tJsev+LdEhHhyXH39z0l/BHuEwPep2CriHeq/4L3eEhelBxHwrJC1Re3/xhJ
         TUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269896; x=1707874696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRR8PzYQmgmoJFN6j49S/WzNDY1me1I/s7STh3i5jTE=;
        b=DPQ9tPjJLfv1+7J1NCu3Qf5Q4AbZN3fm9RtsjTlt1toVGGpcayrWddfG2RAff9rEQr
         Qo7ODcs0s8oMD3WhpzvTatO0PW3Ulnshe7GFCYE1wYvG51tGA4djziRAfOKLB0Uziyy5
         Dt6r3X6i8TwRcxf4KRj1XGAIARNnFm0sLvphtTM2BaE47O2V+syra7fwLQK9mQgPPi6e
         uwAvLT1lQ/UckuSVxKS2KujyT8AB/qg0Vt/yLbvwuaMYcFv2kZ9JGQXs9LQIFi8Y1GN9
         sWDXqxL68ug64wr/Xr3O4cCaCXRTuv7tXIYtFqWRrO2rgwIk/mpnje5nbohuGi8vCfaW
         mvLg==
X-Forwarded-Encrypted: i=1; AJvYcCXBZmkH3Fjp/Cn2SZ7+JY2yzmBG6/83uyATDjAv+OPqnE+Jjhfi5p0bmXXeydC2rRVO0D2OnlyLJdyadQeSgA0ZrZXO7U9SrLze4gEqoA5iMcyI0OZdH76Vc+ctea4OykQh7+7CvSpIc24=
X-Gm-Message-State: AOJu0YyONOqvAjQlJnbs796pBvZBXThWtGEbtQUEljz8t0p7d6DNSFlZ
	KD0R6nFUxLB9zp+OzWi6Fbi4HKKQQcOjFqnfCSjeUU8kzES/wludgPs6roDDUlxbrC1RA/98zXf
	yZaHkqf423aCB4a4lurLor5JfuYg=
X-Google-Smtp-Source: AGHT+IHWVeRFoevEJonT+g3/tVNsAHF4QS5hTRgSA1pbOYTogyQc97c7t5XlEjUcYdKoasVqT0L4oXyqiu0EJ5+E2ms=
X-Received: by 2002:a05:6512:78c:b0:511:32d3:db3c with SMTP id
 x12-20020a056512078c00b0051132d3db3cmr2514220lfr.3.1707269896169; Tue, 06 Feb
 2024 17:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msJQGww+MAJLpA9qNw_jDt9ymiHO+bcpTkGMJpJdVc=gA@mail.gmail.com>
 <ZcK-W54WoNQswKfg@casper.infradead.org>
In-Reply-To: <ZcK-W54WoNQswKfg@casper.infradead.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 6 Feb 2024 19:38:05 -0600
Message-ID: <CAH2r5msB0KRXy9xhaFoUP253ed5HqxzKvvkm0G2x2oyKqopxRQ@mail.gmail.com>
Subject: Re: [PATCH] fix netfs/folios regression
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	"R. Diez" <rdiez-2006@rd10.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Also, what if the server says its max-write-size is 2048 bytes?

A good question but realistically the worst case I have seen is 16K
and those servers were ancient (most SMB1 were 64K but for any
reasonably current server the worst case is typically write size of
1MB (Azure) or 4MB (Windows and Samba) while some will increase max
write size (to 8MB) not reduce it.

You are right though: setting "smb2 max write" size in Samba
/etc/samba/smb.conf to 4000 (less than 4096) would cause writes to
hang (since it would now round down to write size of 0) - so we can't
set it less than 4K.

When David's patches for netfs/folios integration rewrite are ready I
do want to see if they fix this bug so we can avoid the game of
rounding down max write size (fortunately extremely rare when it is
needed but without this temporary patch we do risk data corruption in
this strange configurations)



On Tue, Feb 6, 2024 at 5:18=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Feb 06, 2024 at 05:14:42PM -0600, Steve French wrote:
> > The code in question is a little hard to follow, and may eventually
> > get rewritten by later folio/netfs patches from David Howells but the
> > problem is in
> > cifs_write_back_from_locked_folio() and cifs_writepages_region() where
> > after the write (of maximum write size) completes, the next write
> > skips to the beginning of the next page (leaving the tail end of the
> > previous page unwritten).  This is not an issue with typical servers
> > and typical wsize values because those will almost always be a
> > multiple of 4096, but in the bug report the server in question was old
> > and had sent a value for maximum write size that was not a multiple of
> > 4096.
> >
> > This can be a temporary fix, that can be removed as netfs/folios
> > implementation improves here - but in the short term the easiest way
> > to fix this seems to be to round the negotiated maximum_write_size
> > down if not a multiple of 4096, to be a multiple of 4096 (this can be
> > removed in the future when the folios code is found which caused
> > this), and also warn the user if they pick a wsize that is not
> > recommended, not a multiple of 4096.
>
> Seems like a sensible stopgap, but probably the patch should use
> PAGE_SIZE rather than plain 4096 (what about
> Alpha/Sparc/powerpc-64k/arm64-{16,64}k?)
>
> Also, what if the server says its max-write-size is 2048 bytes?
> Also, does the code work well if the max-write-size is, say, 20480
> bytes?  (ie an odd multiple of PAGE_SIZE is fine; it doesn't need to be
> a power-of-two?)
>


--=20
Thanks,

Steve

