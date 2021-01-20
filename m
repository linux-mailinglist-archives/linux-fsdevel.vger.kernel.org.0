Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3462FCD17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbhATJBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 04:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbhATJAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:00:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2672C061575;
        Wed, 20 Jan 2021 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RaWLb5cuOxioAYXgsdU/4k1ily/oqbSWtIgPbTftsvU=; b=s/AYqCvKSMxlrqVI39kGzkvJ4D
        SOw3rkTBfb/Y6ft2Eyhm+uD468TO6pnm5AsvXgJcK67X7JKDEJEwqb5FmYnpyc4RrraF8UmSwlYcs
        NFWwPKPBJSOpq1DX6bzqgLh/ticV4GVt0b5O7ULzUwBFmfMbkeWE1bLYahKJZ5+9XXTwUhwJiL7ed
        bhTSuPmw0kyEfj/ptp/PuBciYBJdhod9ECMH3FLWx8qcoGCeXKlO7gm2BAEmie1djvH9ZLBwEY9Q4
        We/GMZ99CpMoTGOkX+4Ypg5LZviZzDzKtn5KjrXQBNRSalACfHrcxt8lVrsoDLFBJDrmuQyrShk1A
        kKjv42Yw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l298Q-00FRAi-Av; Wed, 20 Jan 2021 08:46:39 +0000
Date:   Wed, 20 Jan 2021 08:46:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210120084638.GA3678536@infradead.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611084297-27352-3-git-send-email-bfields@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:24:56PM -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> After this, only filesystems lacking change attribute support will leave
> the fetch_iversion export op NULL.
> 
> This seems cleaner to me, and will allow some minor optimizations in the
> nfsd code.

Another indirect call just to fetch the change attribute (which happens
a lot IIRC) does not seem very optimal to me.  And the fact that we need
three duplicate implementations also is not very nice.
