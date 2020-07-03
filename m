Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B842137CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGCJfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCJfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:35:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C69C08C5C1;
        Fri,  3 Jul 2020 02:35:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so20312765ljj.10;
        Fri, 03 Jul 2020 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLmfy2pnBy37MmMuk79InOyFQOgM0OuGfW1lA5Bezns=;
        b=dPAjz1hRA/nWCvLhxUJ7uccVaEcwWGHbKTb44GQgl9LbzS4P6iJHC9rTS2nlOv1sFZ
         ilJIhJrVs4lZNtbBpljQqJaP52MEfvlFZWtrFyCKDaq8EB9QBGfWgXivYQhySdghuDCw
         xZbaZmTj+muqQhER3JHXJChUNdRVKAhEkYeYPBrFKKpz8vH/HepPR1Qgy/gOVXbF2G4l
         UsEIzzrg4hjteJT84C6pImwA9mxXVrU3dpYN/25xEPNBPlqBmCOyoTaYqNyGzJBIlQFy
         LoQyMyb7o49jAxi6ONh68RAoHketLxFTY9OgrDp8JB4d/gGx1DRmECcpXfDsRYBpEBgI
         RnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLmfy2pnBy37MmMuk79InOyFQOgM0OuGfW1lA5Bezns=;
        b=OXRfnojiGdwe6lfW+/4932mWpfQxyLbbeN7Z+ntgQvrRWLKFVSR5us3yn/Et/xF0Vi
         w1323nbTY+XiPV1Wd1FCBb40dNFofTFMu7xSlUSvBfXGWBunnWY63P49pR5PIE2/rqzp
         edE744BnBEVLyoGADqWlk22q1BsqGU1kX3luMJpV1LJrSqHfG6+nXymenA4Q6ftakGb7
         Yf0eTtQKdecB9xk4vShPch48HgGgytBzA1it89bx6Cs5fJePTC8/+alojhha5MeEKcaj
         SLN9f4ZOc1wYVJcejjxeN7kJu6dwWyFhYKWzPqVg3gobFiZMt+WoPVYwg5+Agn5Uq80A
         Vnxw==
X-Gm-Message-State: AOAM533dQ+mPrPfaRIcf27ijYdhK932Ve4j74Tx7os/SXugA68cl2aUN
        7JkhnX6jEzThR2Su9vG8gtE+/HA4JsLRHBWlQIA=
X-Google-Smtp-Source: ABdhPJw1fRvCdmWXz1y7V1BJUhyPLgKVAwcYywSD36PjOkR8Vultjf9a5oAIaozxkYLgP29FTGmHL6QlT3bDv1jwa/A=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr19865475ljk.44.1593768936347;
 Fri, 03 Jul 2020 02:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-17-hch@lst.de>
 <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
 <20200702135054.GA29240@lst.de> <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
 <d7c902f9eecffc51f3a5761fa343bedad89dff7e.camel@perches.com>
In-Reply-To: <d7c902f9eecffc51f3a5761fa343bedad89dff7e.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jul 2020 11:35:25 +0200
Message-ID: <CANiq72=LekNWFbK8_+88T2oGSqA5A0fjnvn28cY-tEOfKbSqdw@mail.gmail.com>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method calls
 to seq_read_iter
To:     Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 9:44 AM Joe Perches <joe@perches.com> wrote:
>
> And I'd generally not bother with 80 column rewrapping

Thanks for the quick answer Joe -- here I was referring to the cases
where one needs to move all the `=`s to the right like:

 static const struct file_operations memtype_fops = {
  .open    = memtype_seq_open,
- .read    = seq_read,
+ .read_iter    = seq_read_iter,
  .llseek  = seq_lseek,
  .release = seq_release,
 };

(I don't think there is any/many cases of 80-column rewrapping here).

Cheers,
Miguel
