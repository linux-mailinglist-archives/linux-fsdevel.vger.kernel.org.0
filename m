Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B814EBBC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiC3HeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiC3HeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:34:05 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAF9204A80
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 00:32:14 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2e5e9025c20so208519367b3.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjTDi9n/uLRqxVKGGOaPNySXftZQ6axRJXtPfIo5LUI=;
        b=oy0ldmBjJZfRyL+iZuZ5FQ/Inj2N4hflGyxVltzKvGdTjhOYfkFX8SjWEA2uOlOnz3
         AKOfxviF2B7L+/oZuIvzhkjT00ZrJliFLYhLF5UqAOo0/bMIjxjKCLujhnabL6gKCGgO
         6MdTSmLe+CDGS2g1FopXywQUJWfY5c6avaXqJbsJKiYkTBJ/0avOJLEK3cVY8YflI3R9
         9ZHjM2AsS6qJf+rw0uC4YVZdhi463GG9MmJXC5ZHSj13srAq2ZRVFVYkCDQ6zhypRruU
         I5qQRa/lQIUTWj8p7n28JUDfMbQT8CfQr4x1Gd54i7/6CAtDTanLGOYFGb9GZwXKSAon
         h4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjTDi9n/uLRqxVKGGOaPNySXftZQ6axRJXtPfIo5LUI=;
        b=YeOzpa3AfoVsfcE1kEpEl7UpvitAlOTjU+GobiXl3o20Rs8t11ipn7Nm1eWcwcToG/
         sU4MQqoB16KrygKe2oKCSbnIE1v2Z4WrdaJcstRAKwPMOteQACxoamCSjMHDQjaAkVgh
         cSE8m1A7hsxLsJQWoJzXJyz5lOArN4o1YC/Ok6KnKd6pKz1LJgGfVI4MzEqOdWaD2NUo
         N+YamQuiYJFby5UNxWZCUDrxQPfuwvw7MUtvjejk4l8RWhqdkW2HGs0ovQvCnYS7Ta/8
         KCuohl4JSgy6Moce61I78ephH9XCHlzq+HEQxQatbfg6ela52xpEfHVFu30Os8OLxYcw
         DW5A==
X-Gm-Message-State: AOAM532JTj22xLgReOv3bsVo7rVH/wsKJneukizzVY7zSeJYgG0az1iQ
        mEVIl0BHZktMkw+dopJYsRbb3ho6NxJ9qg8hrFBK8A==
X-Google-Smtp-Source: ABdhPJz47F/zt8DASramM8wZ7Ct2jmaZz8jkBg/c3k72v2zUuDdQNpuEmcP5Le6BlzGgL/Da/aZVgVfRA9PmmuG+3Qc=
X-Received: by 2002:a81:897:0:b0:2e5:f3b2:f6de with SMTP id
 145-20020a810897000000b002e5f3b2f6demr35325738ywi.141.1648625533474; Wed, 30
 Mar 2022 00:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220329134853.68403-1-songmuchun@bytedance.com>
 <20220329134853.68403-4-songmuchun@bytedance.com> <YkPu7XjYzkQLVMw/@infradead.org>
In-Reply-To: <YkPu7XjYzkQLVMw/@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 30 Mar 2022 15:31:37 +0800
Message-ID: <CAMZfGtWOn0a1cGd6shognp0w1HUqHoEy2eHSWHvVxh6sb4=utQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 1:47 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 29, 2022 at 09:48:50PM +0800, Muchun Song wrote:
> > + * * Return the start of user virtual address at the specific offset within
>
> Double "*" here.

Thanks for pointing out this.

>
> Also Shiyang has been wanting a quite similar vma_pgoff_address for use
> in dax.c.  Maybe we'll need to look into moving this to linux/mm.h.
>

I saw Shiyang is ready to rebase onto this patch.  So should I
move it to linux/mm.h or let Shiyang does?

Thanks.
