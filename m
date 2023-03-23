Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24A6C5FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 07:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCWGof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCWGoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:44:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452F2DE5C;
        Wed, 22 Mar 2023 23:44:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v1so13207511wrv.1;
        Wed, 22 Mar 2023 23:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679553852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMt6IiIj1g/DqQnbQSAvbNGtbOJm5tLZxMcMsHALdIk=;
        b=GhmjoBqZnTla9JBkjF1UZtu8wu6QjffqlHVeeBSYX2nsCx2EjNUPd9PoBLsyD6Fvay
         PUDva7C4NGKsmwEbwBCxAOGd9EL87aiHG+kQudl9u9UlFpmv9e/4RjhfDSdSVwnwvcBm
         baBY0/IoZRR49XX2VcDjY1RfhNbEJkmSxuN/ffwm0Mm67KsM6hDo5BFwoP77jL1yua9J
         37n9J27adgwFwke7WNhN8IzlQlAPD55U+bklIM3krb05IsmeD8vkf20E9UygrsGyoZ9R
         Tc00rBGRQW6lUANqYbvaQ+qdXnh/WeUiS1MpV6MziUy55YOmt4caiqeTmvENycbM24So
         ACTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMt6IiIj1g/DqQnbQSAvbNGtbOJm5tLZxMcMsHALdIk=;
        b=W5cLQhdJmNdBQFo4dCPZRzzfHVmnCtu87sXroPeqtE9YeMV1cc/z+ivQbJDda1Hisg
         bRfqOZ3t2ocelhXtNDjee/t/sT5wBBkEkFqBpwfJcdqpbfgLGuCj+oqV2Km09DbuGnbP
         VV2EH3ti2QOcLDxDMqhSeRopRUq0hse+Vl8t4JnUoFXtdq4s1obEzROVGoAe41O6JZbg
         aFLv93oiPcalDWm8/2QL9Fs2jHPr8jJEWHzoVPRJ/RkR4rzS7VpsZWQA69R298UOzh2g
         4YQFrdq2aLfPelYT6eqYRisugHM6qu660WZlCO6Tz2JKNgfEKzrqJ1oelaaiKJfGs//B
         lL7w==
X-Gm-Message-State: AAQBX9ce29FazUbaPs1XJmeEzWhkhOAkZ2I7xblP0TDrknIThigvQv8a
        j0mHaTBPWvs9eNrK63LdQ64=
X-Google-Smtp-Source: AKy350ZGd5btCaPavQ2r8rRtJiNmG4yjfpo1Ok0NUgSUne0wsPU91oXttK7RYC1dOoDQRW6+1/L2hg==
X-Received: by 2002:adf:ee84:0:b0:2ce:ae54:1592 with SMTP id b4-20020adfee84000000b002ceae541592mr1469269wro.38.1679553851918;
        Wed, 22 Mar 2023 23:44:11 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b003edc9a5f98asm845384wmo.44.2023.03.22.23.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 23:44:10 -0700 (PDT)
Date:   Thu, 23 Mar 2023 06:44:10 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
 <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:52:09AM +0800, Baoquan He wrote:
> On 03/22/23 at 06:57pm, Lorenzo Stoakes wrote:
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
> > we dispense with it, and try to write to user memory optimistically but
> > with faults disabled via copy_page_to_iter_nofault(). We already have
> > preemption disabled by holding a spin lock. We continue faulting in until
> > the operation is complete.
>
> I don't understand the sentences here. In vread_iter(), the actual
> content reading is done in aligned_vread_iter(), otherwise we zero
> filling the region. In aligned_vread_iter(), we will use
> vmalloc_to_page() to get the mapped page and read out, otherwise zero
> fill. While in this patch, fault_in_iov_iter_writeable() fault in memory
> of iter one time and will bail out if failed. I am wondering why we
> continue faulting in until the operation is complete, and how that is done.

This is refererrring to what's happening in kcore.c, not vread_iter(),
i.e. the looped read/faultin.

The reason we bail out if failt_in_iov_iter_writeable() is that would
indicate an error had occurred.

The whole point is to _optimistically_ try to perform the operation
assuming the pages are faulted in. Ultimately we fault in via
copy_to_user_nofault() which will either copy data or fail if the pages are
not faulted in (will discuss this below a bit more in response to your
other point).

If this fails, then we fault in, and try again. We loop because there could
be some extremely unfortunate timing with a race on e.g. swapping out or
migrating pages between faulting in and trying to write out again.

This is extremely unlikely, but to avoid any chance of breaking userland we
repeat the operation until it completes. In nearly all real-world
situations it'll either work immediately or loop once.

>
> If we look into the failing point in vread_iter(), it's mainly coming
> from copy_page_to_iter_nofault(), e.g page_copy_sane() checking failed,
> i->data_source checking failed. If these conditional checking failed,
> should we continue reading again and again? And this is not related to
> memory faulting in. I saw your discussion with David, but I am still a
> little lost. Hope I can learn it, thanks in advance.
>

Actually neither of these are going to happen. page_copy_sane() checks the
sanity of the _source_ pages, and the 'sanity' is defined by whether your
offset and length sit within the (possibly compound) folio. Since we
control this, we can arrange for it never to happen.

i->data_source is checking that it's an output iterator, however we would
already have checked this when writing ELF headers at the bare minimum, so
we cannot reach this point with an invalid iterator.

Therefore it is not possible either cause a failure. What could cause a
failure, and what we are checking for, is specified in copyout_nofault()
(in iov_iter.c) which we pass to the iterate_and_advance() macro. Now we
have a fault-injection should_fail_usercopy() which would just trigger a
redo, or copy_to_user_nofault() returning < 0 (e.g. -EFAULT).

This code is confusing as this function returns the number of bytes _not
copied_ rather than copied. I have tested this to be sure by the way :)

Therefore the only way for a failure to occur is for memory to not be
faulted in and thus the loop only triggers in this situation. If we fail to
fault in pages for any reason, the whole operation aborts so this should
cover all angles.

> ......
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 08b795fd80b4..25b44b303b35 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> ......
> > @@ -507,13 +503,30 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> >
> >  		switch (m->type) {
> >  		case KCORE_VMALLOC:
> > -			vread(buf, (char *)start, tsz);
> > -			/* we have to zero-fill user buffer even if no read */
> > -			if (copy_to_iter(buf, tsz, iter) != tsz) {
> > -				ret = -EFAULT;
> > -				goto out;
> > +		{
> > +			const char *src = (char *)start;
> > +			size_t read = 0, left = tsz;
> > +
> > +			/*
> > +			 * vmalloc uses spinlocks, so we optimistically try to
> > +			 * read memory. If this fails, fault pages in and try
> > +			 * again until we are done.
> > +			 */
> > +			while (true) {
> > +				read += vread_iter(iter, src, left);
> > +				if (read == tsz)
> > +					break;
> > +
> > +				src += read;
> > +				left -= read;
> > +
> > +				if (fault_in_iov_iter_writeable(iter, left)) {
> > +					ret = -EFAULT;
> > +					goto out;
> > +				}
> >  			}
> >  			break;
> > +		}
> >  		case KCORE_USER:
> >  			/* User page is handled prior to normal kernel page: */
> >  			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
>
