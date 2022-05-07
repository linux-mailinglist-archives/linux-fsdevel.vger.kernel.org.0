Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343F51E55A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446026AbiEGH7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446037AbiEGH7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 03:59:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FA220DF
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 00:55:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t16so7590120qtr.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sZ+6qGAYQtVj/5uKhgdz89BsLQ5vVUVAoZSX25FRqc=;
        b=R4DZDq0s9dy8bLTfSJSYfxAsbMK/ZjqPyH7UsoI6jAu6Lx8pPI7C3rG/5QFuKVNz+1
         OvfWllqYOaCympt8Oi4VT4wggsPthPizCLCulJDg2Lat2EI9jqf0O79wlbGldFvuRFfO
         ZrC2SqIU/8Kb2xHV4aLjXKx70/UV6jPM28nPve2tcE3cCBjL97eg4KPoctpknQ/sSOIi
         /cOg2beDtJ9xMBUacHozgm7fnYc2I4WUi6g+dI6xHCPfupmppIio1DV485wJlNDJvEwM
         DxJWXDE2YRhQ8T6gg4A1u+mgJkdxBDmR+UnSHf+6cbAj/3rRAbvB6yhUyHq66I3T34Q4
         6IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sZ+6qGAYQtVj/5uKhgdz89BsLQ5vVUVAoZSX25FRqc=;
        b=XKYoYFRNCt4rFwmM23Mb3TAJp79o3TDiuuPaJdWcKrn6NU1D3sTmeEIbrUAwFnYIRc
         W3lZLxHbAsZ4uVG6b/pL9Zt/J3o10sZt593p3v/2bQh1yl1/nbg3DXin7kdndoRSg+bh
         7PgRM4wH0Y89WhoZQJtvSDixaFcmZiuDvUw6PietmiOm6N8uCk0felzfG8wbndo9YbXL
         tR1Kk39ICW3+MnWHmDt/izkW7eBYYt42aGEMHN92Tx0tazEOG5aD30izUbqt1aWINoQk
         ZETdefbFf73DnACEoJ+/M6wQ/qDiWj/V3Jh+8sEnxK3rleq63AXTtLfRSqDKVquxFDcA
         ZdXg==
X-Gm-Message-State: AOAM532RHOAZ30qgfjGBeCARbrrLqhfZ34cN82bb6pAg7Wl57/w5AnoF
        i6nsMBnvVCYOFNaRcyi/Dz4Sf7Pa8tFcvc8GDqQ=
X-Google-Smtp-Source: ABdhPJyq0Bqiou5V65FsLbbs8erMjc8UfZimnx8vRwEx+3QRKlHmbUuchwgTDf/VBvEx3MtpGN67kdNJtB/F+sx40TQ=
X-Received: by 2002:a05:622a:1052:b0:2f3:c085:6316 with SMTP id
 f18-20020a05622a105200b002f3c0856316mr6232583qte.2.1651910128662; Sat, 07 May
 2022 00:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220506014626.191619-1-amir73il@gmail.com> <20220506091203.yknwtnnxaz6n547d@quack3.lan>
 <CAOQ4uxhvT=b6bNwxE5_XBmOh84nae72GhWJ_vaO8iwHgqY_ceA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhvT=b6bNwxE5_XBmOh84nae72GhWJ_vaO8iwHgqY_ceA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 7 May 2022 10:55:17 +0300
Message-ID: <CAOQ4uxha1=Sx3jNyOJkzMbB4Pe194G0DFVnxzZHRQM2B4WJCYg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: do not allow setting FAN_RENAME on non-dir
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 7, 2022 at 8:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, May 6, 2022 at 12:12 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 06-05-22 04:46:26, Amir Goldstein wrote:
> > > The desired sematics of this action are not clear, so for now deny
> > > this action.  We may relax it when we decide on the semantics and
> > > implement them.
> > >
> > > Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
> > > Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Thanks guys. I've merged the fix to my tree (fast_track branch) and will
> > push it to Linus on Monday once it gets at least some exposure to
> > auto-testers.
>
> Actually, I made a mistake.
> It should not return -EINVAL, it should return -ENOTDIR, because
> the error is the object not the syscall argument values.
>
> Going forward, when Matthew implements FAN_RENAME on
> non-dir, the error should be changed to -EPERM (for unpriv caller).
> This will allow better documentation of behavior in kernel 5.17 and
> newer kernels.
>
> Can you please fix that before sending to Linus?
>

Actually, nevermind, I have thought of another issue so posting v2.
I think we should deny all dirent events on non-dir with
FAN_REPORT_TARGET_FID.

This is what happens when posting patches from airports :-P

Thanks,
Amir.
