Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC04F6F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiDGAVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 20:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDGAVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:21:11 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5058C336C
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 17:19:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s7so6908997qtk.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Apr 2022 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3mWEnyekxUAKBntA2OPgIAq5gAuaD6bF8X9P4fQWVHY=;
        b=mCm4aZc8V0CZVgKvFBLDEaytsHuexVkWhnUTk3QdlrLI6zwX1CjwjYlp6z815SV608
         c6jVJgFYnqSXX2yBAAtTUhjGggSusRwcGvHP88sPtTIk5Mk6wFLWsga9TqCM8JPbINpE
         SPYRrNM2ej7K5ICemsSQnq9IKwioRPeU4dUlrw70zUCfOKFu4kX2HJ5gUgMqZSzUAc2A
         c/MbPU2BsjIrB4GmXJiD9KxOmOwPPHTHSKRipjGdFOgZmWuLr2xBXNI7QB5uAE2mg3SE
         rUUFGJnBjJdQ+e3YFRXW4dr8KhDrztU5t4AzsHCDthBxcVxH0RQoHukOG9t+02xrBiCE
         59JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3mWEnyekxUAKBntA2OPgIAq5gAuaD6bF8X9P4fQWVHY=;
        b=Vs8lwSr57dwk8DUr4F9I8GEm9nwYC8ZlNPwSy8Gp4s4RyT1HTz7WzSYcRkTfhOVf5c
         97g8xOZcY6sswPXwN9dpdOSdd1TMgSvF098FtdODy4syp0nSNg+WnmbttqC/954Ugz3s
         hsGy7AVMz4RwycSiQ8RkV8ZaevdjpYQf18ZOPb5PZ0nCzSNIiPVjiai+MCfWKgdKD0p6
         +ZLnWjfY+x6Lo9d6bFSK6XERfMeji5mKpvb7WnUtS/0uzJTX9LD+9mp7ikHKc5nqiPSs
         jq1xLbjncRQvRqsC8XQ75izlmHUh/a1GGrYnlQoN6cEsiKrEuheqLsfNa47jnNaPvjkC
         DuRg==
X-Gm-Message-State: AOAM530rWqbx6niwIa4bQMstG3wSVyTB32Z0MNAGw/3Nlo7498xGjhOh
        k+uvKUMovh2NRrRwr7qm7gcnFg==
X-Google-Smtp-Source: ABdhPJx8VVHyff4a+1iNZKsR51aHhj1HJx23vesqDtCuIEm5GjNaDF1HUownJz1K8ZiNQWfhjJS7Mw==
X-Received: by 2002:a05:622a:38c:b0:2e2:32de:4d64 with SMTP id j12-20020a05622a038c00b002e232de4d64mr9824145qtx.402.1649290751642;
        Wed, 06 Apr 2022 17:19:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f17-20020ac87f11000000b002e1e831366asm14290048qtk.77.2022.04.06.17.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 17:19:09 -0700 (PDT)
Date:   Wed, 6 Apr 2022 17:18:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Chuck Lever III <chuck.lever@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
In-Reply-To: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
Message-ID: <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 6 Apr 2022, Chuck Lever III wrote:

> Good day, Hugh-

Huh! If you were really wishing me a good day, would you tell me this ;-?

