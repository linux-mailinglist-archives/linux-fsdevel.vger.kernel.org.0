Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC649E42E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 15:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbiA0OKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiA0OKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:10:05 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B8C061714;
        Thu, 27 Jan 2022 06:10:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z199so3652107iof.10;
        Thu, 27 Jan 2022 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFpDXlPgjwfaToJnaJ2TrcvU7QDBx2ezd1Ffsp4i4pQ=;
        b=FpGgGQpCkztH7jlPa1wzuFIdcXx7MhVknp0QuRvrQGvlIkgJnQVPlyYGrdIbTuew6y
         Owbaa0jtP2ZE9gaSMXjV0z0J0bFBLGq9cH0e1S4rtGCfW/kQIeDWFipGf+cqr6p68gpL
         DSLinr584+Wjyl2Vxq76o/9T/88rb+SO5oziOh46yXuaVDe4A+HdESp5yeg0Kw0Upfh6
         EqmsfXVxI/Wsp5Bt8okAc/CpwfTNUBXKWhm/FaL74QGMa3DOE6eBnJ4SeH2GYqnugXZF
         p9Y2SeqgEq/urZICP8UBkavKz8yERETV0slozcPMrP2izwQCzSfzvOclv5i1/dd2U8Uy
         p0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFpDXlPgjwfaToJnaJ2TrcvU7QDBx2ezd1Ffsp4i4pQ=;
        b=Qza+6RlFHT4tCxyc/igfTmoeOsvSf0cLxLuyDdoSg2ZJsq/ToIvHuWsKZ1JNqnK0r2
         QJGtUCh75GqeR3aQJIHjTYuztPMbqPf01yPe6CczCJfS+bZNZE/yXEcuKeruq9URiGfa
         f3bm13fuMRjDO2mTaxMwzzYG1MdT1EpwzwcJMX0uOKZcE0tMutiAWUMZk7I8w1P0ue+N
         WLjb1R9DXF7AnCo+vFJTjbEk4Rnk+xZwYGaZBoBBMBiNtk0GI3iRg1inj7j0ovZIMm4C
         iNEiR8B51SVtd+LJ53Z/mfLdCa2oEZA5yFdagu6M3BJxdyN+/fcWyCUvuB+MYUJrpfpU
         3bkQ==
X-Gm-Message-State: AOAM530PoeGTvYb2ukfhttAIdRlwdj4eW4b9F1LYK5gFpOnih/HKDAnl
        fwXM/0HnuaD5Q1qpYtXrtJgToXTQwO6+JYzG60Q=
X-Google-Smtp-Source: ABdhPJyhxK3upk7mF4LEUZ3hivGB+JpEEcZLaph0uph0ugsC7g+Xk9k1ydZW6ct4Re0o4vY4TB8HdfZXVIH8MP4M7VE=
X-Received: by 2002:a5d:941a:: with SMTP id v26mr2092314ion.64.1643292604711;
 Thu, 27 Jan 2022 06:10:04 -0800 (PST)
MIME-Version: 1.0
References: <CAFadYX5iw4pCJ2L4s5rtvJCs8mL+tqk=5+tLVjSLOWdDeo7+MQ@mail.gmail.com>
 <YfHMp+zhEjrMHizL@casper.infradead.org> <YfHU5/RrpJlRx5sO@casper.infradead.org>
In-Reply-To: <YfHU5/RrpJlRx5sO@casper.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Jan 2022 15:09:53 +0100
Message-ID: <CANiq72=fTTreGHn_-t1tBLKxMeCr4b0ENsHGAgWZL1OZ7sKhMA@mail.gmail.com>
Subject: Re: Persistent memory file system development in Rust
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hayley Leblanc <hleblanc@utexas.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Vijay Chidambaram <vijayc@utexas.edu>,
        Samantha Miller <samantha.a.miller123@gmail.com>,
        austin.chase.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:59 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> ... This time with the correct email address for the Rust list.

Thanks for the Cc, Willy!

> On Wed, Jan 26, 2022 at 10:35:19PM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 25, 2022 at 04:02:56PM -0600, Hayley Leblanc wrote:
> >
> > I only have a toe in Rust development, but I'm not aware of
> > any work being done specifically for filesystems, that said ...

For your reference: a RamFS port was posted last week. It uses the
Rust for Linux support plus `cbindgen` to take an incremental
approach, see:

    https://lore.kernel.org/rust-for-linux/35d69719-2b02-62f2-7e2f-afa367ee684a@gmail.com/

> > Bento seems like a good approach (based on a 30 second scan of their
> > git repo).  It wasn't on my radar before, so thanks for bringing it up.
> > I think basing your work on Bento is a defensible choice; it might be
> > wrong, but the only way to find out is to try.

Side note: Bento is not using the Rust for Linux support (as far as I
know / yet).

Cheers,
Miguel
