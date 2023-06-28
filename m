Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF67417BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjF1SCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjF1SCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:02:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93649E2;
        Wed, 28 Jun 2023 11:02:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso3672441b3a.2;
        Wed, 28 Jun 2023 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687975329; x=1690567329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xqri33yoDNZGyEBQeXSHUSwznC+68J260AdLVrfRsM=;
        b=fDtJ9NZvaS4L1aMwArhLRV5JeI/wTBBLIHL8vVk9VyPyXkkUcWSaX3EmbLVw26eXeq
         7ANcADHHJscIhra53M6SW2Gn+LDPF4FjnB0xSiAl5aEr4rKF9Yjb0actQmuFWCdCREcv
         sC+DMdd90d1TZuLtxhn/bSBGRuZpDhPL57WycoRQdlBGy3sXOMaDlqwyLDgLDKemtxph
         +AI5R3vAfMJP43uStb2EkBDHSQvwAwsc5fRPN8jh3VMpSCB5TxsPc3O+YqDr3TIy8rQY
         gGltQb8siAYWAQ4n+U9PjL3QTJwytuo5j1gTUPlDv6/wcETdqWWDOviV2y6+SHqKteaW
         YStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687975329; x=1690567329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Xqri33yoDNZGyEBQeXSHUSwznC+68J260AdLVrfRsM=;
        b=Pt9SI8wS0Bq3tUyC5N11RzknBi3flttt5pRxi2tHqzaFJabYN/uRSnwmt+yFbD4Inx
         vFSfuJbgS+tnAJcXDJZN1DucEHhCvG/9ITdtsJ7QkSHkstp6xEZZqfV6XlWdHpIcqMl6
         8Xnq5/IozcCLXBdH7qH5uBNO2eZOBkr8F4Qzl2bPUA6RceSfHCdXCXFTPw2w1iUi1x8/
         WJ6B6QAFWbjsEgbacMcaRyeNNpOtK7Ye8lD1lIaKFDI/mSdNVm7OQtAM70eJp0IMwPIT
         fGcMRR5bGhYv3PJIAp64/uV2MxaXqZCK/DEAQoDpUPWjXBrvIlKu2xCpPS1BYRz4/GIj
         QuBw==
X-Gm-Message-State: AC+VfDyYNfbXrr9YYG1OO4As5lajepbV1iDDNAxEDbCdix8Jq9fOnnmE
        fu6UlB5eOwzyozcGEYpcRqY=
X-Google-Smtp-Source: ACHHUZ7CHlFkEDs/5sm1MQ+azVbXjUYeQq+AGDFJrP6yd6SvPLGcTvYW7z0CNBmdbfRAh6bU6N7z5w==
X-Received: by 2002:a05:6a21:329d:b0:127:72c3:fd60 with SMTP id yt29-20020a056a21329d00b0012772c3fd60mr9334511pzb.1.1687975328667;
        Wed, 28 Jun 2023 11:02:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7961])
        by smtp.gmail.com with ESMTPSA id l6-20020a656806000000b005579c73d209sm6133960pgt.1.2023.06.28.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 11:02:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 28 Jun 2023 08:02:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
References: <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
 <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner>
 <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner>
 <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628-spotten-anzweifeln-e494d16de48a@brauner>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:35:20PM +0200, Christian Brauner wrote:
> > To summarize my understanding of your proposal, you suggest adding new
> > kernfs_ops for the case you marked (1) and change ->release() to do
> > only (2). Please correct me if I misunderstood. Greg, Tejun, WDYT?
> 
> Yes. I can't claim to know all the intricate implementation details of
> kernfs ofc but this seems sane to me.

This is going to be massively confusing for vast majority of kernfs users.
The contract kernfs provides is that you can tell kernfs that you want out
and then you can do so synchronously in a finite amount of time (you still
have to wait for in-flight operations to finish but that's under your
control). Adding an operation which outlives that contract as something
usual to use is guaranteed to lead to obscure future crnashes. For a
temporary fix, it's fine as long as it's marked clearly but please don't
make it something seemingly widely useable.

We have a long history of modules causing crashes because of this. The
severing semantics is not there just for fun.

Thanks.

-- 
tejun
