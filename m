Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2696C2D7CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392744AbgLKRWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391389AbgLKRWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:22:20 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A27C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:21:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f11so11800471ljn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Zvx589bsUIbmqE82oEdwfWs2Xi7/vP9R94glZMxDI4=;
        b=Yp9MUKy3tiVM3AgIKNYYbT1orB+p2HR6TaAWz5JGoZ2U4n/syVDFxQRcmAKaEbtB67
         iXlRVbxxPt453YHy8DjwxifhLXxdN23jG5UwWVCXdXfc5eeciIU5R/H1r5syJ8SrlKek
         Fx+i+GD5btbmMbdjSgvt/hwCWhbS0ZfUUC9+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Zvx589bsUIbmqE82oEdwfWs2Xi7/vP9R94glZMxDI4=;
        b=CLlXoqiNA/gkm2c4tNCx/EvzFnSnGvbtjiydOg66DvuGryBltoUdLHO58wHS3DSxEq
         h66azo0PuWkTHlXnnDgKeKpZ6I3W3okFngrmNIExmwKJlCzL6mFFCd8+8NhSxYMVxoe5
         2L1/9jFqhK46F7lTg9PwWfPz5LA1KaN/lO9nZmq8Vt5NPOnPFtBa8MI4LK8AcGHwLYc1
         ahQUMX4Q4wf4PoDsfZb7LcwJ4UPGuve8ZscBFZDS9MHC3HOCzrxbUsCUwom6eJsMH1yl
         r2axF9bnEWlq8KQAn8YBJml6zi1Al/VuTDIjTPtBQWTMWawa6fqzuNnDYtTKeTcQqSLb
         yyQw==
X-Gm-Message-State: AOAM5314R4TiWKZDxhgEna2xznBbTQFG2tHi+Ys9KYTUk97p3HSfseCz
        hT0UJqy/lvxS/uGtHemL8Scw7GD8tRVC4g==
X-Google-Smtp-Source: ABdhPJwhfRHIHjqV27C7syoSaW3p1w2ye3k6XjMe5kk+h5f/tNs7OIjQEWuKjXv8+sEyV3/YNCD3lg==
X-Received: by 2002:a2e:8e63:: with SMTP id t3mr5435339ljk.88.1607707298180;
        Fri, 11 Dec 2020 09:21:38 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x11sm1071703ljm.106.2020.12.11.09.21.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:21:36 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id x23so11765020lji.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:21:36 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr2960839ljj.465.1607707296360;
 Fri, 11 Dec 2020 09:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-2-axboe@kernel.dk>
 <20201211023555.GV3579531@ZenIV.linux.org.uk> <bef3f905-f6b7-1134-7ca9-ff9385d6bf86@kernel.dk>
In-Reply-To: <bef3f905-f6b7-1134-7ca9-ff9385d6bf86@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Dec 2020 09:21:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkA5Rx+0UjkSFQUqLJK9eRJ_MqoTZ8y2nyt4zXwE9vDg@mail.gmail.com>
Message-ID: <CAHk-=wjkA5Rx+0UjkSFQUqLJK9eRJ_MqoTZ8y2nyt4zXwE9vDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 7:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/10/20 7:35 PM, Al Viro wrote:
> > _IF_ for some theoretical exercise you want to do "lookup without dropping
> > out of RCU", just add a flag that has unlazy_walk() fail.  With -ECHILD.
> > Strip it away in complete_walk() and have path_init() with that flag
> > and without LOOKUP_RCU fail with -EAGAIN.  All there is to it.
>
> Thanks Al, that makes for an easier implementation. I like that suggestion,
> boils it down to just three hunks (see below).

Ooh. Yes, very nice.

        Linus
