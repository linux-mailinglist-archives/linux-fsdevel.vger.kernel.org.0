Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2129345A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 07:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391717AbgJTFoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 01:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391703AbgJTFoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 01:44:24 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05BC061755;
        Mon, 19 Oct 2020 22:44:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o70so894397ybc.1;
        Mon, 19 Oct 2020 22:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BrPJPcLie++WhcFG2H6liSuPBGZKeNigUGtzRTI/244=;
        b=lgsM8xurft2PeQBmM0bXST/PHIzkLfyJzfVC2J/Baqf2giPSofgO0I3NPl8zadDNF8
         qvtZWw+x33r/fVDozjAwl1sgQPb+MEbTLFyGTojUlMFGy4KikSw0Vn0l3oLZqtTf9T9g
         TvHU5DZ07pj8yOhhBDeWKjCtY+e5TY4p5A1ZBv97Ie7HYhfJbVUg3TGIb4kYA8Xu39V0
         0cuyum9vQ3OLa6phAviALnHsfl5nzpm2t6DjqzASbObyYpkgYSvN0b0znYev800diQhv
         RgdNSojh1xjfu+0MlQVgCVK3kkrAYy4yReA6sLZDLw15TgGxsQbT1PEY0HzpW8SNqEFS
         zSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BrPJPcLie++WhcFG2H6liSuPBGZKeNigUGtzRTI/244=;
        b=An25/KpIK71zs85ideqH1Chmm6lcO+NXY8vxtcexc3o9YO3LH+OMBbVo7t3hvu5Txh
         7srhJGrC9Uxsd5wxdPD6i72F/F8SehMtgipNSGhJz8tQJyabfmKGQ40NqDWh0rcx6t0Q
         yf+B6mib0NEsOQSsnqIjQDhlkuRK8T17wAI12o5DYrupJBANLLAYEVd7JtwK/ud/JdgN
         npxCllI1JGEm3YIaWGzyovpah+9XQgLmwa0p+Mur81hB30kFVb+/d43Ypk9CECt+caj8
         Qpz6XLhmV2qjzshhj3WkS5Bu+8RykeVWDBtG4gpepS2hjB+jEhtY7POPQa+up5gvRqRU
         Cf/A==
X-Gm-Message-State: AOAM531DkmdyvJDNFx3FP6xu9MOO9HZfBNpFcQtGRp/4yQqIn3ugriFC
        XC8begcDG4EkFPUwoVAgRN61k77bpW3gp6vOENc1s+tvyFWwEDXx
X-Google-Smtp-Source: ABdhPJx29RYpK9uWsjh8gcTS/j686QWbo7DuI0iW4upE8nyE/Za+1AdFUgwanp5KqbJ2BYCFKd4ibFh9kL233d9VTAA=
X-Received: by 2002:a25:7c5:: with SMTP id 188mr1805300ybh.131.1603172662222;
 Mon, 19 Oct 2020 22:44:22 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 20 Oct 2020 11:14:11 +0530
Message-ID: <CANT5p=pwCHvNbQSqQpH3rdp39ESCXMfxnh9wWrqMaSk9xkdq1g@mail.gmail.com>
Subject: Linux-cifs readdir behaviour when dir modified
To:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I spent some time in debugging this issue today:
https://gitlab.alpinelinux.org/alpine/aports/-/issues/10960

A summary of the issue:
With alpine linux containers (which uses the musl implementation of
libc), the "rm -Rf" command could fail depending upon the dir size.
The Linux cifs client filesystem behaviour is compared against ext4
behaviour.

What I saw while debugging (some of which is already covered in the
bug and related bugs):
1. The musl libc sends down small buffers as a part of it's readdir
implementation. These buffers are very small compared to it's glibc
counterpart.
2. cifs.ko is reading the whole directory from the server, but is only
able to fill the readdir results in small portions due to the bufsize
sent by the libc.
3. The libc does unlink of the dirents that have been returned so far.
4. The libc continues the readdir from the prev offset, expecting to
continue the listing.
5. cifs.ko now sees that the directory has changed, and fetches the
directory contents from the server again. However, the reply to the
user is populated from the prev offset, so directory listing does not
return files from the new beginning.
6. As a result, the final rmdir (which assumes that the directory is
now empty) fails.

Out of curiosity, I checked the ext4 code to understand the handling
of this use case, and I see this comment:
        /* If the dir block has changed since the last call to
                                        * readdir(2), then we might be
pointing to an invalid                                               *
dirent right now.  Scan from the start of the block
                             * to make sure. */
... and the corresponding code.

Now the question is whether cifs.ko is doing anything wrong?
@Steve French pointed me to this readdir documentation:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir_r.html

If a file is removed from or added to the directory after the most
recent call to opendir() or rewinddir(), whether a subsequent call to
readdir() returns an entry for that file is unspecified.

So I guess the documents don't specify the behaviour in this case.

We could go the ext4 way and reset the offset to 0 when we detect that
the directory has been modified. That would handle the "rm -Rf" use
case as expected by the user here. However, we could end up repeating
dirents over successive readdir calls.

Posting the question to the larger group, to see if it's worth the
effort to make this change. The change here seems quite simple, which
is to reset file->pos to 0, when we detect that the dir has changed.
But since it'll result in change in behaviour, I wanted to check
first.

-- 
-Shyam
