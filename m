Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE4269309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgINRXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 13:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgINM3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600086569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk8zzz6iG+LTm12PI7VouoO/Ytz2Ct1GiEhjBUFwErY=;
        b=J2UK9YNZ2cgx+JggcwSGVEQlWTm9FWahm5fQxDmCZRKeM3z014KqPykwnz/rx+SfYQHWhQ
        8caYTwqwrOiDHjCP4Dc8ClFb/ySTlBY49VQho+ZuYvCHLFaDenypHqko62CdHNF1tdBpFf
        /8nfU+QPPlFZi6DAElV5cfI0+lP8xOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-Ek22kb_SPq-uEBu_pSzU0A-1; Mon, 14 Sep 2020 08:29:27 -0400
X-MC-Unique: Ek22kb_SPq-uEBu_pSzU0A-1
Received: by mail-wr1-f70.google.com with SMTP id l9so6805990wrq.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 05:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fk8zzz6iG+LTm12PI7VouoO/Ytz2Ct1GiEhjBUFwErY=;
        b=nGkOlFG1hAliQ9pmUmTauJlKc7rSRuALgeFkUGC/YgfBmstqDMxclzG8fhh0DD6n0/
         RCsNE5Xh14iNuWPGL2MGV7KQ0v3iFm75YLej9ZVtqo1pR+QVhQYnLEGVm5Sae8WhuoYm
         m8Uh9/6Ab1IS4+LgSNmBYZ/aaNP4hYuCkoskYZsqtWSAdXjHdAcMDimgWLo3dlKL5vr1
         Ym43XXBWcWupX2ozhBltNieHhUWRKbqymX6XseaAPO6fzRXbiyb5q0UT9Ih1UGXYyaA3
         ty9AKDJpKDUDC+VZa59RMkfpteC37ijT9m4WLHHhk0lvLS3HAH+N1z1xy5RtkOEDJIVX
         O0Rw==
X-Gm-Message-State: AOAM531AI0nERhO4ySstP2WYhDsSs1nqzwIXOPMJigQpk6/yGxUfeTf4
        5tYRwiocccU252oV9nSpnbkEnW8Id29Jmml8WDsMTDIgOcjKIA90EfEVZEPT+G7h1xHH2gX89O8
        hVOCmVhe4R9ZFIdWyIpTkHMFCViok+aY4P+30v0ARIA==
X-Received: by 2002:adf:e391:: with SMTP id e17mr15196095wrm.289.1600086566095;
        Mon, 14 Sep 2020 05:29:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+1/aFCLy9zZXQtB8mFgNA23Rd5h+C192n3Cb5/bsjdvKfJteU4hp00DAohSj/jPGHMiEVc2PHHrciAVdye6k=
X-Received: by 2002:adf:e391:: with SMTP id e17mr15196076wrm.289.1600086565833;
 Mon, 14 Sep 2020 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200623052059.1893966-1-david@fromorbit.com> <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200914113516.GE4863@quack2.suse.cz>
In-Reply-To: <20200914113516.GE4863@quack2.suse.cz>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 14 Sep 2020 14:29:14 +0200
Message-ID: <CAHc6FU6jU3qJppLvs-FrKVt0SryWDs_q9bV_=Lr6rZTwMfv+Tg@mail.gmail.com>
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around filemap_map_pages())
To:     Dave Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Could the xfs mmap lock documentation please be cleaned up? For
example, the xfs_ilock description says:

> * In addition to i_rwsem in the VFS inode, the xfs inode contains 2
> * multi-reader locks: i_mmap_lock and the i_lock.  This routine allows
> * various combinations of the locks to be obtained.

The field in struct xfs_inode is called i_mmaplock though, not
i_mmap_lock. In addition, struct inode has an i_mmap_rwsem field which
is also referred to as i_mmap_lock. If that isn't irritating enough.

Thanks,
Andreas

