Return-Path: <linux-fsdevel+bounces-60464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB8FB4807A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8543C150B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A972192F4;
	Sun,  7 Sep 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LVsbWHKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7715C158
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757281899; cv=none; b=Ak66esuFWSQ3tGdwRa2zpH6fmoiAA61E2pJ9dTZzKNk63Lta4Gv/FMdp6xrfrtyM8M2iqlb1knQ/TPhFITpjT0/bHN0m8zfv/8Jn85rUuGkFf5sLJM3k6LmifYGh/qV3nsP+aMnWS0QoBlMGiQ1SkECcNtZBT3Q4swY+dNqRcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757281899; c=relaxed/simple;
	bh=i2LQtogur9TYi2w6kPWdqVJRnYjyF81GA7kgRNMabBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myvKKAPHMz9TbmmAyA8I4jD6xFou/Y3pwLEeoGAkXHAUW/n1zRitzpanHs0w6VCp7aEk+QGZonfrlwgeVYE9AXzzcHOHi6ezPXaridmtU5nE+atb1EyxU/JgJdEaETz3ERMyfB5tDj/AKodl5Sq2FytLlbSCdX6fKlt2prr/LLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LVsbWHKJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0411b83aafso644019066b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Sep 2025 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757281896; x=1757886696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctvD95hXD8mZTU0XdsrSMHd2LX8T01qbThDdBoatB90=;
        b=LVsbWHKJYwuy2uQMt3JSTOdZf1msvLmepCmkrgaFyTO7bojL4PizdI5XGs+PPKhE+V
         zJzTRhSJkruX+MseOavR6C/WWKYVuYi38ICb2z0Y8/Dm3t/PuzKVWb3IQnE65EHeGTlM
         WBowtiE5ipi78BnyzfWuCz0b2UEUd/uScrv7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757281896; x=1757886696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctvD95hXD8mZTU0XdsrSMHd2LX8T01qbThDdBoatB90=;
        b=vtmayQq5EyKlz/fe8TODubWNWdJw6zGvdlo413bEvr9fEAALFiZisc2hPZ3i4VJ7KD
         85EnDN4BgbsHQqtdJSDTsX/NOqN8ulPMaFSdE0tD+kEjnXkWz33Cv8i8uEzm3AazRnu8
         a7xoXYcELhthm0z3ob5qgxjK9Ton40pKIchZMO7p91hMQTJdQhVmN2d9voSiN8ebccZ+
         BWWNVyAfGjEWAF2oQzKwV2gSwpn0j75jpvqOyzfus6PBvc4KlsfVkD806LjL8lVPQcEE
         Uf4vXQpg2VcocyPt9hVFYtSneDbi/oKV+Ra1+finicW0CirYcoLYi5v3fggwQgeHWGtH
         ya5A==
X-Forwarded-Encrypted: i=1; AJvYcCVKEJBMJ3cAomvN44vZsLBAzy3YBgcSdjGDKbQVMHbrvaTIxXeX7v1/SSqbf7cWYuXuObm06sg/SovaQ/O4@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRU14KQtyoXTTrSweBoSkttpolWbrpYsBlKO+5Q+ZyL3oULPO
	sU4au/nANP5WOpIeq2xn8s88v6AEyLIQkxylk4LiWLC4Hvs2ulOhMETuvJg5s0znRqDGccNT/Wb
	CdYzYnJ0=
X-Gm-Gg: ASbGncsEbZvo4mkBmXaYsjLtn/0QQsXHKdZaHHSazPVUhZq68rIdN//9pfzTkuW/9HW
	ac95SSUQvCPNETj3OzQO9ydoLgcA7jcVpRIbj+pC+b+8QhxoaxmCgMFdDOtS6iZd20T4sfKJzBy
	/OiaBkEpER4J75LxbsvBft/kjt4mP4gAD9mVHmywEhw8o4stHNyjzX/Yna6rx2jz+1wbU5d9l6G
	8cyF6ewQWlmM02Anty6Xr/tzgS4t4+QpPuaF0KnBdXrMZz2REk1wwx1ecQxFMsPJSzKMl7bP+dU
	qRAYacQmnYJMBLy23J8EqW/g5x+e4dNyt0Cqk/e4THyF7IgXUidAiP/ZY4zySoGchLaPvuLPsuc
	HwPtzO6xBD7aoIbtoTtt9cjVQXl53azFvJb2IAnxOeKBVE5roxcvr+V3uatsAfz96nc5pNYl0FW
	6hXGiVsbU=
X-Google-Smtp-Source: AGHT+IE4buyKoTCqONIpo+sG+LZIByNsMovLUScezCPYjbpHXoXlE32PnJlQTXNCy9fjO3rhJaESdQ==
X-Received: by 2002:a17:907:1c28:b0:afe:fbee:88a with SMTP id a640c23a62f3a-b04b17663a2mr574322666b.59.1757281895790;
        Sun, 07 Sep 2025 14:51:35 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b03fa921a32sm2049393966b.31.2025.09.07.14.51.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 14:51:35 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso2241750a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Sep 2025 14:51:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGx2yPUh7RXetrCYn83BY0t6mRgrJlOYsREp7Ea1437aekYmTqg8B4Kg/JvONIWGTvL7XQj7xYpdBS6x0A@vger.kernel.org
X-Received: by 2002:a05:6402:2348:b0:61c:8fe9:9423 with SMTP id
 4fb4d7f45d1cf-6237edb2f15mr6243812a12.17.1757281894679; Sun, 07 Sep 2025
 14:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907203255.GE31600@ZenIV>
In-Reply-To: <20250907203255.GE31600@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Sep 2025 14:51:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
X-Gm-Features: Ac12FXwlIHsK0S0LoMt3iSb_Stso35WytM2_-ODSedS9EKM_1bb6hs4KsugT48U
Message-ID: <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Sept 2025 at 13:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         I would like to discuss a flagday change to calling conventions
> of ->create()/->unlink()/->rename()/etc. - all directory methods.
> It would have no impact on the code generation, it would involve
> quite a bit of localized churn and it would allow to deal with catching
> ->d_name races on compiler level.

Can you make this more concrete by actually sending an example patch.

Well, two patches: first the patch for the "claim_stability" helper
type and functions, and then a separate patch for converting _one_ of
the users (eg 'symlink').

Because I have a hard time visualizing just how noisy the result would
be (and whether it would be legible end result).

And I do wonder if it might not be simpler to have a model where
filesystems always get a stable dentry name - either because we hold
the parent lock on a VFS level (fairly common, I think), or because we
pass a separate copy to the filesystem

You did that with the d_revalidate() callback, and I think that was a
clear success. Can we extend on *that* pattern, perhaps?

            Linus

