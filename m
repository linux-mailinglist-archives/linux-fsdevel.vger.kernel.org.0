Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9C6017C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJQTiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJQTiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:38:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4F7170C;
        Mon, 17 Oct 2022 12:38:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 207so14505133ybn.1;
        Mon, 17 Oct 2022 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=11HlMSQgh2+1m4prM5hBOZCjfPivio1t8D+HJv6iXrE=;
        b=Qqf6jWDrDZvWOGO4mY2ZGxVxgAh7R1tkR0Jjq9c4ilfW90N7wx58GWNtMZKlnuWLPC
         U5teH3PTFAjeT7dlEM7EoTRpVXoEOIUEQQoaQwYMPr1ISM6DDsbpnhda4eQs2y63NzU0
         /BIjOb6KK8YYEVE1FvR8vmhthMgW3+wL9qc2ILLLxCn8/0cKKQolwZm2Rv89ll4HX4s3
         pZgIXUNqEG9RW4BpEIs6dkJZmr633WQqJxMJyuEcKqgCsClVEP7Bkp0MDNLbS86BXWpN
         P0/Pa6SigUrF/ejkkIVNYx5oiS+UMCJuAOmtAIHj4yaBlTPlwhQBGt8xPtR1C3ooIvF5
         ca0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11HlMSQgh2+1m4prM5hBOZCjfPivio1t8D+HJv6iXrE=;
        b=IFxeKOXSs5/AOaDk4Q7szasoA2SZPqjGI13FpFNxhXcfi/qyqzcKddGSC7WjNZVXXj
         fLWgf3W3vjLyAjfVMTh/x+zaKh7ziGYm/W3Iq5izR1KmrrqAZHXrMkCwc7OX4Wvyy6TB
         DABNwA/FrSnuMb1OycN+A3VhRp5ncjtiM4Mgn9MLT15qLh9jDkQVau9+AChRN2X44qAz
         Lc8s91c464iqnJVPz0LVa81Xs0bNH3Xpp3Xy4U84L7NPnDyngvObTmnBoesFnyUYl8+h
         FPeLwlXMSlPkm6lYs06IqH8I6SdMqTtEiaZBG63MJoyZuCD+beCQWEIrlbmYJTwXeKA7
         YiKQ==
X-Gm-Message-State: ACrzQf1FxFTH0GYC4Jv6CR45/bqc4sBbrVcJAfp/S+eM+rM6qoRiLotw
        z7fxN/Us3PnjKFyZDEhfu0btbj8k1AM0xme2LSw5UiIejn0=
X-Google-Smtp-Source: AMsMyM4LhTg0HjBLlIz0JvMpO2FzWSArw6uSd4FVCafMCg2dbJOuKRgc+2ieTbY6xAQ6YpiCu5wggKRugl+TCEXWpfM=
X-Received: by 2002:a25:810f:0:b0:6bc:a66f:6763 with SMTP id
 o15-20020a25810f000000b006bca66f6763mr11123241ybk.355.1666035479638; Mon, 17
 Oct 2022 12:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221017161800.2003-1-vishal.moola@gmail.com> <20221017161800.2003-2-vishal.moola@gmail.com>
 <Y02JTOtYEbAyo+zu@casper.infradead.org>
In-Reply-To: <Y02JTOtYEbAyo+zu@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 17 Oct 2022 12:37:48 -0700
Message-ID: <CAOzc2py24=NBFX6mWZ9s0eRH-rU87n-mYsVK=TW_jtx646z_qQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] filemap: find_lock_entries() now updates start offset
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 9:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 17, 2022 at 09:17:59AM -0700, Vishal Moola (Oracle) wrote:
> > +++ b/mm/shmem.c
> > @@ -932,21 +932,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> >
> >       folio_batch_init(&fbatch);
> >       index = start;
> > -     while (index < end && find_lock_entries(mapping, index, end - 1,
> > +     while (index < end && find_lock_entries(mapping, &index, end - 1,
>
> Sorry for not spotting this in earlier revisions, but this is wrong.
> Before, find_lock_entries() would go up to (end - 1) and then the
> index++ at the end of the loop would increment index to "end", causing
> the loop to terminate.  Now we don't increment index any more, so the
> condition is wrong.

The condition is correct. Index maintains the exact same behavior.
If a find_lock_entries() finds a folio, index is set to be directly after
the last page in that folio, or simply incrementing for a value entry.
The only time index is not changed at all is when find_lock_entries()
finds no folios, which is the same as the original behavior as well.

> I suggest just removing the 'index < end" half of the condition.

I hadn't thought about it earlier but this index < end check seems
unnecessary anyways. If index > end then find_lock_entries()
shouldn't find any folios which would cause the loop to terminate.

I could send an updated version getting rid of the "index < end"
condition as well if you would like?
