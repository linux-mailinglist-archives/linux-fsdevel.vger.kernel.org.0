Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45373114A10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLEX6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 18:58:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41957 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLEX6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:58:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so5609075ljc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOmvCcAfxENDt59JmszfSJIXz70mzbpvyp0lp8vems0=;
        b=Ekqfj+O7irTIS0InDutPgmPnBQgrHSMkEmzAiT7Q5ixN8sawn5JY5nEfE6Oii4Oz21
         eg8kbdw3ISdBN9bt9ycolPwJGycujLH+hx+x0SsfOArbXB3ywkfyL8hmA/Q4oD21fDZW
         LbmSPC6Jzcv6AttAaWv0ZEvqDReE3MinNrjeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOmvCcAfxENDt59JmszfSJIXz70mzbpvyp0lp8vems0=;
        b=p5SyLLlu3Aq/gbPAyRlkm5C0IetE9/Y+5sA8QABxWEu3c/DB+4uSl6Fd99IdlihBRx
         TWaUuxgcBGZd0C4CGozYmBgQ9XhWkxWz//9IsQ3/8Fn97FsmdrzfX9ht+OBgbPFHgBYT
         rt0li/M+vOhIr2mav5PZMHYZm6ATUtrGYo0etYtAPYqQfTO8eI8nE3gfq1v6h3OBHPGr
         9IJs1dEwdTg8BU+wi//Din0+Vzk/gHgvhdW6dXEE8qNRhwoh6tYJL+vyIm0KYQfUHqPc
         TqBqJZfn/1rEol9QRYa5y5HhJrVS19LQ3KXKshG6hpWgXqcvzmUELWYGrDzfv3UJbpmM
         g3Yw==
X-Gm-Message-State: APjAAAXGeIt/RpfdKg99OT7Xel/7cR2ZNKCETj2m6gDAh0eovMuKUzhj
        rWGFFz1YT8YkcPI0Uc2Oa/bvu4yPHlw=
X-Google-Smtp-Source: APXvYqzlah0wf/Zm355n1RuPn9DZqgExrcpM4vnfK8kEM2yHjExdHLFilWMeVb4TjJVEFqFOnPtOpw==
X-Received: by 2002:a2e:9008:: with SMTP id h8mr7207325ljg.217.1575590327945;
        Thu, 05 Dec 2019 15:58:47 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id k22sm5544824lfm.48.2019.12.05.15.58.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 15:58:47 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id j6so5650722lja.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 15:58:46 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4684297ljn.48.1575590326630;
 Thu, 05 Dec 2019 15:58:46 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <157558503716.10278.17734879104574600890.stgit@warthog.procyon.org.uk>
In-Reply-To: <157558503716.10278.17734879104574600890.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 15:58:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiy87EzKRXRa3VkgesGndrR02pizpX_TEzP+cPPJytpWg@mail.gmail.com>
Message-ID: <CAHk-=wiy87EzKRXRa3VkgesGndrR02pizpX_TEzP+cPPJytpWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pipe: Fix missing mask update after pipe_wait() [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 2:30 PM David Howells <dhowells@redhat.com> wrote:
>
> -               struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
> +               struct pipe_buffer *buf =
> +                       &pipe->bufs[(head - 1) & (pipe->ring_size - 1)];

I changed the two occurrences of this to use a local temporary "mask"
variable, to avoid the long lines.

It's no longer _caching_ the value, but it makes the code more legible.

              Linus
