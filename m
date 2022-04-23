Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5B50CC52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiDWQjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 12:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiDWQjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:39:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F0E624F
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 09:36:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn33so13029717ljb.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qb5Szh+CcKy2SBrVNCKts80EODHTuY3uc2BaRSQms88=;
        b=DY1qADisgv4bdnv5TOJXAoTsHGxPnzMJtTUEpOVn3Cevi/YDTmZqy13LyQ+f7Fzr8f
         BDsGuSh7cddzLWLWnuMvJFflGmiSd5+Ou/nCN59b52nfewu0XF6gU/hq/w0YVaKtMhOi
         nAuo0+xpgMEeAUbjsbMs9AtgbjUdaSu4QnUeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qb5Szh+CcKy2SBrVNCKts80EODHTuY3uc2BaRSQms88=;
        b=CtznbmXWe+6kmg5jIHe3xn72nprZVmOSmqCTj3BODoWJxSN0G7KM49kxLq1rivhMaf
         vFALKLEyT/9l+m03B7Cykt3r2bAFEm2ywCjbHJmZO8k7N3YgxJRtCjtfD85xog3jIrvh
         40m27SwSuRpSV7K0vnqEsF3y/01NgN0u3cK+3gmmIb2cCsypAkO+57vyQErM6ms9bnyp
         pTowGvFMTc1A371BBDrW6h/OyvBcdqW5eZAuLUDB+Sn/D+TY96LBDYWAlwoSb4jvveo4
         FddCFDZinqwMOA1twPF53QRQ+BOwyfJUOEKOTLauPL7QTsB+AVJXOvYML4tzqdDIB5JM
         LozA==
X-Gm-Message-State: AOAM531FhI3ScgkZ3cAxqhtICzpns5kHfybH/y+/9UR94HtC6pPz7SVS
        jGXicCDOlSLt/PkpqsHKUmG1zo2ivW4OTFTl
X-Google-Smtp-Source: ABdhPJxRFYQhu3sKZCFppuMjHopS6R/9BQrytM4794fmhfGMo9Zl8GN7H4EJgmg6H79AcDLDLV8QvA==
X-Received: by 2002:a2e:bf12:0:b0:249:3a3b:e91a with SMTP id c18-20020a2ebf12000000b002493a3be91amr6097972ljr.343.1650731762983;
        Sat, 23 Apr 2022 09:36:02 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p7-20020a056512328700b00471e9ca15b6sm519007lfe.245.2022.04.23.09.35.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 09:36:00 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id bq30so19312887lfb.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 09:35:59 -0700 (PDT)
X-Received: by 2002:a05:6512:6d4:b0:470:f48d:44e2 with SMTP id
 u20-20020a05651206d400b00470f48d44e2mr7148386lff.542.1650731759019; Sat, 23
 Apr 2022 09:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
In-Reply-To: <20220423100751.1870771-1-catalin.marinas@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Apr 2022 09:35:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com>
Message-ID: <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 23, 2022 at 3:07 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> The series introduces fault_in_subpage_writeable() together with the
> arm64 probing counterpart and the btrfs fix.

Looks fine to me - and I think it can probably go through the arm64
tree since you'd be the only one really testing it anyway.

I assume you checked that btrfs is the only one that uses
fault_in_writeable() in this way? Everybody else updates to the right
byte boundary and retries (or returns immediately)?

             Linus
