Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7B46F35B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 19:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhLISxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 13:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLISxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:53:07 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96626C061746
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Dec 2021 10:49:33 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id o17so6240065qtk.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 10:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmTnqLpZG3L87y+u6kWGuNLhyVdE+MXKVwUo2tZ+WXw=;
        b=R8VBVyJcZnXnjU93pDTV82pZASm9LKLHmvwRuK71fHickgEiI9S/IBkXHvwB7h5Dpg
         /RvAOJMHeGp/V+JnQ+pMiKmg7cyzu33useqAng0PzS3h2CbGaGQIapWA1Q4L5XlPos4o
         5Yv3d3vTlAdW6WyhUPMm+LYvGqeXky9hzQkS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmTnqLpZG3L87y+u6kWGuNLhyVdE+MXKVwUo2tZ+WXw=;
        b=XohDlCkkWYcMaVgDMxc7mSJ66AmzH8SfvPI5p5aPbWkW3RYJ8XOWP5lkdYZmHqTgjx
         Y7IahCwIhF5BiJF6To9pnlsBsx0ntFyeNQ1YK9A4mo9GG8XrNsFNP3H91nqacWwxiVvx
         +iUylugws7gwMiOKz0imcwARFJ8Ep8GBjiFW/n54Q/GZxaTTbN8S/raCXv3WVwbH156c
         wq341p0O3IGVArS9A1RQ3j9r1gXPJtnQHkTTBjKpZeFH7UoHIZiBrEfYVnLUkRW/7c1f
         LRPCLqn9pGDav+QvCAm1g+56xFS8SWbhvk0uUTH47T2QA+pkdfQh2C8ec0DFQxWIZSoq
         2zfw==
X-Gm-Message-State: AOAM530tormnn1eH41B51wTDdck6P2blHRum8MeoLS/Tz0d68BxYOdFn
        6Mwok6kKpsqZYQFTcBT/aHgDgTN4dig0Ot08qa4=
X-Google-Smtp-Source: ABdhPJwjVHaZ+/t1jybYuRv4WWGBHCj27nD4T/xdi1zelqPl2P/d9dItB/2dVl/YXRx6VXR5AHxCmQ==
X-Received: by 2002:ac8:57d0:: with SMTP id w16mr19816685qta.398.1639075772612;
        Thu, 09 Dec 2021 10:49:32 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id m20sm218181qkp.112.2021.12.09.10.49.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 10:49:31 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id o13so11261056wrs.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 10:49:27 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr8799289wre.140.1639075766991;
 Thu, 09 Dec 2021 10:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207142405.179428-1-brauner@kernel.org>
In-Reply-To: <20211207142405.179428-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 10:49:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjxBRNkav+RjpdHjDZHRPAJgjdM4wTFi_oEnk0_dc67g@mail.gmail.com>
Message-ID: <CAHk-=wjjxBRNkav+RjpdHjDZHRPAJgjdM4wTFi_oEnk0_dc67g@mail.gmail.com>
Subject: Re: Pull trivial helper to preempt fscache merge conflict?
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 6:25 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Since the patch has extremely low regression potential I did agree to at
> least ask you. But no problem if you'd rather fix it yourself during the
> next merge window should you decide to pull.

Honestly, looking at that pull, any conflict would seem to be so
trivial that I won't worry about it, and I'd rather deal with it
normally than taking the odd extra pull early.

                 Linus
