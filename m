Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5941D155840
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 14:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGNRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 08:17:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGNRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:17:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so2103790ljg.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ormWsvlEB3xaoLQJ32yqI2+YJjynCIo+Gkrsb90CUoc=;
        b=zXiaaJaV/6vtSOmP9ODS2FF3enQ9DrLr2xaXqFISXdgWNN7JEZGqqteYAJg8ilecHC
         ugo7pUkEj4BeIf0kvvpCo+9nvJTidcqrfgAKlXwcZrT/G25Hc0OKXxZ/73AFix6/STWU
         kzL1F0LE/LTZEKILuppx9YGI01N+5ZbDcEQGL0HvU+uZcMgWGZCPrEAiaZ+BllPyAS7f
         imqyuyZC2NI4FLBEhH4BIw6rEMsgDbGkg9nOxXihh8ryQwuUgPpw2KkNvbQrfWBn7wd+
         mDYhZSynO7JxUG39HhOZIVunHOvL6zWKn3v9WqBVZysmR4JglhGrT7lyZay33uwkGfhZ
         Lp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ormWsvlEB3xaoLQJ32yqI2+YJjynCIo+Gkrsb90CUoc=;
        b=F9KLHDEASuZsGbLBh7rDm0+83iRaCs1H497zL83e79VgTmuNSLBLvVUqxuQHXeIefz
         i+yGTUKokv91gyiyw32PzMXDbz1oD7k8xdkY9oy+L+biU5NcK09qTUgi0hDlsAQyjauy
         QWTwfkRH765Qx1/sHpTqPOIzvakUSFD3A0kx3JnfhaC2+eaDtVEnbBtbMnrvCuMaJ6sQ
         rS1blR8Q6nv77NSGM4j/fEBW7YuOY/HBVGoxWclPwFq4M61J8G6U+BIWB3xb9IyBCscq
         bSmoyS9isq1tRv67JZFU5tPTNsF3vJSZYOQq9NfboS2Q4l+LSoEMxwFB905BcMy1Yxg2
         gTdQ==
X-Gm-Message-State: APjAAAUWAk93KWCBhE27unP2Yi+jZPgqzfNAbDMdNZ34udVIHASe+Ekr
        aiYYmkEMdpS0bxXtwc/Y+9ofQg==
X-Google-Smtp-Source: APXvYqxpnU/YqzHLLTtDrHtrmgEZwjR2XCzlQQy/QlYwTJZA8pqDeflD/7gMq3smNNvvvq1H14aHzw==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr5296927ljc.195.1581081470799;
        Fri, 07 Feb 2020 05:17:50 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 3sm1236687lja.65.2020.02.07.05.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:17:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 623C7100B12; Fri,  7 Feb 2020 16:18:06 +0300 (+03)
Date:   Fri, 7 Feb 2020 16:18:06 +0300
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
Subject: Re: [PATCH v5 04/12] mm: introduce page_ref_sub_return()
Message-ID: <20200207131806.xwnhxomxgt3hoqcc@box>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207033735.308000-5-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:37:27PM -0800, John Hubbard wrote:
> An upcoming patch requires subtracting a large chunk of refcounts from
> a page, and checking what the resulting refcount is. This is a little
> different than the usual "check for zero refcount" that many of the
> page ref functions already do. However, it is similar to a few other
> routines that (like this one) are generally useful for things such as
> 1-based refcounting.
> 
> Add page_ref_sub_return(), that subtracts a chunk of refcounts
> atomically, and returns an atomic snapshot of the result.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
