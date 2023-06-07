Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8150C7262A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbjFGOVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbjFGOVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:21:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFBF1BF8
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 07:21:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so1384975a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686147671; x=1688739671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMyK7sGNgF/LzrX7OfXx8UkwIkNpkpIRipLRDd307mc=;
        b=ZAO+UjggyLUAXocwo+f1ffF55K91DfZ8epyFt5H0xeaunDg8f5rPHJ8ICHZLpusfva
         JOKoJzBMOq6DC191K2bSpMWtnDs0ghAus9h8caFQjAh0rN8bKkNUT5UbDrikEueltYzn
         yxjqkMSG/io7e4iINCYZTrnsKgv5+gf0A08nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147671; x=1688739671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMyK7sGNgF/LzrX7OfXx8UkwIkNpkpIRipLRDd307mc=;
        b=DvdLQEloCOw6wVFd4p97ore/73Ku3BXok4unTvGk3cxasmjrNkxlPcqsRF5MTiQ/V+
         z/QgJkKQZflm4mg7LSpLO/3xK3YRAy5FvkDqdd3ZkiwCjJrIDe3Ai41XskIc2Udx/yo5
         HurQaGCuQ1X8v38Joue1FV9eXG39SqnvXAxNalqPDg3Pf9Cm+PHkifd0QXeiD7ttTZgl
         0HeEeeyDjwiWVU3cj/F34RvT3Sow5UGw7TyVAeyvGqO9WAMzSdzu5RNFg4uSW+k9/v/O
         /wraAHtdAhgr9r2FA0Bw9WTXd9tIVZ1SQ2s1axwsWVJL1jAkXhW6brz8kKe07kejTi2m
         2WwA==
X-Gm-Message-State: AC+VfDx2WOEI0E6TKRCm6uZ9L2W6R96r2Z9sshJr1P4YOY3ddemCzx9A
        D88ASG4quSHIokKRh+kmysELdar3GTlYaI/MqX3bXQ==
X-Google-Smtp-Source: ACHHUZ6ls0BfeaGjgy/UHP9tI5Zr52h5fzDJc+6ypxsFs41cAhR8QcI6xLlvjBxPFGZL1jHMOUTeHCwQNCnACX8vt6Q=
X-Received: by 2002:a17:907:7f93:b0:96f:bd84:b89c with SMTP id
 qk19-20020a1709077f9300b0096fbd84b89cmr6973182ejc.70.1686147670910; Wed, 07
 Jun 2023 07:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230321011047.3425786-1-bschubert@ddn.com> <CAOQ4uxjXZHr3DZUQVvcTisRy+HYNWSRWvzKDXuHP0w==QR8Yog@mail.gmail.com>
 <02f19f49-47f8-b1c5-224d-d7233b62bf32@fastmail.fm> <CAOQ4uxiDLV2y_HeUy1M-WWrNGdjn-drUxcoNczJBYRKOLXkkUQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiDLV2y_HeUy1M-WWrNGdjn-drUxcoNczJBYRKOLXkkUQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 16:20:59 +0200
Message-ID: <CAJfpegtL3NXPNgK1kuJR8kLu3WkVC_ErBPRfToLEiA_0=w3=hA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] fuse uring communication
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Mar 2023 at 12:55, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:

> > there were several zufs threads, but I don't remember discussions about
> > cache line - maybe I had missed it. I can try to read through the old
> > threads, in case you don't have it.
>
> Miklos talked about it somewhere...

It was a private exchange between Amir and me:

    On Tue, 25 Feb 2020 at 20:33, Miklos Szeredi <miklos@szeredi.hu> wrote
    > On Tue, Feb 25, 2020 at 6:49 PM Amir Goldstein <amir73il@gmail.com> w=
rote:
    [...]
    > > BTW, out of curiosity, what was the purpose of the example of
    > > "use shared memory instead of threads"?
    >
    > In the threaded case there's a shared piece of memory in the kernel
    > (mm->cpu_bitmap) that is updated on each context switch (i.e. each
    > time a request is processed by one of the server threads).  If this i=
s
    > a big NUMA system then cacheline pingpong on this bitmap can be a rea=
l
    > performance hit.
    >
    > Using shared memory means that the address space is not shared, hence
    > each server "thread" will have a separate "mm" structure, hence no
    > cacheline pingpong.
    >
    > It would be nice if the underlying problem with shared address space
    > could be solved in a scalable way instead of having to resort to this
    > hack, but it's not a trivial thing to do.  If you look at the
    > scheduler code, there's already a workaround for this issue in the
    > kernel threads case, but that doesn't work for user threads.

Thanks,
Miklos
