Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404B0432A31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhJRXSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 19:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhJRXSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:18:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069C8C061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 16:16:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r19so3131313lfe.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8NcdhqdVTYivLPB/4AQ/n+hK6qI5Cqzz6EhWUcLIk4=;
        b=aAgTInrSiwhLMEvXKlaIEPoHz91AKhYnFSh6ZeY+8aJ0m70YuCN1AEZZBWoZtmDnc0
         UH93kBEjtd+TYhT62QAI7CBjo2v93qAopTUcR6TmRLkNao76XsyoKi86VcVcxx/zguwH
         YPSt1VisZ9TPpfyBoJ0BFEUQoZwBYLZlh8ek71OfJvcTUwYscpaWaHuOczDDY8vjvrVI
         oPALskxKO+CCRY875mfkvHPAEGgkTPYrcshxB4Wqp6jjgSQe1FMFORpDo0LPNMrsgJ+0
         g71o7VwLfcRnj3CRv/EWq/3SGww9AETo058msEGtDQx5bjW6V8HaEvMKTQED22hcxCCs
         NBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8NcdhqdVTYivLPB/4AQ/n+hK6qI5Cqzz6EhWUcLIk4=;
        b=UePIRBk63OSbPACKQIgyfWMRFWOkUR4gthL+i/bpmda5gry9wXJmBI6wmSGFrZI6q+
         OW5vtO8ev9DgIQ7DfSaYeaKKV6xpNt/7hwV8hUaP7STaQzGsOQtNuslazdTvOhNG4KY0
         Q+hsm4dxySisQV3GvPSSXh+vmLTyv5OTSsrc8TLQzRQf06oNVmNaPpYjoAokRq/9VAR4
         zZTqw/AMc6N6hQkwTNvDLrdrPE1DpZtP4YqcH+jFmiZniAsbYVCKcNQaWipyCJcVbvyh
         Yvki+JKvSuHSvos46i/fF1qYtw8fqm3DMbmbBuJbWAJKlFETXxHmMWU9MzLmK8CzpiLt
         6wqg==
X-Gm-Message-State: AOAM5321kxrO6eZ2eJPWzrrEN0MXxZbGyy5+QqF/hVyHc4DmAovCl+9T
        o//ba9DJCX/9IpQTc6CDCQ0kLzs64H9PqA==
X-Google-Smtp-Source: ABdhPJzYZsc9DzluDfFcQYm/U5oV2+pFcKeBboxjUKEhxR81JlpIWnF73PROY1HoFW3gBKesKVPj9w==
X-Received: by 2002:a19:48d1:: with SMTP id v200mr2600433lfa.47.1634598984410;
        Mon, 18 Oct 2021 16:16:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o21sm1765814ljg.93.2021.10.18.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:16:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A5E6610309A; Tue, 19 Oct 2021 02:16:27 +0300 (+03)
Date:   Tue, 19 Oct 2021 02:16:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
References: <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3tkuCUPVICvMBX@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 05:56:34PM -0400, Johannes Weiner wrote:
> > I don't think there will ever be consensus as long as you don't take
> > the concerns of other MM developers seriously.  On Friday's call, several
> > people working on using large pages for anon memory told you that using
> > folios for anon memory would make their lives easier, and you didn't care.
> 
> Nope, one person claimed that it would help, and I asked how. Not
> because I'm against typesafety, but because I wanted to know if there
> is an aspect in there that would specifically benefit from a shared
> folio type. I don't remember there being one, and I'm not against type
> safety for anon pages.
> 
> What several people *did* say at this meeting was whether you could
> drop the anon stuff for now until we have consensus.

My read on the meeting was that most of people had nothing against anon
stuff, but asked if Willy could drop anon parts to get past your
objections to move forward.

You was the only person who was vocal against including anon pars. (Hugh
nodded to some of your points, but I don't really know his position on
folios in general and anon stuff in particular).

For record: I think folios has to be applied, including anon bits. They
are useful and address long standing issues with compound pages. Any
future type-safety work can be done on top of it.

I know it's not democracy and we don't count votes here, but we are
dragging it for months and don't get closer to consensus. At some point
"disagree and commit" has to be considered.

-- 
 Kirill A. Shutemov
