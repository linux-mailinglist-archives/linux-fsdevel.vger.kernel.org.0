Return-Path: <linux-fsdevel+bounces-78753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLZmGlTNoWn3wQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:59:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F121BB1CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEFB530B102F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ECA34CFCB;
	Fri, 27 Feb 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BfQZtu2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063D33A71C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211303; cv=none; b=aTRYME2Yv+uGdCb9K5VUOyqYZItPZi/kJeIHxZkG5P+nQO8dU22wAhwPaz3+GuEdBUwAG7nK8YJnUURGauWvRCrtWN1jNrf1azXvcBkLGOUXMqSgZxYPSY9Aw5wzXNDr1te0yJeD5peEvBZ9i2aKX+gna1j0MuiX1AGLYbAo4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211303; c=relaxed/simple;
	bh=akqtFXFlakqrq63EVEoOPi0xlG+rsi+sf28934TfM2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1oCf81ZXId9fL5+9U883N+G2fzb47vpYHyL7pl9JEdctg6aYFzadKaSXJwYPSWZgkh+7HYhmfOySAG3rDXpZBChObxAP+pvlgd1lDmUZkEhNd/g4YTT1fT6o9HdpLr4NUjIv5vQ9OBRyXEVzbLWbiPFzWeDM3pSz89EcmRDe3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BfQZtu2P; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7e7so3192626a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772211300; x=1772816100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GpBThobI1yKVNNdYpkj2NtSBP17ERljyfHveyPj9vAE=;
        b=BfQZtu2PFwvGAggOTgd7ohsTM6GqPxVZ1D79fcc8xqBVWC1oCl9ybnJN96qg7Bm4EK
         xqEDFRL8M9wGBlI65RE1TEYaxEn5WOYxX51RHOs1eR3m/UPPHs5pco1BSXZIMaZuZDRH
         P1CNG6+Wo0Kyjv8vkZREld9ZUepnij7RC8JmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211300; x=1772816100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpBThobI1yKVNNdYpkj2NtSBP17ERljyfHveyPj9vAE=;
        b=n1Ab2qtsU28wsGbU5CFOlAu5WUN0PyP/CBICsY//AqFg2LUcCFvO30d28GReQpBshu
         4kWs3cAJdcCHOJOOqMl1gAVK0tg6TCC705/CfNbseVU9mIN9l3DYgmnpTSFmSKrRmAQ4
         uO/xmbfvLhRe5izipsA9lg6RosoJDYMpWguUX83wjcmPBA54jQmmKWbkUL/iFRLBtrJg
         WrEgW095B/LhbodfYD26BTas6kOonjaYLGsFc9ovRrbdAYvOCC0BzRfp0uIfmhkPNhug
         cLAaeubI4L5WbmyKLO2920Wp2uZMG5CXCLbkqndNl10jeO6yGLG2I+CDQ1/BQGTa7GcY
         bRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwUJDqRUTGxZwxkC4uOWIoLYHzJqQUOhuJq5aS50HwKw2ccsYEZLXMtQ6t1mjqyTtAZdmsIMghMwZYzpEC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lZDng/EgwO5E0nwZ1aRWv0NrwpZMCootXgw01U9QpOZJx1oW
	tJwKhwySsJgHZv+/NtmxIaTD75ANyFiAWlcoCMDDKVa5jtfmtOEcBTTQhgcyYueg12ZczlF0MY3
	yBrCtovc=
X-Gm-Gg: ATEYQzxaKfh4CyOijN0H4vUAaPS/ABSOG7Ado5SjBPkqsKgmm8eucRFT4zy95Ml13J+
	IUansFylWtst1at3REgIToxAnD+A5hw3cMt2M9O7u6llb/AreDY8ZWB/B8PQePsWUVAtbz2qpk8
	mfYOucAzyqThddBbbUr/OKIhOuEMVe211Kp+W84btbpwj7qVp7S3414eigH3J/KnJE5VvmfdkfB
	U1s3BF3Ul0O3VD4e5+aJ9wDe0AH4P1aEslBEhSgAEo7g6BBfRP5wWOiiAM0cANx7DqikLvY4gP7
	gIgp4EEo0d7c4INNhBVktmClcOEuJ8B/9tsbKsxQXs7XORZXuec+Ndc9VLuZ/ktpkQ7Yst95XFh
	fBRAXZ7IAxAAfRJ8tg+3g0PmNXquRwWr/3FpJAr902rTpiGVMyBRpXdAB1cAA6RbGwmmtaYOAwt
	/aRoKW/DH/hMwAJuwpPyE9qIA54N/ZGZssGgCnSslAlStd0ZSlhAYpz5FFlqGxnYeVsaJJJqDF
X-Received: by 2002:a05:6402:144a:b0:65b:f5fa:afdd with SMTP id 4fb4d7f45d1cf-65fdd6bd8a9mr2445374a12.5.1772211299885;
        Fri, 27 Feb 2026 08:54:59 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd4691asm1374455a12.14.2026.02.27.08.54.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:54:59 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9359c0ec47so240323266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:54:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGAmgY8fakpV1eJZe5rT70n9xip3USkLZG1IwbnXvRAuCCdEbKy/GEZobZAmKCp8XW/Nj5q7OhOlmIHsoX@vger.kernel.org
X-Received: by 2002:a17:907:724b:b0:b3b:5fe6:577a with SMTP id
 a640c23a62f3a-b93763615cbmr185110966b.8.1772211298942; Fri, 27 Feb 2026
 08:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io> <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner> <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
 <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
In-Reply-To: <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Feb 2026 08:54:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5V+8zHW1n4dhPp-eV8xhG4AvxSkzFp+dbrj6TzAYqjQ@mail.gmail.com>
X-Gm-Features: AaiRm502s2sCJxFl7SIl_psQnc0b8KoUXw-TE0CeWGyT4cOWUv9PhA1xz2bdI2w
Message-ID: <CAHk-=wi5V+8zHW1n4dhPp-eV8xhG4AvxSkzFp+dbrj6TzAYqjQ@mail.gmail.com>
Subject: Re: make_task_dead() & kthread_exit()
To: Christian Brauner <brauner@kernel.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[gtucker.io,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78753-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C3F121BB1CC
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 01:48, Christian Brauner <brauner@kernel.org> wrote:
>
> Anyway, let's just take what you proposed and slap a commit message on
> it.

I will look forward to getting this patch through the normal channels
and I have removed it from my "misc tree of random patches".

> Fwiw, init_task does have ->worker_private it just gets set later
> during sched_init():

Ahh. That was not very obvious indeed.

                 Linus

