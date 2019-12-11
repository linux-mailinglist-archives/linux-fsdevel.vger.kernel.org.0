Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CB11BC59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 19:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfLKS7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 13:59:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42431 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLKS7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:59:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so25247832ljo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgBVUlOJfW0c5CGJYH0MeOYBNpJwKBTZNoD1eRFDzR8=;
        b=XDQhOjEFh8/OdvfmcG2kHwO3ilXHx/bJqO8ELWxgJCmKkwDaWF9zVtCQpCF4T+sMPf
         poLzCR65uhWPH5bBTmIASa1hyVJAgS+ARnu/6A2EDYubR7mdxN9LNkWicAtUJKJRriYl
         AFhrGxB/lePeG33Vb05dZ7T/i73L2uk59BIHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgBVUlOJfW0c5CGJYH0MeOYBNpJwKBTZNoD1eRFDzR8=;
        b=iPm594cT5eDlS6vQA/lNE0jVzlTXNVGk/u00k8TplW3x+k2S3ORNMaBmdeQN8ZOpxj
         78ToQ1oiZHilYB8Nm3+3ahoUHL8XRd/CLco3DPk/LRRtIgwtVlL4el+DlxOo7Wz1HhJk
         VKMiCwXK18DenKdgsIvmMpWqoTuj97wf3eVOKpsJXWPNYQxXEnhZMiC4A1++dAsc2QA7
         TSUM7oWHoJUwVYZQG+d7YcRV2tLTh+myoGPxcsebX6/LTgC4ff/c1aEFGs1GGc9bB+Tc
         Byw6aocBWTlyFaRJhb1XLYOdicqJUBoJvj/wte5NjvHQuHxm9KEBq1Is67E43a680toV
         jFKg==
X-Gm-Message-State: APjAAAVf2NwFrLmh+JUdUX4VcpUvBi96B0wUL8q3R3nG6fWxxdrNkeD/
        KlGrxhmu5MLaTRswTjSKFjQyFcSBRtE=
X-Google-Smtp-Source: APXvYqweBIMTo/lrwGyZZ9juKl162Zu/d30J5iNjQGezjMkEGDLkjw0sMwA3+w97ZGOBV6Ein6WKJg==
X-Received: by 2002:a2e:9356:: with SMTP id m22mr3285301ljh.160.1576090784854;
        Wed, 11 Dec 2019 10:59:44 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id o20sm1679601ljc.35.2019.12.11.10.59.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:59:43 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id i23so5083192lfo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 10:59:43 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3325403lfo.134.1576090783418;
 Wed, 11 Dec 2019 10:59:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
 <xnpngusphz.fsf@greed.delorie.com>
In-Reply-To: <xnpngusphz.fsf@greed.delorie.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 10:59:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4usEUgMFvq6Jzuc5Qg4QZxf39SUYZt_5OLN7+wjh-cA@mail.gmail.com>
Message-ID: <CAHk-=wh4usEUgMFvq6Jzuc5Qg4QZxf39SUYZt_5OLN7+wjh-cA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     DJ Delorie <dj@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:09 AM DJ Delorie <dj@redhat.com> wrote:
>
> Builds for F30 and F31 are in bodhi, waiting on testing and karma...

Thanks DJ,

               Linus
