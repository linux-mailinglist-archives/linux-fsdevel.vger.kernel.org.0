Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245E3767671
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjG1Tkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 15:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjG1Tke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3190330F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690573186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SYf4OrR/ld3B4A6cONLgiWawWLuXcl3wa23pykc4IA=;
        b=WAgJINiaRQO0h206AsgpcdSUyHKR7zD6UpX0iqcNG57vx+oJhWcQ00sBLvx2ORfcymfhYU
        JVY9X8SIB3fuYMARX6Oxxf2jTCWb9YZ8ypDZJhpU5Oi26lmCSNLym7hWVgUaSOsT9ca5jM
        KLTmxDjl6Q1CaH6CDdKwQmhYcCE4cVY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-hwMyNAeWN8mnTb8VdS6sHg-1; Fri, 28 Jul 2023 15:39:45 -0400
X-MC-Unique: hwMyNAeWN8mnTb8VdS6sHg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-403fcf7a9d0so5265941cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 12:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573184; x=1691177984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SYf4OrR/ld3B4A6cONLgiWawWLuXcl3wa23pykc4IA=;
        b=C69G+S026Wh2fOu5HNjahdufeOV39MEFf84rWFB4/Q+rqrt8xiVRmkoXskfzfz+Fv9
         BLs5i1XZRDf0xeoYR1zm2peNFjYX6sknEmfZIoGZhBbb0xQSDnawnj8QI0hC48ct+0Ye
         4QU/N+4l0b7Cme6T2fPxi7zX2MBHnIFnj7UdwOTq8MzwzX/WAGD9k/ZuG8QrlNyp6qv1
         P5azmC3kUY5gTLlU7dUiQu/wsCA3xWtCWLhx19Wdzbv5Smp14oF7bcae+dhUb7sdSvoP
         CHPG2jTzqAEkeEhKxnfjnRvpC33jMpbbFpUDvhdg2p2MFJw/GM7VUrrV8xHlkRzNhmR0
         KvpQ==
X-Gm-Message-State: ABy/qLZtUQHsQzkByaBMnQrqzUPueiuYL7JSFWMy+lYSvcZgfVgl+Kew
        tUJuaWKb+vYxbu21Y2soM7zEb2LzF703REGAr8or2sNeEeMdGif80WXOV0UvdhuOc0JH5Iw6E3Z
        PH+fJPxr37ZMhNDd4rnk2CWWyYA==
X-Received: by 2002:a05:620a:4711:b0:765:435c:a4fa with SMTP id bs17-20020a05620a471100b00765435ca4famr222422qkb.0.1690573184460;
        Fri, 28 Jul 2023 12:39:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmrTP10A8xdUl+VSEcIGR77+VRbVpJaJ9zwt72G0J8ooMANGBHVma6UiMEMYUfmQjE79CjSQ==
X-Received: by 2002:a05:620a:4711:b0:765:435c:a4fa with SMTP id bs17-20020a05620a471100b00765435ca4famr222411qkb.0.1690573184203;
        Fri, 28 Jul 2023 12:39:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g12-20020a05620a13cc00b0076730d0b0b9sm1360440qkl.14.2023.07.28.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:39:43 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:39:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMQZfn/hUURmfqWN@x1n>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Linus,

On Fri, Jul 28, 2023 at 09:18:45AM -0700, Linus Torvalds wrote:
> The original reason for FOLL_NUMA simply does not exist any more. We
> know exactly when a page is marked for NUMA faulting, and we should
> simply *ignore* it for GUP and follow_page().
> 
> I think we should treat a NUMA-faulting page as just being present
> (and not NUMA-fault it).

But then does it means that any gup-only user will have numa balancing
completely disabled?  Since as long as the page will only be accessed by
GUP, the numa balancing will never trigger anyway..  I think KVM is
manipulating guest pages just like that.  Not sure whether it means it'll
void the whole numa effort there.

If we allow that GUP from happening (taking protnone as present) I assume
it'll also stop any further numa balancing on this very page to trigger
too, because even if some page fault handler triggered on this protnone
page later that is not GUP anymore, when it wants to migrate the page to
the other numa node it'll see someone is holding a reference on it already,
and then we should give up the balancing.

So to me FOLL_NUMA (or any identifier like it.. just to describe the
caller's need; some may really just want to fetch the pfn/page) still makes
sense.  But maybe I totally misunderstood above..

Thanks,

-- 
Peter Xu

