Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3C3694F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbhDWOmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 10:42:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40274 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230416AbhDWOmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:42:01 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13NEeckv032357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 10:40:39 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8FF8315C3B0D; Fri, 23 Apr 2021 10:40:38 -0400 (EDT)
Date:   Fri, 23 Apr 2021 10:40:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adilger.kernel@dilger.ca,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
Message-ID: <YILcZpQh8T//6HLb@mit.edu>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
 <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
 <20210420130841.GA3618564@infradead.org>
 <20210421134634.GT8706@quack2.suse.cz>
 <YIBZgx4cm0j7OObj@mit.edu>
 <20210422090410.GA26221@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422090410.GA26221@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:04:11AM +0200, Jan Kara wrote:
> Yes, I understand that. What I was more asking about is: Does it really
> matter we leave those buffer heads and journal heads unreclaimed. I
> understand it could be triggering premature OOM in theory but is it a
> problem in practice? Was there some observed practical case for which this
> was added or was it just added due to the theoretical concern?

I was doing some research, and found the mail thread which inspired
bdev_try_to_free_page():

https://lore.kernel.org/linux-ext4/20081202200647.72cc5807.toshi.okajima@jp.fujitsu.com/

From what I can tell Toshi Okajima did have a test workload which
would trigger blkdev_releasepage().  He didn't specify it in the mail
thread as near as I can tell, but he did use it to test the page.
Thinking about it, it shouldn't be hard to trigger it via something like:

   find /mnt -print0 | xargs -0 touch

in a memory contrained box with a large file system attached (a
bookshelf NAS scenario).  Under the right circumstances, I'm pretty
sure a premature OOM could be demonstrated.

					- Ted
