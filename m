Return-Path: <linux-fsdevel+bounces-36855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601519E9E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8B3162952
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE40171E7C;
	Mon,  9 Dec 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R6Oj2dz0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B39155345
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768845; cv=none; b=a+JBM5xMlhi7jF+6v3s9d/xbZEuwYVWe/NISzRuSpad9RGskypziwy+ir1+8qsky2mHe2GQZRg4Yq6q1JGg1/zmMxowuCamg7Gr6MkJ1JePdkaaWYyJVXUHl+gux+pjyfKy5P2PGsYlluxvDp2kQKiLAE13z31JTwGUQdY9SLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768845; c=relaxed/simple;
	bh=EpO0mHNsxoTIrIlepAq/s8cJm27FUN87hDBBQIahs1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWx4z0hmUf6hIOb60niFWFBbxxFVk2WYxUGSXGyuEeZl1loLzpXzrMyOO1uhynblNEOtODHPg0Rg3Moooq+6vUXJRzuy47RMYS3RCBDBn9nzD0HjPQ63wVtV4o7BLGAYnuUyyfDlceJCf6LFIKC6jxabmfWRR0fEBmdIlrHdYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R6Oj2dz0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa66ead88b3so359972966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733768842; x=1734373642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5MmDGlwefJc6M1TjdzyEa30t5fwiMC4TrQsoohf+AOg=;
        b=R6Oj2dz02zNQ74RKJeh3T7iO/6cguhD5lg5eLnkqN0EKhYkUZFl2fQuc6xEFvLxtcl
         s3Q3AtC+YLwzwSl4Dnvt3+dDknr8e6iD2waSWq/G01Brv29IpPDY/1b1ho6h+eQpFT5N
         0bHG1yn0EniFBcAln+w6V3m/j74Xv2BMLwp20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733768842; x=1734373642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MmDGlwefJc6M1TjdzyEa30t5fwiMC4TrQsoohf+AOg=;
        b=BR64Q9Y6Ds1QoZyoVBb/gGnFmdsgU4L71CmoQ65sM+55ZpF14bHptjE2CYgiR+bY1N
         uEv7HR/nKVbeh8dhlf83iu+o2SNewTXDA+qVfODMSEocGeBDNPd7+4NkmXCbVrdbqXk9
         /OFEOUgbGQiCJ4HTqaytLOEVelHFUh+kyfLPZ7dxdXFIeeaHsrKfXdoD0i31Ra6srrWA
         uPGB7xVW6OwaheQbqt7HZKByLXybXH4KnIDz4vzJZmZ5xPgrIwzTmx+i6VFWDAEHXgwF
         LJLdMevY9kP1h0rUD8r3VsryBXHwJwRdTbIw9XcE6w5p2rV13rVzA2t5YgamM+SVJceh
         NIjQ==
X-Gm-Message-State: AOJu0Yw0eiyMvP8rF7G/S08yWk66CP5+HkGyZUPLfcyOePmh0OJRcJ7V
	Q/aE8DtLpxoWE/Z3we68U227UchmxwCwbcKO9P6VkxOvM6trl792Wk8ZizjHTnNrnFKIUhwiZ7L
	eTYQ=
X-Gm-Gg: ASbGncsP1saPiIF+8IonTmy4kMUJHtngalGv9OkNSDYxNjJmHPyWLneRii6MAu/89sc
	3M7de3yNGvGUrBES+XXnC0VP26pFt6VCB7MrIkS7uVw4VlGgXvGwH+i4j9Rs4QSoc/j1kIirCY0
	cWFV8NBXS2tkJ7i2R6s31Q2LApC9uFjEKO2AynBLHR8IX3xehTazvKDHtGCuYdhlF1PRuBxy80x
	8kh75aLb8TPWR6RS0SNo+lqNrm2OLym8Dp0Mzjhwdv9peLnQksBLR73/Fo2NfnHLzGWhRkwmA/5
	ukcM+b4IppnFGGlwyo5K0qpg
X-Google-Smtp-Source: AGHT+IHCWNwNOAG12CCz2xeOdBxIun1SYS5NCmrYuRsieZ/cy0xM0L4osAf0nwuDoQZ/Y2Ugqd72qw==
X-Received: by 2002:a17:907:cc24:b0:aa6:88c6:9449 with SMTP id a640c23a62f3a-aa69cd5c8afmr161719866b.19.1733768841559;
        Mon, 09 Dec 2024 10:27:21 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa695c3ac07sm112062766b.66.2024.12.09.10.27.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 10:27:20 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec267b879so905214866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 10:27:20 -0800 (PST)
X-Received: by 2002:a17:907:8327:b0:aa6:6ab1:37ff with SMTP id
 a640c23a62f3a-aa69cd592bdmr156488966b.17.1733768840317; Mon, 09 Dec 2024
 10:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209035251.GV3387508@ZenIV>
In-Reply-To: <20241209035251.GV3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Dec 2024 10:27:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
Message-ID: <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Dec 2024 at 19:52, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)

Editing the patch down so that you just see the end result (ie all the
"-" lines are gone):

>  {
> +       unsigned seq;
> +
> +       rcu_read_lock();
> +retry:
> +       seq = read_seqcount_begin(&dentry->d_seq);
>         name->name = dentry->d_name;
> +       if (read_seqcount_retry(&dentry->d_seq, seq))
> +               goto retry;

Ugh. This early retry is cheap on x86, but on a lot of architectures
it will be a fairly expensive read barrier.

I see why you do it, sinc you want 'name.len' and 'name.name' to be
consistent, but I do hate it.

The name consistency issue is really annoying. Do we really need it
here? Because honestly, what you actually *really* care about here is
whether it's inline or not, and you do that test right afterwards:

> +       // ->name and ->len are at least consistent with each other, so if
> +       // ->name points to dentry->d_iname, ->len is below DNAME_INLINE_LEN
> +       if (likely(name->name.name == dentry->d_iname)) {
> +               memcpy(name->inline_name, dentry->d_iname, name->name.len + 1);

and here it would actually be more efficient to just use a
constant-sized memcpy with DNAME_INLINE_LEN, and never care about
'len' at all.

And if the length in name.len isn't right (we'll return it to the
user), the *final* seqcount check will catch it.

And in the other case, all you care about is the ref-count.

End result: I think your early retry is pointless and should just be
avoided. Instead, you should make sure to just read
dentry->d_name.name with a READ_ONCE() (and read the len any way you
want).

Hmm?

            Linus

