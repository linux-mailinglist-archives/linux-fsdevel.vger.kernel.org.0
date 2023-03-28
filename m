Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745C06CCA63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjC1TFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1TFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:05:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776782690
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:05:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so53768622edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680030342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH6qVSVNYYjL/WOnblgueAC0k2yBN2UdkUGAywHMf0U=;
        b=R6ZtZOIMu54/r7wg/aMDrxeHJ4Iee163X/D9p/W5XiAwy1zG8YozgvsUBmV85X5Wtg
         P3TQ7WYOoO0axNTH38wg4AURm7+yqBR9o3DdsWyJ87umuZGJ5nFv8tn7lPDxl90gu7my
         mCZGiRHaDIEsWLik3SKtaWzXb1kgROjEDDDws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680030342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH6qVSVNYYjL/WOnblgueAC0k2yBN2UdkUGAywHMf0U=;
        b=W0NqOMPIQRG/VkVUNhGh+n2/spmMPM2OmN16U+DRNLAUZa9eDc3X+VXxMyB1zFHAq/
         lNlUaZHZaLERnopSfmcaslU90edTyeP3zCxTIYSyRsuKFz7mBfE0gEpxXr1gO2AOEnQ+
         pWDUjbA+QYc3sRjzrlYZBV8gf8oeu7Mj6yI3BGZXOKYYRjDkBGXJNuQQA95oEnHGpVKx
         Sb7ux8jvNKMp8wcDWRFREsk0GyoNuSp5b+D779SqvsLfV+DVfb5tODjfx3Tv+FifO0h3
         qlz3Rme2JqPo7fipLYJfK4JZpUEie/LUh5GKRGJeahYGKqMl54Z8ELB1Woq+egFibOZh
         nmcA==
X-Gm-Message-State: AAQBX9dGJpeSDTXQ+MjkwQpS+szhbZdPPa+PoMB7SwWgf1BA8PyS7uvB
        m2DgrAOdq6l1JP3dl6i6eywlPHnSXT2Chm4kveuW0w==
X-Google-Smtp-Source: AKy350ZeKy1pT7k28fZ9b2OAJ3/lYCS9alFaEtXtiUWw8gyg8FEmS9Ce6WjTYFpT44PhtxBhNFOvFA==
X-Received: by 2002:a17:906:2547:b0:931:e5de:d28d with SMTP id j7-20020a170906254700b00931e5ded28dmr17098891ejb.33.1680030341754;
        Tue, 28 Mar 2023 12:05:41 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm15490648ejc.197.2023.03.28.12.05.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:05:41 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id x3so53768417edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:05:41 -0700 (PDT)
X-Received: by 2002:a17:906:6b84:b0:931:2bcd:ee00 with SMTP id
 l4-20020a1709066b8400b009312bcdee00mr8215593ejr.15.1680030340929; Tue, 28 Mar
 2023 12:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173613.555192-1-axboe@kernel.dk> <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com> <ZCM4KsKa3xQR2IOv@casper.infradead.org>
In-Reply-To: <ZCM4KsKa3xQR2IOv@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 12:05:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
Message-ID: <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF iov_iter
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:55=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> I think it'll annoy gcc, and particularly the randstruct plugin.

No, randstruct doesn't go change any normal data structure layout on its ow=
n.

You have to actively mark things for randstruct, or they have to be
pure function pointer ones.

But it's not like adding a 'struct iovec' explicitly to the members
just as extra "code documentation" would be wrong.

I don't think it really helps, though, since you have to have that
other explicit structure there anyway to get the member names right.

So I don't hate your version, but I don't think it really helps either.

             Linus
