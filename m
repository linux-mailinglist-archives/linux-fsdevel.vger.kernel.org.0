Return-Path: <linux-fsdevel+bounces-8212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE85831097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 01:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0E71C20A54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742417C7;
	Thu, 18 Jan 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YnKDAOvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2308A49
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538440; cv=none; b=bkX4460Bpc8PsMgowR1fXF2HwEYlhTAPlhkAmwfKIRmwZXR+r5oYXQsPwGmBNbNhhIB5ZrLwXudGvbSKcnVP2fpG8CHsPqJtzjtBWqEBo2BaCZo/ZnXrOgjS3Xwrc47Yts0ycJ9knnUkEGIptt9PAAckS4k2jLDFLEYmlD0QPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538440; c=relaxed/simple;
	bh=wfhytQrJMMiWrixD9nmB30TWoD6EGInbSOyFaCWgi98=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=OnlchRAd8TujiHwgTXU5LfDfBKjDdlESu+yRrBdmmBBU59IyY+WyTk+qaI0RUZOUxuSX1o2Wp9UgnezN2b2yN03ei5KfUB9spYEOUMrATd3AQzeG7vtjofzefnY9qFldPwgtrnzcszG4enL7aHrJcA+QV/rZJSQs856kAQAmAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YnKDAOvH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so40438366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705538437; x=1706143237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVPLukBNnnNjMwVZJfAGjZfCfAS2LZk4MtxqkQd4+bU=;
        b=YnKDAOvHjbwzMrjPUhfOWm/tI1LqLrjYUIdjcDl+wAe4AxctLAaQkRiJzzgRnZdC6z
         5hJ1+hQj9K/Enph3lY2ehv9YGbxAGYo+j6MCu6mrnoF6DOqEnfUO+0mkYVpDMTwqQuNC
         llN+c7XMeM93ZGg6Om4jozWCroky3rVRYHAo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538437; x=1706143237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVPLukBNnnNjMwVZJfAGjZfCfAS2LZk4MtxqkQd4+bU=;
        b=bQd5pZFxggGS3dErVJRoRZAwrV0JFRoJE0C2OhT9asoR7cSKik6LIv8zXG/Nldy08i
         DwjfG2Ulo7sQYdyMKvb4BbNJJ7a42IIZwDoNHuSgE8oPvpBLug22UbXts078gMfgYUiM
         +QO1MogoM/5Sr9/b3ZyPbneDYKTHQpk7ruGoEvXvyjLX7U5Bqaj5ScsTlNFXh+V50zO/
         qKvk2aF1TNIlLnXqnwmaa+Cgy3PaoW6zJssYuQ6ZIa4sMih22M9E6/clyiLPxcd/IFrc
         X+wDu8S6OV9CaP/iLjiUk8c5CaCID7zmLr/bwYcw/RKNjY2iLkBTx8D7bHbwYzL+T/ut
         xlqQ==
X-Gm-Message-State: AOJu0YwveLMUkOLZ1FYbkQTx19RIl2jjl4MtNxZpffRb4JJ6r6cr+kCx
	LZoJJpSvGCkMCHKd5YAtSmS8LXEWjIVnapCIaQBGw8vpxvXEAxyYGxI6zZrWLgfBwP7edRn/FP7
	4ADgzHw==
X-Google-Smtp-Source: AGHT+IEW8Km/aIt1ehzqN2+wcQmZkjxb5gAiaJ2MWHTdyC6DjjgjVPkd8o+x/j/KsVUxvsRvhpWRiw==
X-Received: by 2002:a17:906:4946:b0:a2d:a38c:a51a with SMTP id f6-20020a170906494600b00a2da38ca51amr1772465ejt.29.1705538437041;
        Wed, 17 Jan 2024 16:40:37 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907a58700b00a2caa85c56csm7474427ejc.38.2024.01.17.16.40.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:40:35 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a064e54a7so155973a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:40:35 -0800 (PST)
X-Received: by 2002:a05:6402:511:b0:559:f742:25f1 with SMTP id
 m17-20020a056402051100b00559f74225f1mr141873edv.2.1705538435513; Wed, 17 Jan
 2024 16:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117222836.11086-1-krisman@suse.de> <20240117223857.GN1674809@ZenIV>
 <87edeffr0k.fsf@mailhost.krisman.be>
In-Reply-To: <87edeffr0k.fsf@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 16:40:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd_uD4aHWEVZ735EKRcEU6FjUo8_aMXSxRA7AD8DapZA@mail.gmail.com>
Message-ID: <CAHk-=wjd_uD4aHWEVZ735EKRcEU6FjUo8_aMXSxRA7AD8DapZA@mail.gmail.com>
Subject: Re: [PATCH] libfs: Attempt exact-match comparison first during
 casefold lookup
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, ebiggers@kernel.org, tytso@mit.edu, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 16:02, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> No, you are right.  In fact, it seems d_compare can't propagate errors
> anyway as it is only compared against 0, anyway.

Note that the whole "malformed utf-8 is an error" is actually wrong anyway.

Yes, if you *output* utf-8, and your output is malformed, then that's
an error that needs fixing.

But honestly, "malformed utf-8" on input is almost always just "oh, it
wasn't utf-8 to begin with, and somebody is still using Latin-1 or
Shift-JIS or whatever".

And then treating that as some kind of hard error is actually really
really wrong and annoying, and may end up meaning that the user cannot
*fix* it, because they can't access the data at all.

And yes, I realize that if somebody is an unicode person, they go "oh,
but it *IS* an error, and you need to detect it".

At that point you should just block that paper-pushing pinhead from your life.

Bad locales happen. It's just a fact of life. The patch that makes an
exact lookup work even when some locale rule is being violated should
be seen as an absolute win, not as a failure to detect an error.

This is another case of the old adage: be conservative in what you do,
be liberal in what you accept from others.

I find libraries that just error out on "malformed utf-8" to be
actively harmful.

                Linus

