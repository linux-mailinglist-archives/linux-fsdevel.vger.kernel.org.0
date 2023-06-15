Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFA731C1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbjFOPDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFOPDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:03:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC6273D;
        Thu, 15 Jun 2023 08:03:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6667e221f75so1147677b3a.1;
        Thu, 15 Jun 2023 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686841399; x=1689433399;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YH9rMkNjJX8ZqFPdpCOC17vzzr2VHQgSu5WOxx2M3No=;
        b=b/K88F8mocSsHk2afYYaiTeaMLSqxi3SxTIs59GKTdUMTxvmYo2rdzU+P1zytqPPzY
         3EDu3uUN/fme0822vjIFV11Ra+TvwEBbOGTXMPlCxBoNQpiph/vwHs6QcnZT0UKdrJb6
         4B0efjSNOfst1ulb4Y4T60o3RX7zAiLHz9zRwdaNwFFe5wY25kNqpsOqBq79j8ZPnADQ
         wiZev7UNXXPOVpU5VnN42uI1dM2HoED5p4L2c8yMO69idoY8xf/TuwXOu+pTg22Y3g+u
         9y7wvfVWZ+THLvGlGrDRN0W4JiD6aJnt/3Sc85XMCilJ189vWp22zhafM9wKtkKCC2OS
         KYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686841399; x=1689433399;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YH9rMkNjJX8ZqFPdpCOC17vzzr2VHQgSu5WOxx2M3No=;
        b=KCHOf5SsfhCLapifL6eKTovGT5wS8jJPojyc4VoqE+/C3O2cH1//HIrWtK5RweMR3s
         tagxcAZ25L3OOrx61ZM5yHYjPW/7aNWKMfZV9BgvfE9ykCttNerw6DSEw/D7mbeC63L8
         PGBmexBxW/fAwfi55CrilUXOYTdQ0WwWuiJH6s4eAJnK7qmh2Gs/yztSB3E55WicDf8E
         XlBIlqPXqs0p8+kgqHNip39B/A6q9D8QmjV7yzYNVUKUO3N6H8C52FOsBGLJJqHMkS2r
         k8T4K+/Boc2QUzOljvxVFbQQ5QyEZscxkuLK5kL1hOSIS1L5Otz4qanv4wMYsAdsmUY7
         oNGA==
X-Gm-Message-State: AC+VfDzbtAKV57DsCodMYgMISeZHt6GJbvmMV0JTo+s5cxpNzXV2ixPC
        DeZHx+yMBsyd/Cj3aK37Wyc=
X-Google-Smtp-Source: ACHHUZ7f3fpuoGsWEzwukNwAZHy2JI3couKTgHmU6zRnm9iav+T42KG1iF+exFOn3fKrZW0d2ENB8Q==
X-Received: by 2002:a17:903:2446:b0:1b3:f499:b318 with SMTP id l6-20020a170903244600b001b3f499b318mr6708038pls.61.1686841399343;
        Thu, 15 Jun 2023 08:03:19 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709028f9800b001b016313b1esm14186793plo.82.2023.06.15.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:03:18 -0700 (PDT)
Date:   Thu, 15 Jun 2023 20:33:13 +0530
Message-Id: <87h6r8wyxa.fsf@doe.com>
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
In-Reply-To: <cover.1686395560.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

Hello All,

So I gave some thoughts about function naming and I guess the reason we
are ping ponging between the different namings is that I am not able to
properly articulate the reasoning behind, why we chose iomap_ifs_**.

Here is my attempt to convince everyone....

In one of the previous versions of the patchsets, Christoph opposed the
idea of naming these functions with iop_** because he wanted iomap_ as a
prefix in all of these function names. Now that I gave more thought to it,
I too agree that we should have iomap_ as prefix in these APIs. Because
- fs/iomap/buffered-io.c follows that style for all other functions.
- It then also becomes easy in finding function names using ctags and
  in doing grep or fuzzy searches.

Now why "ifs" in the naming because we are abbrevating iomap_folio_state
as "ifs". And since we are passing ifs as an argument in these functions
and operating upon it, hence the naming of all of these functions should
go as iomap_ifs_**.

Now if I am reading all of the emails correctly, none of the reviewers have
any strong objections with iomap_ifs_** naming style. Some of us just
started with nitpicking, but there are no strong objections, I feel.
Also I do think iomap_ifs_** naming is completely apt for these
functional changes.

So if no one has any strong objections, could we please continue with
iomap_ifs_** naming itself.

In case if someone does oppose strongly, I would humbly request to please
also convince the rest of the reviewers on why your function naming
should be chosen by giving proper reasoning (like above).
I can definitely help with making the required changes and testing them.

Does this look good and sound fair for the function naming part?

If everyone is convinced with iomap_ifs_** naming, then I will go ahead
and work on the rest of the review comments.

Thanks a lot for all the great review!
-ritesh
