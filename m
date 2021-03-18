Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6533FF6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 07:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRGOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 02:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhCRGOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:14:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47549C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 23:14:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v23so755822ple.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PfJSGhVIXOhUCTnbC4O18i2rgfMR9l6aqEhZ+m64aE=;
        b=Bj20pbfJeNE2YdFKUD/MaTbGJmD4ZucMFS1HjM8hJ43vUiqq+wu14WIBSUYepacT17
         G4Li7MpGUsW/o87QJXg1qgQcPhQTCya1C8xi7N8dKRD/Q/ZBB6S/AD15CqhBJD5oAKrn
         lwraLQ++Zhpp+fFHN8Xjd017DiACD6Dw01oGz1pfd19Rj9WXVTXsw44oQqrHmhpkvUnY
         YzhzTmiCp/yYdwgtqp4qzk+rvnebt502pdDiX1kSMSwJARFgI14p1DGaKuOawhZKsf7d
         BFhKqdKiirZd1l7A8L6CxYX8Re/LWihgbJBLZ03ZC8k0T5hm/TWc15r/oWNIJgJHYBGI
         H6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PfJSGhVIXOhUCTnbC4O18i2rgfMR9l6aqEhZ+m64aE=;
        b=OzUrAOeOwZ2pEcFpP75qe2e6HW0PC3nw55/zqdaTPphB1asf8s1uY1fBgkPJmlRmL3
         xkB6ak+JWaX8FOw1YSiA4PqjormOZg0AQHd4vLNh/EeGceQvCE5Pi0sG8Gatet85Y38E
         2Sw+CUOlJNmvHtxIKM2CUt582bn35TnZSLxMQQyHye552nNmHeoSB4rqSQ1X3uhowWKf
         E6pIku8fu5YWdKfUA1auU7zbt0VByfKtv7oZwJ2KLvDRpbMkz3fnpf2sHP4F4DAkoWE5
         O2MmLXMa2R0hsHhZ9zWcRl0BTZxYpqvQfBuGKhfPDDunIw5DMGC1baitjHBWtZwA56+n
         9T6Q==
X-Gm-Message-State: AOAM533jcXuTMdciEGhGGrn6Pkzz1tqtOEeC+k1t+Np5zt90iN7VHB1o
        4nFgY9mISlU01vY646F4XmeLxsXVxtdyxtTnjveZtA==
X-Google-Smtp-Source: ABdhPJxVkw/zyrhe1wE4gMerqjvIr9q74wwmhWyfejQcH2X7CII3lwOwWAuiCNVH96ggTBGOTc2/Yoe8EiX0/Gp7l8I=
X-Received: by 2002:a17:90a:fb8e:: with SMTP id cp14mr2661187pjb.52.1616048060530;
 Wed, 17 Mar 2021 23:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210308170651.919148-1-kaleshsingh@google.com> <202103172255.46B192DA@keescook>
In-Reply-To: <202103172255.46B192DA@keescook>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 17 Mar 2021 23:14:08 -0700
Message-ID: <CAC_TJvcWuzb3FPqYQ_LYJ1iEbTWQE=E=hYaLme3VCZFBQNGe0w@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Mar 08, 2021 at 05:06:40PM +0000, Kalesh Singh wrote:
> > Android captures per-process system memory state when certain low memory
> > events (e.g a foreground app kill) occur, to identify potential memory
> > hoggers. In order to measure how much memory a process actually consumes,
> > it is necessary to include the DMA buffer sizes for that process in the
> > memory accounting. Since the handle to DMA buffers are raw FDs, it is
> > important to be able to identify which processes have FD references to
> > a DMA buffer.
> >
> > Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> > /proc/<pid>/fdinfo -- both are only readable by the process owner,
> > as follows:
> >   1. Do a readlink on each FD.
> >   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
> >   3. stat the file to get the dmabuf inode number.
> >   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
> >
> > Accessing other processes' fdinfo requires root privileges. This limits
> > the use of the interface to debugging environments and is not suitable
> > for production builds.  Granting root privileges even to a system process
> > increases the attack surface and is highly undesirable.
> >
> > Since fdinfo doesn't permit reading process memory and manipulating
> > process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Who would be best to pick this up? Maybe akpm?

Thanks Kees. Andrew has queued the patchset for the mm tree.

>
> --
> Kees Cook
