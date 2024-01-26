Return-Path: <linux-fsdevel+bounces-9124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEA83E560
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1DC1F23056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103182511E;
	Fri, 26 Jan 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G0b+K8dK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04F250F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307989; cv=none; b=c7RA/2E8InXVJCXtwE2PA4tq/3jNApCpDuQqj/2GxnS/UJvrV+ydTYUxRa72vQG2C++eFB9zTCqdUH/C6iSxcrkpAOzbCXQNYZdYZzDX8JvDfaDRfn3fT+kdrxFuzSMwNm1TncuRp8QScbgbNXoDanqGM3QX52ehU+JuRcGW04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307989; c=relaxed/simple;
	bh=ulYxyMID4hoDqqkZq7ZMib690LO/V3+HiOYKu4iA5EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6U85P08jjo6n7eU8TF6E/iAmf4GG3Ai/N2TOCrEx44nJ9O9uIKubDAT4S2iVFQH8MTVHaAV0i+61I4b9cct+vllZo4kzie7o0ahDnhxdGQ8tzbt/Z3Vdcs4/3SfIYJOaR8iuYCwk0vyjLt9+TVrKQlGbSZkVK70mtlq4aIUook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G0b+K8dK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so83144166b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706307985; x=1706912785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7RgCCRFdykhHgupnFCoE0SS5Tr46EimKI36cb0Txx4=;
        b=G0b+K8dKSaXhtj/LF1iMD6wZqs1UnX2DuWYXjXfIXukLmUdh9ieE9HvalEHFleujju
         hWEUmLs1vA9PrCLZLauOgOch+V9E4Shox7k9C9vcHDvmYJh6vIYYFcPBfE9MLH7hRhyg
         H0U6DbaBApv8Z9eONS/HV+1Qa6sUSQ6dbIJ9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307985; x=1706912785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7RgCCRFdykhHgupnFCoE0SS5Tr46EimKI36cb0Txx4=;
        b=Wt3ZyrQc1P8tw24a3+ORvvsXRKoa/DjWOQs9JZW0K66CAveWnRP3pYUILJa4AB4oCP
         uz2B8cCzA8m8XofdkDMISvXNqNproPT42ohhTj22KPMRFZip+WrVdG84YWcUAIA1QO7F
         Frepbx1ndg0q6u3UwoLS2Jh7Otz5AWMSmMHgfDfrUbLXoVBog0uJmc4d32JygWqm8z0t
         PeaOj2gQO/q0Yl6ttK4t2HQUExb5CTqBSXGT3ZIFzQjAQh84DbIMtfDyyBzEXPpkEw/B
         5iZznY4n2KUmJIVJ7QOydHbDrT6om1lOMhouqtyG+10qxgYTzuwv6BmRXGg58Qt56lmL
         ThOA==
X-Gm-Message-State: AOJu0Yww5BlVuBVL7ctBPeruF3u8VUJ8gSTqdrvRBqZpndvZkKpLVhSm
	MZexpqoxTo8b81whbQ/mvHDsFxAbCAao/NOFMyqAjwB8kmMWze4X5tcUD4ogKOycpC+yFlTzUeM
	shGdFkA==
X-Google-Smtp-Source: AGHT+IFphnEFX77O0TmNWysGybjj5fxf6bJmRhPBijn5bG0uudmQGP99WhhSxbM0yzfXD+/OqgPWtQ==
X-Received: by 2002:a17:906:54d:b0:a30:cf8d:8c27 with SMTP id k13-20020a170906054d00b00a30cf8d8c27mr243518eja.68.1706307985491;
        Fri, 26 Jan 2024 14:26:25 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00a2ada87f6a1sm1077106ejc.90.2024.01.26.14.26.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:26:24 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55790581457so667081a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:26:24 -0800 (PST)
X-Received: by 2002:aa7:c64d:0:b0:55d:71d8:9dc1 with SMTP id
 z13-20020aa7c64d000000b0055d71d89dc1mr232273edr.38.1706307984490; Fri, 26 Jan
 2024 14:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com> <0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
In-Reply-To: <0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:26:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
Message-ID: <CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm not at my computer, but when I tried deleting that, it caused issues with the lookup code.

The VSF layer should be serializing all lookups of the same name. If
it didn't, we'd have serious issues on other filesystems.

So you should never get more than one concurrent lookup of one
particular entry, and as long as the dentry exists, you should then
not get a new one. It's one of the things that the VFS layer does to
make things simple for the filesystem.

But it's worth noting that that is about *one* entry. You can get
concurrent lookups in the same directory for different names.

Another thing that worries me is that odd locking that releases the
lock in the middle. I don't understand why you release the
tracefs_mutex() over create_file(), for example. There's a lot of
"take, drop, re-take, re-drop" of that mutex that seems strange.

           Linus

