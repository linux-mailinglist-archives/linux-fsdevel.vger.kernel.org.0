Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF120C4AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgF0WPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgF0WPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:15:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C48C061794
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2020 15:15:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so13949785ljv.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2020 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4JEHR7Il2IGp8f5V95s+cFH08ZEfipxHhJKa+vtSQXc=;
        b=L5az16Wx0Vb9F9owDOvTovtU9UfiHOeqrhQTmmBE4a4nothf30qTjIzyM7cu7SLlCV
         YKOvifljh4XN6M2evYVQVyyN8JAU84f2cZB3eUoAUJ7NLDuZx7HIHXCdIn+SygeHmNx+
         97SUthWIKvp2epNCe7/LpggsYcP6nm+vsFS9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4JEHR7Il2IGp8f5V95s+cFH08ZEfipxHhJKa+vtSQXc=;
        b=QHHfFR7kAr0jSHZTjEaOIOZJ902p2pBn4qOaXRZ/tLuWEp2dZVRvmEloHeHlYSEpgO
         HO7TdJv1W0cvV1X/rYTs0KgOeE/WT8YF3xgf/U9bKlbMRSMAAj4wn0G7zaY98NoukGC0
         5Uiblqbvh1gq/SXBdV50elT9jmKn+uim3/Bn5uvYv9BH5hVtHRlYtpZ9eBSvrquAI17K
         b2/JsD6sTXLb44z7OBr5r9CBOF+lJeUzeBQsN7gwmaaHTtlxAbL9GYAQ7zP+77I4p5wM
         NiYFLpJQJIAapQ0Wlbq5rVedgCwumiAUhb0WiNIo0yRiAW5J/M5hFEHqD6fKv0tevP8Z
         RMUQ==
X-Gm-Message-State: AOAM532d2UMmwUzVpCWAGvxMqL2+Kk3//yaclE1Ay9YHHem2PaQe5wav
        9Xqb4Imm8R0Jnfzvnvb55mlzT9u58GA=
X-Google-Smtp-Source: ABdhPJwgnKwEULxtDgdacCj2q3t/mhJeDFmZpE0kaCc+IbB10qLtbFRvkzyMDUiodHzY9v0o+TnlvQ==
X-Received: by 2002:a2e:7116:: with SMTP id m22mr2549813ljc.271.1593296118059;
        Sat, 27 Jun 2020 15:15:18 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r13sm7697624lfp.80.2020.06.27.15.15.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 15:15:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s9so13904545ljm.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2020 15:15:16 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr155744lji.70.1593296116489;
 Sat, 27 Jun 2020 15:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200626075836.1998185-1-hch@lst.de>
In-Reply-To: <20200626075836.1998185-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jun 2020 15:15:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
Message-ID: <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
Subject: Re: [RFC] stop using ->read and ->write for kernel access v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> as part of removing set_fs entirely (for which I have a working
> prototype), we need to stop calling ->read and ->write with kernel
> pointers under set_fs.
>
> My previous "clean up kernel_{read,write} & friends v5" series, on which
> this one builds, consolidate those calls into the __=E1=B8=B5ernel_{read,=
write}
> helpers.  This series goes further and removes the option to call
> ->read and ->write with kernel pointers entirely.

Ack. I scanned through these and didn't find anything odd.

Which either means that it's all good, or that my scanning was too
limited. But this does feel like the right way to go about things.

Al?

                 Linus
