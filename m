Return-Path: <linux-fsdevel+bounces-9131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C0183E5D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603392840CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DDB25637;
	Fri, 26 Jan 2024 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MScHVDiX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3C250F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309347; cv=none; b=i2HzG80w84K96+jaP0sT/NZ4ljzVSXecdiZqie0L7vZzIHZmF685BsxLCKVTmbiZwNhLRs0dQxCNrWRAv87ilnHSgSj41EIZGlxJxjxirACL/UPpi9Dd64GZiB1fslvqxA2jmRk9la7n0X2yL1z9vNxod9MROq+pyXkJBGJiJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309347; c=relaxed/simple;
	bh=ZC8lIw6nkj5AkxyuI4xf/CiVElrJVya/QfDBrLgEqn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoVRQies9nDKt/jzFu0AFrFXjeSXdtWfPt6ScZsKM+JHvXs3UiLjuuKXbXMCyiLa314qCfnWEoFYVvDoj3Rm4aTvQ09v0dl6UuIThIkSxJlGhzXJ9MIwsQYlrV/OsCdNTW1eBIf7il6D229L+nnHfL6WpQCFS3FwPjBlhYZ7HUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MScHVDiX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so125864266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706309343; x=1706914143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrhM++a5OFTukQjh6bVd0EodL17OqMY2SHvdwAgkV3I=;
        b=MScHVDiXM6oJ5JNU8P5D4csBM5lGEIPpPeJmXOcjVXbk+A/RrE7R9PFN9l8tR9Vx4B
         HVZFCO0Ui/Rf8VDrgg0Do+wsmppw6CtG0caw9sUdZwk8aQ4uoo3CxTxcGi/+1YEM7nK1
         Yjnpl1WWTrNMga7ZlyQPDjV0f7wiP0mJhMpAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309343; x=1706914143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrhM++a5OFTukQjh6bVd0EodL17OqMY2SHvdwAgkV3I=;
        b=IPYYYMdXaK9AkQmaQOO1MpYGLRfgJOtcEjG8McoghWrJAem2/BAvqoOeQT5SYmDVnz
         OYE60srmxQiMu/qceyUJhelojmHR+scNQ7cBc4mN3DadtsYQWOgLUbKVG4PiWiItfc+j
         s6j/DXM6XNk58cP52wuILuaVkphW9s9cnWqpiFQqLDc982/IyJLxTVCT8UtoTLT/vL5f
         00q/9qb6NXoVot4xMQjOl9iHRezmoXmDKiCZnbmd3zae3BXXhtH/0Rfn04OuFShod04Q
         NAhOxb3PjfQUKfX2DrKHlrXjlrsy7XWWOvfhp78pPdSqhiqnu73ZRpkw/9icTmDwQJXa
         AHDA==
X-Gm-Message-State: AOJu0YxXiT/APZ2aJ4vGuDIgGfBomC+/x2Z4len5QaE+sW/oGJjUBt5C
	tY9Il9tkhC71qNoh2a04obgv7Ic3KkmdUf1InGw3MTlPBQsK+IhdSS+FXdC4g7Yqs/OztYzCNcC
	dg4mVTA==
X-Google-Smtp-Source: AGHT+IHQNp+yV6r/ppU+XQMQPhKfZFyT9EZeq0sY0IfB1sX5VWSfNwvDWe9VnwmowAHrYxu6xcXN3w==
X-Received: by 2002:a17:907:170e:b0:a30:86ec:44dd with SMTP id le14-20020a170907170e00b00a3086ec44ddmr433158ejc.67.1706309343192;
        Fri, 26 Jan 2024 14:49:03 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ps10-20020a170906bf4a00b00a30f04cb266sm1078689ejb.5.2024.01.26.14.49.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:49:02 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a356f8440so1166295a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:02 -0800 (PST)
X-Received: by 2002:a05:6402:2709:b0:55d:31f8:920a with SMTP id
 y9-20020a056402270900b0055d31f8920amr513622edd.27.1706309342198; Fri, 26 Jan
 2024 14:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <ZbQzXfqA5vK5JXZS@casper.infradead.org>
In-Reply-To: <ZbQzXfqA5vK5JXZS@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:48:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
Message-ID: <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Matthew Wilcox <willy@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 26, 2024 at 05:14:12PM -0500, Mathieu Desnoyers wrote:
> > I would suggest this straightforward solution to this:
> >
> > a) define a EVENTFS_MAX_INODES (e.g. 4096 * 8),
> >
> > b) keep track of inode allocation in a bitmap (within a single page),
> >
> > c) disallow allocating more than "EVENTFS_MAX_INODES" in eventfs.
>
> ... reinventing the IDA?

Guysm, this is a random number that is *so* interesting that I
seriously think we shouldn't have it at all.

End result: nobody should care. Even the general VFS layer doesn't care.

It literally avoids inode number zero, not because it would be a bad
inode number, but simply because of some random historical oddity.

In fact, I don't think we even have a reason for it. We have a commit
2adc376c5519 ("vfs: avoid creation of inode number 0 in get_next_ino")
and that one calls out glibc for not deleting them. That makes no
sense to me, but whatever.

But note how the generic function does *not* try to make them unique,
for example. They are just "unique enough".

The generic function *does* care about being scalable in an SMP
environment. To a disturbing degree. Oh well.

                Linus

