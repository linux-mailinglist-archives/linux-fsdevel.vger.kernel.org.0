Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263D34D1FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC2N5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 09:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhC2N5n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:57:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46480B12A;
        Mon, 29 Mar 2021 13:57:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9AC6F1E4353; Mon, 29 Mar 2021 15:57:40 +0200 (CEST)
Date:   Mon, 29 Mar 2021 15:57:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     lyl2019@mail.ustc.edu.cn
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] fs/notify/mark: A potential use after free in
 fsnotify_put_mark_wake
Message-ID: <20210329135740.GB4283@quack2.suse.cz>
References: <39095113.1936a.178781a774a.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39095113.1936a.178781a774a.Coremail.lyl2019@mail.ustc.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!


On Sun 28-03-21 17:11:43, lyl2019@mail.ustc.edu.cn wrote:
>     My static analyzer tool reported a use after free in fsnotify_put_mark_wake
> of the file: fs/notify/mark.c.
> 
> In fsnotify_put_mark_wake, it calls fsnotify_put_mark(mark). Inside the function
> fsnotify_put_mark(), if conn is NULL, it will call fsnotify_final_mark_destroy(mark)
> to free mark->group by fsnotify_put_group(group) and return. I also had inspected
> the implementation of fsnotify_put_group() and found that there is no cleanup operation
> about group->user_waits.
> 
> But after fsnotify_put_mark_wake() returned, mark->group is still used by 
> if (atomic_dec_and_test(&group->user_waits) && group->shutdown) and later.
> 
> Is this an issue?

I don't think this scenario is possible. fsnotify_put_mark_wake() can be
called only for marks attached to objects and these have mark->conn !=
NULL and we are sure that fsnotify_destroy_group() will wait for all such
marks to be torn down and freed before dropping last group reference and
freeing the group.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
