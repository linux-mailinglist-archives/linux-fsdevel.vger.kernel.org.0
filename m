Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1636E562C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDRBGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjDRBGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:06:05 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3974492
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:06:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-552ae3e2cbeso66918447b3.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681779962; x=1684371962;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFgQbB9ZPoIUhOcvwbaJbA/N4MM87FyHead5du+V3Ns=;
        b=NGOp6SEkLFn1PavoV21e5YSPl9r8FlBhE2wJdHQaKbBfaDw59sLesAVILF7Yc8PcrC
         GhZCeYHfw7HezwQKVOD/i0/fVMXaFnOE8aJzMBcEglKWccTsDfOtnkLtDSxTOsuFCwsk
         +n0f90t/WSsuX0iLyGGj7bd8ui+WKibLC3Olz3zYHOMIY0QXA/zPw3cAxwVd2onr+eoQ
         5dJUy3JSw/Cvnt/s/hOsx2DpdL6UWL5sCt1uEkXuwC/TJIfzIagsaMy7tV/TGozPbMBZ
         mTA6Jmd7lSEZMUx1D6KbNUfGVYKlX57NYdMyLKBqr3lXPZtt+Tq4WZcNitUYzCF3vMlE
         Y0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681779962; x=1684371962;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFgQbB9ZPoIUhOcvwbaJbA/N4MM87FyHead5du+V3Ns=;
        b=O0gXnW+luXqFMgE2xIGeS/Xj4s60uhxyTjIzSIcglu3doUwI+7z2xxE3pOEZkdB21I
         qACZ+Z3ueg3vAiXmYp0aVBsarcxHJQHdNwwofBvhkiQqj2KySqybubBh08Iva5/cv7H0
         y6meQl+19422w5OP9gS/ReMuun9catE4T3w670BbMnEMBUdrReqyoB336orW/+Tls2js
         1FKZmvpG29SvWil5kC5iVXghDTsXZUbkh4iYTFG3teN+0CJnr7+zPkv+dmYF0X9Q4WZd
         h3ACaHkdKqB4reel75+3nqEA3FC6FeG5hE5dPgQcC5IJRdWqmhaoH5omSIPxAVjAc30F
         4t2w==
X-Gm-Message-State: AAQBX9cdy0twxANuWcShI2Ov54WSQExqjOhTF8e0ZHq8EKANE5Fniqo/
        GqhyEz2T4D+mR715ywUg9gB05A==
X-Google-Smtp-Source: AKy350YOQmlBbCyoNnOfLdczvLi7r0v/cg2o+uubtBem4fUiiKm/lSMWMk18fdEwlDX7VCYkVn5KGw==
X-Received: by 2002:a0d:c305:0:b0:541:8c8f:ec14 with SMTP id f5-20020a0dc305000000b005418c8fec14mr15135378ywd.14.1681779962057;
        Mon, 17 Apr 2023 18:06:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c7-20020a811c07000000b0054f69ac5220sm3489851ywc.133.2023.04.17.18.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 18:06:01 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:05:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
In-Reply-To: <0AC0520E-1BD2-497E-A7ED-05394400BFC9@nvidia.com>
Message-ID: <8dbb3c83-48d-93d-3e3-4c833b81904@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com> <20230403201839.4097845-7-zi.yan@sent.com> <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com> <0AC0520E-1BD2-497E-A7ED-05394400BFC9@nvidia.com>
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

On Mon, 17 Apr 2023, Zi Yan wrote:
> 
> What do you think? If you have a better idea, I am all ears. And if you
> are willing to help me review the more complicated code changes, I am
> more than happy to implement it in the next version. :)

Sorry, no, not me.  You'll have to persuade someone else that "optimizing"
truncation is a worthwhile path to pursue (and to pursue now) - I was just
trying to illustrate that the current patchset didn't seem very useful.

But don't throw your work away.  I expect some of it can become useful
later e.g. once most of the main filesystems support large folios, and
the complication of CONFIG_READ_ONLY_THP_FOR_FS can be deleted.

I doubt my "minimizing the number of folios" approach would be worth
the effort; I think more likely that we shall settle on an intermediate
folio size (between 4K and THP: maybe 64K, but not necessarily the same
on all machines or all workloads) to aim for, and then maybe truncation
of THP would split to those units.  But it's not a job I shall get into
- I'll just continue to report and try to fix what bugs I see.

Hugh
