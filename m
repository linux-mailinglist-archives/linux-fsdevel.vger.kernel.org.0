Return-Path: <linux-fsdevel+bounces-31266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2392993BCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 02:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AA3B24069
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 00:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B5AD5B;
	Tue,  8 Oct 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QOGG7VIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19B3214
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347359; cv=none; b=eQPNKk3Z0bscuE6vZ8OJRn4TWmCmwGA4Zz1YzNPKAtIqLPKV/lliiEUI3krCVZsvrrqbjBDPqIbvbYilT36DIhW2xCDR4J9W33YtT1JbOojF62P19pg15FQxSmmxENjXFsW4d5fF53Uii6W5IXlsT8QvZ2wzdRI9LUmu6NsWZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347359; c=relaxed/simple;
	bh=Tke8szf/tF+Zw53GGM7FveqgBu9sg0bXcPAEsM0e6AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cih6xRbZQChl02L+sL6omN5gnuvx/hDuZtULJkJTvKagnMPDx80ubxS8TgARqiygh1wJUwNWKMQetcvPYa6L5EGwABStJ4TCYwNe+hOukVXh0qIFDhj+6/Z4rFw1OvW/FpGUfN+KotqQ3qS4+V71vZfV8CsfSDAEUtfh17dBKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QOGG7VIl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so6309751a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728347355; x=1728952155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsQ1lX9RfNwwbE7U1ME2PBLb06zd6P+Kklt61iLJfEw=;
        b=QOGG7VIl46wTFZtLMslm6U/E0QOquNdwYRoWRS0HPtPWqUGDN5OHMd+LxneCfVNMKZ
         Q6lI0co3MYLO9OrYErYpilwUe8v7P9efQQELiKbjHCQ5yi+3HyEeSbrsdTiMbN+XQrDu
         Kazrk3+mgEzor0ZgPwyjAPMSZZIaStkvQAvqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347355; x=1728952155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsQ1lX9RfNwwbE7U1ME2PBLb06zd6P+Kklt61iLJfEw=;
        b=kp4wENBMejmr+rSohohj1WQs6QUO9sc4Z/Z9zTfOoxw1KyHnmWGwDKNomnGlWHC+N2
         eu3RTsaJiJlJL0xqf18QH/NhXKsI0EN1owdUTLQxZfhWR7L7TQB+BF87Ddk6itzInTai
         KJrkeiA/SVFQTsEXkRsV6RyMJ4T53fPMbDERCq34OcienUZt4u7YFpcnhCXGRRJ5KHOT
         QgnBcjUpAz8TvgXfSvUatlFMMhVkjBG5DqnEZhblVxFSofGUH+sxhO7P+Miy0I0UV2CF
         eAoVD+mjnzynaQLwQglNa2/U9OV/AtwFNNN8Gtlyo0ZOQ3HzFi4yhO/39v2WHs4SB+b0
         ilqw==
X-Forwarded-Encrypted: i=1; AJvYcCVNX7JhZCc7tvcrBUf3mmIOpvH2hUP3h0NaBCmBtkuVGDJ8mJSbbvOgQ4AbgGWBl5Sr0392RUnXzF4scG2c@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgqj9+Ce71k92SuL/1FC6YGo1zXXSYHhztGw5tZ0vqpfYIQBj8
	Wyb10kf+EQuXXaO8WGWlLtHt4+7uQNDSbI4XQOoXXPsbutKaWg4ICChUdDyHn+YkxBNzXpu5uCN
	ARd7nbQ==
