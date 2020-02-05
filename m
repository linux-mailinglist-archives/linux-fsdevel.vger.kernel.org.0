Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D0C152A1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBELnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 06:43:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33679 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgBELnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:43:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so1271610lfl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rg7FTb2EgzwOWtOl0Xh6SbFh/TDgIq/m4oej/j7EPsc=;
        b=xqc4RuXXK6fPykrtEKs2WWshltrhXJ8pi3DtiLilCDNoCowiBWIO11F8QV2xYxhR8b
         T3vNBwC3lWRaITvvrEEqmM0SMQWJPa3dJbYhI51XEx8oF0CkrITqDVx8yRD0aTffPJDn
         sdmmfHSWVSqPoliUVDy85GbYfW6ruojAgBfVZxXigpn3TqbLBDdRhyS8A1HALKtjt7fQ
         sLqgWUx13HP8PvkDbWENV1Q7qLdBeHXkHTTFMm1c3IJcKkbYcDPWZ7K6No8QskYqARcS
         h42YxDkYmUL75rirEZLc3ay0c2OKP0hW8yKGroN5vGefezStmjyzjwY5hJRbwIuMdmnn
         RvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg7FTb2EgzwOWtOl0Xh6SbFh/TDgIq/m4oej/j7EPsc=;
        b=V0qL1B87FWheevvqZoZtgN34qzFMdOOLsE1bE/xGD53ptNpkf+Z8JnKD6rPuJgZKxF
         IkJwF+BsN0VatuTp/CppB1J+wLrzjjgfQq55Q0Dbk1tj+zI7wwL6VR7ySVaAcSxDEmOg
         XcBTbxT3i1I+OQq9VP4jSC/JI+kyVBOoon7TApoA2AxNikaW70A7Fu1oI0SxdVgkZgPB
         KDRCgAOMC9EXte44or3R0r19JO4WIHTABSL+sN1H8U/oG/WiBxr9xVRiC2mR+Z8HlSwX
         fRU/KbtdDDScxrXViYh8ZFzJuibv3CFwQd1AsBnM+f+mpb8QRbrVXq3kC3j7Db4RtqZM
         8QKQ==
X-Gm-Message-State: APjAAAXz9cJ+YWqQBLJU8I330mTACfSahnjzt2CLUGcLyHhP0SFGEfx3
        evBgHFwg3hwyp+eeewvCjt+bAw==
X-Google-Smtp-Source: APXvYqyGuiOfyYh+qTRTsP2YJUspzVgxdBbwwERcM0hZgAzWTzfcx473yxjEYxYiSHWiqrCV91FjRA==
X-Received: by 2002:a19:5201:: with SMTP id m1mr17618504lfb.114.1580902991825;
        Wed, 05 Feb 2020 03:43:11 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u23sm12011076lfg.89.2020.02.05.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:43:11 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 42BA0100AF6; Wed,  5 Feb 2020 14:43:25 +0300 (+03)
Date:   Wed, 5 Feb 2020 14:43:25 +0300
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
Subject: Re: [PATCH v4 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
Message-ID: <20200205114325.4e2f5aghsusihpap@box>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234117.2974687-11-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:41:15PM -0800, John Hubbard wrote:
> Now that pages are "DMA-pinned" via pin_user_page*(), and unpinned via
> unpin_user_pages*(), we need some visibility into whether all of this is
> working correctly.
> 
> Add two new fields to /proc/vmstat:
> 
>     nr_foll_pin_acquired
>     nr_foll_pin_released
> 
> These are documented in Documentation/core-api/pin_user_pages.rst.
> They represent the number of pages (since boot time) that have been
> pinned ("nr_foll_pin_acquired") and unpinned ("nr_foll_pin_released"),
> via pin_user_pages*() and unpin_user_pages*().
> 
> In the absence of long-running DMA or RDMA operations that hold pages
> pinned, the above two fields will normally be equal to each other.
> 
> Also: update Documentation/core-api/pin_user_pages.rst, to remove an
> earlier (now confirmed untrue) claim about a performance problem with
> /proc/vmstat.
> 
> Also: updated Documentation/core-api/pin_user_pages.rst to rename the
> new /proc/vmstat entries, to the names listed here.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Please, clarify semantics for huge page. An user may want to know if we
count huge page as one pin-acquired or by number of pages.

Otherwise looks good (given Jan concern is addressed).

-- 
 Kirill A. Shutemov
