Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19D72133C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 07:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGCF44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 01:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCF44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:56:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1BC08C5C1;
        Thu,  2 Jul 2020 22:56:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so19639888ljj.10;
        Thu, 02 Jul 2020 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7CQxovl3Hx2iIZDORMrEAXuVQ/rY3OF1nxqZdqV2k8=;
        b=KTZ5dEkqWXKE70lBn85URIGJkMh9ILNp0ubPQROgWkS6+Jol3qJeCDg3q1i70405Uo
         fsw88NSiztL5DV07QesyOFz8Ho9CWlY6DbsDl/YihghSpDztPZi7Svwq4/bYvjn4qtRf
         1LF/crilyKMVlkMYTQ67qzwS7/AHdRQFSfHhvD/AMZYZtFiezzH3fly0sHs2XwUyU6FD
         JYTVPWvIoReCmfXVWjkTKtBlIt0jTKdWwGYOh7PqbfkKeSWWb1srzjuJTxzdQccxjkQD
         CFCtCBvmyPFQt+/SWuQfj8KF2oswEkQrSvmPWzT50JZ5+xxRRuqlz9lvtnlYvHTQatsX
         PEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7CQxovl3Hx2iIZDORMrEAXuVQ/rY3OF1nxqZdqV2k8=;
        b=UEMzg4NgvtFq4/6Sbide+UuOliWcqfhI1kVyuugxW3IqgkHe0UK1awntdnkVpbjU+s
         jXIVQd0oigX8JYplgIp4rGGBUg4EanR26kGtQEL234PY7sLbsC9Wvy3jh4odz3n4gzu3
         5YaKUWIPf5tgKKSdi4br7/v5QigZ/RwK7NzbxDeJjF3cwPqXdBmQvbxbn/6iFQ82J5D/
         SqIek1wS/ekDc9OoZ8NzKDsfLzfNOoTb04FSANRah7rpVxPEO7PLJLZa25Q1tK4Gq4tq
         BmfT0WNuteyxwMsJI//mcR1Ml79CW/jnALMYZTidy1To9ip08BYcoBCJXZJsIR+0KKsr
         Fzpg==
X-Gm-Message-State: AOAM531bz2Wv7DFDqUUhVbzocTipYrgO51eQ6bE3z15NCh7dRfYj1sXG
        6wzlbjdwzD5PfWJMCMBCKEXzcO0PEu8VVl+kMf4=
X-Google-Smtp-Source: ABdhPJzmUp+Q1RFlDtjUTNfJ2/hHjmOHR7r2DMT/PxDFyOs/hWMku5oY5XNK/cNQA0SEx6xtpSX6q4UN7xzR7dii0Uw=
X-Received: by 2002:a05:651c:102d:: with SMTP id w13mr11831459ljm.29.1593755814556;
 Thu, 02 Jul 2020 22:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-17-hch@lst.de>
 <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com> <20200702135054.GA29240@lst.de>
In-Reply-To: <20200702135054.GA29240@lst.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jul 2020 07:56:43 +0200
Message-ID: <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method calls
 to seq_read_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Do you have a suggestion for an automated replacement which does?
> I'll happily switch over to that.

I guess I'd simply find the unique set of cases that occur and create
a replacement for each manually. A handful of them or so may already
cover the majority of cases. CC'ing Joe since he deals with this sort
of stuff all the time.

Some cannot be handled with replacements, e.g. re-aligning the full
list is required to fit the longer `_iter` -- if you want to cover
those cases too, applying `clang-format` to the initializer may be a
good approach.

Cheers,
Miguel
