Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1F1D7B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEROnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgEROns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 10:43:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73876C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 07:43:48 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so10146250lje.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmKMl5YPAbtYvThGAufK7+pRDXytMF6DEwy6+OdOT6c=;
        b=NnbKbGQluk5lNt1OMh91AzLf43ctbuCx11Qrf3/SH8c37zea2KCW1nBzzZxOP6eBMJ
         mNikiWnBzqw1Qh5gemWUCvWkJrCIW8yDSnkDx8R6ZYBzKq+OLJjZPeFz2G9mgUvlkVTM
         dm8UA+SmF8OQXRg6DdCXiTcqKrEVyEYP7SLPKT2yHm+RCB4cGu3cFPb2AjVfi0QY5rUq
         qAGDKXTutca8F5XEP0TqE545HEJbER9IgNbvIFzIa9jPi0OuqeYk/x+vJdTSoeTUygoI
         8E5aJEpfXrwXeNyCuMqf4Iw1FJkWkKCQGV1kAlYV1sACiLyt3C6WFh/ySD2nZG5gBeFu
         wwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmKMl5YPAbtYvThGAufK7+pRDXytMF6DEwy6+OdOT6c=;
        b=MbnBkg0pS595Rt9vLKDjQVBCOKYsgHGeojzlLlw7wcyb04m+B6zxIKDlsRxVISlnlS
         6LpOWBorQEf3rnbbv+D2jIPSHlOvNRznsKU2cO40Utz53SfhWfcCVE80BePelkIf7Lhp
         z2ADWV2K2XPYxvKT463H+DAwcTR8hnwBZreMFJupJoLN5wn+GT3e7B1137ZfC5TSAa4A
         pevZcg5rkHeBvMdPy/T5yK+bGMadeAGR6ALeSRoD4ungtd1wj+ogt1dQxelY8T60J1O4
         5qK+rl5u0tP2v/Y97nbUAWgzPDPD4wvgX3kYHGampCfNH2kXui6vlTnBRW1jwV/o842S
         EwoQ==
X-Gm-Message-State: AOAM532pzKY8xyd3MLP+ovZ2o3AgRIWTwjUsB6lKOKNKc9o98qUzfekY
        g+djU5/xJQ9xgPbYbd5kWmTmOEu6XJL39rpFc0w9rA==
X-Google-Smtp-Source: ABdhPJxtr0BKnKjn6pCHBXg0CBH0lcE95cP/SI2TsQx+b5KMUXKtBPY9ZvGp2Yty+kEdByTnUauiLd0kc/yHpxl0ygk=
X-Received: by 2002:a2e:8e8c:: with SMTP id z12mr2985329ljk.221.1589813026603;
 Mon, 18 May 2020 07:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200518055457.12302-1-keescook@chromium.org> <20200518055457.12302-2-keescook@chromium.org>
 <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
In-Reply-To: <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 18 May 2020 16:43:20 +0200
Message-ID: <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 3:03 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Also - gulp (puts on flame proof suit) - may I suggest we check if there
> are any distros out there that still set CONFIG_USELIB=y

Debian seems to have it enabled on x86...

https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/kernelarch-x86/config#L1896

A random Ubuntu 19.10 VM I have here has it enabled, too.
