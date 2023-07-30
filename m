Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A40768688
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjG3Qu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjG3Quz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:50:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358C10EA
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 09:50:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-584034c706dso39803117b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690735853; x=1691340653;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOc3sAM7hTvO70uQD/m9fZDrRb5SABF2nw7C9wZtKX8=;
        b=VRJUGNdOo9yMXtnka8zKkl1PjpZ+2Vm6W3+/xtQ1VST2i7zAukOA7oMx0ozyCe40Es
         fCvAF1pAOInKQiIfEqt/w5ar/y+86Sq3DK+MULvwtqjQIPFAju8l7jlc00m8kxmcoBYD
         i8RxouS/f9mnL41JvJ5sjFxnkZRlyIT5BhzPKCQdqura4EbI+2qWzydZxaxylt8XiC5E
         MHwtcmyy3NlXT2bgQ1N2xZ6rwIUeOGZmdS8NRBmk9nGMU10YZxM4Y7UnEk5xxG9Ar+En
         DlB++9F2tBivYrwca0A4ILMHfAS8sq7fCtHPqmfF2FoxccV/XekEQrVcS+9cT5Jff0Gr
         PLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690735853; x=1691340653;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOc3sAM7hTvO70uQD/m9fZDrRb5SABF2nw7C9wZtKX8=;
        b=MG33rPr1ThfqFEJliyQRHj/ZpGMWPqSIZWiRhaMjqpChqjfSqWIeVE0B4Cb1FhnQo3
         ml29VRiIc0M3cFIOgJ63L0APVKFpWAXAm+nbUKeh2dz4mk3S4A2Il386RzAkdM7dVzJp
         WWE85bfbOtYDx5e40wLXJaFsoikpu5uZGB6HHXcUTJCmaYiokIKzOtYdYzzeC3rO/Dl7
         bTDvBTMVYjmuroNncsOEsPXkcehy1qT1EdqjVCdQmN9zkatDT+QaVNdMgm91ebauRAyB
         0hgyY6dUpQPNPQt+Timuzi9Q3dO96CpYGGwG6tS3s4DvD4XaPQx1+XTl+h2Q6lN34V3E
         2Egw==
X-Gm-Message-State: ABy/qLZtAbc5gV2o54ncv1gDOUJ11x/l2N4qJRix2yhs0bDJU5qErFyC
        ySRonN5V48R1mtmySMZtQQl/RA==
X-Google-Smtp-Source: APBJJlEYYaTXM0wJR066M0vQpHK3N8c0FQQ98ypGElC0wHKdiFwsfUdtQTBr9mnePBp3PHNcg8e1FQ==
X-Received: by 2002:a81:910a:0:b0:56c:ed71:a4ca with SMTP id i10-20020a81910a000000b0056ced71a4camr7546472ywg.1.1690735853181;
        Sun, 30 Jul 2023 09:50:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m79-20020a0dca52000000b00545a08184cesm1020928ywd.94.2023.07.30.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 09:50:52 -0700 (PDT)
Date:   Sun, 30 Jul 2023 09:50:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Chuck Lever <chuck.lever@oracle.com>
cc:     NeilBrown <neilb@suse.de>, Chuck Lever <cel@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] nfsd: Fix reading via splice
In-Reply-To: <ZMaB1BwBfNko1ZoE@tissot.1015granger.net>
Message-ID: <3082a8da-4a13-de28-ed50-8aa2e7a59afd@google.com>
References: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net> <169058849828.32308.14965537137761913794@noble.neil.brown.name> <ZMaB1BwBfNko1ZoE@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 30 Jul 2023, Chuck Lever wrote:
> On Sat, Jul 29, 2023 at 09:54:58AM +1000, NeilBrown wrote:
> > On Fri, 28 Jul 2023, Chuck Lever wrote:
> > > From: David Howells <dhowells@redhat.com>
...
> - This fix is destined for 6.5-rc, which limits the amount of
>   clean up and optimization we should be doing
> 
> I'd like to apply David's fix as-is, unless it's truly broken or
> someone has a better quick solution.

I certainly have no objection to you doing so; and think that you
and David will have a much better appreciation of the risks than me.

But I ought to mention that this two-ZERO_PAGEs-in-a-row behaviour
was problematic for splice() in the past - see the comments on
ZERO_PAGE(0) and its alternative block in shmem_file_read_iter().
1bdec44b1eee ("tmpfs: fix regressions from wider use of ZERO_PAGE"):
ah, that came from a report by you too, xfstests on nfsd.

In principle there's a very simple (but inferior) solution at the
shmem end: for shmem_file_splice_read() to use SGP_CACHE (used when
faulting in a hole) instead of SGP_READ in its call to shmem_get_folio().
(And delete all of shmem's splice_zeropage_into_pipe() code.)

I say "in principle" because all David's testing has been with the
SGP_READ there, and perhaps there's some gotcha I'm overlooking which
would turn up when switching over to SGP_CACHE.  And I say "inferior"
because that way entails allocating and zeroing pages for holes (which
page reclaim will then free later on if they remain clean).

My vote would be for putting David's nfsd patch in for now, but
keeping an open mind as to whether the shmem end has to change,
if there might be further problems elsewhere than nfsd.

Hugh
