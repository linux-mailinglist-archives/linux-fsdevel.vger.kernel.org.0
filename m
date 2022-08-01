Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF9586E57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiHAQM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiHAQM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:12:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DED1117B
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 09:12:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so8280205ejp.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o7YLDWp/HQ8+VIdGGoWwDf5GNDP+fMQa77PB0KY66Kg=;
        b=G1+XdKeRi6JeiafbwektiTaln+hCPgsiBzIhFmoZNxV24Bc9UoFyWrjaqrUDS/t8FX
         111SSjnhyb/fOxmWnqbCxVC+tfzcu9VRnZe0m2FIEidys9FshZnMUmifrNsJCJ/8vOmR
         VBwtICzkqhLPss6QW4P6o9AHz4AuYhJGzfp6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o7YLDWp/HQ8+VIdGGoWwDf5GNDP+fMQa77PB0KY66Kg=;
        b=CTlx7bGqt2TrTWe3kfRL6+m6gDqwQwIFaSDY0SjUmI6hRL3wk2a4nZ5Y80xR6nRMJu
         DllP6owjiMvzcjb69zrHop/biiVUFPAxLWAt5Xd7y3vrLPNMUtGe60In6JNRwVZ4wPN7
         Fa8emkE04N1/Ab9WepmcqMl0pTE/VlHJQL+7dJrjDIYA+AT72pvCj1Vf18GrmmbPfbbs
         bTtXXZP9rr3ObQYUJ85ZroCk6MkEFMyLGyst0LfUvNXbBkrD7ifDduT6ikygzYUaTkp8
         sGIAkx+/s4e3dmx3gJH2EknJ1H0fsuGJIYXTHHx00SAK/rnlVYOGob5lf62+OqA7P/rh
         c8yA==
X-Gm-Message-State: AJIora9vXtPXNJ6IP7iEIVis3WlHAb9u6xxm1OcpIhsT7WiGBgdHX7Dw
        dAqHs1jQH3b1QD6NVSBa4Yj5I29X2o3s+PylZnA=
X-Google-Smtp-Source: AGRyM1vGCCAcfrgaJiBAqzUkm+75dfpv/eur7AfYk52rvL8XijWU6gKMjsWTdefKQIeF3rDRIcdSgQ==
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id di4-20020a170906730400b006ff0a765b09mr12947255ejc.193.1659370345248;
        Mon, 01 Aug 2022 09:12:25 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id cz13-20020a0564021cad00b0043bbb3535d6sm7036846edb.66.2022.08.01.09.12.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:12:24 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id q30so10317972wra.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 09:12:24 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr80096wru.193.1659370344396; Mon, 01 Aug
 2022 09:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220801145520.1532837-1-brauner@kernel.org>
In-Reply-To: <20220801145520.1532837-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 09:12:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfZgtQgW6Nd1BLdY5G7PTVmEjs6Qe-JFn4NMjNzTGMdg@mail.gmail.com>
Message-ID: <CAHk-=wjfZgtQgW6Nd1BLdY5G7PTVmEjs6Qe-JFn4NMjNzTGMdg@mail.gmail.com>
Subject: Re: [GIT PULL] acl updates for v5.20/v6.0
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 1, 2022 at 7:55 AM Christian Brauner <brauner@kernel.org> wrote:
>
> What follows is an optional excursion into posix acls which provides a wider
> background. But the pull request message can be cut off here if not useful.

I actually would have loved to have it, but honestly, it would make
"git log" somewhat unwieldy for people who aren't directly involved
and interested.

So I put a link to this extended background info in the commit message instead.

               Linus
