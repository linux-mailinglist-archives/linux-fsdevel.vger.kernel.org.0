Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2D3F8E89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhHZTPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 15:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbhHZTPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:15:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2470C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 12:14:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y5so6212952edp.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rx0FUZ0y/4cX/RB/wrUdWs+Xu2SixTxkAb51quz7jo8=;
        b=gnWwUt3JdlTv8VP9sot3kjTMSbk6xwqrxgCgHZylW8hKKqckrTGkz0muKu4CBOEHn7
         wG6JLCceDpcYIpIo5EF/oBtz+SiHUfn/Qa909EqNs0kW2jo1foPRy+rCIamGkla+QT9S
         6ZM1JxJVo1tT6oeX8u3OUOeJJ6zaEf9Q28JJhmMaDgCglfm2bOtEn5qjrgtqpVaucGdZ
         LI267o4R1RTs5O4tS2zWmwEQpTA9ZAmgRK5EU/B9I4xcBeINEDvGPQMGe0vPsT70C/HL
         OVy77vIjlo6NdxsB4/rJ5nTmgISGdu1vTD12Avv/kDgks2NHFxXy86bmK5+2Y3hrWB1F
         irSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rx0FUZ0y/4cX/RB/wrUdWs+Xu2SixTxkAb51quz7jo8=;
        b=CLrW67EVTNp5+W6T4u3Qu6+xLNB2ZYHsbeRE998t6dq5LCtGNmqekxfysLvJtp/no7
         fdNtjhW0e0V4l6e9KD7JifBQGAKjNFY2lColQDHhg42Csfk+1Td9+t1SEgpxN/hfi9Bu
         LAdpCaLbP80K1O5Tt0zUrgnChG7KYuMQh4aS25XfLWAxueViqnDZJ79CrwiBez8lm9pw
         iaCM+CjL/sicDCzuLA7DxMGt7USQh+4/uASBj5rYC0rCRST4o8sdPSRGCf5HD4h9Ln2f
         vfprsOciqFqvwClj9nD2zfv7Vyg2Rao4TR8pV8RMZm7X0haYyUgWkMY1VIK7+kWlroQ9
         oXvA==
X-Gm-Message-State: AOAM532sJ4Qzq4N/dIR6614upx/nZkMDYkqP+mmnx2JD52jD2BBeMk52
        xYLeS9lK+kxyi2xiuv5HJTBqORlpWPOWr1qE3I06
X-Google-Smtp-Source: ABdhPJwW5wBqVh+ZTgsyTSWJmX+Kmrj84VmvqS9Yc/10HktwgbbDnwLo41tBgtnkP5vc5wtH1HUiC5RxqSWTlGMKY1E=
X-Received: by 2002:aa7:d9d2:: with SMTP id v18mr5927880eds.128.1630005252910;
 Thu, 26 Aug 2021 12:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <162871480969.63873.9434591871437326374.stgit@olly>
 <20210824205724.GB490529@madcap2.tricolour.ca> <20210826011639.GE490529@madcap2.tricolour.ca>
 <CAHC9VhSADQsudmD52hP8GQWWR4+=sJ7mvNkh9xDXuahS+iERVA@mail.gmail.com> <20210826163230.GF490529@madcap2.tricolour.ca>
In-Reply-To: <20210826163230.GF490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Aug 2021 15:14:02 -0400
Message-ID: <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 12:32 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> I'm getting:
>         # ./iouring.2
>         Kernel thread io_uring-sq is not running.
>         Unable to setup io_uring: Permission denied
>
>         # ./iouring.3s
>         >>> server started, pid = 2082
>         >>> memfd created, fd = 3
>         io_uring_queue_init: Permission denied
>
> I have CONFIG_IO_URING=y set, what else is needed?

I'm not sure how you tried to run those tests, but try running as root
and with SELinux in permissive mode.

-- 
paul moore
www.paul-moore.com
