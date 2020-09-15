Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2026A0F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgIOIdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOIdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:33:53 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59527C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 01:33:53 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y2so2199588ilp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDQidqHBIFjTbMkErTBfYBQ8Di+XLbYUM7dtNp6lPlM=;
        b=iB2QUEsR0Z+QsPr2FD9w2sefAaNYWPSYSDUY7Mz+1y5VMvHmkdmB7FdoNUJheH/hmO
         JimQdXyCnM3MmZp8eKeLJeQWBhUVhTOgFJL4bRzGsgHIlzw1Fn9p2RQfqXbtVjqp7z21
         lv9Xj8ZjRr/+ByTP4/z3nT9rn1Qm2uHN/i5rMqWt2ktV7zk8ZwTm37HckG1eYtLvNIb3
         +X6B4/fhIvEZNBIc7JPgEgtQBAi2z/svJu2V5hlKgKKocpcWzV67ry/cVAkdp2CtXhYJ
         tklDLX1ZqZDGpqOgCoszNaNTFqG/Wsj+AvZvpJyZMslnSpe3WdywAYRUMhWX1M7z09Mz
         CQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDQidqHBIFjTbMkErTBfYBQ8Di+XLbYUM7dtNp6lPlM=;
        b=AgMlWhyHw15cr8dRxmJU33RZhySiyuoknFj1fRndQZKpl6V3gjr2RKpO1Gj90AgMdA
         u5uKOpH4X1cTwnlW6DSGb+pJkM4G97NfxOG1qScK22YxGMtNPVShbYP5mEfoM620Ee81
         pYSnl+C5DQ4Ml4zb176HWvjnhV1XynEfjWqW1FaY9kIe1Tlp32mX8hM+o9j9EJEqR0Zc
         Lo/Km05UlYnYBY+Cj4eaT+X3PVNY5/zFLWVe4uza7BoE7Su1rbWMWgzaGsNdSVvQIWzC
         hMN+XpLyW9qxRnhHkdmoFKgXAk4UHuOb2DlfbnqfY4vxL91MtA7kQ0UagHHSoGvu+b/w
         xlxA==
X-Gm-Message-State: AOAM5302z22nk61aU8sWGfy9Dv9b52I7DH46i4i4QIl4ByxweirqNUYh
        V/l2FW4EOoTvqN0JjAkpaJ4KPh51SFGiz/thG4zs5twHxAs=
X-Google-Smtp-Source: ABdhPJwpTcKR2TLeXqhY+9oRLbHCB8AYJ9Wlb2HJ3FgikvoMCJTBL6f3Fkxoo4UE08zf5EtcDf9XWFVXW6+twvMXRVM=
X-Received: by 2002:a92:1fd9:: with SMTP id f86mr15602706ilf.250.1600158832464;
 Tue, 15 Sep 2020 01:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172737.GA5011@192.168.3.9> <20200915070841.GF4863@quack2.suse.cz>
In-Reply-To: <20200915070841.GF4863@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 15 Sep 2020 11:33:41 +0300
Message-ID: <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
Subject: Re: [RFC PATCH] inotify: add support watch open exec event
To:     Jan Kara <jack@suse.cz>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > Now the IN_OPEN event can report all open events for a file, but it can
> > not distinguish if the file was opened for execute or read/write.
> > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > want to monitor a file was opened for execute, they can pass a more
> > precise event IN_OPEN_EXEC to inotify_add_watch.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>
> Thanks for the patch but what I'm missing is a justification for it. Is
> there any application that cannot use fanotify that needs to distinguish
> IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> specialized purposes (e.g. audit) which are generally priviledged and need
> to use fanotify anyway so I don't see this as an interesting feature for
> inotify...

That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
Last time this was discussed [2], FAN_UNPRIVILEGED did not have
feature parity with inotify, but now it mostly does, short of (AFAIK):
1. Rename cookie (*)
2. System tunables for limits

The question is - should I pursue it?

You asked about incentive to use feature parity fanotify and not intotify.
One answer is the ignored mask. It may be a useful feature to some.

But mostly, using the same interface for both priv and unpriv is convenient
for developers and it is convenient for kernel maintainers.
I'd like to be able to make the statement that inotify code is maintained in
bug fixes only mode, which has mostly been the reality for a long time.
But in order to be able to say "no reason to add IN_OPEN_EXEC", we
do need to stand behind the feature parity with intotify.

So I apologize to Weiping for hijacking his thread, but I think we should
get our plans declared before deciding on IN_OPEN_EXEC, because
whether there is a valid use case for non-priv user who needs IN_OPEN_EXEC
event is not the main issue IMO. Even if there isn't, we need an answer for
the next proposed inotify feature that does have a non-priv user use case.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_unpriv
[2] https://lore.kernel.org/linux-fsdevel/20181114135744.GB20704@quack2.suse.cz/

(*) I got an internal complaint about missing the rename cookie with
FAN_REPORT_NAME, so I had to carry a small patch internally.
The problem is not that the rename cookie is really needed, but that without
the rename cookie, events can be re-ordered across renames and that can
generate some non-deterministic event sequences.

So I am thinking of keeping the rename cookie in the kernel event just for
no-merge indication and then userspace can use object fid to match
MOVED_FROM/MOVED_TO events.
