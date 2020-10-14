Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2628E0FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgJNNFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgJNNFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:05:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314FC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 06:05:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so3152205ljj.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ZpNEpwEuFA9Rfuw8aSUEHfgR5iSTqvnZX1G9kxgifM=;
        b=Tte/tOrj3c7eCfHcXm4ClATrY0EmDpKA48oz5D3m0/1p3dkxXHSfod3UKUn7LMxKlM
         r6IoMLOJlWrhtvJa3IgB0aYPRqaCiuaYK+UYZgVjPJ9htrgHoqdWFr4bQc4GGldcyYwc
         FTy7Rh3n1xWPTAh8yUbnwnE6+43zXN/iVmZCPFftSwKJiwMjvuVjYtT+4lfKa0C4C1mi
         nRHdoVP/J9d/lJP5HLeZ8U76fWQpXP2GjiYjZY24a3OaAWJdO84Q01ECLLu7rTM3654D
         ClJ48Z6CqXb4Vu4aHNbWk2gWkafO6kJ/lRNFl0GGzjTjKPGU7M35xTkxT4r79Bp8kw9x
         U5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZpNEpwEuFA9Rfuw8aSUEHfgR5iSTqvnZX1G9kxgifM=;
        b=fVEY8779PzEwsclB4svyD5WggQfSwB4iOcx8lPAWAlBp6TcWF0TCktJC/NOJOAOPLd
         ruWWKe3KMhYsNoYY2ald12f5JgLPd/PTAB4MAWROmfhuF1AweyW4MapXu5mjYANKzus8
         LQds9MhUhUKO7xb6KywybwDmxPp7g3ycFOWe6vN4aAIUj/a6QLPmqx9Bux5ub1KgejJW
         i4dM3zOeP70h8I+1dqPVbfhzawT9fLtZ9GNNTOzO3p3+UC+OfC/tMyXFLTJm29nRwz/i
         my/d2aSSwdj6Y7Em6Akdi11NzO5EHQ6b/TY/hgpRue53P50vHIN9BbH8RADAS/XHpJev
         1Uyg==
X-Gm-Message-State: AOAM531Dx/U7oIZY/rlZLS5inFa1SNODlcgeGutnPA1W8aSegNJVc9Fd
        SIptt6O13Q3ON0nBoWV+fI8kvQ==
X-Google-Smtp-Source: ABdhPJxjPAif0rDRfil1S4kF1FE0lGY1f39gKXlMRTWe6gjf0jnvjuHXT2t5WekJ69UjCNHZCpi2XQ==
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr1699656ljc.254.1602680750926;
        Wed, 14 Oct 2020 06:05:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p7sm1113688lfc.299.2020.10.14.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:05:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4EC9A1035E0; Wed, 14 Oct 2020 16:05:55 +0300 (+03)
Date:   Wed, 14 Oct 2020 16:05:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
Message-ID: <20201014130555.kdbxyavqoyfnpos3@box>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:03:30PM -0700, Linus Torvalds wrote:
> On Tue, Oct 13, 2020 at 12:59 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Comments?

So we remove strict serialization against truncation in
filemap_map_pages() if the mapping is private.

IIUC, we can end up with a page with ->mapping == NULL set up in a PTE for
such mappings. The "page->mapping != mapping" check makes the race window
smaller, but doesn't remove it.

I'm not sure all codepaths are fine with this. For instance, looks like
migration will back off such pages: __unmap_and_move() doesn't know how to
deal with mapped pages with ->mapping == NULL.
Yes, it is not crash, but still...

Do I miss something?

-- 
 Kirill A. Shutemov
