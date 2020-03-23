Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81118FD77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 20:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgCWTSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 15:18:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32822 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgCWTSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:18:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id r7so16030547oij.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2020 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZKG7fTNBsJ3BzEdzcdQdFxvXUKeTmJw8ex6iL6EOq4=;
        b=qREfsk+dXDKglyer4a2qeACjwrid7zU0l/gOaRByTH9Ll2wZjiqzwJ6cbpU5YIjJt/
         TD3Na1To9Dp/0jC9Nwn1Z36a41fldefYxufKaHR5nj+haoYtUv/oTgk6/FXVTEF8SSQH
         xlcCupPEeBXWhFTEUDFdXuU1yHTnF3y4mOvUTnYzGp1A99sbPLA8b6lCLmIrV1fxCTWg
         9uOBIHhMe0B0DIJ7AMYdxhnmOrNcIiBk9iTQVgXpNhohhg1nxXrKKoID9jHaM2g9v0/R
         JUdKFHBPydw5lYwSIparAdsWVMpNSPx65T/dtks/uSBjLqIwV5Xc6L6a72AvpbKr92Sb
         gsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZKG7fTNBsJ3BzEdzcdQdFxvXUKeTmJw8ex6iL6EOq4=;
        b=fqHNdR5jD3nP9PfZfnStd8RmZ3e9N9Wh3k+aRW/Qdhrvt0mI+3dfyMBsqIg230fNr6
         mkHQgRnVla1SvkmSsKcHZrfn5E2s3EiGljhmbhhGB9IxffaI+DbQ3igMpTzB+8bz4K0x
         xuJ3dXKZl92eAX20vgdTwFqvA3HaE4Qh3iHZ2mNgYRd9LPNiXe2aVneGLfJD7binpvRO
         5SmnPycpgz0sKbsFVI2XSTpHu5iIk/GC0rLYM01udxJwd+mu+/2TZKz1v2hBqPxFrSKx
         q2DMpBfPPGkgBbnxdMetS74Z7AmBPYCLSKhG/3Ay9Dfd8JnWj22KX1e0yEL8Rr2nvCIF
         sgFg==
X-Gm-Message-State: ANhLgQ20qpF1ZOvafXQLCTh8WEm0ejxLnNliNZvnbQs67bh2QY2L5Ofi
        b13n4BJRGJ+zPPuUeJU7XljjDVhD2hZNCiKCv9d0FQ==
X-Google-Smtp-Source: ADFU+vvtp101BmSbeYLakx7Wvp+wzVb723oqWR/Id6j79lBhJDMmBLI8QD1mYj4E7HSrHOtRmJDVPLQ/QzaoSrn5hUI=
X-Received: by 2002:a05:6808:8db:: with SMTP id k27mr675696oij.175.1584991110176;
 Mon, 23 Mar 2020 12:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200318205337.16279-1-sashal@kernel.org> <20200318205337.16279-30-sashal@kernel.org>
In-Reply-To: <20200318205337.16279-30-sashal@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 23 Mar 2020 20:18:04 +0100
Message-ID: <CAG48ez1pzF76DpPWoAwDkXLJ01w8Swe=obBrNoBWr=iGTbH7-g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 30/73] futex: Fix inode life-time issue
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:54 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> [ Upstream commit 8019ad13ef7f64be44d4f892af9c840179009254 ]
>
> As reported by Jann, ihold() does not in fact guarantee inode
> persistence. And instead of making it so, replace the usage of inode
> pointers with a per boot, machine wide, unique inode identifier.
>
> This sequence number is global, but shared (file backed) futexes are
> rare enough that this should not become a performance issue.

Please also take this patch, together with
8d67743653dce5a0e7aa500fcccb237cde7ad88e "futex: Unbreak futex
hashing", into the older stable branches. This has to go all the way
back; as far as I can tell, the bug already existed at the beginning
of git history.
