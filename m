Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378C370C481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjEVRmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjEVRme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 13:42:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC55FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 10:42:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fab30d1e1so462385666b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684777351; x=1687369351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=TXiT4G41d+/QacX49+njbr4cngiQQjIe0I3U0q+googMR1+xhIyTmHA95E77iZJ8w8
         rfiAnF/wDTn8b1pFdobvBOIDmt8Dt39vxkrgawgKQ7IiL7ON4cw3gDofK+aS5XMbKZuD
         ar7Px3z7dtoYcC3dG/8itMjQ8eRLrv6Cb07Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777351; x=1687369351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=VGvHETOrcdoEpcVFjoLC17o/8xh69VlpwLr0p4I3/aWiF3+Nlfk785vjz94j5a9pi3
         7Kwa6YhTz43Xzk4xGsBJiRX9LYOa4MzXkaxgJQukBAoz0Ny9kcOwEOtIOLNpHRhQoh8O
         3Qtm78AE0CSwGrUyXKRmpz6j5K6+XA7ztVzJiWVTx0cqky9sn0iLCoB09Fx426ntAeVU
         oPS8Bvws7nSSIPiaWTORzP8TTzxvoRHVJWVF9Rye0atLFFdogSRUk9BaYwUf9OzHc4ET
         l0P7j7FRC4y+xUsCOlLxo3PcqjMIN4VQ50bh44e1MKOL9ijBMFByrCAHT/X/NeF2shFP
         ptfg==
X-Gm-Message-State: AC+VfDzeXt2ZFHteAZqDmxSsfYHwM1LbOk2wjIdRtc8hPilVgu6+ATe5
        KnYfcuh/P9wvof+U/aeo0ql5xfH50CA5ubs4/CCUww==
X-Google-Smtp-Source: ACHHUZ518DkAfnZteFy+hCwwKmIgA8cboayD03sOigR8ugYma15HcA4PXhboF9ltso+Tf0fwhKUlDw==
X-Received: by 2002:a17:907:6287:b0:966:a691:55f9 with SMTP id nd7-20020a170907628700b00966a69155f9mr8980470ejc.30.1684777351498;
        Mon, 22 May 2023 10:42:31 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906844900b009661484e84esm3382611ejy.191.2023.05.22.10.42.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 10:42:30 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-95fde138693so791997266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 10:42:29 -0700 (PDT)
X-Received: by 2002:a17:907:1688:b0:965:d7c7:24db with SMTP id
 hc8-20020a170907168800b00965d7c724dbmr9757222ejc.32.1684777349281; Mon, 22
 May 2023 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-24-dhowells@redhat.com>
 <20230522102920.0528d821@rorschach.local.home> <2812412.1684767005@warthog.procyon.org.uk>
In-Reply-To: <2812412.1684767005@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 10:42:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use direct_splice_read()
To:     David Howells <dhowells@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 7:50=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> We could implement seq_splice_read().  What we would need to do is to cha=
nge
> how the seq buffer is allocated: bulk allocate a bunch of arbitrary pages
> which we then vmap().  When we need to splice, we read into the buffer, d=
o a
> vunmap() and then splice the pages holding the data we used into the pipe=
.

Please don't use vmap as a way to do zero-copy.

The virtual mapping games are more expensive than a small copy from
some random seq file.

Yes, yes, seq_file currently uses "kvmalloc()", which does fall back
to vmalloc too. But the keyword there is "falls back". Most of the
time it's just a regular boring kmalloc, and most of the time a
seq-file is tiny.

                      Linus
