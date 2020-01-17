Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A67141192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgAQTUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 14:20:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44100 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgAQTUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:20:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so3786194ljj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 11:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjn/4JEsak9XgJfi8H/1wSFhagaL5qBcKMX83cbL8lM=;
        b=J6oAUgFSgqzQVKrljKHl0wA585Cu8h3LZrzViJ+RlD9Jt/9vla5+6+/UIQPgOQl7gS
         Sqo6g3ob4Mo41Mx8brh1v3MW0bYMAAA7LEOEXM69LJf7+iKCWNvVV55BAqfB3KEywnX0
         UAZ5Zj0s7Dfyx43GFe9KrRl9tX1FMBy8+oVzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjn/4JEsak9XgJfi8H/1wSFhagaL5qBcKMX83cbL8lM=;
        b=FPwnlxlqBAmRlZ2jcJrYPRNIgxjw7Rv8A6om+2i+tjis/xNgiW3lDktSPxBqORyJcZ
         83A0oHymz0teo9hldP1YNOxLlr//NS2InsTnhuKdaLZjbI7vh3SL8ORLkuz2tJLgEPz5
         DpmtCwSUiCSKctWKRR7zglfV7UGeYubozSa45LqW+acHBNPHQDb817q73PwYNYAhspdP
         r3KJ5x3eHsshQ2NnfZJ5yrwM4SKidrQPF1cao196Embt+wiO3RJYCwvJ2/G8R++SaDwb
         JMGSUCTTni1ePQjM4nHtbg12nx6pzP8wdSG+E03Yui/DQvgSmO3M8an/dW5azRKxh896
         CMdQ==
X-Gm-Message-State: APjAAAVQi1zc7pBvuAykdrQnGjCpmwj7qmEhnJHW+17jd6KNIF981R8E
        FH+P+cQzkuBj0CxYITJkJ/cASzWoSfg=
X-Google-Smtp-Source: APXvYqyc7PZ3W4b7gOmY/f9t0PNLznL8xZvDK7udB4Uxj+rswiba/D28gO9c9iTYP/cD0L2c9bDHIQ==
X-Received: by 2002:a2e:580c:: with SMTP id m12mr6508806ljb.252.1579288835069;
        Fri, 17 Jan 2020 11:20:35 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y10sm12722530ljm.93.2020.01.17.11.20.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 11:20:34 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id o13so27553885ljg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 11:20:33 -0800 (PST)
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr6522426ljc.43.1579288833652;
 Fri, 17 Jan 2020 11:20:33 -0800 (PST)
MIME-Version: 1.0
References: <c6ed1ca0-3e39-714c-9590-54e13695b9b9@redhat.com>
 <CAHk-=wink2z6EtvhKfhSvfC2hKBseVU8UWsM+HLsQP9x3mD7Xw@mail.gmail.com>
 <5c184396-7cc8-ee72-2335-dce9a977c8d4@redhat.com> <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
In-Reply-To: <b70a0334-63be-b3a5-6f8a-714fbe4637c7@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jan 2020 11:20:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOwghtCi8kpdefmLbyG0oSH23vYrMOU8v_XKEe7va-4g@mail.gmail.com>
Message-ID: <CAHk-=wiOwghtCi8kpdefmLbyG0oSH23vYrMOU8v_XKEe7va-4g@mail.gmail.com>
Subject: Re: Performance regression introduced by commit b667b8673443 ("pipe:
 Advance tail pointer inside of wait spinlock in pipe_read()")
To:     Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:11 AM Waiman Long <longman@redhat.com> wrote:
>
> I built a make with the lastest make git tree and the problem was gone
> with the new make. So it was a bug in make not the kernel. Sorry for the
> noise.

I think I spent about three days trying to figure it out. At least it
felt that way. I looked at the pipe code a _lot_, also blaming the
kernel for obvious reasons.

             Linus
