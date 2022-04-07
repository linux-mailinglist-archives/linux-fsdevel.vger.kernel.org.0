Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1F4F8A1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiDGWLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 18:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiDGWKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:50 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1482AC2AE
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 15:04:30 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-de3ca1efbaso7893188fac.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Apr 2022 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=58SSCJZXblAmvBhjeOB3uU7MwelxZJPYCI86bkrnS8E=;
        b=XgwIWPe4EmdEZzg2aaVL2kxNLbvNgtQDgA6CSmpYKHkmeCwbHkMVlvkx7EZXnFHO7x
         J4SENl4Kv459oEqbYIEqiYidiPRy2CAjIFGXnioedXGzr36OF1H2DkSJyBMBC6z2evxG
         ujxE2friAAG/Zl0uHBA5b6H+yYJKsHEbPH6JWlM7x9jyydRQcfHfaG4RYdDuX4izPVUy
         BUlIz/KJJJd3RmEBjuwka9CSK4AWLbHSWUwXCMjbjS1cOWXJCdVd70StvQcN6RjGDRYR
         LWZcR6+S/E+oBAOD/XW6YTBmfANzfiNjyarFB/JqspP7loBQBTX5qFG7/McZ3M07LdLI
         ItUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=58SSCJZXblAmvBhjeOB3uU7MwelxZJPYCI86bkrnS8E=;
        b=d7kT2Q/ZPQavB+8FofVCEpc3kUaBwSN+Zd660PpxRghDTFiLQjXovxbos2Tm4bWA0i
         ojgrhgSQZsQAFBRX6ZrIJDr4/0/ma4inxme9GL57DmQ4ARpalTk8CHdp7k1EXHb9W4l6
         vAZA4Cz0GmVx6uaD8OAJvo8fZMa0jlQKHsADruaVIXxRLeyT+5zl5VBq7A21giBMjdxA
         rHbVh4sBLpOlQ7AxKtchf0M/s7BdMbkDC8oc3kKhVFiueOxeZ0GlgwZXdxApjhx1/hEY
         hqvJT1q8bPksRFNDWN3B/kYTfVbeiyQXpAiAWq+ddeGP8EzPcy5MqPePie2dAyH1cxlZ
         ZX2g==
X-Gm-Message-State: AOAM533IZnBHZL3Tl2S3tM1NpKKiXpGatdVMLebHw31jLqbkRnmnmOXc
        7Wi2julqwrcu11dO3HlxtHCztw==
X-Google-Smtp-Source: ABdhPJy+Z5esE3uurhkzizDtW3m1OKRWfuXho1I1H/+hKIEmfhbFpufLCET49LNS8PawnB+emtOgVA==
X-Received: by 2002:a05:6870:e990:b0:de:9b72:c80 with SMTP id r16-20020a056870e99000b000de9b720c80mr7234558oao.118.1649369069975;
        Thu, 07 Apr 2022 15:04:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r8-20020a05683001c800b005cdadc2a837sm8359376ota.70.2022.04.07.15.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 15:04:29 -0700 (PDT)
Date:   Thu, 7 Apr 2022 15:04:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mark Hemment <markhemm@googlemail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
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
In-Reply-To: <CANe_+UhOQzGcz9hsKdc1N2=r-gALN6RK-fkBdBkoxD+cv1ZFnA@mail.gmail.com>
Message-ID: <5256a357-213e-84e9-a07f-f695cbb68272@google.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com> <11f319-c9a-4648-bfbb-dc5a83c774@google.com> <CANe_+UhOQzGcz9hsKdc1N2=r-gALN6RK-fkBdBkoxD+cv1ZFnA@mail.gmail.com>
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

On Thu, 7 Apr 2022, Mark Hemment wrote:
> On Thu, 7 Apr 2022 at 01:19, Hugh Dickins <hughd@google.com> wrote:
> >
> > What could be going wrong there?  I've thought of two possibilities.
> > A minor, hopefully easily fixed, issue would be if fs/nfsd has
> > trouble with seeing the same page twice in a row: since tmpfs is
> > now using the ZERO_PAGE(0) for all pages of a hole, and I think I
> > caught sight of code which looks to see if the latest page is the
> > same as the one before.  It's easy to imagine that might go wrong.
> 
> When I worked at Veritas, data corruption over NFS was hit when
> sending the same page in succession.  This was triggered via VxFS's
> shared page cache, after a file had been dedup'ed.
> I can't remember all the details (~15yrs ago), but the core issue was
> skb_can_coalesce() returning a false-positive for the 'same page' case
> (no check for crossing a page boundary).

Very useful input: thank you Mark.

That tells me that, even if we spot a "bug" in fs/nfsd, there could
be various other places which get confused if given the ZERO_PAGE(0)
twice in a row.  I won't be able to find them all, I cannot go on
risking that.

At first I thought of using ZERO_PAGE(0) for even pgoffs, alternating
with a tmpfs-specific zeroed page for odd pgoffs.  But I was forgetting
that copying ZERO_PAGE(0) is itself just a workaround to avoid the 28%
slower iov_iter_zero().

I think I have a reasonable hybrid: will reply to Chuck now with that.

Hugh
I've rewr
