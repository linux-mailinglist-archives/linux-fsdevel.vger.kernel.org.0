Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4B1AC10
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfELMho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 08:37:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfELMho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 08:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XopLgHQ7N8sreq2i03EsDQD4RQtxOTNchFWldzh6aQg=; b=qjGe15VSVTqXl0tVtgbN9gmX4
        pZOe75tk63RA1yuR86UNQ/tNbpCfV9ZTR980lHv+egCehDaChO06Sq6OU6JXjGkjcROd6at+3kr6U
        rp1xwaepqThE8QrPN81TAwPHG9DUY8EU9nH94MgiZ4h/O8bi57iopHhPFC8GNriRjjLu0UBO/+AOn
        IWiRv8Fd4FdphkApdywNCq2F69lXzPiWYTBAnQqkuzhHmEBPsGpO5kyXQLvb58zHAda/nlwbM9ABT
        2P56F4Jqqh8X8F4sL+cwJWY6/1+KLfmJCDwlkP4tQe1WgrupuqPMhhNi81Y5d+5wHthVRDy38cCZw
        e9Zc1n5iQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hPnjX-0003TV-Cy; Sun, 12 May 2019 12:37:39 +0000
Date:   Sun, 12 May 2019 05:37:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     yangerkun <yangerkun@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        huawei.libin@huawei.com, Miao Xie <miaoxie@huawei.com>,
        suoben@huawei.com, Al Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] softlockup in __fsnotify_update_child_dentry_flags
Message-ID: <20190512123739.GA8050@bombadil.infradead.org>
References: <0ce0173a-78f0-ae69-05b2-8374fbe3ba37@huawei.com>
 <CAOQ4uxjVf5yTNpuj=6Yb9eXpUwALx3-4tmbFG9g_WKrtkWw7wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjVf5yTNpuj=6Yb9eXpUwALx3-4tmbFG9g_WKrtkWw7wA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 12, 2019 at 12:20:14PM +0300, Amir Goldstein wrote:
> On Fri, May 10, 2019 at 5:38 PM yangerkun <yangerkun@huawei.com> wrote:
> > We find the lock of lockref has been catched with cpu 40. And since
> > there is too much negative dentry in root dentry's d_subdirs, traversing
> > will spend so long time with holding d_lock of root dentry. So other
> > thread waiting for the lockref.lock will softlockup.
> 
> IMO, this is DoS that can be manifested in several other ways.
> __fsnotify_update_child_dentry_flags() is just a private case of single
> level d_walk(). Many other uses of d_walk(), such as path_has_submounts()
> will exhibit the same behavior under similar DoS.
> 
> Here is a link to a discussion of a similar issue with negative dentries:
> https://lore.kernel.org/lkml/187ee69a-451d-adaa-0714-2acbefc46d2f@redhat.com/
> 
> I suppose we can think of better ways to iterate all non-negative
> child dentries,
> like keep them all at the tail of d_subdirs, but not sure about the implications
> of moving the dentry in the list on d_instantiate().
> We don't really have to move the dentries that turn negative (i.e. d_delete()),
> because those are not likely to be the real source of DoS.

We should probably be more aggressive about reclaiming negative dentries.
It's clearly ludicrous to have a million negative dentries in a single
directory, for example.
