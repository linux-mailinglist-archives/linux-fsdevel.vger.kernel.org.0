Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878E66C3533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 16:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCUPLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCUPLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42ED9EE2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679411423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DFoGD9BJrCFMifx1PxTOB2rujq31Ya1+80mI9jX3No=;
        b=d3VteBJGcHlFuksyO4yUg7Zddeebih5thQap2CUKlv0BnnmFPR9eF4WuqkTK8FIHXXqvUP
        d/lrNEocV5zlutU2A2FA0/Eb+dLI9SOdaUN8dOlG856DGSXwfZfObcbyA3OZvFTNCQ7npt
        ZsfciXojJh7Tx+KZjHMVUTOjhPY+HuQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-hgSaKpV9MtGt3SHEfSfqfA-1; Tue, 21 Mar 2023 11:10:09 -0400
X-MC-Unique: hgSaKpV9MtGt3SHEfSfqfA-1
Received: by mail-qt1-f199.google.com with SMTP id u1-20020a05622a198100b003e12a0467easo3913596qtc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 08:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411406; x=1682003406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DFoGD9BJrCFMifx1PxTOB2rujq31Ya1+80mI9jX3No=;
        b=E1EXZ3xMSC1SoOkV8ZuklT51Zk6RCQp1ZN+vFtdFL6VzaGzdsMknVCqW+eru0ACRA2
         w/wZWn5JaYH+czTrJ0K54/7zUWxi6Y8WdBUwxS2UOZnKFmWvwv+f1mSmyRjD3ufssBj/
         WKx4fpvnEeNyX/7U9TDS1S9wXHn15M/QU2/jC6itHgtAPtUTETL2jJUrYvHYUelnYm+b
         YySWtsF+v50VVaLB09hdybvrI8LmViyhGFvLQWWGecJeqbIMXGvuLmWIfTSmbflpzu3p
         Ldox6Qck+e62GVpmJiqNwAXF8zRaQ5h5lG+EcwvdqtxNzqAHinEueEZ3w7CJ46VVr2qb
         dfYg==
X-Gm-Message-State: AO0yUKVNumiL5XSfMG8wQods9YkP6TqSB12TdFGg3U3uitS9QZGfibqq
        UoK5kRsT0edxa/BjHACIN9HbJPIwr5QvNO6RCMtXh1yScwuvUZQfRE2s1P2WyKbA/hDqAb+ltBT
        31e7Ad/NOkFbjS1sZ4vtTWLsbtA==
X-Received: by 2002:a05:6214:519d:b0:5af:3a13:202d with SMTP id kl29-20020a056214519d00b005af3a13202dmr4203424qvb.4.1679411405813;
        Tue, 21 Mar 2023 08:10:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set8W9eKuw8mGCscF9tjJFG3duBKw2qky36XBzhbw6oNhwiuWMqsmeB+rT/nlMILNCEGFQIkjlg==
X-Received: by 2002:a05:6214:519d:b0:5af:3a13:202d with SMTP id kl29-20020a056214519d00b005af3a13202dmr4203396qvb.4.1679411405533;
        Tue, 21 Mar 2023 08:10:05 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a16aa00b0074341cb30d0sm9364657qkj.62.2023.03.21.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:10:04 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:10:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 0/7] Implement IOCTL to get and optionally clear info
 about PTEs
Message-ID: <ZBnIyjTJ5yfxpcgs@x1n>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
 <CANaxB-wGLbM9U_dK=kzs+r5Xy358aKZ0=J_zODiLOcng+dbXog@mail.gmail.com>
 <ZBmmEfgq8QBAKPFN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBmmEfgq8QBAKPFN@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:41:53PM +0200, Mike Rapoport wrote:
> On Mon, Mar 20, 2023 at 11:30:00AM -0700, Andrei Vagin wrote:
> > On Thu, Mar 9, 2023 at 11:58 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu,  9 Mar 2023 18:57:11 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> > >
> > > > The information related to pages if the page is file mapped, present and
> > > > swapped is required for the CRIU project [5][6]. The addition of the
> > > > required mask, any mask, excluded mask and return masks are also required
> > > > for the CRIU project [5].
> > >
> > > It's a ton of new code and what I'm not seeing in here (might have
> > > missed it?) is a clear statement of the value of this feature to our
> > > users.
> > >
> > > I see hints that CRIU would like it, but no description of how valuable
> > > this is to CRIU's users.
> > 
> > Hi Andrew,
> > 
> > The current interface works for CRIU, and I can't say we have anything
> > critical with it right now.
> > 
> > On the other hand, the new interface has a number of significant improvements:
> > 
> > * it is more granular and allows us to track changed pages more
> >   effectively. The current interface can clear dirty bits for the entire
> >   process only. In addition, reading info about pages is a separate
> >   operation. It means we must freeze the process to read information
> >   about all its pages, reset dirty bits, only then we can start dumping
> >   pages. The information about pages becomes more and more outdated,
> >   while we are processing pages. The new interface solves both these
> >   downsides. First, it allows us to read pte bits and clear the
> >   soft-dirty bit atomically. It means that CRIU will not need to freeze
> >   processes to pre-dump their memory. Second, it clears soft-dirty bits
> >   for a specified region of memory. It means CRIU will have actual info
> >   about pages to the moment of dumping them.
> > 
> > * The new interface has to be much faster because basic page filtering
> >   is happening in the kernel. With the old interface, we have to read
> >   pagemap for each page.
> 
> There is still a caveat in using userfaultfd for tracking dirty pages in
> CRIU because we still don't support C/R of processes that use uffd. 

This reminded me whether the interface can also expose soft-dirty as a
ranged soft-dirty collector too to replace existing pagemap read()s?  Just
in case userfault cannot be used.  The code addition should be trivial IIUC.

Then maybe PAGE_IS_WRITTEN will be a name too generic, it can be two bits
PAGE_IS_UFFD_WP and PAGE_IS_SOFT_DIRTY, having PAGE_IS_UFFD_WP the inverted
meaning of current PAGE_IS_WRITTEN.

-- 
Peter Xu

