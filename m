Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596382DED6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 07:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgLSGOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgLSGOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 01:14:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73249C0617B0;
        Fri, 18 Dec 2020 22:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OeiAf24ST0fy3A7E9tQh8AFcXhxelCIuOSJh4rkuThk=; b=u1pbgSsMgOnm/654XrErBy+bD4
        YIcQ1Cb7itGrTJJXNgfgLm/hKw8tRKzDXBoNFlK7arM5E/7+q2Tir7Q9h3eMc05e7RG+cR1Z90y4P
        weNmqHzHa+DMn5m0D9jLEtjhZXdXr7y7aRAsElrkPss9oJFGagyHn3UJZLGyxoOxipcrgSwqF2Ov9
        5Dxf/15s1Bajv32JLlYO7G3l0pmAuXQASI4i8lzkYcrCtNNGADBA+KufVBDZEe86rqzrTyah2bDBl
        x5wBxDoc7/lDJtq+oZrAX8jmiYp0yEExgu9xIz+16ZMFP7eB9oVVBtu4mFcc5LpcSFqLLiaEg6YgZ
        9jIWXRug==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqVUh-0002dA-7K; Sat, 19 Dec 2020 06:13:31 +0000
Date:   Sat, 19 Dec 2020 06:13:31 +0000
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
Message-ID: <20201219061331.GQ15600@casper.infradead.org>
References: <20201217150037.468787-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217150037.468787-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> Overlayfs's volatile mounts want to be able to sample an error for their
> own purposes, without preventing a later opener from potentially seeing
> the error.

umm ... can't they just copy the errseq_t they're interested in, followed
by calling errseq_check() later?

actually, isn't errseq_check() buggy in the face of multiple
watchers?  consider this:

worker.es starts at 0
t2.es = errseq_sample(&worker.es)
errseq_set(&worker.es, -EIO)
t1.es = errseq_sample(&worker.es)
t2.err = errseq_check_and_advance(&es, t2.es)
	** this sets ERRSEQ_SEEN **
t1.err = errseq_check(&worker.es, t1.es)
	** reports an error, even though the only change is that
	   ERRSEQ_SEEN moved **.

i think errseq_check() should be:

	if (likely(cur | ERRSEQ_SEEN) == (since | ERRSEQ_SEEN))
		return 0;

i'm not yet convinced other changes are needed to errseq.  but i am
having great trouble understanding exactly what overlayfs is trying to do.
