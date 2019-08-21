Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0AE973EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfHUHvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:51:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHUHvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:51:31 -0400
Received: by mail-io1-f65.google.com with SMTP id t3so2649631ioj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZvfNhyGscpkSZ3ArnN1Kn2Ohroj07E84u704Jirwf8=;
        b=CocCV7FT+vvRNv2WTAn65V30KzegW/8Wk/kvkKfN55wq3gpMeRFTLjdgzO8aZVdbwD
         jFD8DaMSQgqlXLPddVzX1pno2H45JX0LyiqJjxvBzVrBJgSSHJ1455S8XTeosJnFgsaw
         QQ3Iut++Ff0sTuIcBgiQSVw04Wzblj08sFkPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZvfNhyGscpkSZ3ArnN1Kn2Ohroj07E84u704Jirwf8=;
        b=QcPCJ3Ck5zbzp3pRQN45LWEJSDPr6sal6pEyN3vZjScbqq/10aV3nYcXiSsj72ecZy
         uSOy8YdHhLnG93a32wSbF1nbUILxKcMI4Yc1+8HsIKn6/8Dt1hizBfC5kjI+nTy/a7Jy
         hWY6VfxZrmhs0IaAnIFOHGIAENQuYc2XIaVkBDX44u3l92fSKzUFJHtx5+KHaRsL/dH4
         kcdcsaV8layRVrCN/udNkJ79WNRlN5x13P/WrkHNM+1D+uCT1QP7xFTInm0XTmZ34Owt
         Zt/fTK5AzWZaYOlSl+Vg6WKLklXOgIUC0IgNbRbZAQBpqDzF1ip5OE+kdMlYp/7yFmJz
         5UtA==
X-Gm-Message-State: APjAAAXTdAquHcXLZYj2qTxmrIicWsffkPoxlqVQzPiNhgfBM4eCLMKb
        o+US0SRJqslJJEUSlDJfSJYrNjwXTAHaBWI1TtFfe1Nu
X-Google-Smtp-Source: APXvYqxIBEZzhbqmo1u7Ovv1/N2hg3ZqG+QUyRqFNtOA2g9qKP9yymn/n+xuXEYRrzWSrQD1eljjKY/Wq0O4lN+YFck=
X-Received: by 2002:a02:b713:: with SMTP id g19mr8558235jam.77.1566373890871;
 Wed, 21 Aug 2019 00:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com> <20190820091650.GE9855@stefanha-x1.localdomain>
In-Reply-To: <20190820091650.GE9855@stefanha-x1.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Aug 2019 09:51:20 +0200
Message-ID: <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     wangyan <wangyan122@huawei.com>, linux-fsdevel@vger.kernel.org,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 11:16 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Aug 15, 2019 at 08:30:43AM +0800, wangyan wrote:
> > Hi all,
> >
> > I met a performance problem when I tested buffer write compared with 9p.
>
> CCing Miklos, FUSE maintainer, since this is mostly a FUSE file system
> writeback question.

This is expected.   FUSE contains lots of complexity in the buffered
write path related to preventing DoS caused by the userspace server.

This added complexity, which causes the performance issue, could be
disabled in virtio-fs, since the server lives on a different kernel
than the filesystem.

I'll do a patch..

Thanks,
Miklos
