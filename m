Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD147152A24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 12:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBELqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 06:46:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35053 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgBELqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:46:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so2001209ljb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 03:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jy6I9lCZXmqSIc0Oo7ZwAUc0APIjOD7+FskXlmNX0dE=;
        b=fbUqiFBKKWfMvUVGayetzT7gBoVUOArtTvKe87cxlG4ADzVrq73rMKZXdR+K95XCj8
         2tpgG6t6IONw5sP60aDQPIi6bEjTxNmgDQRNTBOF6qrPugG05rtCHYMncko/ND4Oe2J6
         r5juTmm4ovUmOcVa1aFbKe9GkKmUd7VDww+dSp8QucR9SspUNhqp/6/XnMDjtqCOZCm+
         qKdTR/LxfUsAecDs7AmpEc7Cuc0WG8lutxYO9rxW3DP42v5HUE+fiSgAC2sl51AiqrDI
         7tiuH8OzxbBfsLnmX2PGY8JuKutQO0wJaxcNMEFDaSlRFOuKzWYVhw0WG5ELGFSaNkOP
         JFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jy6I9lCZXmqSIc0Oo7ZwAUc0APIjOD7+FskXlmNX0dE=;
        b=DaIdzC+ubWBzWUn+DxFAdSVWgbppgw8emcN3beicdmzC0iZ4j91mQQl0Ba6pEsUD6B
         O2rDXcDTNbrOneXD1CczMcJ6TY3abFBUmsOfX/D/Wa9TevoS8dUkVyrtFBFKP1kHCGAH
         F8Tp68OoQaaS1ztcbJBeg2DeRnIX9OLhn0Gz39BQVlWxnkDOr5NMnO8XpwpesdOUbTJp
         OZtlMEsHkUlMNnzsSbYD8iHMtuWoDx4odYML++5n46yRUQAlSP2hkReB3dpHu6hOoCqa
         mnZeJAXAywaHJCFvprxAxHegbyJ1zmVllnmouOFHDtprKbzrl6aPchh5RDYRg9yhNtWO
         FziA==
X-Gm-Message-State: APjAAAW9I6GZpgshgxQlSKVdNsZaTvmoDNH8sWxskCuNyvefjEAmLVlE
        OEzRo6rU6FeRW+5OEFhscvPLyg==
X-Google-Smtp-Source: APXvYqyYwLXyW1HUby3u5z2IhHyV0WiYO1K3JWIkU6l6dX312E3ieNWtdHp2AH5LJPi+2PXC1G4V7w==
X-Received: by 2002:a2e:5056:: with SMTP id v22mr20108284ljd.164.1580903158629;
        Wed, 05 Feb 2020 03:45:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w3sm13028052ljo.66.2020.02.05.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:45:58 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0BF46100AF6; Wed,  5 Feb 2020 14:46:12 +0300 (+03)
Date:   Wed, 5 Feb 2020 14:46:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] mm/gup_benchmark: support pin_user_pages() and
 related calls
Message-ID: <20200205114612.foo7zrcplgxwmylt@box>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-12-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234117.2974687-12-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:41:16PM -0800, John Hubbard wrote:
> Up until now, gup_benchmark supported testing of the
> following kernel functions:
> 
> * get_user_pages(): via the '-U' command line option
> * get_user_pages_longterm(): via the '-L' command line option
> * get_user_pages_fast(): as the default (no options required)
> 
> Add test coverage for the new corresponding pin_*() functions:
> 
> * pin_user_pages_fast(): via the '-a' command line option
> * pin_user_pages():      via the '-b' command line option
> 
> Also, add an option for clarity: '-u' for what is now (still) the
> default choice: get_user_pages_fast().
> 
> Also, for the commands that set FOLL_PIN, verify that the pages
> really are dma-pinned, via the new is_dma_pinned() routine.
> Those commands are:
> 
>     PIN_FAST_BENCHMARK     : calls pin_user_pages_fast()
>     PIN_BENCHMARK          : calls pin_user_pages()
> 
> In between the calls to pin_*() and unpin_user_pages(),
> check each page: if page_maybe_dma_pinned() returns false, then
> WARN and return.
> 
> Do this outside of the benchmark timestamps, so that it doesn't
> affect reported times.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
-- 
 Kirill A. Shutemov
