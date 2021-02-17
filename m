Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FEE31DBD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhBQPA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 10:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233695AbhBQPAX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:00:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1615F64E2F;
        Wed, 17 Feb 2021 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613573981;
        bh=FNpF+8AGE0omd74OYhDKv2BUFer+sGtMNUISPRhdmDk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GQXkYK+LnrLOELaKodB9PYmqDSDRRak7P7mNZ7WHA5rImGk0DYJzrSNqDdYQwk2YO
         iXoSuknTe0x7j7UhUulxlaswSogeWl7Ewo5TZi46M/jmeYjzj5m0mydNjPu4VeYRaV
         8d0FsGCTEFgyUdRYUn7tj6L59yiNZ0b7YiTllHKiGUpYELFAHUYBENUr08oNYthhg9
         HK4ydz1PGXvmOoozh7JNyMixnqs3mZetznGmZazB/O08OCQ+s1ID4Qi1iZaU132W/n
         /HJv7zNjViEj5m6gwRvfRubdVzrNNmboiPD44Ah1AKZPWs5dKi0w/XLIGJRjkuf0eE
         W7d6tLDBb25Pg==
Message-ID: <67964c5a81822bf8d6562fbaaef0d43ef2f9f9bd.camel@kernel.org>
Subject: Re: [PATCH v2 2/6] ceph: rework PageFsCache handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, idryomov@gmail.com, xiubli@redhat.com,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 17 Feb 2021 09:59:39 -0500
In-Reply-To: <20210217143857.GK2858050@casper.infradead.org>
References: <20210217125845.10319-1-jlayton@kernel.org>
         <20210217125845.10319-3-jlayton@kernel.org>
         <20210217143857.GK2858050@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-02-17 at 14:38 +0000, Matthew Wilcox wrote:
> On Wed, Feb 17, 2021 at 07:58:41AM -0500, Jeff Layton wrote:
> > -static int ceph_releasepage(struct page *page, gfp_t g)
> > +static int ceph_releasepage(struct page *page, gfp_t gfp_flags)
> >  {
> >  	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
> >  	     page, page->index, PageDirty(page) ? "" : "not ");
> >  
> > 
> > +	if (PageFsCache(page)) {
> > +		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
> 
> If you called it 'gfp' instead of 'gfp_flags', you wouldn't go over 80
> columns ;-)
> 
> 		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
> 

Fair enough -- I'll fix it up since you mentioned it. ;)
-- 
Jeff Layton <jlayton@kernel.org>

