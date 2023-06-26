Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4224673EBEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFZUjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZUje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:39:34 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77508E5A
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:39:30 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5634db21a58so1044057eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687811970; x=1690403970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEFUJeeBn6YjH4lK418olg3ruMKuxKIepWsfszUOpy4=;
        b=L6+t78u34A4EOsgO/5wyxp0/LGY+KJO2+xEm2/un0aE1W+UJ2WdK6S/UKVpguxRp5L
         R5MBxyaqs+VsDVFucNqfi5acwzpetEuEiNoaZ8TINLUMNyLQrLw5ImKiNAUPyZP6AkhM
         z9B43yz4ZPCStialiseimZwqXg90RajcVEsWa9D609XnTsfkElxPVXq9vzh/7VCTNHVv
         ziS22l4ZeeTvBn6hGJgR0FsPhw4xt3yYJhqLCQR4EOQ9FePLgVx2Z54nPJ8gKrH0uwRL
         cxZ5QZHAFRxraqfIGAatLgaElWfrPTD/K+Aa76+FxYyYGofVf9k/HTmhNNqiY77DmCW5
         0/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687811970; x=1690403970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEFUJeeBn6YjH4lK418olg3ruMKuxKIepWsfszUOpy4=;
        b=kZZ1x+MQSm4mqLWJTZH5qRRpvANy34GfwxPjeQX09NKH/cQPMQWmY3rTeWWnKK/zR7
         mt2e91psRJtYrmL/I+nUUPAvrnXXcAbGEvlEQbVGExANDx6RTUVoQEMvDoQ0/6cAZze6
         cgmc4s7aeB6V0+BDlQv300OsltnLPRxyRqHTcAuzVBwtVbKG1G62PTVzQFWpuhszQqu3
         1lUq1uFy5BeGDHaGV0a8onkdAIj9IFPkT49+EUuWhWdfiNKvrK/Nnnl0zPeznAxhQprK
         PZIPIFoO02EVRtbQH/0MajqOk35ONVYuQRgivCvrgUUBhuvlLds+akveySblSBzIfaZ3
         nQzA==
X-Gm-Message-State: AC+VfDwcRaMH7vvCAVOlgdsvFbJ8kqhAUFuAKIJionmnU50wSRy48EEe
        35FdmA9UN6/w9Wfq+RqsnMvyp9Mfj4LZZh6KDf25XA==
X-Google-Smtp-Source: ACHHUZ4olQu8xtmPGwoaeFjq8yuKCjhhdxoXmfM/VHedl6d4Bu5m3oQg0VOJUL1hz/bBmYwBRV/mspwFs9D3oYgx/to=
X-Received: by 2002:a05:6358:cd1c:b0:132:71e7:15b6 with SMTP id
 gv28-20020a056358cd1c00b0013271e715b6mr13920779rwb.29.1687811969526; Mon, 26
 Jun 2023 13:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
In-Reply-To: <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 26 Jun 2023 13:39:18 -0700
Message-ID: <CAJuCfpGt8Bg1VLkx-aMw7_JTvh=co4QSM9B=fvikp0mQ-6rvjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 1:31=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 73f5c120def8..a7e404ff31bb 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -273,6 +273,11 @@ struct kernfs_ops {
> >        */
> >       int (*open)(struct kernfs_open_file *of);
> >       void (*release)(struct kernfs_open_file *of);
> > +     /*
> > +      * Free resources tied to the lifecycle of the file, like a
> > +      * waitqueue used for polling.
> > +      */
> > +     void (*free)(struct kernfs_open_file *of);
>
> I think this can use a bit more commenting - ie. explain that release may=
 be
> called earlier than the actual freeing of the file and how that can lead =
to
> problems. Othre than that, looks fine to me.

Sure, once I get more feedback I'll post the next version with
expanded description.
Thanks!

>
> Greg, as Suren suggested, I can route both patches through the cgroup tre=
e
> if you're okay with it.
>
> Thanks.
>
> --
> tejun
