Return-Path: <linux-fsdevel+bounces-40254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE1A213DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C78E168109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCD1DEFDD;
	Tue, 28 Jan 2025 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ed6nMIHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DC197A87
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101927; cv=none; b=oIlskUH0EESlHNNDYcMXfnWi9SeNbRbbeu7Dgu/1wYlynRA18t6UTbRf628yqiBmAtzH5o+S0/FsG/cO9ll10hZOl5EdStY1a5f4CNQHcIHXoRZVuA9Hg1DTKd2JWNwhzjkCw3geFDFgM6bs6vt8CoULas3U0tRv9wfdv+Ao7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101927; c=relaxed/simple;
	bh=N9CN2NRLEwlAaUiMErbWNM/ka2LpDs1ENztrFanSQjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru5lphXoEv89Y3l+/QVTBoEbQtAECeZnMNjbC7M1H50KVzy0gmMgyihQiiZmZXsQj+OFYPiVe6pu1QiQC7WUOaWbSUzRpME3Yw/4wrjIKjdLNC1EPiwNtrQ6+/iDtg1l+ZgYx21vVc3odNbXSnZtYQxX8i2ZflU2i6itIfNd8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ed6nMIHG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1027146466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738101923; x=1738706723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84FnMlST+VO/jQ2R2VfygR+h9tfLozFMeaGuWZvuIl0=;
        b=Ed6nMIHGEtxFwktHJbGaT59tztSGa6kfO+xa963B3nkfqczovqZelDEftZ4TR9LNd+
         n3Que/EhyVpHEcONOwFiE3cVChY/Qni5K/x5tGhpVgjZ1H2x0ucABNvZTiYKssLvcffZ
         Sx/Z4BUqoTkd3w7FGTqgA4CCwqCuZo4UnIEys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101923; x=1738706723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84FnMlST+VO/jQ2R2VfygR+h9tfLozFMeaGuWZvuIl0=;
        b=ZnsAEuzpCQL3QwpShJTBRlYL6q8siax8+WRVfUH8RILIykOKB1QCiSIt3Ln+Mit8wo
         mGrbMnF0zYUD/sNQG5q7RTV0Wt0vmRuglyY9r6QnMEgtIFPW2pACHxoo1GRCCLJh07fP
         akrN4iC+jWnxXfYD7lreDCYA8jwF4gN9V13aRGlDn6lqg0eB1XFw6rUvFt83U7wXr3Hn
         0gcDqxzfptbcY6jTQyoG56+lauWkMLaYNwfRfJausm1D9g1BI/lqBFBqTGaOqLw/DIkC
         RuHWA/GF0jQ1CMVsJV4QP50JDgD0WpumNq73KIxTFDh6xDQCuzeguj8vccJjnYLIEvPm
         g3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNP/5kkpy9MR8H0XKq3XChoIJoidC+aPOQxRHP9a0gRGLfWIfhm9vDYnq8lwnq5Tk8l24Sb086tWSDXUiU@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNPyPDWvZ4Ln4EfMl6LTvZz8joJf1yCD8EpDgKLDzp1az3zNC
	sHWEpVwnSX97bjM9WS4mGIKS2j2x3qr1ernqM5FlH2s8G38+HFgULOia0O5JipxhBjaclLqObmm
	tiCY=
X-Gm-Gg: ASbGncuUOs5X92PthBZFxuzvNn5o6AmfHZ1pgXA7MlU+YkR82t5+9UMl55a/raoyrZF
	VQGEULFPj3aZ84ya5JZfu71a0QYysdWPP0JMP574q0N1WQnyuEQp0Ep6BIneQ3t0GI56CKiIFJo
	9o2jDattJrLiqYkEbnZkv8kNBES4KQJw15s2Rb3mz1xr0B6vgQu10Axi/DYM99ZDWvx1AVQ6ff+
	ZNyNASoE3RdIMn3l7Q5TDT1KvnOzrD6vBenboP1PQIYD5Qk5GIOcdroBEqKpW8I9imOIr9dkJjp
	NNyB/dl2vm2gI52UiIQu3WhJ2XMCSbYNi6Kf44xd3L01C8vYCoSeQejbV7HjzlSiqQ==
X-Google-Smtp-Source: AGHT+IGZr34R8YY0gPZSoFZeIFTdE1Exgwcf9oF6iaX9+ShkL9kolAjg4G4fMsQwTJGPUChwKEzNPQ==
X-Received: by 2002:a17:907:d88:b0:ab6:9497:fa6f with SMTP id a640c23a62f3a-ab6cfcb30f9mr91277666b.11.1738101923361;
        Tue, 28 Jan 2025 14:05:23 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760b70a7sm860876366b.116.2025.01.28.14.05.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 14:05:22 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso1039576766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 14:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX73SMpRSp71Uw3McowXwEAMIT91oOlWh7SCS/+bhiorakNgPbZFTzKqStsQPiKg+fKqHprBeGMQsSqVjwS@vger.kernel.org
X-Received: by 2002:a17:907:7f26:b0:aa6:832b:8d76 with SMTP id
 a640c23a62f3a-ab6cfcb355emr86990666b.12.1738101921541; Tue, 28 Jan 2025
 14:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121153646.37895-1-me@davidreaver.com> <Z5h0Xf-6s_7AH8tf@infradead.org>
 <20250128102744.1b94a789@gandalf.local.home>
In-Reply-To: <20250128102744.1b94a789@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Jan 2025 14:05:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
X-Gm-Features: AWEUYZlkLKU-Xlt0hbWlgd1bF6aTSPZaKXEuASzXj5F0LLdokGBdnxzJmlI1Pbs
Message-ID: <CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, David Reaver <me@davidreaver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Krister Johansen <kjlx@templeofstupid.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 07:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 27 Jan 2025 22:08:29 -0800
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Is that a good idea?  kernfs and the interactions with the users of it
> > is a pretty convoluted mess.  I'd much prefer people writing their
> > pseudo file systems to the VFS APIs over spreading kernfs usage further.
>
> I have to disagree with this. As someone that uses a pseudo file system to
> interact with my subsystem, I really don't want to have to know the
> intrinsics of the virtual file system layer just so I can interact via the
> file system. Not knowing how to do that properly was what got me in trouble
> with Linus is the first place.

Well, honestly, you were doing some odd things.

For a *simple* filesystem that actually acts as a filesystem, all you
need is in libfs with things like &simple_dir_operations etc.

And we have a *lot* of perfectly regular users of things like that.
Not like the ftrace mess that had very *non*-filesystem semantics with
separate lifetime confusion etc, and that tried to maintain a separate
notion of permissions etc.

To make matters worse, tracefs than had a completely different model
for events, and these interacted oddly in non-filesystem ways.

In other words, all the tracefs problems were self-inflicted, and a
lot of them were because you wanted to go behind the vfs layers back
because you had millions of nodes but didn't want to have millions of
inodes etc.

That's not normal.

I mean, you can pretty much literally look at ramfs:

    fs/ramfs/inode.c

and it is a real example filesystem that does a lot of things, but
almost all of it is just using the direct vfs helpers (simple_lookup /
simple_link/ simple_rmdir etc etc). It plays *zero* games with
dentries.

Or look at fs/pstore.

Or any number of other examples.

And no, nobody should *EVER* look at the horror that is tracefs and eventfs.

              Linus

