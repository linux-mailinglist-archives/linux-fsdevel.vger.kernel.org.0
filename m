Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB847C766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 20:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhLUTS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbhLUTS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:18:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2CC06173F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 11:18:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z29so55885684edl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRiTz8bhQursjP/dTzeG8mCouhMPco8A9ASNz/ffLTk=;
        b=B8V5Wn6N6Zse7OjKgFG0n1vPlbpGwU+uTTSxI53sbD/engpJYQQ4L9W3yCr8LhIIxS
         KhnF3JbhL7ny3lPBoneIi8nvGgIq3g3rISma8RwYPOJEAlrY2Sn9/sl38eWZFfo3EqVM
         4/Opuv9RuJ2bZNzx4/YlvodiF9NjGzi3dwv5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRiTz8bhQursjP/dTzeG8mCouhMPco8A9ASNz/ffLTk=;
        b=EFIFLi6mtinVpkOb99wOQHdDpgbOn7V7JbqjoOovamTTnZkaulSf3kJkD9s1z1j+jh
         uE+XVd/neNd4nIdkJlnSyE9+5R4zrbHToIRiOB0SiTWWUcEVlN+6qtnAzg1nEcBLv5Xt
         cOmgagYBwew6D+oXK14ygE7+dkYeCEo/7GcGfELiEo5n7yT3l8xSjdi/6MwyyoXDvAMT
         fQGQC5Mgfg88xIR3VqAbkWi2tN1darE7zMliCtKam+5UE7xgZIwCFGiW3aJr9lygG7IB
         2kCPNeroZ0k9Wrae0Nai6SftSaEHWnor/f21pCAOO2+KET1RKOY1YqyB7sqXUlD/SCLf
         5BeQ==
X-Gm-Message-State: AOAM532DbZokMTt5Xv7Xq9GGrCZEC1dHzFPmCd70GdnGwiOpDlmR5vVF
        VLhsG+gp314OR+x0yk+aAe9DImJb3AntD0lrZNU=
X-Google-Smtp-Source: ABdhPJxsmV1xEVDrVYcKhflFGIefIDUibDlBiBY829BtFS7+08NLNhpIIf1ngj3HvdPg4+UsWW1iug==
X-Received: by 2002:a17:907:20f9:: with SMTP id rh25mr3885447ejb.209.1640114304380;
        Tue, 21 Dec 2021 11:18:24 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id p4sm6816812eju.98.2021.12.21.11.18.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 11:18:24 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso2405779wmc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 11:18:23 -0800 (PST)
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr4001998wmb.152.1640114303620;
 Tue, 21 Dec 2021 11:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20211221164959.174480-1-shr@fb.com> <20211221164959.174480-4-shr@fb.com>
 <CAHk-=whChmLy02-degmLFC9sgwpdgmF=XoAjeF1bTdHcEc8bdQ@mail.gmail.com> <a30eda4f-ebf2-5e46-d980-cd9d46d83e60@fb.com>
In-Reply-To: <a30eda4f-ebf2-5e46-d980-cd9d46d83e60@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 11:18:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqUaF=Vj9f44m7SNxhANwoTCnukm6+HqWnbhhr2KHRsg@mail.gmail.com>
Message-ID: <CAHk-=wjqUaF=Vj9f44m7SNxhANwoTCnukm6+HqWnbhhr2KHRsg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] fs: split off do_getxattr from getxattr
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:15 AM Stefan Roesch <shr@fb.com> wrote:
>
> Linus, if we remove the constness, then we either need to cast away the constness (the system call
> is defined as const) or change the definition of the system call.

You could also do it as

        union {
                const void __user *setxattr_value;
                void __user *getxattr_value;
        };

if you wanted to..

                 Linus