> 
> I noticed that several fsx-related tests in the xfstests suite are
> failing after updating my NFS server to v5.18-rc1. I normally test
> against xfs, ext4, btrfs, and tmpfs exports. tmpfs is the only export
> that sees these new failures:
> 
> generic/075 2s ... [failed, exit status 1]- output mismatch (see /home/cel/src/xfstests/results//generic/075.out.bad)
>     --- tests/generic/075.out	2014-02-13 15:40:45.000000000 -0500
>     +++ /home/cel/src/xfstests/results//generic/075.out.bad	2022-04-05 16:39:59.145991520 -0400
>     @@ -4,15 +4,5 @@
>      -----------------------------------------------
>      fsx.0 : -d -N numops -S 0
>      -----------------------------------------------
>     -
>     ------------------------------------------------
>     -fsx.1 : -d -N numops -S 0 -x
>     ------------------------------------------------
>     ...
>     (Run 'diff -u /home/cel/src/xfstests/tests/generic/075.out /home/cel/src/xfstests/results//generic/075.out.bad'  to see the entire diff)
> 
> generic/091 9s ... [failed, exit status 1]- output mismatch (see /home/cel/src/xfstests/results//generic/091.out.bad)
>     --- tests/generic/091.out	2014-02-13 15:40:45.000000000 -0500
>     +++ /home/cel/src/xfstests/results//generic/091.out.bad	2022-04-05 16:41:24.329063277 -0400
>     @@ -1,7 +1,75 @@
>      QA output created by 091
>      fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>     -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>     -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>     -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>     -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>     -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
>     ...
>     (Run 'diff -u /home/cel/src/xfstests/tests/generic/091.out /home/cel/src/xfstests/results//generic/091.out.bad'  to see the entire diff)
> 
> generic/112 2s ... [failed, exit status 1]- output mismatch (see /home/cel/src/xfstests/results//generic/112.out.bad)
>     --- tests/generic/112.out	2014-02-13 15:40:45.000000000 -0500
>     +++ /home/cel/src/xfstests/results//generic/112.out.bad	2022-04-05 16:41:38.511075170 -0400
>     @@ -4,15 +4,4 @@
>      -----------------------------------------------
>      fsx.0 : -A -d -N numops -S 0
>      -----------------------------------------------
>     -
>     ------------------------------------------------
>     -fsx.1 : -A -d -N numops -S 0 -x
>     ------------------------------------------------
>     ...
>     (Run 'diff -u /home/cel/src/xfstests/tests/generic/112.out /home/cel/src/xfstests/results//generic/112.out.bad'  to see the entire diff)
> 
> generic/127 49s ... - output mismatch (see /home/cel/src/xfstests/results//generic/127.out.bad)
>     --- tests/generic/127.out	2016-08-28 12:16:20.000000000 -0400
>     +++ /home/cel/src/xfstests/results//generic/127.out.bad	2022-04-05 16:42:07.655099652 -0400
>     @@ -4,10 +4,198 @@
>      === FSX Light Mode, Memory Mapping ===
>      All 100000 operations completed A-OK!
>      === FSX Standard Mode, No Memory Mapping ===
>     -All 100000 operations completed A-OK!
>     +ltp/fsx -q -l 262144 -o 65536 -S 191110531 -N 100000 -R -W fsx_std_nommap
>     +READ BAD DATA: offset = 0x9cb7, size = 0xfae3, fname = /tmp/mnt/manet.ib-2323703/fsx_std_nommap
>     +OFFSET	GOOD	BAD	RANGE
>     ...
>     (Run 'diff -u /home/cel/src/xfstests/tests/generic/127.out /home/cel/src/xfstests/results//generic/127.out.bad'  to see the entire diff)
> 
> I bisected the problem to:
> 
>   56a8c8eb1eaf ("tmpfs: do not allocate pages on read")
> 
> generic/075 fails almost immediately without any NFS-level errors.
> Likely this is data corruption rather than an overt I/O error.

That's sad.  Thanks for bisecting and reporting.  Sorry for the nuisance.

I suspect this patch is heading for a revert, because I shall not have
time to debug and investigate.  Cc'ing fsdevel and a few people who have
an interest in it, to warn of that likely upcoming revert.

But if it's okay with everyone, please may we leave it in for -rc2?
Given that having it in -rc1 already smoked out another issue (problem
of SetPageUptodate(ZERO_PAGE(0)) without CONFIG_MMU), I think keeping
it in a little longer might smoke out even more.

The xfstests info above doesn't actually tell very much, beyond that
generic/075 generic/091 generic/112 generic/127, each a test with fsx,
all fall at their first hurdle.  If you have time, please rerun and
tar up the results/generic directory (maybe filter just those failing)
and send as attachment.  But don't go to any trouble, it's unlikely
that I shall even untar it - it would be mainly to go on record if
anyone has time to look into it later.  And, frankly, it's unlikely
to tell us anything more enlightening, than that the data seen was
not as expected: which we do already know.

I've had no problem with xfstests generic 075,091,112,127 testing
tmpfs here, not before and not in the month or two I've had that
patch in: so it's something in the way that NFS exercises tmpfs
that reveals it.  If I had time to duplicate your procedure, I'd be
asking for detailed instructions: but no, I won't have a chance.

But I can sit here and try to guess.  I notice fs/nfsd checks
file->f_op->splice_read, and employs fallback if not available:
if you have time, please try rerunning those xfstests on an -rc1
kernel, but with mm/shmem.c's .splice_read line commented out.
My guess is that will then pass the tests, and we shall know more.

What could be going wrong there?  I've thought of two possibilities.
A minor, hopefully easily fixed, issue would be if fs/nfsd has
trouble with seeing the same page twice in a row: since tmpfs is
now using the ZERO_PAGE(0) for all pages of a hole, and I think I
caught sight of code which looks to see if the latest page is the
same as the one before.  It's easy to imagine that might go wrong.

A more difficult issue would be, if fsx is racing writes and reads,
in a way that it can guarantee the correct result, but that correct
result is no longer delivered: because the writes go into freshly
allocated tmpfs cache pages, while reads are still delivering
stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.

But unless someone has time to help out, we're heading for a revert.

Thanks,
Hugh
