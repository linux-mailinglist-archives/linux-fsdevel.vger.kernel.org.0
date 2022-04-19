Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180B5060DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 02:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiDSAWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 20:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiDSAWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:22:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99330E0BA
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 17:19:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so26640823lfa.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3DkPb6o1PzrEfvEQlx3KBWUoes3B0+AA9beFlBvYSQ=;
        b=An99LtRG1FkYexpgla3X1/qDm/a/1F14+Uyfx1jAIJ+b6+p6WWVMOIRBbd0541Y35s
         XQHp97t02HymcG61QlrTgCaxBCa+4iY645k3FtZ/oJP1sPWneO1lNg2IJOIzk+sHoBww
         T00CdrYB+oxTVXOnHlRLu3/eV0usgOhJwixlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3DkPb6o1PzrEfvEQlx3KBWUoes3B0+AA9beFlBvYSQ=;
        b=k/pgi5HC5aTiHnzW51g+CvSdCrMx1c3BSqW/R89nHQU9V0+vhILB2/EXYZKHIKtTwz
         C2ifi7lWyQG3vlmIdYK+StNEY7IdqbHt9pgBk076YA6NpoFp9WRfOQlG6nVtLpgezr06
         Dd6wKCst9m0yS2DcIOi0p2q8Ed5Xozj8Dj+R987YtJh+Vmz9bSDJVVZ7fjFzTQGNnQNr
         SwxqBhExcs7W7s75GgjiMY1TbVON3H3xV+o0Fy6r8lTnhSRa7AvsXTOKd2yyfMTZ4T5o
         Geyc85p7p4WLFIKiRJmx/0do9a7Xl7593WZIOxxiS4iLL33IoNk7upr13heRj0YgyZ1A
         n55Q==
X-Gm-Message-State: AOAM531vFG3jwfM+Ii8Ug0KX5ecphvejy9410BYaYMwHTrmwStgIPvgc
        axu/V489LGqSFOKzwvllnSHJxXrCgSYrx6Ae2yM=
X-Google-Smtp-Source: ABdhPJxcQ0LU0gBjjUuBL7SQV6yjaBRCJTpCOWW15WRSfcqk/G1t+Xz8YR7NwlItdUgGn8KX2xeVAw==
X-Received: by 2002:a05:6512:33c2:b0:44a:25e2:25d4 with SMTP id d2-20020a05651233c200b0044a25e225d4mr9692848lfg.359.1650327595535;
        Mon, 18 Apr 2022 17:19:55 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y1-20020a0565123f0100b0044584339e5dsm1357188lfa.190.2022.04.18.17.19.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:19:54 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bu29so26747509lfb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 17:19:53 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr9452554lfv.27.1650327593699; Mon, 18
 Apr 2022 17:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk> <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
 <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
In-Reply-To: <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Apr 2022 17:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
Message-ID: <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_fs=2Dwriteback=3A_writeback=5Fsb=5Finodes=EF=BC=9AR?=
        =?UTF-8?Q?ecalculate_=27wrote=27_according_skipped_pages?=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
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

On Mon, Apr 18, 2022 at 3:12 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hmm yes. But doesn't preemption imply a full barrier? As long as we
> assign the plug at the end, we should be fine. And just now looking that
> up, there's even already a comment to that effect in blk_start_plug().
> So barring any weirdness with that, maybe that's the solution.

My worry is more about the code that adds new cb_list entries to the
plug, racing with then some random preemption event that flushes the
plug.

preemption itself is perfectly fine wrt any per-thread data updates
etc, but if preemption then also *changes* the data that is updated,
that's not great.

So that worries me.

             Linus
