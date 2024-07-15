Return-Path: <linux-fsdevel+bounces-23701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E993172E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD191C210A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A318EFFE;
	Mon, 15 Jul 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpCJ+Fq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB218EFE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054921; cv=none; b=m9LiJLwIbZ62vC+RNjFkDM3lzrgY10YTXxGUagXtGI4NB3f9P+/0x29qOgAwE2TK8Hnb5bw24xIPU/7CrvFX192z3jh6oYOM6pN3G35o6o0f9F7j46rPhkdU4z22cCJQ5XXNhdx/VluK4oZ9e9jVEuJNpFI2WLS6QmbfQNbAT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054921; c=relaxed/simple;
	bh=CTEp9l4lKmLbgIlw5b39Taj3x7sojvtSw0B4jQfUSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeWyl41PNnPQ2iK+cm4logD9VefZwnKSKPr5VRUMDsxEfqBf2KfFAIpIolHYYk2lXsjwVaPeQEbFqC4LlLgl3jupBoo9XhfY2rvacM+g/8E/OetgYIEfDTY1e8wNyLxDOb2LGhb+K/RgdIl9cqbGSN06LWbxsACt3xpi5FBDtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpCJ+Fq+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36796bbf687so2477976f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721054918; x=1721659718; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yLQ8mniU6WgyBpOmCK4AbyGxOEkP4+CpPno/qLGFaE=;
        b=RpCJ+Fq+WRRLb4bWIhfxE91L47IkAPdFD3M+cyID9SLa5/SOGjAplnzuCjm+CmYxDe
         37a69F/IjXBEtayUDd9XE9nl3Eoz4VKyAw3pWiZozmVHwn/SQDZDp0PD3pqlwgc4e3BP
         jXbUiDpy5GG2neHrG4y7CHIY0kSrfriBGK6MrmUDCrDuGV4zBRECSd3Vis4NH3qio7Ug
         4QjWGifN0WzxPJR+RFNzeeBY8JrKwo7kZXRgWE0kRLZ7ADY9MkkqI/qwTESpUhJXhVjt
         OJCXgkkNH1gvrugW27nVVvtJptDyrlUQP958uffl06ep7l5cd35uEjK4d4Yew74RL1zP
         hq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054918; x=1721659718;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yLQ8mniU6WgyBpOmCK4AbyGxOEkP4+CpPno/qLGFaE=;
        b=L+hktVLDWU3e3VTcXbUUMXMnn+A5k8Fi3d4mMugVyCa1U8v1v/79E6N9gqIlYQcfNW
         6Uwlwq9YObDiDnJoCFbFrzIda5QT/dQN0+O/g9bxLf6oRz2UVYflAmT+yH9xtkE3Z3s4
         hgWUOOl+vVNBMbefnKVfo37x4hW5aBsBLK0ePunXwAR64e5z8lkNAaGvF3hjqircjb6A
         Ocp2wab+ho+i7JScYrsacT4HRVho37zfaHoqY0FlmpOzHYLdyiiw5qVGcaUTUGk1Trpr
         GJS4i58HC0+BFwOvEuKQF4mzzmEEhlTtHNoOnCTyERDIL0dbYtasRVd50y0pHR+/v9iP
         7ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCV/lI8l8qDCqHvITux/aJMvUp3Du1Lbg5pLWcZocl9vSRXqrIIyv6C1fxjj1av6+XLztxrLm8T0XHtFAVzDr0W5EjQ3lQ7/MeIA4kBZmA==
X-Gm-Message-State: AOJu0YyUWhbMpbgVsDtHofMrvFQsZEfXggZ8tuLmWiWRaEvflaD3zc8J
	pTnncMQENt4qVQSjqCazfTH32VPbZhyc7Fd9qQIPIMW4M1TgxuV/IgOYtdZG/w==
X-Google-Smtp-Source: AGHT+IGu1PQtxW82SBbZvH8/ZbODcbQ+zOPmozKvymfN7JztLCDnlGBEXvPxVZDsjs12LLtqa6Iz2w==
X-Received: by 2002:adf:f20b:0:b0:367:4dfe:3e8d with SMTP id ffacd0b85a97d-367cea45a27mr12288140f8f.13.1721054917682;
        Mon, 15 Jul 2024 07:48:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:38c6:b130:dde:b10d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db0f26esm6565761f8f.116.2024.07.15.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:48:37 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:48:31 +0200
From: Marco Elver <elver@google.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fsnotify: Avoid data race between
 fsnotify_recalc_mask() and fsnotify_object_watched()
Message-ID: <ZpU2v28viO_I_1zd@elver.google.com>
References: <20240715130410.30475-1-jack@suse.cz>
 <20240715142203.GA1649877@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715142203.GA1649877@perftesting>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Mon, Jul 15, 2024 at 10:22AM -0400, Josef Bacik wrote:
> On Mon, Jul 15, 2024 at 03:04:10PM +0200, Jan Kara wrote:
> > When __fsnotify_recalc_mask() recomputes the mask on the watched object,
> > the compiler can "optimize" the code to perform partial updates to the
> > mask (including zeroing it at the beginning). Thus places checking
> > the object mask without conn->lock such as fsnotify_object_watched()
> > could see invalid states of the mask. Make sure the mask update is
> > performed by one memory store using WRITE_ONCE().
> > 
> > Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> I'm still hazy on the rules here and what KCSAN expects, but if we're using
> READ_ONCE/WRITE_ONCE on a thing, do we have to use them everywhere we access
> that member?  Because there's a few accesses in include/linux/fsnotify_backend.h
> that were missed if so.  Thanks,

Only if they can be concurrently read + written. Per Linux's memory
model, plain concurrent accesses, where at least one is a write, are
data races. Data races are hard to reason about, because the compiler is
free to shuffle unmarked accesses around as it pleases, along with other
transformations that break atomicity and any ordering assumptions. (Data
races can also be a symptom of missing locking or other missed
serialization, but that does not seem to the case here.)

This is a reasonable overview:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

I don't know the code well enough here, but the above commit message
also mentions a "conn->lock". E.g. if all accesses under the lock are
serialized, they won't need to be marked with ONCE.  But the lock won't
help if e.g. there are accesses within a lock critical section, but also
accesses outside the critical section, in which case both sides need to
be marked again (even the ones under the lock).

A good concurrent stress test + KCSAN is pretty good about quickly
telling you about data races.

