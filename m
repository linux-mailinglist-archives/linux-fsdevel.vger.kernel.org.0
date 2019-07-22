Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1895D70D64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 01:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfGVXfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 19:35:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34645 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbfGVXfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:35:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so18122662pfo.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2019 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85QgoVCMoUBXEV57x4G0PDzl0QhwTAJz3PR0yob8+QQ=;
        b=U09JlmRF+1e0SXt1nVtPE+wsgbeVT+ODWkwh5EDZK/HI2W80i+GnSjYreZoZXSI25X
         H/SgYIii0FLjAEyz5fr1WEYrj2sBL7nya8427TlnXTltUbOXOAlyW3PNZsaBZvxVlt9p
         RgLWM5tK8Sx6N9INgAByIFLu9Ox5yaiWxUh//d2f8VulJfzD/2OGyTqkfx1tsYqpi2aZ
         9pTGAYQZrPIxM09wjYq9BG2H+3Xk4U/1Xw1EXLWHs6+EyDzpF9FgQvWLD1cdX6f1bApk
         +PT94ubpctMbcTGgGWiIX4I+Bn5Ly+Usy4Fm5gUH2puNJ6ZQxnG4w0K/QY7JYtZ7JJqP
         eD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85QgoVCMoUBXEV57x4G0PDzl0QhwTAJz3PR0yob8+QQ=;
        b=NK+gBbI5pKhc/lCxOVwvly093K8Os4yCZylr/bnpDngJpI+lXi+x5Hu2eUXLJPE2u8
         Ygc/0oJSQlFVoLYVkh4IO2KU1WYdLSa3m4le3oSXp7czOUS/1IMLS9jYjKnI/OF0jQsT
         SM8hl6weVJXdSYe0yanlJ1F2H1CCqt95k8/TepmEary5qBjM1mIfiSicZ4KudVWu4rNd
         dAtqZTTWRgrLyH/HmFdwIxUM9YcDKy13VFYFwPoKy09B0IXBSOzfNi2crtFPOhOWBbLS
         mhiThPTf5+eypMCvaEOdCT1w7ptgNhi7IyM8Bcv+nWng44qZtVf2439GEcfhGuroZao+
         62mA==
X-Gm-Message-State: APjAAAWifxDR0O/7G4ED8MESSZMXFQ6rC0iG7yyRFBhYCSN9gPibR4GT
        0JinyePaN0p80TA4/JhuGK0=
X-Google-Smtp-Source: APXvYqxd+2dzeBJuFB5qvEgV0O6zCpRw01LkZ+IA8kHWZ1vLbAH4HIeBFqUtXGy3QN5SDNyoAA0HPw==
X-Received: by 2002:a63:188:: with SMTP id 130mr72665111pgb.231.1563838529829;
        Mon, 22 Jul 2019 16:35:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d1c7])
        by smtp.gmail.com with ESMTPSA id l6sm40554336pga.72.2019.07.22.16.35.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:35:29 -0700 (PDT)
Date:   Mon, 22 Jul 2019 19:35:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: annotate refault stalls from IO submission
Message-ID: <20190722233527.GA21594@cmpxchg.org>
References: <20190722201337.19180-1-hannes@cmpxchg.org>
 <20190722152607.dd175a9d517a5f6af06a8bdc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722152607.dd175a9d517a5f6af06a8bdc@linux-foundation.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:26:07PM -0700, Andrew Morton wrote:
> On Mon, 22 Jul 2019 16:13:37 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > psi tracks the time tasks wait for refaulting pages to become
> > uptodate, but it does not track the time spent submitting the IO. The
> > submission part can be significant if backing storage is contended or
> > when cgroup throttling (io.latency) is in effect - a lot of time is
> > spent in submit_bio(). In that case, we underreport memory pressure.
> 
> It's a somewhat broad patch.  How significant is this problem in the
> real world?  Can we be confident that the end-user benefit is worth the
> code changes?

The error scales with how aggressively IO is throttled compared to the
device's capability.

For example, we have system maintenance software throttled down pretty
hard on IO compared to the workload. When memory is contended, the
system software starts thrashing cache, but since the backing device
is actually pretty fast, the majority of "io time" is from injected
throttling delays during submit_bio().

As a result we barely see memory pressure, when the reality is that
there is almost no progress due to the thrashing and we should be
killing misbehaving stuff.

> > Annotate the submit_bio() paths (or the indirection through readpage)
> > for refaults and swapin to get proper psi coverage of delays there.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  fs/btrfs/extent_io.c | 14 ++++++++++++--
> >  fs/ext4/readpage.c   |  9 +++++++++
> >  fs/f2fs/data.c       |  8 ++++++++
> >  fs/mpage.c           |  9 +++++++++
> >  mm/filemap.c         | 20 ++++++++++++++++++++
> >  mm/page_io.c         | 11 ++++++++---
> >  mm/readahead.c       | 24 +++++++++++++++++++++++-
> 
> We touch three filesystems.  Why these three?  Are all other
> filesystems OK or will they need work as well?

These are the ones that I found open-coding add_to_page_cache_lru()
followed by submit_bio() instead of going through generic code like
mpage, use read_cache_pages(), implement ->readpage only.

> > @@ -2753,11 +2763,14 @@ static struct page *do_read_cache_page(struct address_space *mapping,
> >  				void *data,
> >  				gfp_t gfp)
> >  {
> > +	bool refault = false;
> >  	struct page *page;
> >  	int err;
> >  repeat:
> >  	page = find_get_page(mapping, index);
> >  	if (!page) {
> > +		unsigned long pflags;
> > +
> 
> That was a bit odd.  This?
> 
> --- a/mm/filemap.c~psi-annotate-refault-stalls-from-io-submission-fix
> +++ a/mm/filemap.c
> @@ -2815,12 +2815,12 @@ static struct page *do_read_cache_page(s
>  				void *data,
>  				gfp_t gfp)
>  {
> -	bool refault = false;
>  	struct page *page;
>  	int err;
>  repeat:
>  	page = find_get_page(mapping, index);
>  	if (!page) {
> +		bool refault = false;
>  		unsigned long pflags;
>  
>  		page = __page_cache_alloc(gfp);
> _
> 

It's so that when we jump to 'filler:' from outside the branch, the
'refault' variable is initialized from the first time through:

	bool refault = false;
	struct page *page;

	page = find_get_page(mapping, index);
	if (!page) {
	   	__page_cache_alloc()
		add_to_page_cache_lru()
		refault = PageWorkingset(page);
filler:
		if (refault)
			psi_memstall_enter(&pflags);

		readpage()

		if (refault)
			psi_memstall_leave(&pflags);
	}
	lock_page()
	if (PageUptodate())
		goto out;
	goto filler;
