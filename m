Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C31E8C5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgE2Xyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgE2Xyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:54:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BF7C08C5C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 16:54:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v16so1314889ljc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/D552LPCtYn3hG6mSDy6RFyAOe2Q9CIedgAxscSO/w=;
        b=TrTI7pxgWN2mRJvQkgrZJSOALr9y0VXSLbhGTXjJTOtPxbRpbuM221ekLHghLwRPKc
         4yruvpBjvjMt7Oc/t4BfFsds7Qc0MkS9/2zCmCg1DGzxkyZxxItJlKqSru+OURADfLEF
         pbowajAyg5bitEYsnjEo+hF/SUbK91s47IjLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/D552LPCtYn3hG6mSDy6RFyAOe2Q9CIedgAxscSO/w=;
        b=UecpwMnf8dUbCzsk1E2qpNtq/93jOhyym4G/f+G/htUtSX8KuoevgF47MwS8OkpttT
         3oejcgNrb0WJMVsuHnUncXRx0oLSOQTZMvr7tI3ZU0zCLHRznb/KpKbgGDnTAgNLN51C
         sG9QOVxDT9MEXl42UhoujpLqa7ZohtGggh4mgvCl0nXqHljvAJyED92MJ+YBnYl92vDa
         g7IuXyei4559tgiYjrFLheVDQYCxR6TmepJvY3+LpOxUD2bNrZo1HtxQCcPi4OEc/yT3
         LemVseHmOUq7ptUNh0nU1nNSKQYUK3vVLGzcmhdgLpaUaFTgQ1N/7pH7C4KIFjMSLMfh
         WVzQ==
X-Gm-Message-State: AOAM531wUGjechUa10bXj9+oYUETA8qXDNAvytQ0xhAW0PgEmd3DuBM7
        SQ4MGuM+SIYnms6fx9+FGYQXcU6rtKM=
X-Google-Smtp-Source: ABdhPJyRG8sPTVYBGiX6f86PPcR7vbMi6MVfsLgDO9+FAUZeSyKxINOkCF+zRcPrk8HDexrlejCYuw==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr5034996ljh.342.1590796492581;
        Fri, 29 May 2020 16:54:52 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a15sm2654298ljj.27.2020.05.29.16.54.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 16:54:51 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e4so1339012ljn.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 16:54:51 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr4908890ljm.70.1590796491384;
 Fri, 29 May 2020 16:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232615.GK23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529232615.GK23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 16:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
Message-ID: <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
Subject: Re: [PATCHES] uaccess misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 4:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The stuff that doesn't fit anywhere else.  Hopefully
> saner marshalling for weird 7-argument syscalls (pselect6()),

That looked fine to me, btw. Looks like an improvement even outside
the "avoid __get_user()" and double STAC/CLAC issue.

> low-hanging fruit in several binfmt, unsafe_put_user-based
> x86 cp_stat64(), etc. - there's really no common topic here.

My only complaint was that kvm thing that I think should have gone even further.

           Linus
