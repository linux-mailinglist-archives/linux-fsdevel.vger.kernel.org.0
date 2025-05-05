Return-Path: <linux-fsdevel+bounces-48131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384EAA9DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E1817F407
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5825D213;
	Mon,  5 May 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4ACdZKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADC270EB9
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478956; cv=none; b=VQkomsdCsy4zmaLRqo44gtzTJ2E5MaiIwZ6J2jDA2Bg0DAJhCPw6B15tisTnuiprdm+Cl0hT4wRUV0M1v6PHPfNh2z+9aicH9sZtQZWaFc/WLg0fIG+3zSYuwGJiCYKrstf+5hdliyronGZCkRkiZjqQOj2S1qgU1zp/SaFbPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478956; c=relaxed/simple;
	bh=aIPwzpXYbQHPUvBuYtO8UkYPN7EX/jZHc2EgrNGuii0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LrCwwceq7Ddo73RVnIo16TD+FGz11YrDAliU/3aX/oFAt7Qj4/iUNZNHSxnjrffJIF+yffB8KRaUcC1TClksHulXbgshnIdcNXpD04CIq5QzLZK5HVAzYGkcDXYlw1xm6VtHVl8ax59iwDbYHdSahGG7oZdpkbQqPgUKpLTZsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4ACdZKw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746478954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=L7OeTEBr3fodgJyMYLomWUjYK2GfKjBGt84kH8aEkl8=;
	b=R4ACdZKwaLlJDT8MLbwZyOzp4VVqwSavOMuGUpVjzPljF3H+qRdZKOGEb4fRfCcrvL7L6o
	5eBCqLNtyhtpYuKt3YWBbPwonbfg7IHJHT3VNdT5esPI4r4/O2bfH+uYmV4zry1jbqn2Gk
	5puy/Cb0FJ6en8JgHlcgdyEWJrcMX5A=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-pfCea71HM3GfJKdNh3A-cA-1; Mon, 05 May 2025 17:02:33 -0400
X-MC-Unique: pfCea71HM3GfJKdNh3A-cA-1
X-Mimecast-MFC-AGG-ID: pfCea71HM3GfJKdNh3A-cA_1746478952
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2d97c57980dso4739813fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 14:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746478952; x=1747083752;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7OeTEBr3fodgJyMYLomWUjYK2GfKjBGt84kH8aEkl8=;
        b=wrFE3QS6X+kqJXQj1VklRC3M6Ftb1Hk8MIrGyWdTIA2UHaGanUvxdNi5O5GM9xCeDr
         s+hFd8qPOG1OIsOK/FG1zy3voSxUMIOY+OuyArfUj/KVUlM9Y27NA1eX9eDNLziKFnre
         inhrvbjO4W2hVSg1RCHVjAL+NrfuYxrWpF88TKb9XmRwQ11q//hjReAhqewNdJuq5TIG
         OYEliyWC/8hzG/Xmmi7aB/zNrP/RIi2bHb6p5HEpL8wlZzLeuK62/8UuHUCGHvrjuLbf
         d8pDtk0vbe5gR0Npyd0XO1I12tHfH1GyAtOiQDDnQ+zlf3Dfq9qLAQrNHXJLqUTNc9xk
         SCIA==
X-Gm-Message-State: AOJu0YyXKTrRQNpZUTxcm9ZAvhxz5af8Pd+OJHGC1STpfMkivF9x84v1
	nbkSyHMZjghQ1wEf8ZC69itcNuoXrFUweens2iOHVtJsTz7rp5swCkr89+Wn60WmLxuPJ9AFQLJ
	NVpLB6MzJnbRlKeYO3qbUHKNG0by8FzDo+PqY37ChCW2vfv1NY46w9HGQxcQZkmWwZPW6C6AvbZ
	QSzVlU3+/E5buXzIFwvI43qKi1Ek9FXc4LdQNqIW9Iy0ZV2AxCNVU=
X-Gm-Gg: ASbGncvELMfhKsVb/bs28cQnut36km9KBGOaGaOsFOws85Ee3n1HVAkv1mcGNhi57Fm
	5OR4wVDudnKRdXaeOiiiiA6jrMm4FPtsRnxUtBw2SUFlvtrajJ+Srm8dvpkaR1uYvQj2iHZgf47
	MLOA9+OaLwNJuvH5kTviIKAZs=
X-Received: by 2002:a05:6871:a511:b0:2c1:4d18:383a with SMTP id 586e51a60fabf-2db38315961mr700730fac.3.1746478952484;
        Mon, 05 May 2025 14:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOF8EmhVKaZKDP+mItOsiIEmKFXWKPG7M12lHKqaCva84gLHdCEgnENHKa9pcrVcozOzdC87ZZWswHMjiP8ZU=
X-Received: by 2002:a05:6871:a511:b0:2c1:4d18:383a with SMTP id
 586e51a60fabf-2db38315961mr700719fac.3.1746478952247; Mon, 05 May 2025
 14:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allison Karlitskaya <lis@redhat.com>
Date: Mon, 5 May 2025 23:02:21 +0200
X-Gm-Features: ATxdqUHVA3lvkXtHo5vCuI8eYohLqqF2CCF-fBGKauo36z8lOdN3oQlMillrbXs
Message-ID: <CAOYeF9V_n93OEF_uf0Gwtd=+da0ReX8N2aaT6RfEJ9DPvs8O2w@mail.gmail.com>
Subject: Request for clarification about FILESYSTEM_MAX_STACK_DEPTH
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi,

Here's another "would be nice to have this on the record" sort of
thing that I haven't been able to find any other public statements
about.

FILESYSTEM_MAX_STACK_DEPTH is defined in a non-public header as 2.  As
far as I can tell, there's no way to query the limit out of a running
kernel, and there's no indication if this value might ever be
increased.  Hopefully it won't be decreased.

I'm trying to write a userspace binding layer for supporting
passthrough fds in fuse and it's hard to validate user input for the
stacking depth parameter.  libfuse hardcodes some constant values (0,
1) that the user might choose, but in an adjacent comment makes
references to the "current" kernel, suggesting that it might change at
some point.  It's also sort of difficult to determine if a value is
valid by probing: choosing an invalid value simply disables
passthrough fd support, which you won't find out about until you
actually go and try to create a passthrough fd, at which point it
fails with EPERM (but which can also happen for many other reasons).

So, I guess:
 - will 2 ever change?
 - if not, can we get it in a public header?
 - if so, can we add some sort of API to get the current value?

Thanks in advance!

lis


