Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073134255C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhJGOve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:51:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7744C061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZaIfgTqAECN8YQ33y/H4ix8XO1DsmTwgYAAz8mNepJ4=; b=UWLTO4OYqlkhtknN3F38R9qZPa
        9jUTnzWFNyLxIivdRQFEtrB0Kqt156B/4BYk1JecPqj1DIwoWz67JNuNnsBlIO3Vx6dwhXrUzfSNm
        c8AjDfYa3h2JW18/puPFnqLd3xS6hYvAjarYajk2xaiGvRI9I46YyRYRL1i4yU3m1bn8O4y4845sD
        juKN3MXr+xCk/v5kQWaiYkuziW2yHba/Bo4alFGnnIcUGIqSE5FtU+afLHLj7VB3cp82aMkgHWeBx
        DIixh912OAw5KPUnU4p2IfapNz2GDw5vynxGtHVD25xCobRoPRMx42bFtDnG3TtAVpLaFN413PVA7
        qAe9z50w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYUhA-001wgg-0z; Thu, 07 Oct 2021 14:48:38 +0000
Date:   Thu, 7 Oct 2021 15:48:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV8IvJ9HZI0+o243@casper.infradead.org>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <a8cdcb3c-26e5-33b5-44f9-459df8a40dbb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8cdcb3c-26e5-33b5-44f9-459df8a40dbb@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 04:37:08PM +0200, Vlastimil Babka wrote:
> > -	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
> > +	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags.f, &head->flags.f,
> 
> The %pGp case (here and elsewhere) could perhaps take the new type, no?
> Would need to change format_page_flags() and flags_string() in lib/vsprintf.c

Oh, good point.  I don't think format_page_flags() would _need_ to
change, but we might _want_ to change it.  Particularly if we go with Al
Viro's suggestion of using __bitwise to create a new type that's checked
with sparse.
