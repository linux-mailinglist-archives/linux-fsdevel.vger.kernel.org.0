Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD857101114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 03:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfKSCCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 21:02:45 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36304 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSCCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:02:45 -0500
Received: by mail-ed1-f49.google.com with SMTP id f7so15661035edq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 18:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WMZG768ZhPxp5SvLqgbAZTewkvSghGpHsE7xRXqZJsw=;
        b=C4r1jgmlBChBRQsPKbKtl9GXzgTx5be5KDKZYn4xsql1OQ0nccaGxaDnGKRp2LQMQy
         QU4EMMDv/YEsXcLVvmHxN/D455ihth6pEODaKrU4kcZSPVgCz1kghWKUPBJjVi1MmCt6
         9ZdArSU9fL04gTAQJfojiYX+dNHEAdQmzZmUvyX5s6xdAxw0XEGQFQMuVZ/uUW7//Ege
         fNG6+vEaKhr8e5k4jPJUSbplzD5n1xTtAAX7rpODLTlcOV1ZvSP1bya4duDyF8gSmnvL
         LuJosr8qeLB+ubZ68MkRrFQMeYGBux7KOJI41rPfHH2TYJQypn7bQvJxDLRTeFPO6Ynl
         ph0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WMZG768ZhPxp5SvLqgbAZTewkvSghGpHsE7xRXqZJsw=;
        b=Wv2kDQV/AfY4WNjRP/i9hC+CPxng3hs9Md7VKN8nmoBy5oW/8AuTQeO/4/KCOwKkni
         BVeft0PRW8HNhUEwCXJF4m57UW/2t0XRMbf0QXxqN+0RJdC2amcDujOK45EQxXN43mhO
         TzXc79fq5DY1A26aFpjJzbOuBEE2EhL2ZidGrJGd40x67v8VsTrQslzffJuxAB0rP9a8
         9QUVQrLXvfMLZYZCkZmyZmCW4EvXyRBtx2wCgxvmlko69PLn/S6gjh0bKVNY38e8jGzd
         vf0LMWg+t54I9L8ZetQKa7XPpqXf7UVsYD5wLeaPwj0PCdJDENwEj19ZyDGKfyFEk9L+
         pQWQ==
X-Gm-Message-State: APjAAAXJhgbjNJvM70DyJzSdBj2/O00DI30ahX1H4QK88NYuUeCKWOiE
        ez2z3Vz3EH+K+5+yfyXo/zpTle7cDymo/uNB0IyuK1lK
X-Google-Smtp-Source: APXvYqxUD0+FlKDhnGiRmjYynuNXNKLeBlNmFJ/GY339mP73p0c6hvqq5fjz1qV43L746MC/x7Xo82mWASBgvgCO47Q=
X-Received: by 2002:a17:906:f119:: with SMTP id gv25mr775665ejb.164.1574128962030;
 Mon, 18 Nov 2019 18:02:42 -0800 (PST)
MIME-Version: 1.0
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Mon, 18 Nov 2019 21:02:31 -0500
Message-ID: <CAAwBoOKor7qvLs0OaXQ0-CLUpCssukdkfamTQN5c6OQiD2vY3w@mail.gmail.com>
Subject: Possible data race on file->f_mode between __fget() and generic_fadvise()
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi VFS developers,

There might exists cases where file->f_mode may race in __fget() and
generic_fadvise().

[Setup]
mkdir(dir_foo, 0777) = 0;
open(dir_foo, 0x10000, 0777) = 3;
dup2(3, 199) = 199;

[Thread 1]: mkdirat(199, dir_foo, 0576) = 0;
[Thread 2]: fadvise64(3, 140517292505364, 155, 0x2) = 0;

[Thread 1: SYS_mkdirat]
__do_sys_mkdirat
  do_mkdirat
    user_path_create
      filename_create
        filename_parentat
          path_parentat
            path_init
              fdget_raw
                __fdget_raw
                  __fget_light
                    __fget
                      [READ] if (file->f_mode & mask)

[Thread 2: SYS_fadvise64]
__do_sys_fadvise64
  ksys_fadvise64_64
    vfs_fadvise
      generic_fadvise
        [WRITE] file->f_mode &= ~FMODE_RANDOM;

However, in this particular case, there is no issues caused as the
mask passed in __fget() is always 0 and hence, does not matter what
the [WRITE] statement is doing.

But just in case there may be other cases where the mask is not 0, it
may leads to weird situations and I am posting this issue here for
more visibility. Feel free to comment on its validity.

Best Regards,
Meng
