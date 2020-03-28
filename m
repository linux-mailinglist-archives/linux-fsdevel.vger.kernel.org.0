Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9B1964B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgC1JP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 05:15:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37190 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:15:27 -0400
Received: by mail-io1-f66.google.com with SMTP id q9so12446875iod.4;
        Sat, 28 Mar 2020 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saHwc+iPTg9mg/TKDP5qS7eXjj7tpT9oKu8R16Snw/0=;
        b=V85xWxIYguZJQBlJDcV5H1vC4AZQ75o5IfGxxsNZEdxAxyTDRi/3VkUgdzV9fGrNQ4
         QEn+RRB+UT6JfVPHNIwjNNvhFh3YuFNNEY1Y1anvR6+TGFnvb8iLdk4CXhxRuUV/mFoc
         Nx4K0BFA9dCVbqd3DDYnQQM5U2TsQHJ5k8KIKqljnwARGdhfA/aWpnIuOPCHX1g2oAov
         Ecvq+re8mOTiCop9zOauWtaVaFKp/9kJG/fkqy83JBoHCOwUwT8coHiWFwn23KxIY5a/
         RlG2FZO3TzqTfjT3gYDXBt7q+WFD9uBWGTmy0Ye7witZAn3SPU+dQ4j7KVYRKh0jVHJu
         NzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saHwc+iPTg9mg/TKDP5qS7eXjj7tpT9oKu8R16Snw/0=;
        b=MVBdkz4U0JvsH+UnZTgcuPdE94L+rAHBbMnAnxXVHjDRemZtIQ5dlh5uZaFLmwfutT
         FYDP5ifBUIE8Hvvn+lm1hJtaIlrW40IkbwR3Fr+aiZE7ZU56teRZ2X7HGTIt6h3o3nFc
         rXz0ByYhflnh/tespzoNNpuUHEkzR179t9drVHUnEv+vCDXXQUdH4Nkst/n93saPeiJM
         bzJVYoZa5+lh8/oOXHnynCCRaBxJkhpUwEdw72SjohScxn0JppMWuMw49AZE0hifDuRm
         NN6c8C6UpbpAXye0/wy4ehz7TOgmlLNYZZMClL6hTpTETxh1PiyUNjsyrBL+Oip0Oikz
         q/+Q==
X-Gm-Message-State: ANhLgQ2PSC2ILpib6i994M/NBGDir+OnaCAxLUjUsR+oeJ7epOdb9zVk
        6TEht8PSU9xno7munf2jcAtyRk/FmKoLkFNOJCI=
X-Google-Smtp-Source: ADFU+vvnmL98O7dcgjdDEy9H3WSnL/Fo8W+ud7liM4PMa4/hQ6d/GdCnO6D18JH0fPnE4akJt710QRYrN0uxiMCyk7Y=
X-Received: by 2002:a02:4881:: with SMTP id p123mr2604324jaa.30.1585386925551;
 Sat, 28 Mar 2020 02:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200327171030.30625-1-natechancellor@gmail.com>
In-Reply-To: <20200327171030.30625-1-natechancellor@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 28 Mar 2020 12:15:14 +0300
Message-ID: <CAOQ4uxjiRcCh-dQLYu6+Gx0u7urXT=Bsbdd8erfmmzfyU3G5UA@mail.gmail.com>
Subject: Re: [PATCH -next] fanotify: Fix the checks in fanotify_fsid_equal
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 8:10 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> fs/notify/fanotify/fanotify.c:28:23: warning: self-comparison always
> evaluates to true [-Wtautological-compare]
>         return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
>                              ^
> fs/notify/fanotify/fanotify.c:28:57: warning: self-comparison always
> evaluates to true [-Wtautological-compare]
>         return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
>                                                                ^
> 2 warnings generated.
>
> The intention was clearly to compare val[0] and val[1] in the two
> different fsid structs. Fix it otherwise this function always returns
> true.
>
> Fixes: afc894c784c8 ("fanotify: Store fanotify handles differently")
> Link: https://github.com/ClangBuiltLinux/linux/issues/952
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Ouch! Good catch!

It would have been quite hard to catch this with tests as
non equal fsid and equal fid are quite rare in the wild.
I will try to write some test with mounts of cloned loop devs.

Thanks,
Amir.
