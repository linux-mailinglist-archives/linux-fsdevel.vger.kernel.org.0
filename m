Return-Path: <linux-fsdevel+bounces-9266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5408783FA4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D207A283A01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249EE3C49C;
	Sun, 28 Jan 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gOoNi/ia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5341C94
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480285; cv=none; b=FFrRk2o2nvZ6Oe6Q0YEjYsq9cTIkzrjmo5cqzFaVEOc6LNQRlvdpf8QVwChYDgrwxCniKLcSXWthy1r7F0Dx7iVnJ3JTYtWhkeAQrdKxq22R98g65mp1DbtRMRLC4vZAifr+k1fm3PCrRAN7bmgSHTSOEnvGIbU51d0V1O3WpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480285; c=relaxed/simple;
	bh=ZAbeqFfkAVPYZBMTPGlMkmzAB7gy9KOSp2nArVSSt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f15ovad9kTaBGTx9/HUTGCq10MUagzpiAqePQ2wZ4MKzxcF6raAidoqx6dv1bdrRpvdDE+amWqVn7TtN3fkaoI9vF75sjFx7qjpjv4vw14XP38h7vSTSe2EyzHs96MXfusQG2y3PmODMswA21abl3ONp6iQMzE+1C/qh/Eut5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gOoNi/ia; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so16929021fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706480281; x=1707085081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QdJFIrMlzo7zdWhHTFYeNBtmU9mUeMU8Dy6w+dT6xYA=;
        b=gOoNi/iaLala8FW8oQ5fSMfE33yecB93x3rkCHE65YDdFNnw3b8bIzyXD4j11vEXK+
         TxN72k9LGVYGi9S5zNOMB6fOtAIdDYgzcocShl00+hS9z76VNgmLM+xicmjfPUjIxYCe
         TGEEOmmqEvT3VyAhBQtvv/11ZmEKo6225Pt8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706480281; x=1707085081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdJFIrMlzo7zdWhHTFYeNBtmU9mUeMU8Dy6w+dT6xYA=;
        b=tv7/gDx1PTiLQ2G6Hxnb3IxT/VUTk7N6lsVEeOjsVd2uCdnhCh2mvaN0z5sVAlyQAz
         FUSMisygokkcF5ChR+FTA1teOR/QvSbGEPMa2HkT4VN3TGx9D+o9Qj0fycfmwEDj4AEr
         JDKCLBTjUt5XE6MqnAJGGGa1SzfPs6t8oAUR/rRUrZ7BRv8Y4OKFDW0HafNfZEbnfxfQ
         awNOGHceNE6wXeYh0NF0nQg5IGu3c4+pRvikxWcA0aSUb3h6h3b2mkbWPIK0W8IlyxR1
         w4w87sT8dWZiCnMzZyiDX0OF6+tuHpL59b4Zotfqnpuz0cg+5xw9B+1j/UqGH+/+mHGy
         GCmg==
X-Gm-Message-State: AOJu0Yza++csqkSy5k174HpzuBNmNSRi2/jyHMJMFkjkKsMC/D/WSPv4
	Yrf+eGs30g8eDkLOGhaDRvgDjMeEkafheUW5muvfColGXrzDGhCK1sv2fZNcz2GlMuSOdo0MGLS
	D37qI5g==
X-Google-Smtp-Source: AGHT+IH8Ubwxz6zZ7NtjKigvS41yXnks8slWH+wBGIBTsBFzYGaKDfRnnGzjxBq/hYEp9VbR2glL4Q==
X-Received: by 2002:a05:6512:3f8:b0:50e:76d1:b9c5 with SMTP id n24-20020a05651203f800b0050e76d1b9c5mr1956387lfq.60.1706480281040;
        Sun, 28 Jan 2024 14:18:01 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id vj12-20020a170907d48c00b00a354f1aa21asm1926707ejc.224.2024.01.28.14.18.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:18:00 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso1826105a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:18:00 -0800 (PST)
X-Received: by 2002:aa7:d053:0:b0:55f:80a:3006 with SMTP id
 n19-20020aa7d053000000b0055f080a3006mr183783edo.2.1706480279842; Sun, 28 Jan
 2024 14:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
 <CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com> <20240128170125.7d51aa8f@rorschach.local.home>
In-Reply-To: <20240128170125.7d51aa8f@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:17:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0bfqL9Yn-KnamLTvTpw+zbAa=og_JRPjZHgJ5m9iCZA@mail.gmail.com>
Message-ID: <CAHk-=wg0bfqL9Yn-KnamLTvTpw+zbAa=og_JRPjZHgJ5m9iCZA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Basically you are saying that when the ei is created, it should have a
> ref count of 1. If the lookup happens and does the
> atomic_inc_not_zero() it will only increment if the ref count is not 0
> (which is basically equivalent to is_freed).

Exactly.

That's what we do with almost all our data structures.

You can use the kref() infrastructure to give this a bit more
structure, and avoid doing the atomics by hand. So then "get a ref" is
literally

    kref_get(&ei->kref);

and releasing it is

    kref_put(&ei->kref, ei_release);

so you don't have the write out that "if (atomic_dec_and_test(..) kfree();".

And "ei_release()" looks just something like this:

    static void ei_release(struct kref *ref)
    {
        kfree(container_of(ref, struct eventfs_inode, kref);
    }

and that's literally all you need (ok, you need to add the 'kref' to
the eventfs_inode, and initialize it at allocation time, of course).

> And then we can have deletion of the object happen in both where the
> caller (kprobes) deletes the directory and in the final iput()
> reference (can I use iput and not the d_release()?), that it does the
> same as well.
>
> Where whatever sees the refcount of zero calls rcu_free?

Having looked more at your code, I actually don't see you even needing
rcu_free().

It's not that you don't need SRCU (which is *much* heavier than RCU) -
you don't even need the regular quick RCU at all.

As far as I can see, you do all the lookups under eventfs_mutex, so
there are actually no RCU users.

And the VFS code (that obviously uses RCU internally) has a ref to it
and just a direct pointer, so again, there's no real RCU involved.

You seem to have used SRCU as a "I don't want to do refcounts" thing.
I bet you'll notice that it clarifies things *enormously* to just use
refcounts.

                Linus

