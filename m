Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA820672B1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjARWM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjARWMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3232C654D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674079930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MspJ78t8fpxKGkTfcthNkvOr56UzNjzkTKTIZByHk64=;
        b=Be/be34c6o0TtDWuezxnrvwOsU4VOuTutbU3Ek/Co/+PmYpm8yq3Wjdlo+FyfBOm7WhCpu
        pOBsok4NanqybW4OZP8Yk9ZiwyjHxgPYBnxJXXyxxaaubLyxSFqy3LSs7csc6rkiVT4+6j
        /wUmWi4c0Ztr3/yakFr90TKJn7Bs7R4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-qidKtw3FMzWPc04NP9T4wA-1; Wed, 18 Jan 2023 17:12:09 -0500
X-MC-Unique: qidKtw3FMzWPc04NP9T4wA-1
Received: by mail-qk1-f200.google.com with SMTP id j11-20020a05620a410b00b007066f45a99aso322071qko.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 14:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MspJ78t8fpxKGkTfcthNkvOr56UzNjzkTKTIZByHk64=;
        b=4U65CsMbcFNR+Y5zPhWhY9e9BEhxFsivAmOkxkZYhDoWG7Y8mhfHJ0kOc3IFD5jaFY
         J2N62RiVXfZwPuRsHqMDapMeOXq/vOSkhgh/9stgmsmCr2XlxMRQhuab0xfvTtze3bbM
         00PAz3c0MSoACP++i3WCy4iWLzPBbu+kfX2f34FtMT8igUqZw40b46exaDkxjH3sbpaA
         Brs0lX8lHBEZV1CGq/TOO4oCAZ0K4ypm0rhr9ughN/RCtYyvdljF3FEgarkOpfl3VhOr
         C9D2QS/JvdY0BxVjqe9mJ/8fMxCwr84gmaZ074r3WjRDbW9b70jLEtA9h9fxNoALT0zp
         NVQw==
X-Gm-Message-State: AFqh2kr2g7sJ1Qu66ax5s06XGqSGH92nbmSVeFmHd5gd4CIeM3VVoEjf
        zY9pR08WeFhZKmQiWtFRCmBREiEnGC53Gi3l+xSiUkfgtTi93i5a5CjTIcKCdUkLTbu+DRpcvHJ
        ZMpDY/KJlzvMcxTjlQoeM7Glpyg==
X-Received: by 2002:ac8:4696:0:b0:3b6:3334:5b95 with SMTP id g22-20020ac84696000000b003b633345b95mr10187275qto.11.1674079928307;
        Wed, 18 Jan 2023 14:12:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtqYoS7t97z3YRqQ/yIG2PkokwFud7oGhOXmiSrF/oiJiOgqIp1lh3R8UW5pGPmzBq5qufe2w==
X-Received: by 2002:ac8:4696:0:b0:3b6:3334:5b95 with SMTP id g22-20020ac84696000000b003b633345b95mr10187245qto.11.1674079928003;
        Wed, 18 Jan 2023 14:12:08 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id z24-20020ac875d8000000b003b68c7aeebfsm342908qtq.3.2023.01.18.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:12:07 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:12:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v7 0/4] Implement IOCTL to get and/or the clear info
 about PTEs
Message-ID: <Y8hutCGec6je5toG@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230109064519.3555250-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:45:15AM +0500, Muhammad Usama Anjum wrote:
> *Changes in v7:*
> - Add uffd wp async
> - Update the IOCTL to use uffd under the hood instead of soft-dirty
>   flags
> 
> Stop using the soft-dirty flags for finding which pages have been
> written to. It is too delicate and wrong as it shows more soft-dirty
> pages than the actual soft-dirty pages. There is no interest in
> correcting it [A][B] as this is how the feature was written years ago.
> It shouldn't be updated to changed behaviour. Peter Xu has suggested
> using the async version of the UFFD WP [C] as it is based inherently
> on the PTEs.
> 
> So in this patch series, I've added a new mode to the UFFD which is
> asynchronous version of the write protect. When this variant of the
> UFFD WP is used, the page faults are resolved automatically by the
> kernel. The pages which have been written-to can be found by reading
> pagemap file (!PM_UFFD_WP). This feature can be used successfully to
> find which pages have been written to from the time the pages were
> write protected. This works just like the soft-dirty flag without
> showing any extra pages which aren't soft-dirty in reality.
> 
> [A] https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
> [B] https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
> [C] https://lore.kernel.org/all/Y6Hc2d+7eTKs7AiH@x1n
> 
> *Changes in v6:*
> - Updated the interface and made cosmetic changes
> 
> *Cover Letter in v5:*
> Hello,

Please consider either drop the cover letter below this point or rephrase,
otherwise many of them are not true anymore and it can confuse the
reviewers.

I have a few high level comments/questions here, please bare with me if any
of them are already discussed by others in the old versions; I'd be happy
to read them when there's a pointer to the relevant answers.

Firstly, doc update is more than welcomed to explain the new interface
first (before throwing the code..).  That can be done in pagemap.rst on
pagemap changes, or userfaultfd.rst on userfaultfd.

Besides, can you provide more justification on the new pagemap-side
interface design?

It seems it came from the Windows API GetWriteWatch(), but it's definitely
not exactly that.  Let me spell some points out..

There're four kinds of masks (required/anyof/excluded/return).  Are they
all needed?  Why this is a good interface design?

I saw you used page_region structure to keep the information.  I think you
wanted to have a densed output, especially if counting in the "return mask"
above it starts to make more sense. If with a very limited return mask it
means many of the (continuous) page information can be merged into a single
page_region struct when the kernel is scanning.

However, at the meantime the other three masks (required/anyof/excluded)
made me quite confused - it means you wanted to somehow filter the pages
and only some of them will get collected.  The thing is for a continuous
page range if any of the page got skipped due to the masks (e.g. not in
"required" or in "excluded") it also means it can never be merged into
previous page_region either.  That seems to be against the principle of
having densed output.

I hope you can help clarify what's the major use case here.

There's also the new interface to do atomic "fetch + update" on wrprotected
pages.  Is that just for efficiency or is the accuracy required in some of
the applications?

Thanks,

-- 
Peter Xu

