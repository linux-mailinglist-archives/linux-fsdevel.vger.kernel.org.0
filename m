Return-Path: <linux-fsdevel+bounces-15506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307988F7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C5F1C23405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D83FBA7;
	Thu, 28 Mar 2024 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwuyIpJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BC134CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606486; cv=none; b=QqO2X+vrsg6180unlr6KU+e6fsywD94FAA+LkRthmjtyWH1pgCyMA376g5NdsGkhPkXMFcmuPgKOxWsmLbv4Cfl0Cd3JpwBGPuTFquVyLe6RX/EbOICh9HPxjGTkS+K2B6OkPYlz1RPmHO/MepyaUt/FVetv/CUSJ8fhfoAMdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606486; c=relaxed/simple;
	bh=+knzS8GXoYQLLIuMdZV4tnIijfs18q+T3+UppyyoQIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdm/YZdyK6GQU0ZA+TfuE4E1M7SrXYmiy6m/Uh3lRYPle5dFaNtZP6KKVgSp/g7tZ6hTqTZJ3uky419OsxFhqx7VkX1gv+IiZBz+O3X1jbR4sHnXRFhyxz0ZRSsdx34PzO5CcTmuC96zTghOgkcUlbxkoLKvWsljk9HB6Iz0GaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwuyIpJo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690b8788b12so4099646d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 23:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711606483; x=1712211283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ziq3gAG7ZpYF7GuDwJEVNig3MGsDFLYdH/WjtIFPjRY=;
        b=JwuyIpJo8FBDDQHvrag7E+3qR4E6l+WifS42NhEdLWKPztAZsB8DJS2oz/MQVE3mFL
         SltO1OucSJFoZVVbZlX7PQIOcxlCDpUg5nSElb88xoiA7kuNbYatxPtTThNplRUU0my+
         XPYfRS/yfcRbX74SftUBiWd7M8G4GeqhnHkTeDlu1quyFlOMc3Ns4rO4tg3yEWyfWNs/
         WAP47ObnpwgZTV01MtvK//Z6fefalnrcJ2+VVojXmyfSrkIogoaw0wnJwqH5K1jjWm4W
         /XOtwhi65P/2acc6z5iYcfBkP46uZ8Ifkcvj9zs4m/pKN+HE7HO3igI6ftbvehALmJta
         oHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711606483; x=1712211283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ziq3gAG7ZpYF7GuDwJEVNig3MGsDFLYdH/WjtIFPjRY=;
        b=lsonCKF2LD5HKf61T/7UOAYg4V4VeDFNMekyS/jb1wxamThYYUTVjPZmA2njtgkKkZ
         Q8+FLU5ZLCxBUgf7jF9BRseC0N7tluFyJTjs5fnGwGfi2Y9xpyti5TeYC49o1wcCboHR
         ohlbrvyJ64ZLWu6eNVqaAiPPT/iaXRB38uKkbPM1ptDmun1lJ2jU5drmvzyreylJ9kf/
         VMUQ+3h6FB8XoICKl6rZCzOYG9aO9Jn/zzjciZKyEQSv0bhdOhXHxUoKNk6u53aY3EGR
         FL9yR/6Uf53u7tnNL4L8MmdCUAkxuS19bjJ2qTTZHjJdGN4Dd82i8HB5rx47Zwho1L3m
         9cGw==
X-Gm-Message-State: AOJu0YxZbEf1Du3kSmMiZ+HW420HN5qz7m3s2RnnlEhN1QtXbJlbNhp6
	OmCPnHdg/tqJCoTRXw3v3ghh56PK5gHephhtozB+W/HF+/ujgHTV2nHcdHL3fKxMSeS1uErBSgs
	ma35ulO5joqclLhLkrx2M1KyxlYmhzDLY0XU=
X-Google-Smtp-Source: AGHT+IH3U6go1ZrrepmmWWgUb2Rgy9iiIKVhCP1fCLH8P8nSWOWkK9dIjDjxFdAWxwp8ouq/Hy0TFZxXrKCXoVHWoLc=
X-Received: by 2002:a0c:c242:0:b0:696:b114:5d8f with SMTP id
 w2-20020a0cc242000000b00696b1145d8fmr1539501qvh.14.1711606483608; Wed, 27 Mar
 2024 23:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgTL4jrUqIgCItx3@casper.infradead.org>
In-Reply-To: <ZgTL4jrUqIgCItx3@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Mar 2024 08:14:32 +0200
Message-ID: <CAOQ4uxjK2Dcv0oDo5K6Z6QevapViR_mPFD_+wXu1GaufXs42WA@mail.gmail.com>
Subject: Re: RFC: asserting an inode is locked
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:46=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
>
> I have this patch in my tree that I'm thinking about submitting:
>
> +static inline void inode_assert_locked(const struct inode *inode)
> +{
> +       rwsem_assert_held(&inode->i_rwsem);
> +}
> +
> +static inline void inode_assert_locked_excl(const struct inode *inode)
> +{
> +       rwsem_assert_held_write(&inode->i_rwsem);
> +}
>
> Then we can do a whole bunch of "replace crappy existing assertions with
> the shiny new ones".
>
> @@ -2746,7 +2746,7 @@ struct dentry *lookup_one_len(const char *name, str=
uct den
> try *base, int len)
>         struct qstr this;
>         int err;
>
> -       WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> +       inode_assert_locked(base->d_inode);
>
> for example.
>
> But the naming is confusing and I can't think of good names.
>
> inode_lock() takes the lock exclusively, whereas inode_assert_locked()
> only checks that the lock is held.  ie 1-3 pass and 4 fails.
>
> 1.      inode_lock(inode);              inode_assert_locked(inode);
> 2.      inode_lock_shared(inode);       inode_assert_locked(inode);
> 3.      inode_lock(inode);              inode_assert_locked_excl(inode);
> 4.      inode_lock_shared(inode);       inode_assert_locked_excl(inode);
>
> I worry that this abstraction will cause people to write
> inode_assert_locked() when they really need to check
> inode_assert_locked_excl().  We already had/have this problem:
> https://lore.kernel.org/all/20230831101824.qdko4daizgh7phav@f/
>
> So how do we make it that people write the right one?
> Renaming inode_assert_locked() to inode_assert_locked_shared() isn't
> the answer because it checks that the lock is _at least_ shared, it
> might be held exclusively.
>
> Rename inode_assert_locked() to inode_assert_held()?  That might be
> enough of a disconnect that people would not make bad assumptions.
> I don't have a good answer here, or I'd send a patch to do that.
> Please suggest something ;-)
>

Damn, human engineering is hard...

I think that using inode_assert_held() would help a bit, but people may
still use it after inode_lock().

How about always being explicit?

static inline void inode_assert_locked(const struct inode *inode, bool excl=
)
{
        if (excl)
                rwsem_assert_held_write(&inode->i_rwsem);
        else
                rwsem_assert_held(&inode->i_rwsem);
}

and change inode_is_locked() to also be explicit while at it, to nudge
replacing all the existing weak assertion with inode_assert_locked().

Thanks,
Amir.

