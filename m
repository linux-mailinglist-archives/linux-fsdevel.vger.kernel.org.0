Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFFF6FEAE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 06:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjEKEqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 00:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjEKEqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 00:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3432D52
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683780328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8rXiyFTG89ZpswB3hYb5Es6RMJM2JRlnlk73HYWIls=;
        b=MrIRkheLxZsygCvGt2T6/1I6iJ4z+sT/PJTRB6mTKVlbbMGO/+8lcTaIF5VILi8fUxmi7Z
        Jh7G+c7iiOzR347mcq3qRv4YX3YAAfTb4dWRvLZEULGetyC/1/ucejObIHlKfBjjwvID4f
        6ZZHR3dS7DH5IA9gFjmhyszYjObaPZ4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Mn8mX7YfMwqxm5q67_0gMA-1; Thu, 11 May 2023 00:45:26 -0400
X-MC-Unique: Mn8mX7YfMwqxm5q67_0gMA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6442745be9bso1430239b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 21:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683780325; x=1686372325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8rXiyFTG89ZpswB3hYb5Es6RMJM2JRlnlk73HYWIls=;
        b=OeECMZQF0hyLAHIRTO0/ObvjuKoByq9DjOtro4LlcQ/mro2WNd2eH4L9fiGetk5YSA
         rMXCJ83yz2hCnwMcQqCOC9QrSeNMRtlj2liwYr7iB9h73JWJPmvDW+wTEBTOWd89LTkG
         P0mqkN4wCIGsSUFZT4EN7X63B5nnicAxN+Xs1F8E/l4NBusqZCS4y87GI4a7L/6ObUhR
         3QPZ2MxeaJd/11Zfz2E56szrcSpq/c13ROnWiUFmh68jdgJ5NH2Jc+JrINf+uhBKTuXb
         9fqmW1TNGIfMBJI8Yf8BCjZzBP7+ErDaq0CNnoeNkxr2KB/QS3ZrBJ1bQ9I0t6CqTtBj
         A4ng==
X-Gm-Message-State: AC+VfDwtp9R1elthC2f9cS4XVesdgTGfL+2oymBczqjubWMHrA2g4rOc
        LBApjbj3Y6AjGKFSLvk8e8U+5fD5bCM8s6QJAvqcQxwtp5CVhA3YEbrGpLpqgDCkUff1gXMfsbO
        zM8tS4JX2/GdO0jA2GudjAV+pmQ==
X-Received: by 2002:a17:902:d4c4:b0:1ac:40f7:8b5a with SMTP id o4-20020a170902d4c400b001ac40f78b5amr23873897plg.3.1683780325398;
        Wed, 10 May 2023 21:45:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ748vMOPFgvF7BqbUBl3Z5M5SitkSDatlzHYrBmeugpx+1e8smaBL/ipLOyGDyFa3yDnAHbcw==
X-Received: by 2002:a17:902:d4c4:b0:1ac:40f7:8b5a with SMTP id o4-20020a170902d4c400b001ac40f78b5amr23873884plg.3.1683780325041;
        Wed, 10 May 2023 21:45:25 -0700 (PDT)
Received: from x1n ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001a9bfd4c5dfsm4702926plz.147.2023.05.10.21.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:45:24 -0700 (PDT)
Date:   Wed, 10 May 2023 21:45:23 -0700
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <ZFxy48TRh3m09oWB@x1n>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <20230509191918.GB18828@cmpxchg.org>
 <ZFv+M5egsMxE1rhF@x1n>
 <CAHk-=wjKVXt+BAh+Gk+Cs9u8s=XzbQyzHhZSW2bPFMX74gPuRw@mail.gmail.com>
 <CAHk-=wgnHtP2uNtnFdQ4Ou-TZynipVVU5Jow+Fr8nhRgewkXAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgnHtP2uNtnFdQ4Ou-TZynipVVU5Jow+Fr8nhRgewkXAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 04:44:59PM -0500, Linus Torvalds wrote:
> On Wed, May 10, 2023 at 4:33 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We'd still keep the RETRY bit as a "this did not complete, you need to
> > retry", but at least the whole secondary meaning of "oh, and if it
> > isn't set, you need to release the lock you took" would go away.
> 
> "unless VM_FAULT_COMPLETED is set, in which case everything was fine,
> and you shouldn't release the lock because we already released it".
> 
> I completely forgot about that wart that came in last year.
> 
> I think that if we made handle_mm_fault() always unlock, that thing
> would go away entirely, since "0" would now just mean the same thing.
> 
> Is there really any case that *wants* to keep the mmap lock held, and
> couldn't just always re-take it if it needs to do another page
> (possibly retry, but the retry case obviously already has that issue)?

FAULT_FLAG_RETRY_NOWAIT?

> Certainly nothing wants the vma lock, so it's only the "mmap_sem" case
> that would be an issue.

You're definitely right that the gup path is broken which I didn't notice
when reading...  I know I shouldn't review such a still slightly involved
patch during travel. :(

I still think maybe we have chance to generalize at least the fault path,
I'd still start with something like having just 2-3 archs having a shared
routine handle only some part of the fault path (I remember there was a
previous discussion previously, but I didn't follow up much from there..).

So even if we still need duplicates over many archs, we'll start to have
something we can use as a baseline in fault path.  Does it sound a sane
thing to consider as a start, or maybe not?

The other question - considering RETRY_NOWAIT being there - do we still
want to have something like what Johannes proposed first to fix the problem
(with all arch and gup fixed)?  I'd think yes, but I could missed something.

Thanks,

-- 
Peter Xu

