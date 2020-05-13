Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376211D1762
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgEMOTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 10:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733142AbgEMOTj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 10:19:39 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25A220708;
        Wed, 13 May 2020 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589379579;
        bh=XCp5F/lYiyuFT5h0NEXzypxvSnrMq5SZYIt8WXe6LVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uOJGUSp5I2Fhby38cG8aJB5ujSNOpddNlZHsiqZbn37fuENgE22NYAwW53wpZU6TE
         MhNxw4iMQFX9TOzBv4/GTYMM6NmU8ZRogVMufoD8nEujm43LPGYyH6WdGhjmZ89W8B
         Ah8qptaWTjtm601fRZr25nbACz19TyBVIol8MdoE=
Received: by mail-ua1-f44.google.com with SMTP id r2so6105393uam.7;
        Wed, 13 May 2020 07:19:39 -0700 (PDT)
X-Gm-Message-State: AGi0PubOpjyrhBhJsp1c1HERHhWm7SsLiUirirkzOMfsBRG9RMVf5DiJ
        TCXr7YcAJmZUIQtLKENo4bVpw0tkAxMrmfF+dSg=
X-Google-Smtp-Source: APiQypK0Z3eeJRCbcDNHMvprSx0ZZ2CAJhP4go8hTJZBChpwnx4JHb3r9jdcrxmUSeo5vLo9P/JwjJDtE5yuwipHIKs=
X-Received: by 2002:a9f:2c96:: with SMTP id w22mr21303032uaj.14.1589379578140;
 Wed, 13 May 2020 07:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk> <20200513131335.GN11244@42.do-not-panic.com>
In-Reply-To: <20200513131335.GN11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Wed, 13 May 2020 08:19:25 -0600
X-Gmail-Original-Message-ID: <CAB=NE6WdYcURTxNLngMk3+JQfNHG2MX1oE_Mv08G5zcw=mPOyw@mail.gmail.com>
Message-ID: <CAB=NE6WdYcURTxNLngMk3+JQfNHG2MX1oE_Mv08G5zcw=mPOyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 7:13 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 06:49:50AM +0100, Al Viro wrote:
> > On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 06b4c550af5d..ea24bdce939d 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> > >             goto out;
> > >
> > >     ret = kernel_read_file(f.file, buf, size, max_size, id);
> > > -out:
> > >     fdput(f);
> > > +out:
> > >     return ret;
> >
> > Incidentally, why is that thing exported?
>
> Both kernel_read_file_from_fd() and kernel_read_file() are exported
> because they have users, however kernel_read_file() only has security
> stuff as a user. Do we want to get rid of the lsm hook for it?

Alright, yeah just the export needs to be removed. I have a patch
series dealing with these callers so will add it to my queue.

  Luis
