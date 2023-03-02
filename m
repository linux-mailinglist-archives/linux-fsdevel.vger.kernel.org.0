Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B56A8934
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCBTLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCBTK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:10:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A545506B
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 11:10:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o15so995868edr.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677784221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjZUS58uO/4cp4F+HOOvaFHdemHu/dQSnYjcnUBCECA=;
        b=XS9jwU97vp2iRecHS67+yW7nKfBIjGIVzjTCrxTZji4bmZ/TtJNTQFZcHTB67qLslK
         vg4hnoT/zFqmLndtWoXwBhXFKB/ARtUn24UU95MilbxGow59e08QdvIZhx1hn6hJNUC7
         HryP3hmdj9llUUHbeaUHyKTOPtsywMF4rTFl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677784221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjZUS58uO/4cp4F+HOOvaFHdemHu/dQSnYjcnUBCECA=;
        b=AbRShVudT2zQBlUKAJ3M6ZI3oBDcpfCM55fPruF9z/LK60XD6KR2Ly0CCMvLildZvH
         ML+IjJ/Of7z9/qp9bw+f7unV64u7QQtY42vKBZntFM1wnzcmrqSvnUPizryvmRWBJIwi
         61bbck6vgiGdGQh80oYIWVTga35eB18cmJFWHYDd/AX6yokpJ0Px04QMcwGz4L/NprF7
         5DPxL8Rymp0bdQoBIbQMb5hP/kyukcKyiumAl4bngYWZxx6NEr6bN9fJCQges5XD0WRU
         KhGVKbOkjjXpRN4jxDtrY67TzqFj44PFvUaaN8uJq9Tx9JFcdr/M7/bBIjYe8dFiJ+m1
         E7sA==
X-Gm-Message-State: AO0yUKVgOFib2onVPmt7kNPxa33H2zIYeSIIUVmPCnHniz+sTzYIZO8Z
        9x9WTbkCxBAz/pdNAEOhpjFTvTwCAa2vie0qGu4=
X-Google-Smtp-Source: AK7set/hTWf2TSLfoTpnf6xC0GvsWl2AQtjZomiHyXDoWr+w0HXbkr8JB5kStMIXmt/GMEG8Li33tQ==
X-Received: by 2002:aa7:c7da:0:b0:4ac:b6b2:1233 with SMTP id o26-20020aa7c7da000000b004acb6b21233mr10640012eds.30.1677784220917;
        Thu, 02 Mar 2023 11:10:20 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a38-20020a509ea9000000b004c041723816sm214508edf.89.2023.03.02.11.10.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:10:20 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id cy23so1014023edb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 11:10:20 -0800 (PST)
X-Received: by 2002:a50:cdd5:0:b0:4bc:13f5:68a5 with SMTP id
 h21-20020a50cdd5000000b004bc13f568a5mr3966173edj.5.1677784219765; Thu, 02 Mar
 2023 11:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
In-Reply-To: <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 11:10:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
Message-ID: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 2, 2023 at 11:03=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> just to make it possible to say - exactly in situations like this -
> that this particular slab cache has no advantage from pre-zeroing.

Actually, maybe it's just as well to keep it per-allocation, and just
special-case getname_flags() itself.

We could replace the __getname() there with just a

        kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);

we're going to overwrite the beginning of the buffer with the path we
copy from user space, and then we'd have to make people comfortable
with the fact that even with zero initialization hardening on, the
space after the filename wouldn't be initialized...

            Linus
