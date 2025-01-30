Return-Path: <linux-fsdevel+bounces-40415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BEFA232C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918911886B8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D11F03E5;
	Thu, 30 Jan 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MtG2vsIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117101F03D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257896; cv=none; b=haWjqFAvckCJzsbUQqR45WT1L3QlLj4TPenUeWiSdD0kP1LWKh1WmPdB9WeZjniEaQlq9joWNrz7aRZQ5HrH7LRurShVuDLgMj7/JFRR2Ajn85ROUf8mb9SE8oZVU0AMh3PV8Cb33z5Am6NSonraXz3gUlwEZttSWqS4bEVco8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257896; c=relaxed/simple;
	bh=6Qv+A4MOLBB/p2x+2LfQiWLMn2cpLrsE9gu4CYycDTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZ0MeeqKX52jKVseBtxXY9zWu9YyzbiB9fKAfuLOiH+cmuOMR15mojgs0CZn0HoHr7ORka7oue9roL6MgHpt2piQqu2yVv6rq6TuXVXQZGwzxFwM7BJO3WG1i1RfXrAL2ie3OztP5gpnmjIkmwFG8dqNUXNHzlJdOofwTckH/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MtG2vsIX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so235119866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738257892; x=1738862692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=umZKRxEZDIyFeupwQbUpP1kTluqmkTf2dFfPuk8gQnc=;
        b=MtG2vsIX3sw8qqco0qnSqGewfzt2E+/oKI0NHiT/tdZCeUAZTxB/7yN4/lvQyCefe+
         SAbqtHkjO4hi4jv0esJo3Wypzo7RWR/Ip07UH/kz/dbUcuAZpi/LYBOLSq0b+vr1/ac4
         nmpitxW8UOy6GNZD/eDdjWjhHG5L07dl1Tzl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738257892; x=1738862692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umZKRxEZDIyFeupwQbUpP1kTluqmkTf2dFfPuk8gQnc=;
        b=QMPlQebCIn9FWxZWdpgb8KEcLoDZ/8H8KgH7nj1FSmpTscB/8EZLaSLZg/X/stR8qn
         PcbvfbwjuD3LD9XrPX3lSmTAJrPGxQfljTGyZMNzFyS6juvAbw42HtNilnC58sJUQ5jI
         SGXOhSSN+c3bhxQOx8AmORH5MPMrjIuMvN8L0FjWhWkFvIhwFIMgJTeN6ZZFmrizmDJo
         /hUm9LZ3l3Jed8yOoWZGynerz6pcEAWnR7GPQyzqRUIvyosqpfUWAHm5nZSBYywqLrT8
         VOrSFCE09ERRpdft50tHpwKXRqfehFAZSfOIkBm87HmJP2MMt9u0IiV7O1yT+SGeRNk0
         C0bQ==
X-Gm-Message-State: AOJu0Yw2cEmnhrkxSwjs/6p02i/yY0iKQGque4gJC8GumLp7xkNA7S7s
	XdjMe+JVrssjTVE5bh9jql6/CEwX3+BiZZwfIHX0p26DgrCJLoBe5KcN4Wq6jo/FoM3B4JynZl4
	AHTI=
X-Gm-Gg: ASbGncu2GPHCmSMc8M7ruMrFNbNTDoEveGlXVWavFsPWMtIlDzHgVn1Sv9NnSZEmC9i
	F8bf1Fw9YlmNGT7odYBWtNJaoK/DrBwDpOb1MSuqDAJ2abJIEjNIoUWIaMIyexmMAeM8Ln30OSE
	6JSBxoCu1jllJLRoMB324852DV1NnM7GerNelCoQet2af4VmKmNmyoR+zyTT/4W/uVNE/di0HBH
	R56QW20GSJg1sBm5xyRY0kw/hJbuPoXfkd26607nCEBdvDDYa0Ks8MvTmm1Dlg/4lnQmtaCi2b9
	L6kCp37m7NpityqkHqjvo2NDOFFn3owXiIydzH6DV8HWKYe2C6ogXxACUQEqfEJS0Q==
X-Google-Smtp-Source: AGHT+IEC51OYjVhkkL7uNmxbIk9oBEr1JZgYarrAU2s7mOpZxnKEzLPPKGvEALDCVRhAni6IcMrkTw==
X-Received: by 2002:a17:907:da0:b0:ab2:f8e9:723c with SMTP id a640c23a62f3a-ab6cfcc50bcmr916812066b.5.1738257891922;
        Thu, 30 Jan 2025 09:24:51 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ffe44sm151001766b.113.2025.01.30.09.24.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:24:50 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso233227566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 09:24:50 -0800 (PST)
X-Received: by 2002:a17:906:da85:b0:aab:d8de:217e with SMTP id
 a640c23a62f3a-ab6cfd0db3emr759038866b.26.1738257890447; Thu, 30 Jan 2025
 09:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV> <Z5fyAPnvtNPPF5L3@lappy> <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV> <Z5gWQnUDMyE5sniC@lappy> <20250128002659.GJ1977892@ZenIV>
 <20250128003155.GK1977892@ZenIV> <20250130043707.GT1977892@ZenIV>
In-Reply-To: <20250130043707.GT1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jan 2025 09:24:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKkZBM6w+Kc+nufJVdnBzzXwPiNdzWieN3c7dEq9bMaQ@mail.gmail.com>
X-Gm-Features: AWEUYZmTt2mTlIxYn9aBQ5TkH5IgcjClwxwxOG9VfCpa_i04bqh6yE87LV0ZQs4
Message-ID: <CAHk-=wjKkZBM6w+Kc+nufJVdnBzzXwPiNdzWieN3c7dEq9bMaQ@mail.gmail.com>
Subject: Re: [git pull] d_revalidate pile (v2)
To: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 20:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->d_revalidate() series, along with ->d_iname preliminary work.
> One trivial conflict in fs/afs/dir.c - afs_do_lookup_one() has lost
> one argument in mainline and switched another from dentry to qstr
> in this series.

Actually, I had a conflict in fs/fuse/dir.c, and it was less trivial.

The d_revalidate() change means that the stable name passed in might
come from the path lookup, which means that it isn't NUL-terminated.

So the code that did

        args->in_numargs = 1;
        args->in_args[0].size = name->len + 1;
        args->in_args[0].value = name->name;

in fuse_lookup_init() is no longer valid for revalidate, and  instead
you made it do the NUL termination as the next arg:

        args->in_numargs = 2;
        args->in_args[0].size = name->len;
        args->in_args[0].value = name->name;
        args->in_args[1].size = 1;
        args->in_args[1].value = "";

Fine, no problem. Except it clashes with commit 7ccd86ba3a48 ("fuse:
make args->in_args[0] to be always the header"), which made in_args[0]
be that empty case, and moved in_args[0] up to be arg[1].

So my resolution continues on that, and ends up with three in_args, like this:

        args->in_numargs = 3;
        fuse_set_zero_arg0(args);
        args->in_args[1].size = name->len;
        args->in_args[1].value = name->name;
        args->in_args[2].size = 1;
        args->in_args[2].value = "";

which looks straightforward enough, but I have not tested this AT ALL.

Miklos, can you please check and confirm that my resolution is ok? It
*looks* trivial, but there may be some reason why it causes issues. I
don't know the fuse code enough to really be able to tell what
implications this has (if there are people adding other args
afterwards, maybe we now have too many? Things like that)

               Linus

