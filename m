Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67747C4C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbhLURPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 12:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbhLURPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:15:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C0C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:15:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y22so54887493edq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0NH9maniglx0SF/wKf0I3ioVnyY1MiBpV/YgH0N7P8=;
        b=Yaa7g3Zef1Oq1YixxCcEUFRq7kdXZwvcbZkJvP3zY5/RM3j8EXC2mEAIfM1uPPFVrk
         LyNYYIZjMOdR+NAUMpd6QrykLWYz4FbQtkJXyrK42GDXTPjtN67hnRCk1nSj+/VVndsm
         YqscC3t7F8SCnkPYUWJxmfew3IxRArtNpSpNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0NH9maniglx0SF/wKf0I3ioVnyY1MiBpV/YgH0N7P8=;
        b=tzMcC6s2axCOa3sZhS9/yxrTacKYMQSOfQN9EPJ8JuED/HGh/Fhr1gUFNs5Bi5FsJg
         z6DDaN/l9pgam73sPDYfq8FW/Q9dHwpStTahFLMIzHxMD8eJD/jGWe0/m3XB+lxBQ0sM
         TGWdnJPL9X3COStyjcvm0iS1MyMWajz7qA8DPaB3L6aMX/dluEj8MjSet35eqv4M7Jm9
         zfsPAuKWwPHBHlxjE0wZXwaLdTk5YLFBkq4a75vGADcxQxf7MyLr8Uc/FuuuHkzhQjdG
         z8vSRglwUGZBwvUuNsRMksIs1jF8KP5WXLErJ8AIcm3Bg2B52klCfxE+3Tl66zA+l5No
         APlA==
X-Gm-Message-State: AOAM5339TQhTzTxHgkAoh2ADxixyKc3ShGB2sZztw5Qquytuo+Tt8gpG
        bx42T1jNIm7hDsmIxpw9bEHWYX8gUVRAc2Z3qCg=
X-Google-Smtp-Source: ABdhPJwwFXCNaKXim/IbXd4GmX4I9uDlmZ/imH6VTTbhI/RZsjFXKrZcQ7My9W8GdGq9sZwfr+WsfA==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr4271076edr.205.1640106941279;
        Tue, 21 Dec 2021 09:15:41 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id f22sm8778159edf.93.2021.12.21.09.15.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:15:41 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 203-20020a1c01d4000000b00345bf98da86so951480wmb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:15:40 -0800 (PST)
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr3605133wmb.152.1640106940746;
 Tue, 21 Dec 2021 09:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20211221164004.119663-1-shr@fb.com>
In-Reply-To: <20211221164004.119663-1-shr@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 09:15:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHC_niLQqhmJRPTDULF7K9n8XRDfHV=SCOWvCPugUv5Q@mail.gmail.com>
Message-ID: <CAHk-=wgHC_niLQqhmJRPTDULF7K9n8XRDfHV=SCOWvCPugUv5Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] io_uring: add getdents64 support
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 8:40 AM Stefan Roesch <shr@fb.com> wrote:
>
> This series adds support for getdents64 in liburing. The intent is to
> provide a more complete I/O interface for io_uring.

Ack, this series looks much more natural to me now.

I think some of the callers of "iterate_dir()" could probably be
cleaned up with the added argument, but for this series I prefer that
mindless approach of just doing "&(arg1)->f_pos" as the third argument
that is clearly a no-op.

So the end result is perhaps not as beautiful as it could be, but I
think the patch series DTRT.

            Linus
