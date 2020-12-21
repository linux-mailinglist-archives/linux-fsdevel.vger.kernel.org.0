Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1335A2DFF5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 19:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgLUSJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 13:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLUSJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:09:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7FC061285
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:08:53 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so14668275ejf.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMPwSByM5Ofrk9Kvk8b94+hVOdCU16NWvETZQDOg+ns=;
        b=RzcksibqGzUEPSFE0m8P+JWb11CJAU3jMWh0XO1JtfV/WtL4MjWV6XkqYK5EZ5Q2nU
         TrDmyMWHSL26YBIbESRADOXyfBW7UB2f3zCeuNcC+uzPKF1Rwww9NXaogzewXr3/tczT
         WNz6Yz6iyaqyz5eQbs0CIQPzpL191Qeth/q5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMPwSByM5Ofrk9Kvk8b94+hVOdCU16NWvETZQDOg+ns=;
        b=Buk5OvW365J3JDj2tD89dh7XLOodH9rJkxsp0B3oeLLLNEqFsKfqZ1XRHsLTwc1BXP
         R2XoXdXWVSiBD3mAi3Ue42hSMuKH8YI/O2ZEU6moUxW4HJY51m49+KBlkYGIXv9a9pG2
         ijRqcAmTPsvlJjvRbUuyA5e4N9CSRbHa5C6TeGUwGV8OaQ8w1unvZCSuoImcMAP2/5LL
         nkHlan5O6MZrlRwHs/KeO/OdvIRUKXF885bTVyUAtublB9zt8+75wSdMh/1cXLfSJxVj
         lJOW7JZXJ3oVitOxERK9l2gTC9Q9mCM6JBXYM58m5+o9M5N1JbuSsAtDN5MFZZfaWXxm
         Qvmw==
X-Gm-Message-State: AOAM532V5pjuRbs6usavT2yrgjtSGQvqbGrsaAwA/w3tu38PbS9h1EZS
        tWWD5UdIlHljg0QNXJeNN/jRidTiU4anqg==
X-Google-Smtp-Source: ABdhPJxQPTSaAf7XhZ+9bRbygVjETrczjGgBEzT7LZc6nXBndR73FBHlPugo7OuCqJgvU738fVUjuw==
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr7710103ljj.192.1608572286316;
        Mon, 21 Dec 2020 09:38:06 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x11sm2150197lfq.244.2020.12.21.09.38.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 09:38:05 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id x20so25532076lfe.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 09:38:05 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr7549776lji.48.1608572285100;
 Mon, 21 Dec 2020 09:38:05 -0800 (PST)
MIME-Version: 1.0
References: <365031.1608567254@warthog.procyon.org.uk>
In-Reply-To: <365031.1608567254@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 09:37:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
Message-ID: <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
To:     David Howells <dhowells@redhat.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 8:14 AM David Howells <dhowells@redhat.com> wrote:
>
> CONFIG_FORTIFIED_SOURCE=y now causes an oops in strnlen() from afs (see
> attached patch for an explanation).  Is replacing the use with memchr() the
> right approach?  Or should I be calling __real_strnlen() or whatever it's
> called?

Ugh. No.

> AFS has a structured layout in its directory contents (AFS dirs are
> downloaded as files and parsed locally by the client for lookup/readdir).
> The slots in the directory are defined by union afs_xdr_dirent.  This,
> however, only directly allows a name of a length that will fit into that
> union.  To support a longer name, the next 1-8 contiguous entries are
> annexed to the first one and the name flows across these.

I htink the right fix would be to try to create a type that actually
describes that.

IOW, maybe the afs_xdr_dirent union could be written something like

  union afs_xdr_dirent {
          struct {
                  u8              valid;
                  u8              unused[1];
                  __be16          hash_next;
                  __be32          vnode;
                  __be32          unique;
                  u8              name[];
         } u;
          u8                      extended_name[32];
  } __packed;

instead, and have a big comment about how "name[]" is that
"16+overflow+next entries" thing?

I didn't check how you currently use that ->name thing (not a good
identifier to grep for..), so you might want some other model - like
using a separate union case for this "unconstrained name" case.

In fact, maybe that separate union struct is a better model anyway, to
act as even more of documentation about the different cases..

              Linus
