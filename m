Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02491576C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 03:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEGBur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 21:50:47 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41758 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGBur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 21:50:47 -0400
Received: by mail-lj1-f180.google.com with SMTP id k8so12770579lja.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 18:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTmx315aI+e3IpTFIK2JkU5Ig8gY6u+ajBS71um0vTY=;
        b=Zyx1YydnHgapUWH1Iwt4LxqO9GW6APT4up+CYNoMRFOMMFJceV7rK6R+jC2hXf81xW
         Kn9ojQDzPxePIZ8ViB4E9gj+OexFNLICpxDl6+pRf+gYWla1UsAxMtT6v6PJputF9si4
         JnPQh5YEjzAJVd+ysRyWjgsw7cs2X0XcIreb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTmx315aI+e3IpTFIK2JkU5Ig8gY6u+ajBS71um0vTY=;
        b=Tz7fJakg0ey6j3kSSd8b9IqipL9nfe+86JZpkb+SWGU3mROefycruFHoYKEyAKNLro
         aBXJn49LaEc9QiGIMlzdrpEswMZQnkqpOel4evfAaA+KE5b2jPFh0EVGP7ceAbdquUB0
         BrHQRRXhbEjKakt1SNSRNj5s5FZFiiFJJzyabFlkl5GxQoBRkOH45qm5Zaz86K4XgKMM
         PjMr1i0vW/hoe/uXtDRoMWFwhhrhtEIEm/EvudzV5oj5pHqNDdhLcI2xZzW64RqTBU0M
         qioYBzSgseTfIfmdsMI+Xjj99/2d23Stluv2m2wGnetAATX23Mx/73PPhuDwv53V6SUP
         Z2QA==
X-Gm-Message-State: APjAAAV689Dw1rqIgP/sRo6yCT9lF3rfduvwUN13CfpchZUB4I0XMr91
        6LYF/0PZFXa6Hydy+DfuPljcCYdwyHs=
X-Google-Smtp-Source: APXvYqwl077NMRsMNkeWKgYZCNCu3goQtzJxhgYqUk50Xakvu/zKQkSaVvnTefLihz8aVPxMIAJhZw==
X-Received: by 2002:a2e:988e:: with SMTP id b14mr15073295ljj.126.1557193845263;
        Mon, 06 May 2019 18:50:45 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 10sm2754480ljv.47.2019.05.06.18.50.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:50:44 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k8so12770509lja.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 18:50:43 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr14691844ljq.118.1557193843522;
 Mon, 06 May 2019 18:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com> <20190507004046.GE23075@ZenIV.linux.org.uk>
In-Reply-To: <20190507004046.GE23075@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 18:50:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
Message-ID: <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
Subject: Re: system panic while dentry reference count overflow
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 6, 2019 at 5:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Linus, lockref is your code, IIRC; which variant would you consider
> more feasible?

I think we should strive for the same kind of count overflow handling
that the pageref patches did: keep the count at 32 bits, but just add
a new "try_dget()" thing that returns "no" when the count grows too
large.

And then use the "try_dget()" model when possible, and particularly
for the easy cases for user mode to trigger. You don't have to catch
them all, and in most places it isn't worth even worrying about it
because users can't force billions of those places to be active at
once.

I don't see the original email (I'm not on fsdevel, and google doesn't
find it), so I don't see if there was some particular case that was
pointed out as being an easy attack vector.

For the page ref counts, it was all about get_user_pages() and a
couple of other places, and the patches ended up being small and
localized:

  15fab63e1e57 fs: prevent page refcount overflow in pipe_buf_get
  8fde12ca79af mm: prevent get_user_pages() from overflowing page refcount
  88b1a17dfc3e mm: add 'try_get_page()' helper function
  f958d7b528b1 mm: make page ref count overflow check tighter and more explicit

and I think we should see this kind of thing as the primary model,
rather than do the whole "let's make everything 64-bit".

                 Linus
