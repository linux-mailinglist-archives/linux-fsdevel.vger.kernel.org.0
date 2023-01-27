Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC967EC30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 18:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjA0RMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 12:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjA0RMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2561449E
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674839352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PmxGa44W6isfjTBSzVfP/UwTsDElhnXKEsXbjHCdyrI=;
        b=HVSbsFHk/yRTnskZhiUs74/NAQLieBzeqq8Koa+n3mYETrl/zSK6a3xXCBi/2LAkgqCLwV
        6xpAfMRsbbVN5liJRs8McABQ7oHyxWPGklsMMgathJe4Kzxe6QMr6fRG/MUNn6ik3N0SqB
        7W92Xe8m3MHDO0Zo5R7R1X/ua4Hlj7Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-ojnlQKNJNdiaQodCijEhng-1; Fri, 27 Jan 2023 12:06:00 -0500
X-MC-Unique: ojnlQKNJNdiaQodCijEhng-1
Received: by mail-qt1-f200.google.com with SMTP id v15-20020ac873cf000000b003b6428b16deso2385698qtp.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 09:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmxGa44W6isfjTBSzVfP/UwTsDElhnXKEsXbjHCdyrI=;
        b=6+3JtBudzuMetEf1qM2Fj3F3kllKYrwct391wULoTTM01FdQ73wlB+JCJLwZlESVxf
         BP9NM4sd07gbB4aZaLoKtLuLYg632UtZIUwaf1Q6sBP7YXfc5gw4ze7QGICLpmHxXnKP
         lGPPwnQ0VL10lPHSJ8l40LHjq/NMFn0qaoqAB3JnJmVsOXk0XhxKLrRuvjThtQHpKuIS
         rrOkOD9ZlWnHBQvmWuLhe5EQdUEB89NbuH/1ZirTHEN3fMyfurgKSybX3+vK+K1ZNMTn
         8J/wib8Bj6Eocnvm6FXsWNXIVC0mhuYISAQ8PF/voNKTvo32J1KjOABn1TFY0DAblWVs
         JZDA==
X-Gm-Message-State: AFqh2kq6V1eD8KgcTs12RryhsIbOSzNtz4JUGXJJiRJomozeOZaKQM7+
        /TpzB7FsfjO6r3mL4mZuBCtOOJPGr6PbOV4gc1F74MKkS7qcJkVd5CSsom5dEhykN4DVXP8mGpa
        2cs7NOTCY/Ma4cdcw2xbIx8rGdA==
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr63120101qtb.52.1674839160385;
        Fri, 27 Jan 2023 09:06:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBuMR76qCD9iNhA3MG7zbleHxGuuO1yl2hlMrlf18HF044I6aiUQq824mIaMRnIi9g+mEKbA==
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr63120073qtb.52.1674839160145;
        Fri, 27 Jan 2023 09:06:00 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x20-20020ac84a14000000b00399fe4aac3esm2949817qtq.50.2023.01.27.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:05:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:05:57 -0500
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
Subject: Re: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
Message-ID: <Y9QEdbkZxOJ10oEJ@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:43:21PM +0500, Muhammad Usama Anjum wrote:
> Split mwriteprotect_range() to create a unlocked version. This
> will be used in the next patch to write protect a memory area.
> Add a helper function, wp_range_async() as well.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

IIUC this patch is not needed.  You have a stable vma, so I think you can
directly use uffd_wp_range(), while most of the mwriteprotect_range() is
not needed.

There's one trivial detail of ignoring userfaultfd_ctx->mmap_changing when
it's set to true, but I don't think it applies here either because it was
used to resolve a problem in uffd non-cooperative mode on the predictable
behavior of events, here I don't think it matters a lot either.

-- 
Peter Xu

