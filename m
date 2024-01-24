Return-Path: <linux-fsdevel+bounces-8793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6391983B117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C92328383A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660A12AAEB;
	Wed, 24 Jan 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnvBakfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481727E593;
	Wed, 24 Jan 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120776; cv=none; b=kBimRAlzachgtmETxt8C1GYkz1e2twCypC99jqD+VvjxSI1bPyfLxaEehrzzkMgRZ1a7gYqr0mSfQflaCuAJpmkb6KSqaNY0Z87lHOpGqcCaDoSwk8BRuSmJ4Sq696d8M6CCv+BMFQI129qBXoBeMrNiT4mtxWDJenV3ucWyxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120776; c=relaxed/simple;
	bh=QMsfEPIJUjkSF9Q/P/u2zA321e/bA3gG8a+8GG5orX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAQb30errrblSubLOnHV09qLNWVtOAQ0lnS9rdViqLbDu6lR9LsYR/0AwNsw8XGY7ABYcJSQmAevFbwUkJq+ieP0w9c/XsYUYplsg3eU7lAJkilxByvGIV+TCSFrWsLfXWAr+iYZBmlVIinVnfVaDarLm3aUvM7MAGmEuyQFfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnvBakfd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbedb1ee3e4so5516981276.3;
        Wed, 24 Jan 2024 10:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120774; x=1706725574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByWFD7PBnfk3wZd1UkMybKBLmOoo6NtyvU9GHHjyEow=;
        b=gnvBakfdjjK3pKtiyOBNmXi0yIIQpCcjvVV44A6I1JWS/FNL+DTumQFthxkneUwQz3
         0lLeh1NgxiyzywsmmOstkG5iWehsPnqXBsTzxTMFfsGM95ofUaS78HMePaa3X52fUPc7
         mmRj0tEw7ZNaxR5/1XoVggRX5jgbWQ9O9JtuCh1Oq7HybqD6avZnhlaI9M/SjZK2rk5h
         13RANLFa2WC/yOTwZjGs/K9PrKhG7cwMSMdzxlSePX857Bwkt41qQBI0c1dqU3aNwr2e
         /EOfL1NDLWXalVzlBaucxXPaKBjY+sJxm7viXKBAb3Zv+eqZHEc8WZ8L8eVAly3bRWAF
         3uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120774; x=1706725574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByWFD7PBnfk3wZd1UkMybKBLmOoo6NtyvU9GHHjyEow=;
        b=f8Lv5zYu3PG0RMJHvnOIk4bf6Yxh1Ifc94pbaUBK1XMY/00CdWNP257YwsQqMoLqkD
         JR3+2aARuEpnrYKuTrqBG+kJ2LZ+yUv2ZGtG0JIpY5SkUp9YOyv9eVxgB1ND9kzFKmjl
         q6YGbf5NRX1PDfAESZ4fOvB0ofopxLlb3JiMG66KZMZIswx+BS+qVzaCN5hJ6ZO786j3
         0RToS0wF2Uln4PcFPrq2kUo0z5vSNEevoAEu1y1iyQOtXZO272XG996QyWhuMebGOW+q
         NXMyrY9Npb/Bj6wZYfu7MmZ773TRNKOqM/pmrzBXD7YCqRQwt5E+JAv6devN+gdg/mTx
         xGdA==
X-Gm-Message-State: AOJu0YzETFwyo5AzQNpnZsqYYddLuDVG4LpBiKd0UkRZ7/4QJWoBQmQa
	DqVh5JrU9c5Ps+rkWO5o5XwcwYc0OAVaVsNI9HAmWwSSz9zmy/Tw41h6sLt00veBgvTzYZU0wV4
	LdyVO7XO+VJhXRyaStROpLoX4rY8=
X-Google-Smtp-Source: AGHT+IHEfOgcFlOWYngMY55chiB+/QFWej+WhYhYPSG0aYBnXocsr17j3FZlFxeGUDbBemaAUbpmtcE4QEWL8qcYgvU=
X-Received: by 2002:a25:6649:0:b0:dc2:3618:c119 with SMTP id
 z9-20020a256649000000b00dc23618c119mr943354ybm.116.1706120774251; Wed, 24 Jan
 2024 10:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZbCap4F41vKC1PcE@casper.infradead.org> <ZbCetzTxkq8o7O52@casper.infradead.org>
In-Reply-To: <ZbCetzTxkq8o7O52@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 24 Jan 2024 15:26:03 -0300
Message-ID: <CANeycqpk14H34NYiF5z-+Oi7G9JV00vVeqvyGYjaZunXAbqEWg@mail.gmail.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 02:23, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 24, 2024 at 05:05:43AM +0000, Matthew Wilcox wrote:
> > On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> > > +config TARFS_FS
> > > +   tristate "TAR file system support"
> > > +   depends on RUST && BLOCK
> > > +   select BUFFER_HEAD
> >
> > I didn't spot anywhere in this that actually uses buffer_heads.  Why
> > did you add this select?
>
> Oh, never mind.  I found bread().
>
> I'm not thrilled that you're adding buffer_head wrappers.  We're trying
> to move away from buffer_heads.  Any chance you could use the page cache
> directly to read your superblock?

I used it because I saw it in ext4 and assumed that it was the
recommended way of doing it. I'm fine to remove it.

So what is the recommended way? Which file systems are using it (so I
can do something similar)?

Cheers,
-Wedson

