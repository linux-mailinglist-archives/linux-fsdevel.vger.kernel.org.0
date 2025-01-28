Return-Path: <linux-fsdevel+bounces-40188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE31A202AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BBB18879E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FDF38DE0;
	Tue, 28 Jan 2025 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QPY1Vodp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9218052
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738025017; cv=none; b=ZIhTN1hlwKAdCVFwmsSOzhSThNvb/8fIeBHOwhZ79wL2qu4lx+G3EAHjNoW2zyyhskYVe5O0/u51YWH3CPJNBAtIEKGopWpIIFJT8OPJKyESFQjiVSRyqOiZEa29nN/005akklgnv22gQiQPys+acsoZOo/GV8U3Ohs6lQZ7K/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738025017; c=relaxed/simple;
	bh=us6Y/7N0h1MQwR4CHQNJtetX0RP04A8Uck5nBETHPfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJF0DchoiPH7Z3q+j0NnKLodoXjQtvkC4vPqFaO6Yb/Xs7n39ge149a1afJ+VYtSY95rDQeNcro9Gu8nlxTKj2vbSai/fqexh2M0ag+/K1RAsF8wPUkqWTf28YkvP8eBpnQ6SLFyBJ8dgTtUe/wqmwdj9Oqn8s+UxdxrRfQKsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QPY1Vodp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2e308a99bso983005866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 16:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738025013; x=1738629813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9AJtPRV7MOZCjPm7qeQtB2WP4mSHHyd8cWlVfGSXtB4=;
        b=QPY1Vodp50yV5+886I/1WPMdyZP+gUA8PHlN+M3PKfO2OProfESQP/VmWfJ1JGJ7TX
         92xC+ppgaWqkgHt5mmnfejn5veUEYnWjmm6HHuvDZhLQeaFSl3/sr+uGj1Ck9TLkAZA6
         IGRSo7FoWMnWBYSXiJc+TdKwthD/O53cueWEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738025013; x=1738629813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AJtPRV7MOZCjPm7qeQtB2WP4mSHHyd8cWlVfGSXtB4=;
        b=rywHf1BXzVl2ACZwbxOQMXWWn8i/AGcp2jLk27/zxWI6WHNnWh+V24utY6uOskxect
         yRAR+qhIfaBYo1wS3lCebFgtZ8aSQM9phinUzj4HHCpbBdJiPSP8+S04ZiBDR0oq2AOy
         DXZWUab83ya6BpsEWX45Lc6BLbeGVlCNnui8Dm3OGtUrN1QYA3DzYgeJteCeL5FKOf6w
         5DDg8wCFtlw8iyOaDh/PdA4GTguvfD5S3YsZZ11Btla00WVuquR3KkF29xNa1FQT624I
         ++6HQk6EQSpMZLGRuy6vxJe4KDgALOC2SFd1M0f/sgohmcCI7x4Wu9jwzL6g4nPYCg3S
         QpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7HPSOdXwgmhDgRXMqOmlQfsdN8kbslyyiucGwEdUMSNsFcabuGfzQ2HjZYXJrlaQXH+DerdkkLgTvDsVc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89cV8Cq0atmjSAg2YJp9WxjHuYW0/Aa6CbigLCrbJIPZ3b11L
	E6xgD1ndJh3mkfQjvv4PYE73uQJ0d9wBzdhzQ6ySeZG7jOKm/vGcvd5j3cCMKkjBeK4KjQQCurd
	49I0=
X-Gm-Gg: ASbGncsYJhIuFFbfTdbjUhjlmh3uu8qAMvWftGKPX7bk5yicOiRMydqxOnRxhjJiqNM
	Sa2nKRrG2TSgTyEVoFpdausg/a3CJCmxrhD/yOf0H//qqXE3GvdU8wLRQYMXGeLkgDrRRNIW/Qs
	xZTRyqWaPJC3tH++NiBVIOzxmQ/ngNKIE9y3EknzH3MUx3du3g74tdWhLGqr1wWJqjRM2HEFKZk
	xtVEzJJ2PoZ+LHsgiiGX2+MmPoRbEzzvHGGv79DhS0J1r9eJejS3iW6reQFjn2qRZy513G/vhWe
	CEUT6+BpOB4Lib3VCPq9tFolYkOKWxYW3IrvDvuCbo3FKfYcYQGSnNY=
X-Google-Smtp-Source: AGHT+IFE/T2RiIomg80Q7Qcqe6y5dPaqVOQMm5XuPFB5ydMV9/o0AdjNsb9HE7hngQRrGf7bwDR+EQ==
X-Received: by 2002:a17:907:d8e:b0:ab3:992d:d98d with SMTP id a640c23a62f3a-ab6bb87cc7bmr148855366b.0.1738025012185;
        Mon, 27 Jan 2025 16:43:32 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab68d6ff068sm462621266b.27.2025.01.27.16.43.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 16:43:31 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso10168085a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 16:43:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5PksdYsZU6eHMEHT9sf+5UjvgtHCDNrwa+mgUwtseS5ix64yFFm7odyXYSUbuga0h+Ickr+Re3gePmIZw@vger.kernel.org
X-Received: by 2002:a05:6402:1e8f:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5dc4fd1153emr1703315a12.2.1738025010157; Mon, 27 Jan 2025
 16:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV> <Z5fyAPnvtNPPF5L3@lappy> <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV> <Z5gWQnUDMyE5sniC@lappy> <20250128002659.GJ1977892@ZenIV>
In-Reply-To: <20250128002659.GJ1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jan 2025 16:43:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyuiqR9wJ5pn_d-vmPL9uOFtTVuJsjVxkWvvwzhWEP4A@mail.gmail.com>
X-Gm-Features: AWEUYZlotp37_yfmUMxW5YJe75OqciFPw4pReHhGqiE-VWbdNkzPLiQIey8AADc
Message-ID: <CAHk-=wiyuiqR9wJ5pn_d-vmPL9uOFtTVuJsjVxkWvvwzhWEP4A@mail.gmail.com>
Subject: Re: [git pull] d_revalidate pile
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 16:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  struct external_name {
>         atomic_t count;
>         struct rcu_head head;
>         unsigned char name[] __aligned(sizeof(unsigned long));
>  };

Btw, now that the external name looks like this, and has a 32-bit hole
on 64-bit, I wonder if we should just add a length to the external
name.

It would be free on 64-bit, and it would actually mean that we could
atomically load the name and the length for external names and never
worry about any overruns.

The internal name would still race, since the length in the dentry can
change at any time under us, but any code that really needs to avoid
an overrun and doesn't take any locks can still do things like

        if (name == &dentry->d_iname && len >= DNAME_INLINE_LEN)
                .. we know we raced ..

and for things like d_path() or similar at worst it can just limit len
to DNAME_INLINE_LEN-1 or whatever.

I'm thinking mainly dentry_string_cmp(), which currently does things
one byte at a time at least partially for the "I must not overrun a
NUL character because 'len' may be bogus" reason.

Maybe I'm just being silly.

          Linus

