Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3264F76B9CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHAQjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHAQjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:39:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFD12115;
        Tue,  1 Aug 2023 09:39:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso54601465e9.1;
        Tue, 01 Aug 2023 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690907945; x=1691512745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q+FYlsdVjplvOSfu1dq3E3GzIaJTb8Vu7slqEF1uNU=;
        b=PQ/9WtxcgKsHz11TgwxBlZXFedw159G32eIiWIQUC2W8imCUzwa0z69gSm99Nn8XzO
         8YhcJPiguUh5h5KTdY13J4bo7WuUVmvPk+iyTEYw3u0VRUfA+Vcd/SojuIqlXz5cU8pX
         DLLqv6Fq8tz1EnzRZXDwtsGqUSHjUC4jrEquPNX4xqOCU2/lZQRB/f78AgHkBT1ieGLG
         dycGgWYrCxN8LcBYbsC6WdsNktq1jvO9sOmF5N0OUaNXxmE+vhwDytLDIN5pnRBnEP2c
         j+rzbXwOPee0gG28vv+TvUQ44D5nUsFi1a166Lo8XZzVGzIsX86phd4nr6Dv8oH0jgcd
         nbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907945; x=1691512745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q+FYlsdVjplvOSfu1dq3E3GzIaJTb8Vu7slqEF1uNU=;
        b=CImzfgGlkVP1HetXjxOu89cHmTDuylHiboFPnfljqeLBjLsrC1Xum5B1U6FueaJ9D7
         3I75N6ZTwCvPrcmBvClFBgHC/7oj6krFTErIn2oY1olRtxg4qHwZEvgoVwu/k12DELK9
         EFV7Zi6E4lNsakfVbfaxXCzSSYp6/BzpQSToOAW9Giy8oPu5uef9XcmBc0bVvA+dmbvZ
         GTAmXVj6CE1t5kMNZ7blheJgEqr6T0WPiTCbKjyDIi5lv69TAnI3CPgrNyR13gtIyLiO
         IC37iwlbmqQv/8QHhp+eRTyPB5agMZ4UmwAZ8OqCdJvS+M6V44XCA5mHagIJd0RjLb3U
         4Dyg==
X-Gm-Message-State: ABy/qLZHcnzd7tnXRlk7peXshDDtyj5m4gv0CHu7bEuZfZGgMV9bd3kc
        osj6mOB16enL5fe/+fGwmAT9fQKF4AI=
X-Google-Smtp-Source: APBJJlFc5Vg3IQU7O9rEPNVuYWEM2agkv7AwA1Cbrec45/A1tySgo6OaaaphAZnmaJaupcAfxKHaww==
X-Received: by 2002:a7b:ce90:0:b0:3fe:1aef:b9d8 with SMTP id q16-20020a7bce90000000b003fe1aefb9d8mr2764758wmj.14.1690907944448;
        Tue, 01 Aug 2023 09:39:04 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b003fe1afb99a9sm8453826wmb.11.2023.08.01.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:39:03 -0700 (PDT)
Date:   Tue, 1 Aug 2023 17:39:02 +0100
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
Message-ID: <525a3f14-74fa-4c22-9fca-9dab4de8a0c3@lucifer.local>
References: <20230731215021.70911-1-lstoakes@gmail.com>
 <0af1bc20-8ba2-c6b6-64e6-c1f58d521504@redhat.com>
 <dc30a97b-853e-4d2a-b171-e68fb3ab026c@lucifer.local>
 <b6cb8d7f-f3f3-93c3-3ea0-4c184109a4db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6cb8d7f-f3f3-93c3-3ea0-4c184109a4db@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 06:34:26PM +0200, David Hildenbrand wrote:
> On 01.08.23 18:33, Lorenzo Stoakes wrote:
> > On Tue, Aug 01, 2023 at 11:05:40AM +0200, David Hildenbrand wrote:
> > > On 31.07.23 23:50, Lorenzo Stoakes wrote:
> > > > Some architectures do not populate the entire range categorised by
> > > > KCORE_TEXT, so we must ensure that the kernel address we read from is
> > > > valid.
> > > >
> > > > Unfortunately there is no solution currently available to do so with a
> > > > purely iterator solution so reinstate the bounce buffer in this instance so
> > > > we can use copy_from_kernel_nofault() in order to avoid page faults when
> > > > regions are unmapped.
> > > >
> > > > This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
> > > > bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
> > > > the code to continue to use an iterator.
> > > >
> > > > Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> > > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > > Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > > ---
> > > >    fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
> > > >    1 file changed, 25 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > > > index 9cb32e1a78a0..3bc689038232 100644
> > > > --- a/fs/proc/kcore.c
> > > > +++ b/fs/proc/kcore.c
> > > > @@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
> > > >    static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> > > >    {
> > > > +	struct file *file = iocb->ki_filp;
> > > > +	char *buf = file->private_data;
> > > >    	loff_t *fpos = &iocb->ki_pos;
> > > >    	size_t phdrs_offset, notes_offset, data_offset;
> > > >    	size_t page_offline_frozen = 1;
> > > > @@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> > > >    			fallthrough;
> > > >    		case KCORE_VMEMMAP:
> > > >    		case KCORE_TEXT:
> > > > +			/*
> > > > +			 * Sadly we must use a bounce buffer here to be able to
> > > > +			 * make use of copy_from_kernel_nofault(), as these
> > > > +			 * memory regions might not always be mapped on all
> > > > +			 * architectures.
> > > > +			 */
> > > > +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> > > > +				if (iov_iter_zero(tsz, iter) != tsz) {
> > > > +					ret = -EFAULT;
> > > > +					goto out;
> > > > +				}
> > > >    			/*
> > > >    			 * We use _copy_to_iter() to bypass usermode hardening
> > > >    			 * which would otherwise prevent this operation.
> > > >    			 */
> > >
> > > Having a comment at this indentation level looks for the else case looks
> > > kind of weird.
> >
> > Yeah, but having it indented again would be weird and seem like it doesn't
> > apply to the block below, there's really no good spot for it and
> > checkpatch.pl doesn't mind so I think this is ok :)
> >
> > >
> > > (does that comment still apply?)
> >
> > Hm good point, actually, now we're using the bounce buffer we don't need to
> > avoid usermode hardening any more.
> >
> > However since we've established a bounce buffer ourselves its still
> > appropriate to use _copy_to_iter() as we know the source region is good to
> > copy from.
> >
> > To make life easy I'll just respin with an updated comment :)
>
> I'm not too picky this time, no need to resend if everybody else is fine :P
>

Haha you know the classic Lorenzo respin spiral and want to avoid it I see ;)

The comment is actually inaccurate now, so to avoid noise + make life easy
(maybe) for Andrew here's a fix patch that just corrects the comment:-

----8<----

From d2b8fb271f21b79048e5630699133f77a93d0481 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 1 Aug 2023 17:36:08 +0100
Subject: [PATCH] fs/proc/kcore: correct comment

Correct comment to be strictly correct about reasoning.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/kcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 3bc689038232..23fc24d16b31 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -568,8 +568,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 					goto out;
 				}
 			/*
-			 * We use _copy_to_iter() to bypass usermode hardening
-			 * which would otherwise prevent this operation.
+			 * We know the bounce buffer is safe to copy from, so
+			 * use _copy_to_iter() directly.
 			 */
 			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
 				ret = -EFAULT;
--
2.41.0
