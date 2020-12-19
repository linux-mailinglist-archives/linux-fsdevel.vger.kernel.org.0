Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002DB2DF040
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgLSPeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 10:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgLSPeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 10:34:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86EC0617B0;
        Sat, 19 Dec 2020 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=77WRbXUJE7fiLzSym42sJcP/7e7mLX6ggMCc9PUwzE4=; b=wFDwYMBdTKtCfWavneHU3CnWYo
        aDS7KDHLWlAVYyygr07w3EElo5RO9I+friSIBa8UC/W+AuR4TGZobeoG3b474FCfECVIJGzjq4gRS
        95M5tc5O1d/VCJNWbrzBpYwVRlatygQCOIzf5bXfJ3ce+Gpeel0NCT8Q4BQ7Ecp28EH307OrWPy9q
        ABgWl+BH7k40W6+EqoqCGVH4wAUEJRDIZOLMfOjOsk3bloDKKjG1rRZiiW+XefySqOyCUGA1QDj65
        xSSlgSsrmR/OKdaEEjwhBrYwS9Tc4CfYPGWJUX1pGepgKx/m0DpgRk6sGJXMsV/U5NdsR4jM+9rPf
        UAOV/cDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqeEK-0003Ox-J0; Sat, 19 Dec 2020 15:33:12 +0000
Date:   Sat, 19 Dec 2020 15:33:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
Message-ID: <20201219153312.GS15600@casper.infradead.org>
References: <20201217150037.468787-1-jlayton@kernel.org>
 <20201219061331.GQ15600@casper.infradead.org>
 <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 07:53:12AM -0500, Jeff Layton wrote:
> On Sat, 2020-12-19 at 06:13 +0000, Matthew Wilcox wrote:
> > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > own purposes, without preventing a later opener from potentially seeing
> > > the error.
> > 
> > umm ... can't they just copy the errseq_t they're interested in, followed
> > by calling errseq_check() later?
> > 
> 
> They don't want the sampling for the volatile mount to prevent later
> openers from seeing an error that hasn't yet been reported.

That's why they should use errseq_check(), not errseq_check_and_advance()
...
