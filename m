Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B200C573C51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGMSDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMSDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:03:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13823559A
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 11:03:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v12so15083410edc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tc5EcamOBb8LKbS07vyTCWd+lyDqHTTa3tTzVK/S+kw=;
        b=Mi2PgFAXDBaUuwBrt4D9g1zII0o+cCznDSIxaR993lwJ6NYUrkzd20gp/vsoT29dVj
         QJIsEIb38bNIPV+rGCz2T0E8FVTkIegYq8k5hpu7SwaSsOVzPqfeJmCJtJhxWi0MEQy5
         Y+jzBtd+XHoCBHu2gbmtiHEfTRLbVI2x/LHxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tc5EcamOBb8LKbS07vyTCWd+lyDqHTTa3tTzVK/S+kw=;
        b=zgxXbuXjFtju6fYxIAfQDePeyOdEg591j6BmXgvw2y/TbovBO2Qv1kU/laYYxQx3j6
         j0cqvgw4rvy4kAhCpKfwWKU3BU6Qescwuzqkr3avyclfqEoPYyTpzbMhOaPYMrUZywJ7
         Kd39tAQvlshpBIrZpKWEVpS38du6LiQ+/830ISjiR6BS3MDwaIBDMYyydzq2BWDglRmp
         4FxA2a3nWS6MECkNtfo2TO1rzc87tKYRECB4aX38EuqnGDW1ynbKRYxnmaM3n9S9vrGy
         H9QD4Fdu25gJZSPPeWljMMHAVfes17qVf9O4Z0l0nhxLuZ/eqGyq/eukXOPFsSq4kvSK
         0OMw==
X-Gm-Message-State: AJIora+xtT7TAzomRhILpAm5diwgJmv3a+3eFL10k+XAQEB+9WyFRRxP
        wrl1XHlNiI5rUzpyYsEtlDTUQBnR8teo9ZtDhQI=
X-Google-Smtp-Source: AGRyM1smjKkEFfHU1pIiRXGuUMANyd3ZKQvaACsY6Yma2LT/XVDNtPA4FA3vLQ1nPsOQntXuuC5n6A==
X-Received: by 2002:a05:6402:270d:b0:43a:d1e8:460b with SMTP id y13-20020a056402270d00b0043ad1e8460bmr6487619edd.40.1657735418419;
        Wed, 13 Jul 2022 11:03:38 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709064a4600b0071cef8bafc3sm5305034ejv.1.2022.07.13.11.03.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:03:37 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so1690683wme.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 11:03:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id
 g9-20020a05600c4ec900b003a2e9bdfcd9mr11312527wmq.154.1657735417146; Wed, 13
 Jul 2022 11:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com> <13861bb3-84d6-634a-13fe-8b7a626aa147@tu-darmstadt.de>
In-Reply-To: <13861bb3-84d6-634a-13fe-8b7a626aa147@tu-darmstadt.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 11:03:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4Nba5LVqgKxJMDUBds9Cudv2o9b=5qXzkzeKqqq+DsQ@mail.gmail.com>
Message-ID: <CAHk-=wj4Nba5LVqgKxJMDUBds9Cudv2o9b=5qXzkzeKqqq+DsQ@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     ansgar.loesser@kom.tu-darmstadt.de
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:15 AM Ansgar L=C3=B6=C3=9Fer
<ansgar.loesser@tu-darmstadt.de> wrote:
>
>
> Thank you for the explanation. Unfortunately I was not able to reproduce
> this. I do understand, that being able to write to memory without being
> able to read from it cannot be implemented because of hardware
> limitations on many architectures.

Oh, you are right, we actually catch that situation, and require
FMODE_READ for all mmap's.

For some reason I was entirely sure that this had come up and we
didn't, but I see do_mmap() clearly  doing

                        fallthrough;
                case MAP_PRIVATE:
                        if (!(file->f_mode & FMODE_READ))
                                return -EACCES;

where that "fallthrough" is for the non-MAP_PRIVATE cases, so it hits
shared mappings too.

I was sure we had hit this case and it caused problems to check for
it, but that test goes back to before the git days (and in fact to
before the BK days).

So clearly my "clear memory" was complete garbage.

And thinking about  it, I suspect said "clear memory" goes back to me
having issues with the original alpha port, where the hardware *did*
technically support write-only mappings (_PAGE_FOR set - "Fault On
Read", but _PAGE_FOW not set).

So alpha was the first port I did (and a big influence for how the
portable VM model came about), and page protections could be done
"right" in theory from a memory management standpoint.

But even then you can't actually do it, because writable maps required
reading _anyway_ - because the common alpha sequence was to do byte
accesses as "read-modify-write" longword accesses.

So that's likely the source of my conviction that write-only mappings
always require read accesses, but I had it exactly the wrong way
around - it's not even hardware-specific, but general, and just means
that we actually refuse to mmap() files that have been opened
write-only.

That should teach me to actually go and look at the code (or test),
not go by "I have a distinct memory".

        Linus
