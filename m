Return-Path: <linux-fsdevel+bounces-39733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2BA17330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411373A448F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6E1EF0AA;
	Mon, 20 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QST3vBmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02A1EE026
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402010; cv=none; b=oVK+vd2XXbAdPuJU4w0mO2feQlBHhpqLLaIErAfS3tThiZG8uP+e1ZOCgUfWtXTKMNWDPAUqr8Ysj+EpgEnKChLRo8UGlUqD1gWXs9eDzcevmmR+mdOXyMT36ClQzTVXrNXl+edk/iGTUEtHgqQcfKm9vY6XPyZH6GWVQdCpHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402010; c=relaxed/simple;
	bh=KjUpGpjy2jsl/wKPg/u0lShy3sDaLnUgcG0DYmzHyiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjGdWRND0aB2SNdOj5rHRAqTkuVce5/ldqt6zPA02VpD32E/pOUGuGwB5cIA3GWBbLhhcMxIf46z3lc+Ujr+PIfdQMbNGT0Au0XinwnNvS841RB8GBBc5NRoAeyXzKRz6zw/Voyjw8hkRZnjtcsyd8ciJvZltMCPDWt1bcb9yX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QST3vBmL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso9735527a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737402007; x=1738006807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/TudQQHkmV+sd4uzv74ZyqlQkFOnAYHQJfUqzeP0qs=;
        b=QST3vBmLfFDGRS5kaATeqZ0UsuhWuTbNz1H301w8t5eYdJ3dtJcxbGlS0nHuRlhzU6
         axFuRF8WgmfWTXd/v0jQit6tm+amRz4IZXN+o10N99wGmxstQKkzaj9LeI9sPCFHfx/b
         tRNgdshoK6loCe5u7/2FTLqvgvfZ4uOnCFAVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737402007; x=1738006807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/TudQQHkmV+sd4uzv74ZyqlQkFOnAYHQJfUqzeP0qs=;
        b=FHw11wsj4hKeM32dXCXX3dbaRPWaP/R48q7/9vRCfh5i2b33VTq8CHLiwJQk8tLcNr
         dJCaT5HF/b/kE9AO/e7vnx7N4KKxzcmrl1YK64p0Xas/ern/CLDGaDUONuBsL7c2zUba
         6hk3lULp1QGUIpmwgPxfDDJxD2ARs0JB1dxOI16gqGif2K++k4BpgaP/huG0pgg90uOI
         rEde4wdUw/0rA0dojuZKbEHjsriwA4OreGkfWYDkfUSmTg2xffSCMcnY9Z9Y1QOdDUHu
         IW6UBsBe475rIfQK1X4ZIHhQ3SBACDBlQ7b3O4K7uoRDEB5io0YOMIIXu2M7DQAZW/6e
         CXyg==
X-Gm-Message-State: AOJu0YxesHK4Qfmh5JoBtGrlXCNB3AEoYlvlMdmdCdM1/ztHxwHsuht/
	PeM17QCTrW3Wika8UG7OMk8C1z1OD5YhcJRt0+wJcca6Zh+cSuJEYo1t9VAluDFIeqbozW68sfp
	DyF0ADg==
X-Gm-Gg: ASbGncvcNoRZi7ZQuLicJIqx0kQIiE1i8v3a4UWtgp48dRqjZxhZ90g96WrO89Jo5ux
	BCqL1w43Tux/S7T7SWmXYQbOuJp1r8JJAKUFxHatqPcM0XOLDjNCbVS0bH7OMCP9Fb1w8L4gcXN
	FBBw3w7qyxiegKAZGCrs8+T/fvvLQN6HLDSjLmZ1zsblF2nmDpGoG57KzSCZoQdJDgYauuzl1pc
	+tdjOwm8TAeKXjwhauZvO9N3nJQ+HFl9qwRfK6cSjdk/mbWrzgWHKyp/mXcqN6MfL7tbRe+Sva2
	o1yZXPm8qn55FVh9UyLFbzPLWN7CcnjOG2Ql9kLrMwMY
X-Google-Smtp-Source: AGHT+IF7e67vwDFVxMwcVLV3/NiLE80mQtaYzMTe5N9KVTZ4RHfJ1axY/twy3cfGj1uJrsdb141TSw==
X-Received: by 2002:a05:6402:40cd:b0:5d4:5e4:1555 with SMTP id 4fb4d7f45d1cf-5db7d300482mr12367490a12.19.1737402006748;
        Mon, 20 Jan 2025 11:40:06 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670e5esm6230569a12.23.2025.01.20.11.40.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:40:05 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so961854166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:40:05 -0800 (PST)
X-Received: by 2002:a17:907:9691:b0:aa6:519c:ef9a with SMTP id
 a640c23a62f3a-ab38b3d5ebdmr1476947666b.53.1737402005429; Mon, 20 Jan 2025
 11:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118-vfs-dio-3ca805947186@brauner> <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
In-Reply-To: <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Jan 2025 11:39:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxYL9=5MCLhYe8xjeqow7X5dga+_HW96Oh5UufqEsuQg@mail.gmail.com>
X-Gm-Features: AbW1kvYIRLZ59o9GbD7N9CNLAKKDbZrJj2RMEIpA_24nWKgCUQ6igatHkxridWQ
Message-ID: <CAHk-=wjxYL9=5MCLhYe8xjeqow7X5dga+_HW96Oh5UufqEsuQg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs dio
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 11:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And that field was added in a way that causes the struct to grow due
> to alignment issues.  For no good reason, because there were existing
> holes in there.
>
> So please just fix it.

Side note: for extra bonus points, just make those fields be 'u8' or
even smaller, knowing that the values

 (a) have to be powers of two anyway because nobody can deal with anything else

 (b) the powers are already limited to 31 on the top end (by the
existing use of 'u32') and 9 on the low end (by SECTOR_SIZE)

And yeah, maybe somebody wants to have a "no alignment possible"
value, so that would make it a total of 24 different values.

You really don't need 32 bits to encode 24 values.

So wasting three 32-bit words for this all - and an extra one for the
bad alignment - is just a crime, and only makes kstat bigger on stack.

It also just adds extra code, since most *sources* have the size in
bits anyway: it typically comes from things i_blocksize(), which just
does

        return (1 << node->i_blkbits);

and it would be better to just give the bit number.

(XFS uses a special XFS_FSB_TO_B() thing to turn its bit-numbers to
byte sizes - I'm not claiming that everybody uses i_blkbits, I'm just
claiming that all sane users already are in terms of bits)

               Linus

