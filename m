Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C213F3DF6F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 23:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhHCVij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 17:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhHCVii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628026706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EM3F3OHS2L2GE9YJO2LmAbAEq5eEZ/246ein95lIcos=;
        b=MagAUqkLZ5CsIGieqjPCgI+R38B+x0rmzVLBP0LeiX1u2LYt/46E6zqipA4lAYLLbf21sy
        hpkgjD8ZDIKWVAnzWSW03TndvDwf2kHo4VUOKJpuCGBYHdd6AMTQJR28tiG1ipuoW+7Nwq
        1vEsgzK5ludia09cDbXyyL07MdybsWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-u41JTPgXN3SBFp720OEtxA-1; Tue, 03 Aug 2021 17:38:25 -0400
X-MC-Unique: u41JTPgXN3SBFp720OEtxA-1
Received: by mail-wr1-f69.google.com with SMTP id o10-20020a5d684a0000b0290154758805bcso3574259wrw.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 14:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EM3F3OHS2L2GE9YJO2LmAbAEq5eEZ/246ein95lIcos=;
        b=gzejSomHJ1U/p4K6VwN52v0ZDNtmIL2OVXLWszUJbcBM0yPJsbiJF//3pLdXQkpj6T
         BbmqervLZQjbO50HwSKCfJxT3p0K3lqmciuubJJ+g1302KgIiWTj/Dm5mFuhmFPhURr+
         iMQZz8e9d6Wb5DB49+sJiHUDJLtpPmiF9QAc9EH6GgiolIKluCchVACQ8OE0pstCtTiC
         R7Yk5mgjZhkdoBTfBB6jK88tIvZPJMVXz/q0TCHRyeH2mUMiNZh9gfLnVDCL/r+bCfgI
         hKicUS+iz3WIYxWu6dCitLPMtBrG/xCzPzp6CBGnzc+PuXc1dq+GmA3eY/tTSm3Br76p
         ZgGg==
X-Gm-Message-State: AOAM533LUNqZoONTrdmWN57NAOXMLntrEAhqJIkPL+Y+FhoPnOWNL+um
        SCx0yr8H2WZktDW2mlGovx07B3cJo9wkbWhASYtRrrrFCT6L7WFgsaeLKTB/lcCeCB919m4bZnw
        OCyAIFZo9c/HxcD2+0n1btDmkZJTRx2xX6UTzSFMqmQ==
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr24885005wrl.357.1628026704024;
        Tue, 03 Aug 2021 14:38:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZzs1zl2V3LTsadj+4bR4O6BnVBDX/GlTJnBJVWvnotmNbJsR03yyQqgOjRCTvd6UqzZnYP7e1CCrvtQ8KSCA=
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr24884995wrl.357.1628026703875;
 Tue, 03 Aug 2021 14:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <20210803191818.993968-4-agruenba@redhat.com>
 <YQmtnuqDwBIBf4N+@zeniv-ca.linux.org.uk>
In-Reply-To: <YQmtnuqDwBIBf4N+@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 Aug 2021 23:38:12 +0200
Message-ID: <CAHc6FU7iAPOPO7gtDjpSAVyHwgJ7HQPEhDC_2T__DM8GPW5crQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] Turn fault_in_pages_{readable,writeable} into fault_in_{readable,writeable}
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 10:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Aug 03, 2021 at 09:18:09PM +0200, Andreas Gruenbacher wrote:
> > Turn fault_in_pages_{readable,writeable} into versions that return the number
> > of bytes faulted in instead of returning a non-zero value when any of the
> > requested pages couldn't be faulted in.  This supports the existing users that
> > require all pages to be faulted in, but also new users that are happy if any
> > pages can be faulted in.
> >
> > Neither of these functions is entirely trivial and it doesn't seem useful to
> > inline them, so move them to mm/gup.c.
> >
> > Rename the functions to fault_in_{readable,writeable} to make sure that code
> > that uses them can be fixed instead of breaking silently.
>
> Sigh...  We'd already discussed that; it's bloody pointless.  Making short
> fault-in return success - absolutely.  Reporting exact number of bytes is
> not going to be of any use to callers.

I'm not actually convinced that you're right about this. Let's see
what we'll end up with; we can always strip things down in the end.

Thanks,
Andreas

