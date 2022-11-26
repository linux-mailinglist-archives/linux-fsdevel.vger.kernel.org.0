Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65106393BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 04:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKZD3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 22:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKZD2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:28:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585D1BE98
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 19:28:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q12so1525914pfn.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 19:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Q0CkdkqL9ImdAVIDGKbxO6HhGOHH4+dcxvWGaloTI=;
        b=vQcrIjz+iAM4/+6KK9dOteBewZBvvuRjY78MAP7M2DIEwDl8oHKd3zWvIBxPymedBf
         w5Rl+FKB5mm8EamXRDV2s8ZYZC+OjgCQw1bcgYORXysDXExH5CA7rLzA/KYSrSm1Ki66
         4ckYtkPBNi9EFEaqe2ZXhZpQ5igywGjXmEqbiEfDl9f9b92Tj8X8uNIC99qorP1ATkTH
         o3j9q5Nl6x0hT7VrvpvS/cc8j6q1tTP3NQWvdftuplhsVIwaKyBSymofiBuEpuqtp3KT
         c4HcAoi1GGw845MdrJMfDChzoMSR0m3RJMQC5vrR4sE/NwzJNDaGvNfDHE+iM6vBibim
         EprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5Q0CkdkqL9ImdAVIDGKbxO6HhGOHH4+dcxvWGaloTI=;
        b=mej9prhhYMPrFm7AuEFNnYo1VWJMHDhIbjfUyGQK/zMoltWl/0jHvTuNWWUOhYzhg8
         uD2EJ01Kkg347QLDrtvbmykQ8oS63YNTCc1wiBj5z2GrHnTg+odKhXU2Dnx6MbUvotKl
         tz4v4IJYpPRIVMLhh0FF2meONxFuoJyrHXHN4EcYh1O5g2RXwflyNAUG9xPF1VFpVQAU
         OFlQ0MIIzLV8wRQdRoIGivh/bG16RCZP/zIZy5AjndD/+RWI5IZeJW8z1ABQkNRu1NdQ
         HegECqGHuvcNOXqBKRwpHn59U28Uu23LFs5Hvs7LGG06H4WsQ7U/QiTBKGYaLKBKv4kT
         cXEQ==
X-Gm-Message-State: ANoB5pl7mWJZUyJ7ugOTBS4GZx5Qtquh0J+4GZa+R2KUA1ljJpPxP39A
        yXezlRKrq7i4GR5sOIMufclwHlcxZ6HXRG1IuoLas6Nb2r3Qzw==
X-Google-Smtp-Source: AA0mqf6YrmynoSeLWrq1OCN23+0Rw6OG8maifO+H3HCjpykKHdKuyYwAhZaS6xlcO7VtSexNJ9pGce/dN9tHv7AhpWA=
X-Received: by 2002:a05:6a00:c5:b0:56b:a4f6:e030 with SMTP id
 e5-20020a056a0000c500b0056ba4f6e030mr23264033pfj.85.1669433328402; Fri, 25
 Nov 2022 19:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20221125070959.49027-1-zhangjiachen.jaycee@bytedance.com> <20221125165242.a33918e30cc9dc70750ed95f@linux-foundation.org>
In-Reply-To: <20221125165242.a33918e30cc9dc70750ed95f@linux-foundation.org>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Sat, 26 Nov 2022 11:28:37 +0800
Message-ID: <CAFQAk7ja-d-QvccAYHWAUR=P3Jf9Sh33wn=MSTfao-BE9q9Qjw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] filemap: Fix some misleading comments
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 26, 2022 at 8:52 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 25 Nov 2022 15:09:59 +0800 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com> wrote:
>
> > The users of filemap_write_and_wait_range() and file_write_and_wait_range()
> > interfaces should set the lend parameter to LLONG_MAX, rather than -1, to
> > indicate they want to writeback to the very end-of-file, as several kernel
> > code paths are checking the 'wbc->range_end == LLONG_MAX' conditions.
>
> Unclear.  LLONG_MAX differs from -1 on 64-bit and differs differently
> on 32-bit.
>

I think whether using -1 or LLONG_MAX causes no difference if there is
no other code comparing  'wbc->range_end == LLONG_MAX'.  There is no
case in the kernel code using -1 for now, but maybe we'd better fix
the misleading comments to prevent future misuse.

> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -661,7 +661,8 @@ EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
> >   * Write out and wait upon file offsets lstart->lend, inclusive.
> >   *
> >   * Note that @lend is inclusive (describes the last byte to be written) so
> > - * that this function can be used to write to the very end-of-file (end = -1).
> > + * that this function can be used to write to the very end-of-file (@lend =
> > + * LLONG_MAX).
> >   *
>
> The write(2) manpage says "According to POSIX.1, if count is greater
> than SSIZE_MAX, the result is implementation-defined; see NOTES for the
> upper limit on Linux." And filemap_fdatawrite_wbc() enforces LONG_MAX,
> which differs from LLONG_MAX on 32-bit.
>
> I suspect more research is needed here.

The reason 'wbc.nr_to_write' might be set to LONG_MAX for
filemap_fdatawrite_wbc() might be because 'nr_to_write' is defined as
the 'long' type. Maybe it should be fine as 'lend' and 'range_end' are
defined as type 'off_t'.

Thanks,
Jiachen
