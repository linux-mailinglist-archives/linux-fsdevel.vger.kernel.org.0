Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714A311C617
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 07:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfLLGs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 01:48:27 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37203 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfLLGs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:48:27 -0500
Received: by mail-qv1-f67.google.com with SMTP id t7so537205qve.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 22:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/XhX5NzcvEoOOnkZuU0KzcpbNbDGhiztc4BYOKv1pc=;
        b=W8a5puXSTn78e997N/WbywrV9HzxTNN48CaQq/nMaQo8EC1O6RaIUH7Z2R/Rx4DFea
         +9+4Mn/Lez5iZuAJBpEyKEZKRIvFno/cm68LFuPqjf4Gf3TxrypeZg0bIwgdUnCTP5Ps
         1kdt3Dlj5oHglt9HaGhikpcPt07F+wikZRQg6gNwIafnDE3XLc1pyRLuXYWkA2Y2O3et
         9AUvzRTqkrTBG4YmYg1OVzbr/lidRJxsnvge3gaI3CUg2g6COxGhzAVwy5EewnJXmgfz
         foZe/mJBfXuQ/xJBo3289VhbbtSqNej7uyVfhK5QAiQ9kAgYNneFQ/M1u44bOCfdyYKJ
         SK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/XhX5NzcvEoOOnkZuU0KzcpbNbDGhiztc4BYOKv1pc=;
        b=ojEhDcj+nml/Ralr/ooKoSS/qtiDwYV6wZwysT01bru3ZXrQ2C3ft4YDxhqeLsPyDl
         AG7KJn1iRIyvmDkiEEWc0gwjw3qlxIJgXNFl7CtYUhrfPhtCh+gZVdF8MZ48+h0m1YJA
         pMQMoyqYcJvJMjy63o310G+0wEnl+xph5vY/mxBl0EJY635CeRk7iyU9EjiaUD0ETR8v
         5K/KCfN5XiTlCSMN6dDFMPap9MtkjjaKRxpynU3rkQyZhj7tkZsV6JdFF9ZjAfO7uGAh
         z1QuBa0od4C2thKdk4k9fvBNxYZtdOylmCOmeDEgkHiVoT6Pnv8RIy+G8zIrGaH8l552
         QShw==
X-Gm-Message-State: APjAAAVQjumlwTk2cGhygfCl0OUyDzdtdIM/4Y3heIwkSJiva+JQ/yL9
        c8yoB6uvaEvmfeggCM+2gcwqYJZz71zLQzKU8hsW0A==
X-Google-Smtp-Source: APXvYqz+ymPgrYPG6VbW7FtqHH2A24a32WrafGaZ38e33Km9RkFZ84nzJrkBPEw1++1pLsKDLNm7dycU7dWPBtE3Bzw=
X-Received: by 2002:ad4:4b21:: with SMTP id s1mr6798204qvw.34.1576133305639;
 Wed, 11 Dec 2019 22:48:25 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b6b03205997b71cf@google.com> <20191212061206.GE4203@ZenIV.linux.org.uk>
In-Reply-To: <20191212061206.GE4203@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Dec 2019 07:48:14 +0100
Message-ID: <CACT4Y+YJuV8EGSx8K_5Qd0f+fUz8MHb1awyJ78Jf8zrNmKokrA@mail.gmail.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 7:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Dec 11, 2019 at 09:59:11PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    938f49c8 Add linux-next specific files for 20191211
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=150eba1ee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
> > dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com
>
> Already fixed in a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672

This commit was in the tested tree already as far as I can see.
