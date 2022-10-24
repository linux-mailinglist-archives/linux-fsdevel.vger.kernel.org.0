Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240160BD54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJXWZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiJXWZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:25:06 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C4B3172A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 13:46:02 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id i12so7280719qvs.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iSOcydxSXUj96NbU/Er00mnbcEfNU+h40IX+5ItHvVI=;
        b=NdKygZeWtxEfUI9ndMdtc/4AWy07NJQctRLiPLF2eQWEQbYBk4YSxN2tF74liqneT2
         DizOz3/Yz4Eij2YMSyEWq79hgUDw9jAOSR2cbNueYcyedkMrPG+4sHU1EBFXmAmL7PKe
         NNXZcMMs/prAxArt0WyhEnqh+iQq4THrGL3oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSOcydxSXUj96NbU/Er00mnbcEfNU+h40IX+5ItHvVI=;
        b=4uOV0naDn7S81xp+mFOJFxeH0Wi4UFV5dXBDvKf+eeOi1r6ZH2GiIdVP03fRRJbzDa
         vhaNStyB6JdyrR5lCDCcNs9VwpcdhQuQwuVeYt30HsYXawvIkO2lbZ7vAPlLtiLSy3tE
         R1o+qAZRkVhLKcMhReQAn5SVWlrFLVrj16j6qUnGq9N/o9QUHqGzdLn2cV9YVOazExNR
         rdssa2riHozUdfzGIM4WtCkKWkKfqnqeYm+tmm2aI8HejSKXBVFCqS08LMxtmYBqKr8E
         lTWtsJ+ILuCz1VVJ0fS1CPz8VeYeMCwoMDiaUI6GjTU+18FMhm38QAY7HEDNAP3zZujv
         HRUw==
X-Gm-Message-State: ACrzQf13QP9LWS9cJoI9WcpQz0lnZLR3+LO3VaUjgnIKNT7p4XZ+shZp
        jf9B2en8wpamjq4CjMnbz0G6oJgHIcvciw==
X-Google-Smtp-Source: AMsMyM4+QOgUosMSR86BXYKZIeVYSh0KUTfct5f2SveoA11HzKFEMkBagXCcYpqCMsevSh4meTmVpA==
X-Received: by 2002:a05:6214:21e5:b0:4b3:f3e0:5432 with SMTP id p5-20020a05621421e500b004b3f3e05432mr29028877qvj.19.1666643329631;
        Mon, 24 Oct 2022 13:28:49 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a24d200b006aedb35d8a1sm602560qkn.74.2022.10.24.13.28.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:28:48 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 185so1766711ybc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 13:28:48 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr29953243ybb.184.1666643327656; Mon, 24
 Oct 2022 13:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster> <YjSTq4roN/LJ7Xsy@bfoster> <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com> <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 13:28:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
Message-ID: <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        jesus.a.arechiga.lopez@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 1:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Arechiga reports that his test case that failed "fast" before now ran
> for 28 hours without a soft lockup report with the proposed patches
> applied. So, I would consider those:
>
> Tested-by: Jesus Arechiga Lopez <jesus.a.arechiga.lopez@intel.com>

Ok, great.

I really like that patch myself (and obviously liked it back when it
was originally proposed), but I think it was always held back by the
fact that we didn't really have any hard data for it.

It does sound like we now very much have hard data for "the page
waitlist complexity is now a bigger problem than the historical
problem it tried to solve".

So I'll happily apply it. The only question is whether it's a "let's
do this for 6.2", or if it's something that we'd want to back-port
anyway, and might as well apply sooner rather than later as a fix.

I think that in turn then depends on just how artificial the test case
was. If the test case was triggered by somebody seeing problems in
real life loads, that would make the urgency a lot higher. But if it
was purely a synthetic test case with no accompanying "this is what
made us look at this" problem, it might be a 6.2 thing.

Arechiga?

Also, considering that Willy authored the patch (even if it's really
just a "remove this whole code logic"), maybe he has opinions? Willy?

                 Linus
