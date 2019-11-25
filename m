Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8410923A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfKYQzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 11:55:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34461 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfKYQzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:55:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id l28so11632143lfj.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+SujjJtPRTCRXpnBKbsbJY3R6CV+TyFB1NlWtqVos8=;
        b=M9u7Tvt6v8tqt01XClmVMlNXZ3raof6ajbhoE82B2spJqe2uZjt6YF/AKtYmUTN0Vm
         l3hLRhYlt0dTVwNIV3qIW1akPXeAfXfy6Nb44Y/L3wJyTgLYMBYDx0UJVtrNR5IXFbUr
         gT/zhZdOZXnkDo8PIgXKNyYmBH1iwnyF/aoyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+SujjJtPRTCRXpnBKbsbJY3R6CV+TyFB1NlWtqVos8=;
        b=NgMMDRkxwX5RJ55rimi9P86cyAXDcup0idusCUcclczAv8HbeHNlxezr8hrKx2vkb1
         lV859Qskc79kBdqqFFuKUUr1bLVkSPj3zEIarZKV2PQhqVrnf8dqLEf7IcdCPrdVKZd9
         8ZokaBuCqIeQ5waODUMjF9fdMnsVPNod+UF6wkT+earUOijuZmM0iOJPDaAsJoVAv5OR
         sWsV9ZreZbdCbwq4erbgeQFxbH6Nlx07yV8nrkn+1So+T+AdZv+k25/pyHN7mEblbMVu
         Lz6iwkB86kk2Frd0aazS6+C39KCCpAqIsbrSHHc0COayeo5SQWPSJdOvKzm8p3vsEnJV
         cU5g==
X-Gm-Message-State: APjAAAWPSrOtJcN+WejeX5t/3i6MVaRFXsmSheH2jRYTyoQaE0IE1/ZE
        whbzjdmk0rl+T6Jf4E9J4IoelIXzILE=
X-Google-Smtp-Source: APXvYqwk0oSGTTvUPsQEseNR0fOpGLJhdVNVjWGrymiP+ucdtCf8zxKkwA9bpPmic42J2a6pf5Yw2g==
X-Received: by 2002:a19:751a:: with SMTP id y26mr22181190lfe.78.1574700936697;
        Mon, 25 Nov 2019 08:55:36 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e2sm4260813ljp.48.2019.11.25.08.55.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:55:35 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id j6so7708149lja.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 08:55:35 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr9583217ljj.97.1574700935291;
 Mon, 25 Nov 2019 08:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20191125151214.6514-1-hubcap@kernel.org>
In-Reply-To: <20191125151214.6514-1-hubcap@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 08:55:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh41K2RqeqrkQ4fPHuw9Cc1kwGkXqwp69c29gWeBUCkMA@mail.gmail.com>
Message-ID: <CAHk-=wh41K2RqeqrkQ4fPHuw9Cc1kwGkXqwp69c29gWeBUCkMA@mail.gmail.com>
Subject: Re: [PATCH V2] orangefs: posix open permission checking
To:     hubcap@kernel.org
Cc:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 7:12 AM <hubcap@kernel.org> wrote:
>
> @@ -90,6 +90,8 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
>                 new_op->upcall.uid = from_kuid(&init_user_ns, wr->uid);
>                 new_op->upcall.gid = from_kgid(&init_user_ns, wr->gid);
>         }
> +       if (new_op->upcall.uid && (ORANGEFS_I(inode)->opened))
> +               new_op->upcall.uid = 0;

You still can't do this.

You can't make it part of the inode state, because the inode is shared
across different file descriptors. So you are giving a potentially
different file descriptor (that really was opened just for reading)
the magical override.

What you *should* do is to always use the credentials at open time,
and the "can I read or write this" from open time.

And regardless of whether you have your own open routine or not, those
are always available as "file->f_mode & FMODE_WRITE" and
"file->f_cred".

If you use those - and pretty much *ONLY* if you use those - you will
get things right.

             Linus
