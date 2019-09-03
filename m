Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE827A767E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfICVsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:48:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33990 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfICVsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:48:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so8395980qke.1;
        Tue, 03 Sep 2019 14:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSeacdjH5KAA63hvqQ3TjMDtSK79CrnZ88ADfY1YuBk=;
        b=VTqX9qS4xLMsnfmi7LgqloDsV8yxTDCMh/D4j4kIDQdX0rYvHrovcIg0frBYzptj5u
         UG6d8Jn/smiI5LS6VNAk41ZSUvmDhrK4ho400cWMDCrSnNbs7SSRVa64rEFU9X+xe3jh
         uOcwEmT2377giYg9IH9N8eZImDav4F8u1WeU6lNwBOS2s1ay+z9o4lo0VLMHW1qHijia
         Jq1Zgv6HLeIKwMIC1q5iMTVQsMciA985agehwZN57tlRyZhbDUw0Acqq5vq78QXHoESR
         n5o/desuwnLptOwLgftJUgaMav/Fm6OXWCfkkEPqdnP6kX2NJ0Fz9L5kg3U+GL0q0I4H
         yI4w==
X-Gm-Message-State: APjAAAW79fkYytVri2gwoXokP49e+yvTC3ca2WAA2iU/qKxWfz9x9LDJ
        XnWs3bdG7fG9B2Ngq1CfV5KILI8cfKJWLQIYORo=
X-Google-Smtp-Source: APXvYqzGKjDEhNTaKl3R14NK+vIWHogZl6KI2fkl/dkDT6OD3zO0Nzt0XMYejfSqEsJrSDvEjDRIjXOnS1JgTvyNhZE=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr36096134qkb.394.1567547310386;
 Tue, 03 Sep 2019 14:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw> <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu> <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
In-Reply-To: <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 23:48:14 +0200
Message-ID: <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 3, 2019 at 11:31 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Tue, Sep 3, 2019 at 2:18 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Tue, Sep 03, 2019 at 09:18:44AM -0700, Deepa Dinamani wrote:
> > >
> > > This prints a warning for each inode that doesn't extend limits beyond
> > > 2038. It is rate limited by the ext4_warning_inode().
> > > Looks like your filesystem has inodes that cannot be extended.
> > > We could use a different rate limit or ignore this corner case. Do the
> > > maintainers have a preference?
> >
> > We need to drop this commit (ext4: Initialize timestamps limits), or
> > at least the portion which adds the call to the EXT4_INODE_SET_XTIME
> > macro in ext4.h.
>
> As Arnd said, I think this can be fixed by warning only when the inode
> size is not uniformly 128 bytes in ext4.h. Is this an acceptable
> solution or we want to drop this warning altogether?

I think the warning as it was intended makes sense, the idea
was never to warn on every inode update for file systems that
cannot handle future dates, only to warn when we

a) try to set a future date
b) fail to do that because the space cannot be made available.

> Arnd, should I be sending a pull request again with the fix? Or, we
> drop the ext4 patch and I can send it to the maintainers directly?

I would prefer to fix it on top of the patches I already merged.

Maybe something like:

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9e3ae3be3de9..5a971d1b6d5e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -835,7 +835,9 @@ do {
                                 \
                }
         \
        else    {\
                (raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t,
(inode)->xtime.tv_sec, S32_MIN, S32_MAX));    \
-               ext4_warning_inode(inode, "inode does not support
timestamps beyond 2038"); \
+               if (((inode)->xtime.tv_sec != (raw_inode)->xtime) &&     \
+                   ((inode)->i_sb->s_time_max > S32_MAX))
         \
+                       ext4_warning_inode(inode, "inode does not
support timestamps beyond 2038"); \
        } \
 } while (0)

> > In cases where the inode size is such that there is no chance at all
> > to support timestamps beyond 2038, a single warning at mount time, or
> > maybe a warning at mkfs time might be acceptable.  But there's no
> > point printing a warning time each time we set a timestamp on such a
> > file system.  It's not going to change, and past a certain point, we
> > need to trust that people who are using 128 byte inodes did so knowing
> > what the tradeoffs might be.  After all, it is *not* the default.
>
> We have a single mount time warning already in place here. I did not
> realize some people actually chose to use 128 byte inodes on purpose.

This is also new to me, as I always assumed a normal ext4 would be y2038
safe. I suspect that a few of those users are unaware of the y2038
problem they might run into because of that, but that's what the mount-time
warning should help with.

However, I did expect that people might have legacy ext3 file system
images that they mount, and printing a warning for each write would
also be wrong for those.

      Arnd
