Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97B6C492E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCVLb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVLbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:31:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA7521D1;
        Wed, 22 Mar 2023 04:31:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w11so10238484wmo.2;
        Wed, 22 Mar 2023 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679484713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T23LL3jlK2aRrpvWfBk+LjabBn8uwj6VwUBP3zlRelo=;
        b=Oi90EmPC5AdwQsMl/8AC50ncEsO/xpIrtW3kvkjFsk1sVM9b3DU/8O6UxjjwnC1t6z
         +JNbCPYMh7IWjV3r23v5fHlXKS5K7RX2y+YA0qEqAqRs9dF/G7B4FRacoSGoGl/bZ33B
         oGMziCnWVFjOugmjUTBCV3PVWnMI19Sg4V/HUQVaq3ZFyuqa2UaWqZQ4AKS8N65GPtrS
         EFFaEpUlHQQk5FRYOZL/fUF0B7oraK2FDU1Q/0vb20MSePw8wjzcfnew76hDUGlhzFo4
         4DQo1U5C7ulZlkFHjQPJIQNktcI6U/hqyewtlH4/XmrDIpQENX5x2koszFEZfCimKoYM
         lc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679484713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T23LL3jlK2aRrpvWfBk+LjabBn8uwj6VwUBP3zlRelo=;
        b=xsvB6bQhwkUWkZjNiHAGZSCKRE7tDkLnxqNP90Ny+Cw0gBNo40WuWO2aO+N6zyKI2+
         INKRLlLqM1PAt/Ve06imgC9NYHBInD81wwF/om3RDdoT3bErZsagyoNjrq8zXdpG1wtG
         gORIQfSpBWa63aKsCaVtdZ2ccyWMEj0KLzdKFbH1yp2nuBkZ4IXlQp6BbOnZ97iRQnxu
         Qp86V62coWGsH6vBmGeqTeNj7grAxyLyBMMtMuuQcmxksK+AnBmAzR8TccXH+AiCcJ4r
         J+fupuaZf8pm8cHjzjgddeqaY8sj3LjQeZtgXsyhz7fthb7IkO6OSc1k2si/gsmGT7dA
         7QjQ==
X-Gm-Message-State: AO0yUKVzK3AROSPdCVsrOSpQYLsCnoSxuwZFMC/MSxJmtcO6hXMawpNd
        ic3gUyuqmtFLA2w2e5PWyTc0VNJ0hbA=
X-Google-Smtp-Source: AK7set/m0gpIesz5kHDtmZFCglfu+v/Yd6M1WGBAI1KbP8WZyGCkWvPtzbdlJ6QBhFfxK0hyKgfA2A==
X-Received: by 2002:a05:600c:3b8b:b0:3ed:b9ee:b436 with SMTP id n11-20020a05600c3b8b00b003edb9eeb436mr1616832wms.7.1679484712721;
        Wed, 22 Mar 2023 04:31:52 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d4344000000b002c5526234d2sm13813933wrr.8.2023.03.22.04.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:31:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:31:47 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <fe8f9909-332f-41c3-b672-a352cc6218d7@lucifer.local>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <6b3899bbbf1f4bd6b7133c8b6f27b3a8791607b0.1679431886.git.lstoakes@gmail.com>
 <8ba0360e-57eb-93b0-3ae6-612f6b371bff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba0360e-57eb-93b0-3ae6-612f6b371bff@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:18:08PM +0100, David Hildenbrand wrote:
> On 21.03.23 21:54, Lorenzo Stoakes wrote:
> > Having previously laid the foundation for converting vread() to an iterator
> > function, pull the trigger and do so.
> >
> > This patch attempts to provide minimal refactoring and to reflect the
> > existing logic as best we can, for example we continue to zero portions of
> > memory not read, as before.
> >
> > Overall, there should be no functional difference other than a performance
> > improvement in /proc/kcore access to vmalloc regions.
> >
> > Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> > we dispense with it. We need to ensure userland pages are faulted in before
> > proceeding, as we take spin locks.
> >
> > Additionally, we must account for the fact that at any point a copy may
> > fail if this happens, we exit indicating fewer bytes retrieved than
> > expected.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >   fs/proc/kcore.c         |  26 ++---
> >   include/linux/vmalloc.h |   3 +-
> >   mm/nommu.c              |  10 +-
> >   mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
> >   4 files changed, 160 insertions(+), 113 deletions(-)
> >
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 25e0eeb8d498..221e16f75ba5 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -307,13 +307,9 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
> >   	*i = ALIGN(*i + descsz, 4);
> >   }
> > -static ssize_t
> > -read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> > +static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> >   {
> > -	struct file *file = iocb->ki_filp;
> > -	char *buf = file->private_data;
> >   	loff_t *ppos = &iocb->ki_pos;
> > -
> >   	size_t phdrs_offset, notes_offset, data_offset;
> >   	size_t page_offline_frozen = 1;
> >   	size_t phdrs_len, notes_len;
> > @@ -507,9 +503,12 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> >   		switch (m->type) {
> >   		case KCORE_VMALLOC:
> > -			vread(buf, (char *)start, tsz);
> > -			/* we have to zero-fill user buffer even if no read */
> > -			if (copy_to_iter(buf, tsz, iter) != tsz) {
> > +			/*
> > +			 * Make sure user pages are faulted in as we acquire
> > +			 * spinlocks in vread_iter().
> > +			 */
> > +			if (fault_in_iov_iter_writeable(iter, tsz) ||
> > +			    vread_iter(iter, (char *)start, tsz) != tsz) {
> >   				ret = -EFAULT;
> >   				goto out;
> >   			}
>
> What if we race with swapout after faulting the pages in? Or some other
> mechanism to write-protect the user space pages?
>
> Also, "This is primarily useful when we already know that some or all of the
> pages in @i aren't in memory". This order of events might slow down things
> quite a bit if I am not wrong.
>
>
> Wouldn't you want to have something like:
>
> while (vread_iter(iter, (char *)start, tsz) != tsz) {
> 	if (fault_in_iov_iter_writeable(iter, tsz)) {
> 		ret = -EFAULT;
> 		goto out;
> 	}
> }
>
> Or am I missing something?
>

Indeed, I was thinking of this as:-

- prefault
- try (possibly fail if race) copy operation

However it does make more sense, and makes it explicit that it's an attempt that
might fail requiring a fault-in in the while form.

I think the upcoming change to explicitly make the iter function
copy_folio_to_iter_nofault() makes it clear from end-to-end what is being done -
we mustn't fault (spinlocks held) and if a fault would occur we error out, if we
error out try faulting in, if this fails then abort.

I will fixup in respin.

> --
> Thanks,
>
> David / dhildenb
>
