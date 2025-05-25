Return-Path: <linux-fsdevel+bounces-49826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D0AC36C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 22:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A9B3A5A8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071B1A5BB1;
	Sun, 25 May 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CMTHVwP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E582374F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748205175; cv=none; b=UhrbFxBp5xWlcDQ/TZRRpgz85EyBYbp7ZFE+TwIV2I4uX0xtUUT1krBQK9B5iOXzzkEKZpo9nvDSTMpQllD1d0AvRYYpDXyk+unU4Edemvu26epwDUhqmdhfRzaRYEFL0YiNA91RF4s/h3Ntgki8/RBZzLFbrdsoFIrxvtgC8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748205175; c=relaxed/simple;
	bh=gxyJwbkUJWNv7ftsrhZw8/Zztr9LXvZXWpcsrIvobMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnVwZo3FaGJBg6xQV9ZfXsoDS3QNMXn6KnAvpLBpOon6s5Vufm4X5hB6EYegJ2hczJUMwS2W+xfrv/Y3Ps192STrJpXHtg8dWXMEHsJ+ntfasTf7nCGSOEaMa1FXlMM0dpCSDK3w0WYQpV1JLnfPOtiaVe28ZvZyUsN/VQa7dW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CMTHVwP2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad52dfe06ceso192559266b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748205171; x=1748809971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMbIHgVNx3VrfCeDqEy15u71nZHhX0q/eQx+Nww92Yo=;
        b=CMTHVwP20XYK+/Nr29my1pQonlc815m9+G3Cz4IKhh7InExSIlPw4KNImPdcnvJ7du
         ecwGXCH9/fjrpMoXhh0JvRySwq6qS39BlITvSm4sgSmtLWuY/FMi496u7/yl/HwwhCn4
         NDFTyhFhtPq235bwiYex3znKlVKRc94QOccdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748205171; x=1748809971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMbIHgVNx3VrfCeDqEy15u71nZHhX0q/eQx+Nww92Yo=;
        b=a0mJiP2UQ6PCqWxtGI6Buw+CRV1HtEb1Xes1z7cnRRIhR5DY3CsHAMHYjBXdZSkWbF
         vDg7OdJScvne03MKsNCPsdIQJ0lTRyX3Im06lo54XLdReJH1koCaAkll+swCzz1mm+32
         mnQc6A4D3CHmLw+iSL9c50f6S+T0NcJu4CasyXLJvFnUh571O0ysgN8Ac97JuOG9D+di
         A8scng4jsJ0ri7aewwjaMztThgHuMiaGXUAixWwsj1pgVZC8mtIagj7twK4jo64V/kfb
         29BmQLXa0yguai6jRDxRGowwRgW0vmpBMo+93HCbCPaokIjAKchqzd41wUQXIlJFslxD
         KmHA==
X-Forwarded-Encrypted: i=1; AJvYcCWczevjdbQ4VLzHsy30kD0V4ftiJTMwRsf35Hi8gjYViW8DmUuATjv19XyqNck3bWnFf+1USq7a9tYyywwC@vger.kernel.org
X-Gm-Message-State: AOJu0YwryplwqwyFAgdA+YSta77cF8id10Tz/VhgbgIw/yPBufTD+hJF
	51HGtIjL6L0vB/zI1QWRYxOmnCXeFLzRhwyp4Lc3ABmFjS2wXSfqocYqGQZ0VaWbhSVWPYAeOh8
	V6iqK+ss=
X-Gm-Gg: ASbGncuuPvTDwWokLiSM/RyG/AfTRguruocJgbwFSaMQQd13UyjmAftGsCX0GO66mOf
	r7tz8A5NPB7ijDDF7zETTgDGh3uzJKQ7eSpfxzXMgE+EwncuK1VORBwCMxr47ALjVzaQX/hjqg5
	NKN7NURqS6LvQ3RMz2brQ+rjg30a8CAMk3LFKDo2OjdO7z41XXh1oTOD6z0uUWBYiF67dAGFPpZ
	OTk8ofPIdwaCFp/YHBt2GqslOH+iPstEyUIYldmzBDmO3oxr4YZq7hE3lQJBHDDLdjvpnAzW8Z5
	C/nfQ1Ec9dVy6IoX+qFMoDeFO5xz9X/TYuQ2p/Rm6an4/NN0DfvzZl2SBLfENoB6/WZ6qWRiqe7
	DJeyE/xU1NXD+Usi8aoHu+LwRSGQSTb9iDtV/
X-Google-Smtp-Source: AGHT+IHea9vK57z5vtsO/r1Fh3zqcLlRFpzwLl5NcR8TYBSsyZyz++1TmLxBngpO7sdguoLocic8Zg==
X-Received: by 2002:a17:907:97c6:b0:ad5:715b:d1d4 with SMTP id a640c23a62f3a-ad85b1204bbmr446480566b.32.1748205171382;
        Sun, 25 May 2025 13:32:51 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498d05sm1594612366b.149.2025.05.25.13.32.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 13:32:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-602e203db66so2071963a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 13:32:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQQMblLGBfb4N3bfOtIWYmtvG9w3a0PaofxYJzHL4HT5snOEyUAaKuQyomJZRCtN/4qOhvqC6g4EnxNgM+@vger.kernel.org
X-Received: by 2002:a05:6402:26c1:b0:601:d9f4:eac6 with SMTP id
 4fb4d7f45d1cf-602da407b05mr4489696a12.21.1748205169311; Sun, 25 May 2025
 13:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV> <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
In-Reply-To: <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 May 2025 13:32:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>
X-Gm-Features: AX0GCFuJ5fwaRRZ6rDkgCrRmhFDlyouHrjIxzoDVHWjZiJza8Ln2APdrWWNlWR8
Message-ID: <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Well, this isn't great timing, since I was going to do 6.15 within the hour.

On Sun, 25 May 2025 at 12:11, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> I'm not familiar with this code too much, but I suspect problem was
> introduced by commit fb7d3bc414939 ("mm/filemap: drop streaming/uncached
> pages when writeback completes") and only (more) exposed here.

That bug goes back to 6.13 if so.

But yeah, maybe the drop-behind case never triggers in practice, and I
should just revert commit 974c5e6139db ("xfs: flag as supporting
FOP_DONTCACHE") for now.

That's kind of sad too, but at least that's new to 6.15 and we
wouldn't have a kernel release that triggers this issue.

I realize that Vlastimil had a suggested possible fix, but doing
_that_ kind of surgery at this point in the release isn't an option,
I'm afraid. And delaying 6.15 for this also seems a bit excessive - if
it turns out to be easy to fix, we can always just backport the fix
and undo the revert.

Sounds like a plan?

I'm somewhat surprised that this was only noticed now if it triggers
so easily for Al with xfstests on xfs. But better late than never, I
guess..

             Linus

