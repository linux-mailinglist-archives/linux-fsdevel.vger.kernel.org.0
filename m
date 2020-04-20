Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277E61B1A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDTXUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 19:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgDTXUM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:20:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F1020B1F;
        Mon, 20 Apr 2020 23:20:10 +0000 (UTC)
Date:   Mon, 20 Apr 2020 19:20:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] blktrace: upgrade warns to BUG_ON() on
 unexpected circmunstances
Message-ID: <20200420192009.073a1cec@oasis.local.home>
In-Reply-To: <20200419230730.GH11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
        <20200419194529.4872-6-mcgrof@kernel.org>
        <54b63fd9-0c73-5fdc-b43d-6ab4aec3a00d@acm.org>
        <20200419230730.GH11244@42.do-not-panic.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 19 Apr 2020 23:07:30 +0000
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Sun, Apr 19, 2020 at 03:50:13PM -0700, Bart Van Assche wrote:
> > On 4/19/20 12:45 PM, Luis Chamberlain wrote:  
> > > @@ -498,10 +498,7 @@ static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > >   	struct dentry *dir = NULL;
> > >   	/* This can only happen if we have a bug on our lower layers */
> > > -	if (!q->kobj.parent) {
> > > -		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > > -		return NULL;
> > > -	}
> > > +	BUG_ON(!q->kobj.parent);  
> > 
> > Does the following quote from Linus also apply to this patch: "there is NO
> > F*CKING EXCUSE to knowingly kill the kernel." See also
> > https://lkml.org/lkml/2016/10/4/1.  
> 
> We can use WARN_ON() and keep the return NULL, sure.
> 

Yes please. This is definitely not something that should kill the system.

-- Steve