X-Google-Smtp-Source: AGHT+IGL2joftT7qUqCebjzMYJtMRth0BJfX1qdyKSiIrvcTIwinNwmWplZSH4YkHfMkeFBIbqKsTQ==
X-Received: by 2002:a17:907:a02:b0:a86:789b:71fe with SMTP id a640c23a62f3a-a991bff297amr1312108366b.48.1728347355257;
        Mon, 07 Oct 2024 17:29:15 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994e1bb049sm254006866b.165.2024.10.07.17.29.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 17:29:14 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99388e3009so344304966b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 17:29:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUw0FpLBEaU/OBAipljTbElMPN2nS80lseOn45r1y3d1nW+csNJO60mdIEIzjBRqWzAV7c9iKAnsmw9Ij8u@vger.kernel.org
X-Received: by 2002:a17:906:6a19:b0:a99:762f:b296 with SMTP id
 a640c23a62f3a-a99762fbb7fmr20741966b.59.1728347354279; Mon, 07 Oct 2024
 17:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3> <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
In-Reply-To: <ZwRvshM65rxXTwxd@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 17:28:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
Message-ID: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 16:33, Dave Chinner <david@fromorbit.com> wrote:
>
> There may be other inode references being held that make
> the inode live longer than the dentry cache. When should the
> fsnotify marks be removed from the inode in that case? Do they need
> to remain until, e.g, writeback completes?

Note that my idea is to just remove the fsnotify marks when the dentry
discards the inode.

That means that yes, the inode may still have a lifetime after the
dentry (because of other references, _or_ just because I_DONTCACHE
isn't set and we keep caching the inode).

BUT - fsnotify won't care. There won't be any fsnotify marks on that
inode any more, and without a dentry that points to it, there's no way
to add such marks.

(A new dentry may be re-attached to such an inode, and then fsnotify
could re-add new marks, but that doesn't change anything - the next
time the dentry is detached, the marks would go away again).

And yes, this changes the timing on when fsnotify events happen, but
what I'm actually hoping for is that Jan will agree that it doesn't
actually matter semantically.

> > Then at umount time, the dentry shrinking will deal with all live
> > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > just the root dentry inodes?
>
> I don't think even that is necessary, because
> shrink_dcache_for_umount() drops the sb->s_root dentry after
> trimming the dentry tree. Hence the dcache drop would cleanup all
> inode references, roots included.

Ahh - even better.

I didn't actually look very closely at the actual umount path, I was
looking just at the fsnotify_inoderemove() place in
dentry_unlink_inode() and went "couldn't we do _this_ instead?"

> > Wouldn't that make things much cleaner, and remove at least *one* odd
> > use of the nasty s_inodes list?
>
> Yes, it would, but someone who knows exactly when the fsnotify
> marks can be removed needs to chime in here...

Yup. Honza?

(Aside: I don't actually know if you prefer Jan or Honza, so I use
both randomly and interchangeably?)

> > I have this feeling that maybe we can just remove the other users too
> > using similar models. I think the LSM layer use (in landlock) is bogus
> > for exactly the same reason - there's really no reason to keep things
> > around for a random cached inode without a dentry.
>
> Perhaps, but I'm not sure what the landlock code is actually trying
> to do.

Yeah, I wouldn't be surprised if it's just confused - it's very odd.

But I'd be perfectly happy just removing one use at a time - even if
we keep the s_inodes list around because of other users, it would
still be "one less thing".

> Hence, to me, the lifecycle and reference counting of inode related
> objects in landlock doesn't seem quite right, and the use of the
> security_sb_delete() callout appears to be papering over an internal
> lifecycle issue.
>
> I'd love to get rid of it altogether.

Yeah, I think the inode lifetime is just so random these days that
anything that depends on it is questionable.

The quota case is probably the only thing where the inode lifetime
*really* makes sense, and that's the one where I looked at the code
and went "I *hope* this can be converted to traversing the dentry
tree", but at the same time it did look sensible to make it be about
inodes.

If we can convert the quota side to be based on dentry lifetimes, it
will almost certainly then have to react to the places that do
"d_add()" when re-connecting an inode to a dentry at lookup time.

So yeah, the quota code looks worse, but even if we could just remove
fsnotify and landlock, I'd still be much happier.

             Linus

