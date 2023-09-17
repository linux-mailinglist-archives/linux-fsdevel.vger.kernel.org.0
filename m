Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035857A36FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjIQSKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjIQSKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:10:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A91129
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 11:10:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50317080342so415396e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694974201; x=1695579001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nPh6x9aEfKjMFpChJgZC4Fil+eS6ir7xBAr4/X5FntY=;
        b=Pi04PJ7fDSYpqSZShUoLiC1iHMgCWdaz0a+bdP4Gn/rHCjh/Xn1Xjw4Rg7973s3W71
         LWByoYBojV63z10HU0l2YLoTyWRJ1YgGKI2lXB2gP6LVo9SJMauHs9ZPA9GMK8I6YKHv
         TVAc6a3W8mTIZ975PoJdGQGf6UZh+J6MO0B6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694974201; x=1695579001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPh6x9aEfKjMFpChJgZC4Fil+eS6ir7xBAr4/X5FntY=;
        b=jffjBzdsC1NDa5YYVifnzDKrt358V9NcnPI3z6XfN6SzUSKb/scN9F5IH4dUTSnSQr
         QInPFPTYGZIi0rH8UeLGGTFIpvghU+Zvza9zB26fZmOrt+Bh/RwS0M6y9p+Gx4dfrOgT
         8AdZ+kFrVjY+Ul0DtQxlHiWfs3pas65aYfF1VrUodlO1eilpGUe81uDJHtg2q7sHgQP+
         XwPX3VDCV5y1mw6ekde2jZbaoCnA7lkYeVXYUdoozdld6bagko+9oLnQIKaGDCWxzkWL
         B8C1ME/pfMmc4ucgBK1Fnqpcu7GsCF+XT/E+HBkRS1n6SaRhjbgVEldTOFr0ZG9RKcTG
         oXpg==
X-Gm-Message-State: AOJu0YxgH/qUof7U1H0liD1eneLfMcz2+UNjJ7lyXoyqa0SrsUfLDNNt
        WqN6VNVeVH/oVGgmXA65o0deaKlbjnLYnerZBlAb3p0M
X-Google-Smtp-Source: AGHT+IHjBFYV5cCI1LW59ghNAP7AmOCIvUXIJCwm2iWVghcHqqNvDY/ycOneoZy6K9ydjX81v/ErUg==
X-Received: by 2002:a05:6512:70d:b0:4f8:62a6:8b2 with SMTP id b13-20020a056512070d00b004f862a608b2mr5302381lfs.46.1694974200880;
        Sun, 17 Sep 2023 11:10:00 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id c15-20020ac244af000000b00502c642ae8asm1484982lfm.109.2023.09.17.11.09.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 11:09:59 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-502a4f33440so6085532e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 11:09:59 -0700 (PDT)
X-Received: by 2002:a05:6512:525:b0:503:c45:a6e9 with SMTP id
 o5-20020a056512052500b005030c45a6e9mr1751068lfc.39.1694974199018; Sun, 17 Sep
 2023 11:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area> <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name> <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Sep 2023 11:09:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGXuGWftrSWgDgYPrW4devkTjE14CL4+us4igcNkVDJQ@mail.gmail.com>
Message-ID: <CAHk-=wjGXuGWftrSWgDgYPrW4devkTjE14CL4+us4igcNkVDJQ@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     NeilBrown <neilb@suse.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
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

On Sun, 17 Sept 2023 at 10:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sure, it's old.

.. and since it happens to be exactly 32 years today since I released
0.01, I decided to go back and look.

Obviously fs/buffer.c existed back then too, but admittedly it was
even smaller and simpler back then.

"It's small" clearly means something different today than it did 32 years ago.

Today:

   $ wc -l fs/buffer.c
   3152 fs/buffer.c

Back then:

   $ wc -l fs/buffer.c
   254 fs/buffer.c

So things have certainly changed. LOL.

              Linus
