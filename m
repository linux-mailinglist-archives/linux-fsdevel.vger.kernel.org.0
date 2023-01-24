Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3E67A030
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjAXRbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 12:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjAXRbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2352485B3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674581438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFq/mNBnI/BqcjC2peFCYxWVr3CPoW0svWlbdoxg4JQ=;
        b=iaVNqMV+o36ot74qp1buCHGxLGj1WVTI1crGPDK3zWTyOVPc2LEoKx8h4fV8WW98zAHzMn
        PERWH3KNXlrlqPmwPMB0KneJbVBn1/WovaxJmRAoMrFejZEZknbq7/We2rd2ozDszvqj8w
        PptJ1IvAYMcGx2gf//cjwa3oV9kOkvw=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-ymodDYAcMBef0dcKRhjI1Q-1; Tue, 24 Jan 2023 12:30:36 -0500
X-MC-Unique: ymodDYAcMBef0dcKRhjI1Q-1
Received: by mail-vs1-f70.google.com with SMTP id a62-20020a671a41000000b003c08f2a8d7bso3840773vsa.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 09:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFq/mNBnI/BqcjC2peFCYxWVr3CPoW0svWlbdoxg4JQ=;
        b=JxIXFQcEWceTGB8c1kPzbGFfH8ZmJvXF2JdnIITzGdT5wcj+SJ0ftVs0BVEwv30T+F
         AgnUaVzywouthj3rsdIH48nCyTaYAB2awgyzAiDDuGze2xBRKg9DwivAGuralC+Arjoi
         x3Fig88pSUO9FcZY/RCKBqJj5ZYVsHqkCuxnTtL2vdZfLDK5PKak60yRTdv7KFJBeck0
         hwp2c75kaVYpJe8jcgzGzH5+LhP6LewEow5kaR4QW+knY7EQI8dkovkYPkgDrHFI+tBU
         +cKILFuPURvu2b58SxrosKngy3FcUkn6QTgCWmQLqClkHZtI+V4dddc4cG9jSsZCUv2C
         FytQ==
X-Gm-Message-State: AFqh2kqqKPN2jP5bZzcb35j3Ikt0oOjKNIAzVRmEp7BLgJ4u68K3uwiM
        utV41EJXF7/fHYBZ47MAw4T4XJJWkTsPu1yECDqIilBxndP9BhukXqCLO+Gf6u41EFDei51VsdJ
        q4baaV9H+07w7+C2l9wGXevTTvw==
X-Received: by 2002:a05:6102:3d86:b0:3b1:4999:1729 with SMTP id h6-20020a0561023d8600b003b149991729mr18463170vsv.32.1674581435823;
        Tue, 24 Jan 2023 09:30:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsyS/lviwCEpx4hKAW3VXvWWIWezeP2/jZ5CCZZkaNf6ca5wcGThV91c0/XonyDxlB64+l5aw==
X-Received: by 2002:a05:6102:3d86:b0:3b1:4999:1729 with SMTP id h6-20020a0561023d8600b003b149991729mr18463141vsv.32.1674581435542;
        Tue, 24 Jan 2023 09:30:35 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s133-20020a37a98b000000b00706afbdeb01sm1799074qke.8.2023.01.24.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:30:34 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:30:32 -0500
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
Subject: Re: [PATCH v7 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y9AVuF63y9UjEYcj@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-4-usama.anjum@collabora.com>
 <Y8hyqhgx41/ET7bC@x1n>
 <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:18:13PM +0500, Muhammad Usama Anjum wrote:
> >> +	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
> >> +		return -ENOSPC;
> > 
> > This is the function to test "whether the walker should walk the vma
> > specified".  This check should IIUC be meaningless because found_pages
> > doesn't boost during vma switching, while OTOH your pmd walker fn should do
> > proper check when increasing found_pages and return -ENOSPC properly when
> > the same condition met.  That should be enough, IMHO.
> This check is needed in case we want to abort the walk at once. We return
> negative value from here which aborts the walk. Returning negative value
> from pmd_entry doesn't abort the walk. So this check is needed in the
> test_walk.

Why?  What I see locally is (walk_pmd_range):

		if (ops->pmd_entry)
			err = ops->pmd_entry(pmd, addr, next, walk);
		if (err)
			break;

Thanks,

-- 
Peter Xu

