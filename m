Return-Path: <linux-fsdevel+bounces-34338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3049C494D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B30D2860BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29304156F5E;
	Mon, 11 Nov 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nyIh2cFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297651B140D
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365194; cv=none; b=iX1J05j1k8b4jVcr7HpsInQ5p8BG9y/Yu94sSwmj1lZR+rWsY39LPHyyG5OOlwTcBq2sEhvze+D7EVNPKRSf6HI8+kLWD8O7bNJQygB76tJ9MUCSBBiu8rHMfxeCMxmkr670CWQf5MMXxLqky1ZPO6IzGK6zBYlEY7boyqEGvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365194; c=relaxed/simple;
	bh=71nZXfRIrYua2zlXrhTBQOHnk/s6a/TqNaszzlmcZg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWLsjduQALhTJcb83cjOEPfhm8YfwuyCt2cvDbr4pSqN3XQpjFSoFka0oVZ5ZgQFkSslP4JAOv/k7oV+lpqOqb6OXl6n+KYUp05Cmws4pMfFmZQrZ2/Xts8zF4PIA3myHpe/JN5iak6fJOgn3Cy6RF9hhi8LD0HglDssMi+ZUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nyIh2cFy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f43259d220so2463631a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731365192; x=1731969992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VRvtvNdmLIp8XU4kQFCBc6R99fU2D6h//Mc4Pu+ikI=;
        b=nyIh2cFyPK3S1CBucnj8tNIF2tpqToDFcdaOj8JXdN4h0s0crVDw+fAOVZXG7oGdF6
         4kewjbXpSYmX1X1Tr7qiZgCeIOh7UbBszjtZfQFx7xhY8fv3goTBPcLJ7773WZ7eLl1Y
         nLdi5lbmn2tkOCVqtsVjosjZZ574MU+ZZoDjPs/Z261242iYfn9uhzMLyKrb5979ITxi
         MJ2DHtkCYLf7fJWe42OpvkMqLiUyQcRp3R7lrhE/OSweVu7QMctuEzYfOCsLGexqjKzi
         QjgvRrjINqoCV6WP4majjHJN98FihlA4ZwSnTrjqRL+Q3PkkNUDk8uztkUmn7yDSouUs
         d52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365192; x=1731969992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VRvtvNdmLIp8XU4kQFCBc6R99fU2D6h//Mc4Pu+ikI=;
        b=AHhIKNiKr9bKNOe4RFu/0JBG0zXf68HO6L/hJoWVzCTvVsCKp42CNPNHVNAQyfmmu/
         +6E7Yy+nOIro9CfM5U+ULiZF7www/mHBai1F27loupFfVTSsSAKw6koIHSMzI/ZE/nVa
         sTjQDHAlG1pbRj9EK8jo46+q2jr4GZYtPUbBAB2ZrBcC0UJr08EwTQGXsl4H2I4V2Sor
         X0VkH4gx8H1xTHbJpAe1VaxPC2Ym+Vr/4DuAQ9K3MARubHR/DnT+exUrDOfk628UhVua
         POZ7YqqMVbJybFAJ+C60kL4MaB5d2eI6cciOHTR1vTx9qhUjeCFUjMiY81iUhk2AZnwj
         RVRw==
X-Forwarded-Encrypted: i=1; AJvYcCWAaXLGgFp6t/7Pg2ULDfQ1PIXaQ0/AjBBgCDSO7jrdPkTm9n/tfFqDPliMLfPlpDT0+THwiXxUe0bz7lWG@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9Tb4H+VfPSUL4gj6EAUeX2Vofr+OcQ3YLV+kMUEpKe4/rbz/
	7Iks2dQoSR8MkoYqEwvUdr/BChypir4nWYuHKWZT6j/lAL2kLFPXEt8ZNrMhfTn/apVuL0RbQc6
	iO8NNCbvx2+k5pw8La1O+GAx2jTzL7wdi5POaRw==
X-Google-Smtp-Source: AGHT+IHlj8WrQJzuiGSkH3xRWL0oTsnn36a3+WxBSXTkf5/O40cJQXUinPav2r015Kam+qXJ0AB1o31VjfZfu7yIvkU=
X-Received: by 2002:a17:90b:4b84:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e9b16e26b2mr21506952a91.1.1731365192344; Mon, 11 Nov 2024
 14:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
In-Reply-To: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 11 Nov 2024 17:46:21 -0500
Message-ID: <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
> > +       /*
> > +        * This permission hook is different than fsnotify_open_perm() =
hook.
> > +        * This is a pre-content hook that is called without sb_writers=
 held
> > +        * and after the file was truncated.
> > +        */
> > +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0)=
;
> >  }
>
> Stop adding sh*t like this to the VFS layer.
>
> Seriously. I spend time and effort looking at profiles, and then
> people who do *not* seem to spend the time and effort just willy nilly
> add fsnotify and security events and show down basic paths.
>
> I'm going to NAK any new fsnotify and permission hooks unless people
> show that they don't add any overhead.
>
> Because I'm really really tired of having to wade through various
> permission hooks in the profiles that I can not fix or optimize,
> because those hoosk have no sane defined semantics, just "let user
> space know".
>
> Yes, right now it's mostly just the security layer. But this really
> looks to me like now fsnotify will be the same kind of pain.
>
> And that location is STUPID. Dammit, it is even *documented* to be
> stupid. It's a "pre-content" hook that happens after the contents have
> already been truncated. WTF? That's no "pre".
>
> I tried to follow the deep chain of inlines to see what actually ends
> up happening, and it looks like if the *whole* filesystem has no
> notify events at all, the fsnotify_sb_has_watchers() check will make
> this mostly go away, except for all the D$ accesses needed just to
> check for it.
>
> But even *one* entirely unrelated event will now force every single
> open to typically call __fsnotify_parent() (or possibly "just"
> fsnotify), because there's no sane "nobody cares about this dentry"
> kind of thing.
>
> So effectively this is a new hook that gets called on every single
> open call that nobody else cares about than you, and that people have
> lived without for three decades.
>
> Stop it, or at least add the code to not do this all completely pointless=
ly.
>
> Because otherwise I will not take this kind of stuff any more. I just
> spent time trying to figure out how to avoid the pointless cache
> misses we did for every path component traversal.
>
> So I *really* don't want to see another pointless stupid fsnotify hook
> in my profiles.

Did you see the patch that added the
fsnotify_file_has_pre_content_watches() thing?  It'll look at the
inode/sb/mnt to see if there are any watches and carry on if there's
nothing.  This will be the cheapest thing open/write/whatever does.
If there's no watches, nothing happens.  I'm not entirely sure what
else you want me to do here, other than not add the feature, which I
suppose is a position to take.

The overhead here is purely for people who use HSM.  I'm telling you
that in production, with real world workloads, the overhead is far
outweighed by having to copy bytes around we'll never use.  Your
argument is similar to the argument against adding compression to
btrfs, "but it costs CPU!?", sure, but the benefit of writing
significantly less waaaaay outweighed the CPU cost and was a huge net
positive.

This is going to cost something if it's on, it costs nothing if it's
off.  If you want performance numbers that's reasonable, I'll run
fsperf tomorrow and get you a side by side comparison.  Thanks,

Josef

