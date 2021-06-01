Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4A397564
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhFAO13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAO12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:27:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6CFC061574;
        Tue,  1 Jun 2021 07:25:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a4so19505108ljd.5;
        Tue, 01 Jun 2021 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXwBkVh1KOdsr+KAjML5tZJwuUk3Uy21Fq6dGjEOiZg=;
        b=Q9h+LrKoylLZsYtEqjwuS7hFLOYHLqI83SIMLRl66myPHKPdiPcOii2nrW2kSlp4K1
         Y9A2HHJsq6eiBpN+Epthp+aUCN/vBJP5VujK3mRyG/yC1UM8wxLl00mLfN91OQ6AARAH
         x8v8EVwLyJXY6YGxb1N7VsQ2AVK13TNmSOtHNmmgOtTCcsTvu7zrHJVy+YaZ5ieUYO3k
         DFMFCvU29ku+uwmXi5DOgniPOxPC/QaXS0hBpXuDgasJcqjrV4U9AmMqfmHNrvbN6Txs
         V/GptEVfgPGLm1pBnh/WTBJzgpzO5aJK3Cc/DIBMXn0asjYlo6KMwoMlkBnBBV1BStx3
         Z9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXwBkVh1KOdsr+KAjML5tZJwuUk3Uy21Fq6dGjEOiZg=;
        b=fVp2eOvgubEiHTGS3rBlCiKwEquCZlyTB/XijedDXSSbLv+mCrqtrCgZ0aMd5ogm/3
         n5glTd/3P7S00p9Ydf4rixBYAzARM2ix4aLr0I/sxWRNTj00tDiAACUNHZUwV+WNiEEW
         6Fp+SKEHn7xn4VD89+0B4wM+riCdMYmLVaqt+TZG0+4Nl/3KojvreDB6PkcgQ9TRlSvn
         5jxlahkwI57gS3qk0hg3RkFSpKr7ds/nlgX+DdHBoUIDtnKrr+/qJ4QyZKp6uuVw7FBF
         +pQ9PqRBXEx4K/WFE5hZmkteiALFkRUMVwf4LC+ATZ3/Ic0CkQAfVlRCLTUNDLHeMNS4
         GixQ==
X-Gm-Message-State: AOAM533P4hmRP+yTb0vzeIfy9DlFlSDoth2f5+mYpLIW8c8Yi/MrQriD
        NyY5fp4NTe/iOI/dOokBj/tbJAfXABa2Le3zc3U=
X-Google-Smtp-Source: ABdhPJxfuuOlYn8u/cUjN4OxD9jt/ci6zN92sBMLK2ZQiBgNE2BKtsq27R7REJZREeESz1DH0pLFFUzjTJLEzYzdwA8=
X-Received: by 2002:a2e:7f16:: with SMTP id a22mr21877791ljd.360.1622557544705;
 Tue, 01 Jun 2021 07:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
 <20210529112638.b3a9ec5475ca8e4f51648ff0@kernel.org> <CADxym3Ya3Jv_tUMJyq+ymd8m1_S-KezqNDfsLtMcJCXtDytBzA@mail.gmail.com>
 <YLY+MNDgCT89hwQg@casper.infradead.org>
In-Reply-To: <YLY+MNDgCT89hwQg@casper.infradead.org>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 1 Jun 2021 22:25:33 +0800
Message-ID: <CADxym3YKdkRTMKVFbPjD0xLFL4tn20PK7gA6gDd7BQUK8+kQxQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] init/initramfs.c: make initramfs support pivot_root
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, joe@perches.com,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        hare@suse.de, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, jojing64@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, mingo@kernel.org,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 1, 2021 at 10:03 PM Matthew Wilcox <willy@infradead.org> wrote:
[...]

>
> You sent this on Friday.  Monday was a holiday in the USA.  Generally
> you should wait a week before pinging a patch.

Ok, get it! I'll keep it in mind this time :/

Thanks!
Menglong Dong
