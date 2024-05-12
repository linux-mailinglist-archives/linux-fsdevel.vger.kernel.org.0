Return-Path: <linux-fsdevel+bounces-19355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4C8C3851
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F61F21D81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82175337D;
	Sun, 12 May 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VMar/vTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79721360
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715544019; cv=none; b=jVi0FrDJpfWbPqRri2Mx25RlpzluTGN9C8m4sLZCcmSAP271jGDm6VBLNx1Tdg2Dy8ypAjUSysXp7LYm41D3SNsDqIm85gb6DcrgIMyo4cngR9oM1YWFGwbHbrzS0Rauuynf8XO6CsgdsYq1+wWU5ZfkD7hTFTe3H/aM/qSZQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715544019; c=relaxed/simple;
	bh=RExXAGWuq3dgdDTxdGqSAIYX5vMkM9JYjrEQ6xWScKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPnYELT72raO1/p4ExtqUWVjjScpQZIE1yOC6lM/o/xdjdlDf5SNUm7NcIi83LtryDdDDmYPhi6N9RiSOTIMejn2tNf1fy9m54VUOF06IcL0ibgLfDoQh4+U8c0d6zzQGVg0sTpLCIdT8FAUAFduZ/0xat02eyuRnbBZtw7SzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VMar/vTL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso632074566b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715544015; x=1716148815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/l29DmdH2LFFYFHpI3bLRcZ5M5jwY/j8Wz8rl5Q9FX0=;
        b=VMar/vTLb2xvc4rzVr8Ao4OqWNx1CjxCy9m5FwcgdtoDcPat3BojX66ammzelsC9RV
         VOu3e6yynQsYlRg5Cb3sx3NqyVUlJi9V311G9bQ0XoLiiGMO1hJ72/lWPR3rz1QFOvYJ
         MhCxjeEG83JdUhr6paoWtgWWylxlHYIXiMcsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715544015; x=1716148815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l29DmdH2LFFYFHpI3bLRcZ5M5jwY/j8Wz8rl5Q9FX0=;
        b=fT8FWaDxmfRVh5jO4GoAGL8vEa0ehvvDlcwJlAu9/z9f6a8S4AZXBjO+nI54Cn+Yva
         bUVLo+SjVurM/8IitdWMdexFIrNVrRO2w99YnPPeqYCupzGcQYiA83MvNvlVLMt0VcTw
         MbQcnbr6fsR/YxNLc9Q3rp5yDya5PHWMgRzrmh0n/XAuF8vAXMLvCpYOxK/p2PVe8UFw
         fOe9TkSO4s0gq3CQYj3in844LQzqf5zBNj9PaKltuCaKLEgxHkWl8G8JW5if6Bd8uieb
         Oe7EPej1mu8QawYQ2juudh8FtnN6MMSZ6NlKfZETFYYiMjKqlNJ6nF35pBGxIc3bBpNJ
         04dw==
X-Forwarded-Encrypted: i=1; AJvYcCWlvimbfQnSFEDfkxzYjHZxfwiPgQng3FVhPXuHkXLXHmwH3Vthfm3zJi3ZHUZnivIvql1Bh4WEq5V9kxbZpF7tond/opc52pJ/RZY9zQ==
X-Gm-Message-State: AOJu0YysWaWooe2M6kJHv1/PDe1CqExVT73GjGLKkBzpF0blPVrANdwW
	ScktiU+lbpRVXSsOc0A85SWE8Uz8/PzVkLeyTWmKqdPY+Bm0bsSrD3hqHA0AZALdFWJSoOJC9D2
	JPnU=
X-Google-Smtp-Source: AGHT+IETllNkGnAzlsif7cMxf/liSBP4tSBDG5O/qJvvZXHx2+9f1/GS7aR9ljSCFUBzN/bbcdM5Yg==
X-Received: by 2002:a17:906:1c10:b0:a59:9c2f:c7d4 with SMTP id a640c23a62f3a-a5a1167be68mr902412166b.19.1715544015195;
        Sun, 12 May 2024 13:00:15 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7da8sm494724066b.99.2024.05.12.13.00.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 13:00:14 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cdd185b9so807408066b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 13:00:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQQ0ASJ1m6fwNfOx1Pd4gMGZpWf/eQuZWh+7dYAVVPwjhXXhxEzE4SNSyG6Gb3iccZ/UIE+HK9yjFfl/poIBAgjwsTk/SrgGoShHWVhw==
X-Received: by 2002:a17:906:1d59:b0:a59:bf27:5f2e with SMTP id
 a640c23a62f3a-a5a11682723mr868253266b.20.1715544014114; Sun, 12 May 2024
 13:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org> <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV> <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV>
In-Reply-To: <20240512161640.GI2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 May 2024 12:59:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
Message-ID: <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, brauner@kernel.org, jack@suse.cz, 
	laoar.shao@gmail.com, linux-fsdevel@vger.kernel.org, longman@redhat.com, 
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 09:16, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Eviction in general - sure
> shrink_dcache_parent() in particular... not really - you'd need to keep
> dentry pinned for that and that'd cause all kinds of fun for umount
> d_delete() - even worse (you don't want dcache lookups to find that
> sucker after rmdir(2) returned success to userland).

All of those dentries *should* be negative dentries, so I really don't
see the worry.

For example, any child dentries will obviously still elevate the
dentry count on the parent, so I really think we could actually skip
the dentry shrink *entirely* and it wouldn't really have any semantic
effect.

IOW, I really think the "shrink dentries on rmdir" is a "let's get rid
of pointless children that will never be used" than a semantic issue -
cleaning things up and releasing memory, rather than about behavior.

We will have already marked the inode dead, and called d_delete() on
the directory:

        dentry->d_inode->i_flags |= S_DEAD;
        dont_mount(dentry);
        detach_mounts(dentry);
        ...
        if (!error)
                d_delete_notify(dir, dentry);  // does d_delete(dentry)

so the removed directory entry itself will have either turned into a
negatve dentry or will unhash it (if there are other users).

So the children are already unreachable through that name, and can
only be reached through somebody who still has the directory open. And
I do not see how "rmdir()" can *possibly* have any valid semantic
effect on any user that has that directory as its PWD, so I claim that
the dentries that exist at this point must already not be relevant
from a semantic standpoint.

So Al, this is my argument: the only dentry that *matters* is the
dentry of the removed directory itself, and that's the one that sees
the "d_delete()" (and all the noise to make sure you can't do new
lookups and can't mount on top of it).

The dentries *underneath* it cannot matter for semantics, and can
happily be pruned - or not pruned - at any later date.

Can you address *THIS* issue?

                  Linus

