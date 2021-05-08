Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39079377472
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEHWtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhEHWtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 18:49:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0DC06175F
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 May 2021 15:48:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so19050869ejj.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 May 2021 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kA/KDUDO096vq2rEKxFXAZivI52axFruzSdRkQyvoI=;
        b=PWRMIeUKO0nmSZhexye/3YzAUVpInwAh7XXlaTHnWhlKIAuWvggExHJgbfmaYh9nR0
         DRNpc5CAKtPEke/TFa5iaD4eYxQPerPxY17lVXLaNXY4SEls6TLdUjya9c5Rt62dxKkG
         IgPGuzEDzfaGsPkyXdCfqJY1xki5yy39Ae+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kA/KDUDO096vq2rEKxFXAZivI52axFruzSdRkQyvoI=;
        b=ZwHeutNQy1FGI9rbMB689sCqX/J/KJKljwTK920afegiS4Ookq4hrYsVcm8nF12AZq
         E+g4ju3FtsK5Dqs3NN0Q7XpxnghfLi1099xqVdqKMVYq0e1Mo2VTGCi8tPaHH5wBvlkX
         BY0s9aRwtRjNYQqb6S8Q45xsz/CnXO8YelHGdZ2NL8keaxOQNtaWPQ3ry3kRx2YMfqjD
         uPe+pl32qAxlaRN3X7JuG1czia8t9MNOwBz39E69dEE8VXuwIDY2emmmFtdBbf9SPw+8
         Frxqotu8kwbVHzt11fopgRDfF8CBJNpVRCrnmROOu/3PElR0RNbOF6X02k4Q8J1vdvLP
         Dekw==
X-Gm-Message-State: AOAM530Jfxo7UctcQrnzp2l97oJ6EAZiLgTgoMmz5imEfEJmQSC8ippo
        IlwU+8DsRf9Rui0/x6nJJM8+O2fUGtOymDW2Kok=
X-Google-Smtp-Source: ABdhPJyjCX7zhLz9xqVorLkPLXlcC7Is9rTkvyk8F55v49eHHt/c5anSqRHwKIli0BtlnTAgdau46w==
X-Received: by 2002:a17:906:e4a:: with SMTP id q10mr17261286eji.511.1620514125516;
        Sat, 08 May 2021 15:48:45 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id mp36sm5738554ejc.48.2021.05.08.15.48.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:48:45 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id z6so12781605wrm.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 May 2021 15:48:45 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr10896192lfr.201.1620514114222;
 Sat, 08 May 2021 15:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
 <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
In-Reply-To: <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:48:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbaLFNU3448HhUX7AZB1xxqTg=A8PLbzazQxR_ukyJsw@mail.gmail.com>
Message-ID: <CAHk-=wgbaLFNU3448HhUX7AZB1xxqTg=A8PLbzazQxR_ukyJsw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 8, 2021 at 3:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> static inline struct mount *real_mount(struct vfsmount *mnt)
> {
>         return container_of(mnt, struct mount, mnt);

Too subtle for me indeed.

           Linus
