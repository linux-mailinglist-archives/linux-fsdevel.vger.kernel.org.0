Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807057794DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjHKQjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjHKQjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:39:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA32D70
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 09:39:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcc0adab4so293756666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691771947; x=1692376747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIHlgRVD4zuIsPHrllchsXgEvRrrKBDJPCXSLRIlRrE=;
        b=HKHeGXsCsnFAgm5g19pTrZh7wlETPzz6bibBKIHF7dFVtlcbrZfdZx/5fo+bjGFGKR
         JlmyttburRrNMleVRL7az+QY06Z99EU/gQdrtZiZtFMDu9QYak1AQGY/CfVzd8BSx0FQ
         YYXV9UECSnsSqdxDAaAJ2Pm0riRPcsoqhgyK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771947; x=1692376747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIHlgRVD4zuIsPHrllchsXgEvRrrKBDJPCXSLRIlRrE=;
        b=X2Bs2oYbtuvS/Kypcu2+8dWprCzE15CeiDIUt5MbiOfET9zwy1wgdR0bbtKSydTcSB
         cRv052o49EbjvOOj8AuGYoUgwK43yZbVCeq0uZqU8H6y2zxX4krNpmPMCQV/QAC8wtns
         JN7sEngIUZ5p2lnpAC9J5rGcijpuTvxYCsdlTQnMIeyN9ZZIiNsZvm48C9ZpWpHAV10o
         /7d8SgoHyfRQ7AUxlbJAhsYsurDxe7CxX4G0BK1xX8gPv16Rw+91KcNthgY/TtvY8YjW
         48pKQCfkq3koI8T3JUfqE9epQm7miMqZjev5Q2ni/Txhm6YeeJVgc/Rd2NKwMa5MfV35
         kwZw==
X-Gm-Message-State: AOJu0YwRzdx4S+mCYQxjFBdEFvbmluU1sn4AXHeK0MGxJD2gM2Trv7i6
        r9FZM3ikWiIO7r7R3/8q+ZyNhDU5mSQLYIkmuagBayZA
X-Google-Smtp-Source: AGHT+IFuO/cJAo8hBjZnH67xnyyBuNCn2vkHqFMeMEycTnaLlyvdN511ZjRfszlBvd0k+K0eGjiykQ==
X-Received: by 2002:a17:907:9715:b0:99b:db4f:68b8 with SMTP id jg21-20020a170907971500b0099bdb4f68b8mr2503094ejc.76.1691771947304;
        Fri, 11 Aug 2023 09:39:07 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b0098e34446464sm2450194ejb.25.2023.08.11.09.39.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:39:04 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so2927997a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 09:39:04 -0700 (PDT)
X-Received: by 2002:a05:6402:184c:b0:522:ae79:3ee8 with SMTP id
 v12-20020a056402184c00b00522ae793ee8mr2037905edy.5.1691771944135; Fri, 11 Aug
 2023 09:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <3710261.1691764329@warthog.procyon.org.uk>
In-Reply-To: <3710261.1691764329@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 09:38:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
Message-ID: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Aug 2023 at 07:40, David Howells <dhowells@redhat.com> wrote:
>
> Convert the iov_iter iteration macros to inline functions to make the code
> easier to follow.

I like this generally, the code generation deprovement worries me a
bit, but from a quick look on a test-branch it didn't really look all
that bad (but the changes are too big to usefully show up as asm
diffs)

I do note that maybe you should just also mark
copy_to/from/page_user_iter as being always-inlines. clang actually
seems to do that without prompting, gcc apparently not.

Or at *least* do the memcpy_to/from_iter functions, which are only
wrappers around memcpy and are just completely noise. I'm surprised
gcc didn't already inline that. Strange.

            Linus
