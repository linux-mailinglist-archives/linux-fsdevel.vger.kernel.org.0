Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AE6C04D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 21:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCSUbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCSUba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:31:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23D1D917;
        Sun, 19 Mar 2023 13:31:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v16so8634741wrn.0;
        Sun, 19 Mar 2023 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679257887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cFhYBMM/sGGl7pUJxalvtsHlN8hIIUBXY4TsO/Ulp4=;
        b=XH3XjdmF6NLQPjyVOunH3smTe6tOJwpuub27ZPlebc1ahBFynKOYZC0MdcMSmQEfn4
         M5k4G8A8SShX1sW08OKDlIBCfKKnBYI5+lvpa3tmuyylE4NDDuVyZierz6SUo9xPYClv
         nlHMBk8/1j6eaS0HfiLSuIa4Ra3SHWBhlaZ1CxPa3OEaoG6Lea+k506s5uRTxF3bhG8i
         mvIFGWP7dRCP3B4Pp8HlogCXAKy+4/uG1i0MQC2fYVCVcHySCDKscNnz/2hHrQ90JYxn
         lFaQSyS5LkR6t2h5uWuOUsfIJKP09DRJNcPnYlLjnGrju4TkEcXgqVbyFTfaj4nqlNbd
         ONSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679257887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFhYBMM/sGGl7pUJxalvtsHlN8hIIUBXY4TsO/Ulp4=;
        b=Mcl2nQFSme9jtchRtCC9MV3U63IYzZMdhej3wZpLwDQ4EbN3RZ35/FdQ8QhaQ0Tcy5
         GnOuL7PtpEFzVEhINhyTg6OQXjfcI2ekIuw/koWY8zfHepeNUhG6/Hry8qTaItNB0Phc
         J4viaIU7TPbAJrnzfY51JwZT3pfZ+w0NgE18gN4MPpFpJ5VXP3rN9WwZY0l9USGFc14N
         Uav3rYSKMG3JklKoHDJZuh9LEvh/9Bd548yshG1abcxQnRJ2exla+ujRSVJuy4ZEs7pn
         8B4/1N0LpHjeQ7NipuztSYVD47mjBPo/zWtwRQJv0mjV0YIuC1J4y8dablX/pj34DJrw
         5jDw==
X-Gm-Message-State: AO0yUKXvZaAWo9KZQcPkwhjkSiQw10OSl0lTzWJlW9yGbIIjGfR78NGC
        XCNKIc3U8ZJduT9J4Wks89Y=
X-Google-Smtp-Source: AK7set+pIJNGSG5LeaQdnKFzjoOJYJs+d1dlSBU2X1SCQGdjp/5s4IuGlPSsXl6L36T0AdB/QjJ2QA==
X-Received: by 2002:a5d:4848:0:b0:2d2:471f:cf6e with SMTP id n8-20020a5d4848000000b002d2471fcf6emr9074119wrs.5.1679257887423;
        Sun, 19 Mar 2023 13:31:27 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm7248708wrr.88.2023.03.19.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 13:31:26 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:29:16 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <fadd8558-8917-4012-b5ea-c6376c835cc8@lucifer.local>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <20230319131047.174fa4e29cabe4371b298ed0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319131047.174fa4e29cabe4371b298ed0@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:10:47PM -0700, Andrew Morton wrote:
> On Sun, 19 Mar 2023 07:09:31 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > vmalloc() is, by design, not permitted to be used in atomic context and
> > already contains components which may sleep, so avoiding spin locks is not
> > a problem from the perspective of atomic context.
> >
> > The global vmap_area_lock is held when the red/black tree rooted in
> > vmap_are_root is accessed and thus is rather long-held and under
> > potentially high contention. It is likely to be under contention for reads
> > rather than write, so replace it with a rwsem.
> >
> > Each individual vmap_block->lock is likely to be held for less time but
> > under low contention, so a mutex is not an outrageous choice here.
> >
> > A subset of test_vmalloc.sh performance results:-
> >
> > fix_size_alloc_test             0.40%
> > full_fit_alloc_test		2.08%
> > long_busy_list_alloc_test	0.34%
> > random_size_alloc_test		-0.25%
> > random_size_align_alloc_test	0.06%
> > ...
> > all tests cycles                0.2%
> >
> > This represents a tiny reduction in performance that sits barely above
> > noise.
> >
> > The reason for making this change is to build a basis for vread() to be
> > usable asynchronously, this eliminating the need for a bounce buffer when
> > copying data to userland in read_kcore() and allowing that to be converted
> > to an iterator form.
> >
>
> I'm not understanding the final paragraph.  How and where is vread()
> used "asynchronously"?


The basis for saying asynchronous was based on Documentation/filesystems/vfs.rst
describing read_iter() as 'possibly asynchronous read with iov_iter as
destination', and read_iter() is what is (now) invoked when accessing
/proc/kcore.

However I agree this is vague and it is clearer to refer to the fact that we are
now directly writing to user memory and thus wish to avoid spinlocks as we may
need to fault in user memory in doing so.

Would it be ok for you to go ahead and replace that final paragraph with the
below?:-

The reason for making this change is to build a basis for vread() to write
to user memory directly via an iterator; as a result we may cause page
faults during which we must not hold a spinlock. Doing this eliminates the
need for a bounce buffer in read_kcore() and thus permits that to be
converted to also use an iterator, as a read_iter() handler.
