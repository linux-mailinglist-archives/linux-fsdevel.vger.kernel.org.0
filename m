Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3613F3137F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhBHPdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 10:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhBHPaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:30:55 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8BC06178A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 07:30:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so10425095pgu.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 07:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVa5iP/ZP1kIUt+ZL6wEw6hpu9lqQN04bPoh5Ps/O8k=;
        b=SB50xgtOv2drwobrNTCxM8e1R7wRSzKZvSWvf9w54gMrS7FLzMV0SFb5/DSUr9R9xy
         juPcTRQ6i8IJmZvPrNlhOU00XAyhXmzWppXj2SETQbihFRRqrOCjVVAUVjcQT2r31C+U
         2gAlTRD3O7rHE/SEaIAYSVlkvhu6BYsVW1WrrnJ3iLysWw2M/oxe3cHtcBhIh3/0GBm/
         fIXM6Uq/3b/k4v4dcQHagjrUNkX3ilDp0Uh9pnrTyjxnEV3OOKGEoB9jGDArCMzjV+M4
         qBp/3Y3ZDJk2y36OqxRMAh4EKC/Tgns1qBW5sgdlVWztkN3j7MrPNB2e/08kdPjSNJ6R
         FSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVa5iP/ZP1kIUt+ZL6wEw6hpu9lqQN04bPoh5Ps/O8k=;
        b=Rza7P5j7re9EyvZAxaZmXSYzsQVCvDtLU1Xw3hHwQJSEiyNNzMtsKQN1XmnMNyLQ3R
         k9BgIgfwJXKDa/8ilQc8WjXKqEh5rd1y6fti2PgWQDxn1CsbWOOEDfttFMZa1zsyiQIo
         /3kcU6//4N4bXnbHbccD1w1hmz+70WDSLYWNHP9muN05YIFHboiQCOW1DKevhTqQYZep
         TrzKs51G7sLZJiuHXRvGuoFF5OKzdXsoFu+dHO8XA7R5Q6GaIvmGnbEDdPBg0j4zSCvI
         QwlAvOd2FwB+xMyMQWS+uQSqJRZ8xcFZPIyTpHks8NwEcaP5OLa7sQ9NMpnE6e3fwInA
         f50g==
X-Gm-Message-State: AOAM5309oLzELwbN8UVbsPn1lH0jFvfKgGFb8e1drO9rJGAwAjDhOqef
        cRh2I8r2wRJ6lpuDV79DozoJh4f6InOReGJmrGqQRA==
X-Google-Smtp-Source: ABdhPJxmRkIV7FEKwi4Ks9SoAI+DtUo1kXi3hGwtraZqD7I2gA+9nHX+iiKNSbI78kk5xN19ZMyxo2ZNGRPJ5UobDXo=
X-Received: by 2002:a63:724a:: with SMTP id c10mr17900352pgn.124.1612798213229;
 Mon, 08 Feb 2021 07:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20210208151437.1357458-1-kaleshsingh@google.com>
 <20210208151437.1357458-2-kaleshsingh@google.com> <20210208152244.GS308988@casper.infradead.org>
In-Reply-To: <20210208152244.GS308988@casper.infradead.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 8 Feb 2021 10:30:02 -0500
Message-ID: <CAC_TJvfkZbktznxas7donjrOnHeF4ZmTrsvPwNnWSqkkcORe9Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] procfs/dmabuf: Add inode number to /proc/*/fdinfo
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>, Anand K Mistry <amistry@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 10:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 08, 2021 at 03:14:28PM +0000, Kalesh Singh wrote:
> > -     seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
> > +     seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\ninode_no:\t%lu\n",
>
> You changed it everywhere but here ...
Ahh sorry I missed this. Will resend with this corrected. Thanks Matthew.
>
