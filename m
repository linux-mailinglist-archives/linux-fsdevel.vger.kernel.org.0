Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77E567C14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGFCri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 22:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiGFCrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:47:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14D1A06E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 19:47:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x4so13174693pfq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jul 2022 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IW/MEisRImp3/lPYkYpqCnuHv6idrwG0D60CzTjNlbg=;
        b=quxpqfHGltM89OLv0TIHtu7OKPWuWQXFLM4J5R8qY/nAAEfFdhcnS14yGAp7e1n5di
         0cPJ3TwSSrAVYbIoskwpc480ETBLPHs54TGThC3k8J6KBnpMusgr90miFBdiJXUsgyx6
         xbcBdflNaQMiKApuZJoTRU7zlZz1DXl+8lm3R3P+HoO978TYfORR5vSSDjUYmLmMp+q2
         8+aRcqXKO5YpZtPafnyRV4D8vzdXVFr3Rjt474WTm4VlDURJ0P/FMc8TZKJU2Zh/WdmC
         J5Q75J6DZ33YaXiwTDBD8ENDZbyIyeSUYrwFljyI0x6EjCVPN6pn2bzzWd7Pt1oEpfHk
         cdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IW/MEisRImp3/lPYkYpqCnuHv6idrwG0D60CzTjNlbg=;
        b=6kDWu6pvX2lKL4BBkP6lJiI1QSDrXARr7y5F0AGwsyUc03FEA+73EEzQVqJ0hSArka
         4a4fNavowQPwPlnTyO4cV3n6cXBfu1ydrP/5iCPvdRA6d14DozRurWdmZWLJAHLAfk3r
         mJZnhtLD285se9hDe0wljNkAyikxhH9ndFZDPMvBFy4IDq030/V6OGjV6T2YHOJpdMr6
         sDZlHI+8WwtrNz3W145mAJ0Rv9qyyA7m8C2+tsx4KNniZ7Ud3noHggsV9SUvo8jeB68x
         keMxrFFxCS8bEGeavwPLUwdSxuyvePjAVlVZOEkq50E+gFvLB+V64gqNfW/udRMLBx7k
         qDeQ==
X-Gm-Message-State: AJIora8cxqQCVXKsaNQE2ccz/wV1bSkvT7IlFOYPqLSNJVPV8VTqPjGf
        x0AfTSYuA4it7vQHjMn79SXJJw==
X-Google-Smtp-Source: AGRyM1uTdJ3o4LNsP4D1e5S082o3mxjqvUnFNizEKLHJoOTPoitYvcw6+5ewIYS0dZ1OpE+R98mpjQ==
X-Received: by 2002:aa7:910b:0:b0:524:f8d9:a4c4 with SMTP id 11-20020aa7910b000000b00524f8d9a4c4mr45971995pfh.5.1657075655655;
        Tue, 05 Jul 2022 19:47:35 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090311cd00b0016bdeb58611sm6180279plh.112.2022.07.05.19.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 19:47:35 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:47:32 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, jgg@ziepe.ca,
        jhubbard@nvidia.com, william.kucharski@oracle.com,
        dan.j.williams@intel.com, jack@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix missing wake-up event for FSDAX pages
Message-ID: <YsT3xFSLJonnA2XC@FVFYT0MHHV2J.usts.net>
References: <20220705123532.283-1-songmuchun@bytedance.com>
 <20220705141819.804eb972d43be3434dc70192@linux-foundation.org>
 <YsTLgQ45ESpsNEGV@casper.infradead.org>
 <20220705164710.9541b5cf0e5819193213ea5c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705164710.9541b5cf0e5819193213ea5c@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:47:10PM -0700, Andrew Morton wrote:
> On Wed, 6 Jul 2022 00:38:41 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Jul 05, 2022 at 02:18:19PM -0700, Andrew Morton wrote:
> > > On Tue,  5 Jul 2022 20:35:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > > 
> > > > FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
> > > > 1, then the page is freed.  The FSDAX pages can be pinned through GUP,
> > > > then they will be unpinned via unpin_user_page() using a folio variant
> > > > to put the page, however, folio variants did not consider this special
> > > > case, the result will be to miss a wakeup event (like the user of
> > > > __fuse_dax_break_layouts()).  Since FSDAX pages are only possible get
> > > > by GUP users, so fix GUP instead of folio_put() to lower overhead.
> > > > 
> > > 
> > > What are the user visible runtime effects of this bug?
> > 
> > "missing wake up event" seems pretty obvious to me?  Something goes to
> > sleep waiting for a page to become unused, and is never woken.
> 
> No, missed wakeups are often obscured by another wakeup coming in
> shortly afterwards.
> 

I need to clarify the task will never be woken up.

> If this wakeup is not one of these, then are there reports from the
> softlockup detector?
> 
> Do we have reports of processes permanently stuck in D state?
>

No. The task is in an TASK_INTERRUPTIBLE state (see __fuse_dax_break_layouts). 
The hung task reporter only reports D task (TASK_UNINTERRUPTIBLE).

Thanks.
> 
