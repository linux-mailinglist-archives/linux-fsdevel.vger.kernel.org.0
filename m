Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822B346F1BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhLIR3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbhLIR3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:29:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44BFC061A32
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Dec 2021 09:25:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r25so21352200edq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqExJZ9/DphBTKULUzi0rda5Ww/lFJEMJ0HrtECPjTI=;
        b=CEZX4drLnp80p9b9oVxK0f0qT2WA3YF+B1Tl8CQVWg2uGKK6+gQz0h/GPS2FyiNNJ9
         gAKRuC48E81Hb/mGX0sY3phjIF/WMv16b9bipyIo+rIOFDAbKwrmyJ7HqNkTia2gkVbu
         /I1NAgDWldKvVVC+e1z0jNAfGMMlQioj2HEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqExJZ9/DphBTKULUzi0rda5Ww/lFJEMJ0HrtECPjTI=;
        b=RpGufyhmR2t4lGWBr1zQpOaWeYIDDHAuoOatNcGuFVpMKX609DlHODl4JnOgkZP9u9
         Xu11YlMBm4apmTQe0fAUDFO9//PRzHHzUL7DFdbC/XEuCQpkveUTVJVFnf1gJjzFDF74
         Z0FkPss7ri7JAKydN0SLxIfdSUzywJ0hmaE2Oe8cv058KdBxcSE2k0b96Gf/i97C4s1M
         vUf3qk/spK0BiZJvUFu4fiIX3hle3/QtdFAJEeMDZS9L1MUdguAkfI2q/x6Uu73Q/ODJ
         pUi9hCemBZUdiWlltMAjb3/F5aF1Oto3sT8nFAocJxqkv5L+aXynxpY3isd6ipeiIybV
         GQww==
X-Gm-Message-State: AOAM530DI6HVhQ9E6/ceynu04oAblTx3gdjmtHqFt1LG4yi52nrgFvli
        o9bbgDd2ME2qnKjLpj9FNG0KFNFDJDxxIsCJ
X-Google-Smtp-Source: ABdhPJyBWd34Fa4+9nqLjHLzOVT/XKeUr+a9pFjFN24d8mTQ7V7dUvpUTMa1T3GfxUIBKgtLUokz0Q==
X-Received: by 2002:a17:906:79c8:: with SMTP id m8mr15976201ejo.511.1639070535083;
        Thu, 09 Dec 2021 09:22:15 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id w5sm184833edc.58.2021.12.09.09.22.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:22:14 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 133so4827841wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 09:22:14 -0800 (PST)
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr8659906wmg.152.1639070533785;
 Thu, 09 Dec 2021 09:22:13 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906891983.143852.6219772337558577395.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906891983.143852.6219772337558577395.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:21:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgejk2DA53dkzs6NquDbQk5_r6Hw8_-RJQ0_njNijKYew@mail.gmail.com>
Message-ID: <CAHk-=wgejk2DA53dkzs6NquDbQk5_r6Hw8_-RJQ0_njNijKYew@mail.gmail.com>
Subject: Re: [PATCH v2 10/67] fscache: Implement cookie registration
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:55 AM David Howells <dhowells@redhat.com> wrote:
>
> +               buf = (u32 *)cookie->inline_key;
> +       }
> +
> +       memcpy(buf, index_key, index_key_len);
> +       cookie->key_hash = fscache_hash(cookie->volume->key_hash, buf, bufs);

This is actively wrong given the noise about "endianness independence"
of the fscache_hash() function.

There is absolutely nothing endianness-independent in the above.
You're taking some random data, casting the pointer to a native
word-order 32-bit entity, and then doing things in that native word
order.

The same data will give different results on different endiannesses.

Maybe some other code has always munged stuff so that it's in some
"native word format", but if so, the type system should have been made
to match. And it's not. It explicitly casts what is clearly some other
pointer type to "u32 *".

There is no way in hell this is properly endianness-independent with
each word in an array having some actual endianness-independent value
when you write code like this.

I'd suggest making endianness either explicit (make things explicitly
"__le32" or whatever) and making sure that you don't just randomly
cast pointers, you actually have the proper types.

Or, alternatively, just say "nobody cares about BE any more,
endianness isn't relevant, get over it".

But don't have functions that claim to be endianness-independent and
then randomly access data like this.

              Linus
