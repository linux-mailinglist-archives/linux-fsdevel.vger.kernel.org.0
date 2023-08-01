Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C876B9AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHAQdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjHAQdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:33:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111C31BF8;
        Tue,  1 Aug 2023 09:33:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so6019186f8f.1;
        Tue, 01 Aug 2023 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690907600; x=1691512400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHGU2gldR70GqySNOHxAwDHvYPybisAew0SwiRmKpZY=;
        b=sUkr6tkOpfLpmNAXaSFuiW9LXXeEwoKnrmMBkcK4Hzd0GO2uCmDG+gS3aJeFobgXlD
         ImcBSaz6f4I9GQ+RO4VH50l6qUxD+A8J0DSNTD75KJC1ayt6U4xdPnPubhdWeczlWQ6H
         fMfduYyNkmjd2kWxa5QQJ123pP6nOzDRnh1UyGT5KnRAlO3R6gH86arPxDYsF/4Pn0ie
         rKXwqC3Nj3MtsSP9/dw1OtLM6sSmfKy6MMU9v7Uf0lNMpxRtqiBJuwYDHe1w6uAg17kf
         ZTu8tou6vHV8MSGse9+huBvZCwjrIlu7RI0oZQNdHGmjzTEizy9R6fAyj0yfLm36uJBV
         32xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907600; x=1691512400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHGU2gldR70GqySNOHxAwDHvYPybisAew0SwiRmKpZY=;
        b=Q4Kwa16mPVrx0jNDTjeW7G6cN5lX8nDltLwYtANQFpkx8P8YzVXnYj/W33X8OMt8MB
         p9wnu1gAWQoqQlN1nEEgDOuTecAp8vFiMHtXW4LJDwL4U7dvPLs6Azzi/hS++iShdrVS
         kGG7DirCW+boYnJe6Y2Tv4hHM6tWqhJ7rJStzkIPOqZJZrq4wXrx7GfNtRjaazXwrc+5
         nzRakY2RZzJi1PAd2XU0mjnew6f5mg2R6MnkQwYOoshGQ/RswPjEHV5QiOsIPAGlz6e0
         8KF+1Th3ixV0N1rOTXBHe1BwaTnL7N1ANkBJmMQmgCKfUvQiTbo9HJO1DOUZgIaJ9l5M
         2Nlw==
X-Gm-Message-State: ABy/qLYjZjBMQdqnCc2yKXkkX6mb77eZHQOB7FVqopZjAKYA2jjgWCCo
        4MCMBN9oqiDU7gtTwsRJfzc=
X-Google-Smtp-Source: APBJJlGWssiVAATcXmhQas2IAW1DtAJFXZ/rOYG4wKV4z3qFLF/SvVTfMh8RRRDM4z57utXs4wl8gg==
X-Received: by 2002:a5d:6783:0:b0:313:f02f:be7f with SMTP id v3-20020a5d6783000000b00313f02fbe7fmr2576237wru.55.1690907600207;
        Tue, 01 Aug 2023 09:33:20 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm16488864wrr.56.2023.08.01.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:33:19 -0700 (PDT)
Date:   Tue, 1 Aug 2023 17:33:18 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT
 regions
Message-ID: <dc30a97b-853e-4d2a-b171-e68fb3ab026c@lucifer.local>
References: <20230731215021.70911-1-lstoakes@gmail.com>
 <0af1bc20-8ba2-c6b6-64e6-c1f58d521504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af1bc20-8ba2-c6b6-64e6-c1f58d521504@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:05:40AM +0200, David Hildenbrand wrote:
> On 31.07.23 23:50, Lorenzo Stoakes wrote:
> > Some architectures do not populate the entire range categorised by
> > KCORE_TEXT, so we must ensure that the kernel address we read from is
> > valid.
> >
> > Unfortunately there is no solution currently available to do so with a
> > purely iterator solution so reinstate the bounce buffer in this instance so
> > we can use copy_from_kernel_nofault() in order to avoid page faults when
> > regions are unmapped.
> >
> > This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
> > bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
> > the code to continue to use an iterator.
> >
> > Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >   fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
> >   1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 9cb32e1a78a0..3bc689038232 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
> >   static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> >   {
> > +	struct file *file = iocb->ki_filp;
> > +	char *buf = file->private_data;
> >   	loff_t *fpos = &iocb->ki_pos;
> >   	size_t phdrs_offset, notes_offset, data_offset;
> >   	size_t page_offline_frozen = 1;
> > @@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> >   			fallthrough;
> >   		case KCORE_VMEMMAP:
> >   		case KCORE_TEXT:
> > +			/*
> > +			 * Sadly we must use a bounce buffer here to be able to
> > +			 * make use of copy_from_kernel_nofault(), as these
> > +			 * memory regions might not always be mapped on all
> > +			 * architectures.
> > +			 */
> > +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> > +				if (iov_iter_zero(tsz, iter) != tsz) {
> > +					ret = -EFAULT;
> > +					goto out;
> > +				}
> >   			/*
> >   			 * We use _copy_to_iter() to bypass usermode hardening
> >   			 * which would otherwise prevent this operation.
> >   			 */
>
> Having a comment at this indentation level looks for the else case looks
> kind of weird.

Yeah, but having it indented again would be weird and seem like it doesn't
apply to the block below, there's really no good spot for it and
checkpatch.pl doesn't mind so I think this is ok :)

>
> (does that comment still apply?)

Hm good point, actually, now we're using the bounce buffer we don't need to
avoid usermode hardening any more.

However since we've established a bounce buffer ourselves its still
appropriate to use _copy_to_iter() as we know the source region is good to
copy from.

To make life easy I'll just respin with an updated comment :)

>
>
> --
> Cheers,
>
> David / dhildenb
>
