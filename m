Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB4731D83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 18:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjFOQMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjFOQMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:12:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2F1BF3;
        Thu, 15 Jun 2023 09:12:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b505665e2fso7282085ad.0;
        Thu, 15 Jun 2023 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686845545; x=1689437545;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DME1NMGsUM2aRxqbyvvHgHixtGQJbWqBPVgXaFtzftk=;
        b=ckxDFeyo4iQLdRcrjzcqGKuqhZsaUOzwZuy/EHDLbPveHbXXxey2L4EbB96Re9rYa2
         IY7dI3qtQyRi8yp28aO5pJ0XF5BGAlf3Mdy7z85urcZuYZ14HrAoCKRKph0H3cjKSOPZ
         FkMkyEHM7jb3LQS0fbRMPI+w+yqsnUzrjwJq3x+O0Em2H6luA52dTjoHjaXtHQlgMHLS
         Kd4HGGP0SJmmMhVDzVj2h3tsepK047mMp6cg+CD8m/rwKtjroWn96c5ouC2LjYzsHSFk
         7cF841hVAjzrES9QVpJhVCjiANlIIsQC02lPDeBfZetDDnISawKdsb4HzxS1+y/B2N+0
         6KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845545; x=1689437545;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DME1NMGsUM2aRxqbyvvHgHixtGQJbWqBPVgXaFtzftk=;
        b=KF23ryF9r9yFRs/gMs1YuPkZRFsHEYuAXtRNdWnCGvxzR00Gb8twG1K0nD2Yi2aiYz
         L/4iJS3fdJY9yv7y4uTJyq1IDi7IkYcwYEAmPovRVUs0rC5G8EXtCU6x8ELtmkpe7ud1
         oXnvYIFSclTQA14qdLMyR++ZnymYKe3beGEU6WwivzTPzv8sU3sYO6NiCpEF4zJY2Xtx
         /8EJY10ceP550PHqjQCME7ir1Q2akTW4KAAzCJolSgEdwwU3eC+ZN8MIm21NKRCBP5Fy
         qX4SLnrX1x/N+nEdYY9MVD47mnaLxuyAeowd/S7IsGQoWz3PoKAxAAMeQjbST3nrRVf0
         zLjQ==
X-Gm-Message-State: AC+VfDz4bAm2wJq9QabGy0B0/xC7pShwYYoamTkAMArnwXFZ6d7sxyaa
        /w+eWirw+f41E14W6N/5DIo=
X-Google-Smtp-Source: ACHHUZ4LaiMMPnlq9Z4CLw3tZ7nEf3uTqctWCB4L4GPiVPx6zM+aBadInctf6oyEWvYfSHEAskQMIw==
X-Received: by 2002:a17:902:e54d:b0:1b2:5d90:fc3f with SMTP id n13-20020a170902e54d00b001b25d90fc3fmr6993693plf.17.1686845544908;
        Thu, 15 Jun 2023 09:12:24 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902854b00b001b04dfbe5d0sm14019741plo.309.2023.06.15.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:12:24 -0700 (PDT)
Date:   Thu, 15 Jun 2023 21:42:12 +0530
Message-Id: <87ttv8ln6r.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 0/6] iomap: Add support for per-block dirty state to improve write performance
In-Reply-To: <87h6r8wyxa.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>
> Hello All,
>
> So I gave some thoughts about function naming and I guess the reason we
> are ping ponging between the different namings is that I am not able to
> properly articulate the reasoning behind, why we chose iomap_ifs_**.
>
> Here is my attempt to convince everyone....
>
> In one of the previous versions of the patchsets, Christoph opposed the
> idea of naming these functions with iop_** because he wanted iomap_ as a
> prefix in all of these function names. Now that I gave more thought to it,
> I too agree that we should have iomap_ as prefix in these APIs. Because
> - fs/iomap/buffered-io.c follows that style for all other functions.
> - It then also becomes easy in finding function names using ctags and
>   in doing grep or fuzzy searches.
>
> Now why "ifs" in the naming because we are abbrevating iomap_folio_state
> as "ifs". And since we are passing ifs as an argument in these functions
> and operating upon it, hence the naming of all of these functions should
> go as iomap_ifs_**.
>
> Now if I am reading all of the emails correctly, none of the reviewers have
> any strong objections with iomap_ifs_** naming style. Some of us just
> started with nitpicking, but there are no strong objections, I feel.
> Also I do think iomap_ifs_** naming is completely apt for these
> functional changes.
>
> So if no one has any strong objections, could we please continue with
> iomap_ifs_** naming itself.
>
> In case if someone does oppose strongly, I would humbly request to please
> also convince the rest of the reviewers on why your function naming
> should be chosen by giving proper reasoning (like above).
> I can definitely help with making the required changes and testing them.
>
> Does this look good and sound fair for the function naming part?

Hello All,

Hope I didn't take too long to respond to my previous email.
I had a discussion with Darrick and he convinced me with -

- ifs_ naming style will be much shorter and hence preferred.
- ifs_ already means iomap_folio_state_** v/s iomap_fs_** means
  iomap_iomap_folio_state... makes iomap_ifs_ naming awkward.
- All of these functions are anyway local and static to
  fs/iomap/buffered-io.c file so it is ok even if we have a shorter
  names like ifs_alloc()/ifs_free() etc.

Hence I have decided to go with ifs_ options for v10 which Darrick (including few others) agreed to here [1]

[1]: https://lore.kernel.org/linux-xfs/87h6r8wyxa.fsf@doe.com/T/#m7c061e634243f835ecddfb642bbfb091a9227ec7

-ritesh


>
> If everyone is convinced with iomap_ifs_** naming, then I will go ahead
> and work on the rest of the review comments.
>
> Thanks a lot for all the great review!
> -ritesh
