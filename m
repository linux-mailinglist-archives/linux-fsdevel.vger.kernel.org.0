Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F501493E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 13:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEFL6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 07:58:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52003 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEFL6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 07:58:54 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so7530324itk.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaYC1JqAO623Gl+KoBD18WPWraCDEDJU+j3owWXUwKU=;
        b=cLWVJeHbldosDdIyM2Dff44Abax5kRuJZ4JFWT+3L8DeHQp8fEmoFKS3Zz7FrC2RpR
         YpkoEjvQ+vUssfX4jwGMXz/rWwBFD2ICsnMTVpBcLlYQQA4DpR7uVq5FZCQBN9Go7G0g
         C5+CWWYyd61m/NVYFGhZup7NE8UmLwX+v3dxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaYC1JqAO623Gl+KoBD18WPWraCDEDJU+j3owWXUwKU=;
        b=cHzunfNlrAszINpaXz4eYXyQuwTnTgCynQiVXcN7+DjCNwmD2u/NK4sFqczYjTlQbx
         f2cFl3fUAFeRjKmG2YD5/rgeEwNiSouSMWtW7wlvsy5L4jaUNuKYNjdclcEwxvmDBaJL
         pzq9srygcKlNEQ6aCgs3JkxUY2yfmi75g6I9qORpG8//VjJSUBBCTNdB4vVb1jUdh/z9
         Z9CFumykF43O5SByPv+4bP8mu4A8Lamrjz0TPBCi6GxP6vTRZPAWkB1WsUMTFnOABaK7
         uiZwO6W2lY//q7H3j5FiT4owgaWkyFPbSBAZ4jOrQjymQnc3G7XewDuqi4FPxMZFAEyT
         xc+A==
X-Gm-Message-State: APjAAAV3E0BkkofzMBMu+rdC+D22l+eZ/aiQaG9clprpj/3UrDmFPhzg
        D13VEVMjkqT/zWNmZ97x4sq866UJN92zS/JhGHO2HA==
X-Google-Smtp-Source: APXvYqy8+C9SJ8MJExlZKI1ApCztiefXgoTcLKjC62VFnvVQBJFTfpRVWYu+oRx4dZxeUbNbnSXGEcXiDunobljOv80=
X-Received: by 2002:a24:4094:: with SMTP id n142mr18576671ita.1.1557143933698;
 Mon, 06 May 2019 04:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190424163950.14123-1-amir73il@gmail.com> <CADJHv_tDBdHNBqrO_uARQhMZYEeadPcoshtXFVnvpcVpOFGdhQ@mail.gmail.com>
In-Reply-To: <CADJHv_tDBdHNBqrO_uARQhMZYEeadPcoshtXFVnvpcVpOFGdhQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 May 2019 07:58:42 -0400
Message-ID: <CAJfpegvCtm1rEZ2FyGM1xxJ8Ee-5Q_dr6PCt_WBNvMdJLiTcaw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: do not generate duplicate fsnotify events for
 "fake" path
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:09 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> On Thu, Apr 25, 2019 at 12:39 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Overlayfs "fake" path is used for stacked file operations on
> > underlying files.  Operations on files with "fake" path must not
> > generate fsnotify events with path data, because those events have
> > already been generated at overlayfs layer and because the reported
> > event->fd for fanotify marks on underlying inode/filesystem will
> > have the wrong path (the overlayfs path).
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20190423065024.12695-1-jencce.kernel@gmail.com/
> > Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> > Fixes: d1d04ef8572b ("ovl: stack file ops")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > V1 was addressed to Jan and was trying to teach fsnotify about fake path.
> > V2 leaves fsnotify subsystem alone and just sets the FMODE_NONOTIFY
> > flag on realfile. All the rest of the complications with mark mounts
> > are irrelevant.
> >
> > Same extended fanotify06 that was used to verify V1 also verified V2.
>
> Thanks for fixing this!
>
> My overlayfs tests on this patch looks good.

Thanks, applied.

Miklos
