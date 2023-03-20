Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FC6C0C5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 09:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCTIkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 04:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCTIko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:40:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B330728B;
        Mon, 20 Mar 2023 01:40:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso8634204wmb.0;
        Mon, 20 Mar 2023 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679301642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcKnhemYdKHWThhsxV1AhOlClFynUX4pt1AKusVZUtM=;
        b=ERS1o6I1GyJB1x/Owu+aLzg/wa7KALPuXw34Y5/nyy/FPpP/dQAR5s65Sh+cpgQSUu
         2WeXVR2YxURM6pF79L/vGRAHBTxBarR59IUS+PiP5dj2gULIVjfPD8KJT6ZbmmZGa55l
         HD/gjEvlaOpZNvho7lOMiOcEGfJ43sYrTM+Wo0qM9pqaL3DnjhLRlfkXbtQjc6/1Laj6
         HH/PGtwgiA2+UhopsFytxDyc2BROSOZT7bdRokzb9/NpsLXY+DVHJ89IE5Rj3O4PUR5I
         xuX1PIIwK6DR6izzjFtsik1xfU4aTCr6bGydAA5AWzpaTySlU1uZ6uqqxokT35DkuPlS
         q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679301642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcKnhemYdKHWThhsxV1AhOlClFynUX4pt1AKusVZUtM=;
        b=qcbWOTLMO/LmMAFIcs+28OaSLRMJkJyylbzNdPuA03GrioytNP0SQB1IhY5Dt4rg48
         ZOTUFq04WoSHG6LxETgrweZR6BKY+insAQ5OAZ+NaCSVSxsEt3otDDGcHnJEyc4KJ/nR
         fJiWrUPhcdaB2EUHl2i5Hc0pMWJegcs29jQHMLSiYjcXyzNhsU7JNho1GMuurSS9shtT
         eIHk4gqKtss7cfSv+m8nKRlqYabd+TAtYquFlAOTfnwWEFXQg8z0MIVSdl0IPj4oDChr
         CLR7BpJUbYzEAohQJ8/FtdPECpfSeOn/mT5nGC8WVI2kr0H3SF1xA8efvxl8Fyn6oYfa
         p8QA==
X-Gm-Message-State: AO0yUKVebC1s0UKqo29eaJwvZwOeuhicVsLk6skbXhfkDDum0hXyJnPG
        gk6XZ3gVbvzEM1JLQ/80xks=
X-Google-Smtp-Source: AK7set/x80FQjPZUn/3XtHXtVyfMUipTNm59Yq+rktAgdqJxPhM28LN40nX/xK7/Rl6DFvAQKJtv4A==
X-Received: by 2002:a05:600c:2053:b0:3ed:5cf7:3080 with SMTP id p19-20020a05600c205300b003ed5cf73080mr12180070wmg.5.1679301642106;
        Mon, 20 Mar 2023 01:40:42 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b002c5706f7c6dsm8295961wrr.94.2023.03.20.01.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:40:41 -0700 (PDT)
Date:   Mon, 20 Mar 2023 08:40:40 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ce89fe94-dc8d-4e10-9181-e01760939ef6@lucifer.local>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <20230319131047.174fa4e29cabe4371b298ed0@linux-foundation.org>
 <fadd8558-8917-4012-b5ea-c6376c835cc8@lucifer.local>
 <ZBd00i7fvwrMX/FY@casper.infradead.org>
 <b4233383-2c87-422f-9f66-3815a6c77372@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4233383-2c87-422f-9f66-3815a6c77372@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 09:16:18PM +0000, Lorenzo Stoakes wrote:
> On Sun, Mar 19, 2023 at 08:47:14PM +0000, Matthew Wilcox wrote:
> > I wonder if we can't do something like prefaulting the page before
> > taking the spinlock, then use copy_page_to_iter_atomic()
>
<snip>

On second thoughts, and discussing with Uladzislau, this seems like a more
sensible approach.

I'm going to respin with prefaulting and revert to the previous locking.
