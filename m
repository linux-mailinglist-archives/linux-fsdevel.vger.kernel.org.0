Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B606649FCA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 16:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbiA1PSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 10:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiA1PSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:18:14 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E195C061714
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 07:18:14 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d188so8096771iof.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGvQucbWcxiiy9BkaB6wybPeaPqv2uq8LEkM25/SbSs=;
        b=LNlv2VwIrnEBfg4AcR1HbS0P7lFmqI/Vng314k6PTuXh/RqXQGQAcXB5RYlU0aFl9m
         Fy9laE1Hn20sWaEbNC92vQfSwu3vqXHQmnaRV6ecxYxAO3ahfu/C7mc/IEwppqu+jfbv
         ID47ckU7VO99rr50d6KJAf+uG/rdvU4GoOdeH27WVfGvCkSvmlUbrTHoSCDZ5MlCkuz2
         SsyLFO/Be1ZTHRGvjj8LioRxUp3GJRTNkvnCYou5wjcOQw9OaNdvK96fdtt6BSWDCy0K
         mJUvQTGz7xhtOpJ9ZmDyKeV6zhB7VHxir2ZXnaGTRSyRJe5MyDgU7U4FQb5j6G7emAZW
         chnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGvQucbWcxiiy9BkaB6wybPeaPqv2uq8LEkM25/SbSs=;
        b=GE0gUOMKiBZgNAYjb8VTWWdx+r7Ckqhk6yXfCq3n+6CdXESU13S75dTIAfScbkLeSy
         Xp7+Qq3M8Nkt+bZBV+yYuweM/kVSUGq4fEAJqLK9xf8PV6+Twla7dhWxohc3tNdj3/Xp
         vwbU2afXxgHflI863jRq0boN8wxj8Isri2Y4i+CeeTY9oHAPBXNUjl+N3bGNeAOnwZ4R
         woEoyd34FdXF16ue2oMg2JIRHio9sxN7KanfkHOj+oFsB2up6H7FwLZym411BdkSXUM/
         qdSfLV3a2tQImiRNqSWgAZR9OD5a6r3mA+2lfDLiOzf9atyNpSfehEF7FSCvACWvEFKU
         Hdcg==
X-Gm-Message-State: AOAM532FhaHGGEUNajrIaRbgXRbAFXDL9MU2azgt+scx5TYUFc8Liu54
        17wdkFdpb0OKdZZYbqo5fJJzb5cj5tE8pIZIHAg=
X-Google-Smtp-Source: ABdhPJxyAsqnScCQerNR0btIeSX8By+dl3MrfEU5kjiMt9CR2pVjXmVTLG+xV2aEusux6zaMcVRVGFtJN1Dgt1vTxdI=
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr5292098ioh.70.1643383093617;
 Fri, 28 Jan 2022 07:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20220120215305.282577-1-amir73il@gmail.com> <20220124135023.quzjsqtsrxynffrs@quack3.lan>
In-Reply-To: <20220124135023.quzjsqtsrxynffrs@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Jan 2022 17:18:02 +0200
Message-ID: <CAOQ4uxhwbLvjnpuj=fiszS2_cGu-5tCFJ0Hdv7Xdw4sq09kmaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fsnotify: invalidate dcache before IN_DELETE event
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Ivan Delalande <colona@arista.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 3:50 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 20-01-22 23:53:04, Amir Goldstein wrote:
> > Apparently, there are some applications that use IN_DELETE event as an
> > invalidation mechanism and expect that if they try to open a file with
> > the name reported with the delete event, that it should not contain the
> > content of the deleted file.
> >
> > Commit 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
> > d_delete()") moved the fsnotify delete hook before d_delete() so fsnotify
> > will have access to a positive dentry.
> >
> > This allowed a race where opening the deleted file via cached dentry
> > is now possible after receiving the IN_DELETE event.
> >
> > To fix the regression, create a new hook fsnotify_delete() that takes
> > the unlinked inode as an argument and use a helper d_delete_notify() to
> > pin the inode, so we can pass it to fsnotify_delete() after d_delete().
> >
> > Backporting hint: this regression is from v5.3. Although patch will
> > apply with only trivial conflicts to v5.4 and v5.10, it won't build,
> > because fsnotify_delete() implementation is different in each of those
> > versions (see fsnotify_link()).
> >
> > A follow up patch will fix the fsnotify_unlink/rmdir() calls in pseudo
> > filesystem that do not need to call d_delete().
> >
> > Reported-by: Ivan Delalande <colona@arista.com>
> > Link: https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/
> > Fixes: 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of d_delete()")
> > Cc: stable@vger.kernel.org # v5.3+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks. Both patches look good to me now, I've merged them into my tree and
> will push them to Linus later this week.

LTP test:
https://github.com/amir73il/ltp/commits/in_delete

I'll post it later.

Thanks,
Amir.
