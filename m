Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1714C98D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 12:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgA2LZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 06:25:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36278 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgA2LZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:25:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so18049916ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 03:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yuCTClL/pM7fgvSlPLx1qB/TzQ5SdJMl6/MOShIA1DQ=;
        b=0W7H46FMjIQyieXPqDTdHmsnT+fVvJJD10f3x0BOMctRvL9MkeTdx4VbdbHlRTBEN3
         b5/NawDAfyQpEhbLgT0rwOvcpevf1CHvRnfPK+nWNiUWSGyImoO0vgtrGmVKW+uZx29r
         bBsFaVwVuNzEQGuzTVKaB1lufIwzDYjD7ErDm/9BiL+5qbFTXQ+Ady+yLKCnGSNAgMd3
         W6mnYQvJTpgMGiYduy+scv4eX7iMsBIwYQPsUNpaNK3OyYiGdeXL9USXqvdYpFTTjSlw
         AraHVZkw1JBmq3Op+CNUrl6EEty11YBA5pwAZqGuiTKUaRJ47uGYaNwZMdUrsfU+3Fw7
         +BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yuCTClL/pM7fgvSlPLx1qB/TzQ5SdJMl6/MOShIA1DQ=;
        b=hcu+MEvAghoG20zczwd4LmMGvyqEJ1cJ0GqNq9ES/3n4s/IjtkzIIIoeYpj2frx78f
         ruetCbDPuCRL31/x7DlfkvVunnWi3k2v2/SV2tFRJSN1foiAkAEmF5h3xcJCOvsrQ4C9
         3uO4qFeuY9v8xlb7zht0t7Gr7IPrBXw1gY9cJQ2hmXfVvaIla7Ir6iswfTu6d95pnheA
         aP6zAq2qpRsw3we680uRhCXQVnvWy48YGQLKWE4jjCM7YByrgyHrSzxeiSjiG/KcnG6F
         GSfPB7KJEeTc41jrtLzq7yakWf5j5alRYR1iOVzYHQTBEbnTPtDOqky7uRUcaiOytesq
         iIyw==
X-Gm-Message-State: APjAAAUNCuu0lDy/qU2gfLWQDeYwAv7SLuyMYG7cym0Qna73mJjiTiJo
        /CfD6v9WygHSVHH+PweExhFDWA==
X-Google-Smtp-Source: APXvYqwyL72yG90SI0NWAGgcd0insDnp1IMG7ae6YjG0JpIiyNIWobcDnM8YcTAzCUBn1pD6tZdqCQ==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr16595052ljg.108.1580297103916;
        Wed, 29 Jan 2020 03:25:03 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d9sm778410lja.73.2020.01.29.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:25:03 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 04319100AFE; Wed, 29 Jan 2020 14:25:11 +0300 (+03)
Date:   Wed, 29 Jan 2020 14:25:10 +0300
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
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for
 compound pages
Message-ID: <20200129112510.ulims6u36ofk2qwa@box>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129032417.3085670-2-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 07:24:10PM -0800, John Hubbard wrote:
> When debugging a problem that involves compound pages, it is extremely
> helpful if dump_page() reports not only the page->_refcount, but also
> the refcount of the head page of the compound page. That's because the
> head page collects refcounts for the entire compound page.
> 
> Therefore, enhance dump_page() so as to print out the refcount of the
> head page of a compound page.
> 
> This approach (printing information about a struct page that is not the
> struct page that was passed into dump_page()) has a precedent:
> compound_mapcount is already being printed.

refcount on a tail must always be 0. I think we should only print it when
it is non-zero, emphasizing this fact with a standalone message.

-- 
 Kirill A. Shutemov
