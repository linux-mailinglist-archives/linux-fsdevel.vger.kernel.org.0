Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322B26181C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 00:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfGGWlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 18:41:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43013 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGGWlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:41:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so13936668ljv.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jul 2019 15:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcsLGMUFQAhJlOvMra+sDFTnfJhyurYZj32MYfKitAE=;
        b=d1zDU5FEtUUjct83eyU6qfw3BEHwcpclDyV7DCNUYSglTpf1MCajLuQoKGKi4jJVVS
         dYxWNlNhJM/pVgTqRYTsXVbEPAK3/A0UYNj8BhpeLmjA3O2f50q/ZhmZ4AVjPA7HJm9w
         Lxic1Zrh0kVkBYTgX7gtZybpTIW/Tx2J0/wRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcsLGMUFQAhJlOvMra+sDFTnfJhyurYZj32MYfKitAE=;
        b=qWYPZCln6FJvTGUD+GzvLNIHGdnvfxKIp8HtvDrb7brXEgyS3yOcbHD46Kp3quoXt7
         xkFBFrsVM20vszBGujd8oSuSClEEs33X23LaQk+PmVkJWs9uQob9bCzBj5O9yQ3UT3ve
         T4NfVDhPRDqfQVQiCsi76+r69V+49umR+b8aPa1orGipomigOeP62e0fm1bFHAhVxYDf
         51Dxubrx3cxudouqtYz/Ufl4E6UyJl++1Ye9vKCBIy1RSuT2GA507hlndQMg08G7Z6QH
         rh02Aea7IAoJ2LYxzWB7iAMnwtu/DRR0OHuztKLQJVbi7DSeNB3l+yirs+Yg3lvAqz1F
         fHfA==
X-Gm-Message-State: APjAAAULVFyrfzphqPytbyXCxCNLtS+LmwsEeSuoHxPN2xcdxEKp7B82
        pDl74LpePW29eOGcuUh1lw5XC3zOSoU=
X-Google-Smtp-Source: APXvYqzT5M1HWOGh/o4ApHlsQ08YxV7NAlrhDv5gSll31ZVzmE9rhlHupcU0Xbww4vm5nO1XvYtfvA==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr8438385lja.230.1562539307805;
        Sun, 07 Jul 2019 15:41:47 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y5sm3222068ljj.5.2019.07.07.15.41.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:41:47 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id b17so5971097lff.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jul 2019 15:41:46 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr7060354lfm.170.1562539306171;
 Sun, 07 Jul 2019 15:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190706001612.GM17978@ZenIV.linux.org.uk> <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
 <20190706002236.26113-4-viro@ZenIV.linux.org.uk> <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
 <20190707214042.GS17978@ZenIV.linux.org.uk>
In-Reply-To: <20190707214042.GS17978@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jul 2019 15:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=iuSja-aib7z4bgivbJWuVcKf1Yd8Cdx-2nos3Fnmqw@mail.gmail.com>
Message-ID: <CAHk-=wh=iuSja-aib7z4bgivbJWuVcKf1Yd8Cdx-2nos3Fnmqw@mail.gmail.com>
Subject: Re: [PATCH 4/6] make struct mountpoint bear the dentry reference to
 mountpoint, not struct mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 7, 2019 at 2:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It is namespace_sem.  Of all put_mountpoint() callers only the one
> from mntput_no_expire() (disposing of stuck MNT_LOCKed children)
> is not under namespace_sem;
>
>                 list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
> -                       umount_mnt(p);
> +                       umount_mnt(p, &list);
>                 }
> in mntput_no_expire() passes a local list to umount_mnt() (which passes it
> to put_mountpoint()).

Ahh. Ok. This would be better with a comment. Maybe a separate helper
function with that comment and the special case of passing in NULL (or
maybe not pass in NULL at all, but pass in ex_mountpoints?).

Different locking requirements depending on argument values is very
confusing and easily overlooked..

                Linus
