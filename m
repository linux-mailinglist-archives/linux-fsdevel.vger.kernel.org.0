Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AB421443
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhJDQkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhJDQkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:40:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0BC061746
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 09:38:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n8so18518788lfk.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nD/CqNzR9E4HGpSddngZ7NQXINMID609Z0nuYAzxVQ=;
        b=EhHEBOBGv3jAdd0eEwTEevENTAb2AhyLvwesYd92iZLWqj7mTTdpBBgs4KL47AQ0oH
         ZwglecIE1krknfq1btMK26sMK70sIco+nuL8EtgDkDN9ePohB2tzfYyBZi//yhabNZMZ
         QP2aeujeABcZR46+NAT9doCWdbaRbYrX5zVHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nD/CqNzR9E4HGpSddngZ7NQXINMID609Z0nuYAzxVQ=;
        b=qOj/Ot+5TXAdBBf8xz+rv5IlDnlU2XOC0239HGZVrdBuKe4qyo4c5c8V+DJBaeRKiM
         QijdCdQYNvSOb1intMyJh5O3B6XWc+ld3AYR8nqVEZQyiPZ56Uy5qQLmmeGX6qlQvKsl
         kJCsTRDXtmEc5F7CGKLp3tZ8Sy0TjXmnBRpnNeGMXosy18bexUElLwO7Mxg471SRNoRo
         6tfAxQGDruLgKZPCBSMWErhoj7J64qaoCDjB/e+GbfnUyIWMLrGaoVbOS2yqeZnPbeQq
         31vP8hzSMpD4joxil3eBqPSMlJYIXTV2xapwg56zdjr4e6cvEe+cKDeW2nPXDF7YW9jn
         ngUg==
X-Gm-Message-State: AOAM533PfkriVIWHxneW3CMqymS8it6kjLt6aMzqrGDJYXwXuzPRLB2/
        t4ncQcyVgrfL0eGzS8Urn47pfoyXVx7R6VzE
X-Google-Smtp-Source: ABdhPJwRbpO8iDIAURMd9xpaCjFSB9hF6mpfaDtKaMiZSNJvkXvcOJTXN+EEfddPbe98PDS4Z6lr/A==
X-Received: by 2002:a2e:a782:: with SMTP id c2mr17569723ljf.517.1633365529453;
        Mon, 04 Oct 2021 09:38:49 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t13sm822294lfc.34.2021.10.04.09.38.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g41so73976400lfv.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr16602800ljd.56.1633365528411;
 Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <270324.1633342386@warthog.procyon.org.uk>
In-Reply-To: <270324.1633342386@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Oct 2021 09:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ANpwDnAJ0HAdbwyti7Z6aBBJT6JEbkta9VjaF30Tcw@mail.gmail.com>
Message-ID: <CAHk-=wj-ANpwDnAJ0HAdbwyti7Z6aBBJT6JEbkta9VjaF30Tcw@mail.gmail.com>
Subject: Re: Do you want warning quashing patches at this point in the cycle?
To:     David Howells <dhowells@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 4, 2021 at 3:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Do you want patches that quash warnings from W=1

For W=1? No.

The kerneldoc ones might be ok, but actual code fixes have
historically been problematic because W=1 sometimes warns for
perfectly good code (and then people "fix" it to not warn, and
introduce actual bugs).

           Linus
