Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8155243F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiFTSxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbiFTSxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:53:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9886341
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 11:52:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fu3so22855960ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BY+l3/iWa7w1itjUvaWxkXywRqC5+ZWN90+wmo8mRc=;
        b=MTHy/MIVd4Lv76xkjaJ5Pqvm9BzLO3/CezQNQZ1bD+H54NQEoEIgfcaHrz45v3z7+B
         ssM8VOxX0rXHZXbU3ddShrmSpkB4VzvQmBq8oBEYO4GR2goc00qYw64FZIlfWgtLMzw9
         Y3td9y7q0x/lZx4omcxKY2Y9EImXTIJy9yNSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BY+l3/iWa7w1itjUvaWxkXywRqC5+ZWN90+wmo8mRc=;
        b=Ok8xyyMyOT43MPxfXy/02IM2xAa0mAq5igcov+8G/PgqmDnS4OQivHmjObTywRpKic
         DYBXgr6AwVH9X60x/28677MUkZd/kJB60bHvd2iv5Db61T+XeIqZ+2qJMhBtzHYpLDG2
         ClaJXGhk0f5DzTZyXHb2NvUMeXCLPRe64L+2ektjyFBpzGlDIA7NWdIoVm5EuNtntkiX
         bVF18O5pCLCKjnajJwsaWmmSWxAWiIrzvzXldLo7S3iw28k7rW3jJepJhxH0LV//jK9g
         iDxhTeDVs5FJdJr+UPnfeKtY5z5MXxuyC45a/mRwOhHKKVOqkmXBdW2op8q6h5xIcEJ7
         +WSw==
X-Gm-Message-State: AJIora/iH3/17CLDEbwaT6xxIEUyTLFJEvbFRESPJs/D6Qls8nhI7V11
        Lq4mTUXYZEG8QK43JGA4IXltgqJa+413yRWr
X-Google-Smtp-Source: AGRyM1tt1C1Q+z0TZ0KJcss66ONlKshCsi0xZ21nJOf7sfju4HwmDQTkS30quiwvLIOfDw+rRW1q2Q==
X-Received: by 2002:a17:906:5789:b0:70d:20cc:fc73 with SMTP id k9-20020a170906578900b0070d20ccfc73mr21927631ejq.473.1655751177708;
        Mon, 20 Jun 2022 11:52:57 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id w13-20020a056402268d00b004359202969esm463666edd.4.2022.06.20.11.52.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:52:56 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso6119779wmc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 11:52:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr25790980wmp.38.1655751176442; Mon, 20
 Jun 2022 11:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134947.2772863-1-brauner@kernel.org> <20220620134947.2772863-2-brauner@kernel.org>
 <CAHk-=wjapw1A3qmuCPsCVCi4dynbDxb9ocjzs2EF=EDufe8y8Q@mail.gmail.com> <20220620152514.wqf5itczv6xtsa3u@wittgenstein>
In-Reply-To: <20220620152514.wqf5itczv6xtsa3u@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jun 2022 13:52:39 -0500
X-Gmail-Original-Message-ID: <CAHk-=wi1LrCrMrryuSXfom=Tye-wD5_P1anyakY5tCfHhwHPUg@mail.gmail.com>
Message-ID: <CAHk-=wi1LrCrMrryuSXfom=Tye-wD5_P1anyakY5tCfHhwHPUg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mnt_idmapping: add kmnt{g,u}id_t
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:25 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Originally I called that kfs{g,u}id_t but I was never happy with that
> either... I think either vfs{g,u}id_t or fs_{g,u}id_t makes sense.

vfs[gu]id sounds good to me. That way we avoid the confusion with our
current "cred->fsuid" thing due to the access() system call.

               Linus
