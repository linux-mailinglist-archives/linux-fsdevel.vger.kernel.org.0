Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06373609C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhDOMtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 08:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhDOMtP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 201C7AF23;
        Thu, 15 Apr 2021 12:48:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3DCF01F2B65; Thu, 15 Apr 2021 14:48:48 +0200 (CEST)
Date:   Thu, 15 Apr 2021 14:48:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yutian Yang <ytyang@zju.edu.cn>
Cc:     jack@suse.cz, mhocko@kernel.org, linux-fsdevel@vger.kernel.org,
        amir73il@gmail.com, "shenwenbo@zju.edu.cn" <shenwenbo@zju.edu.cn>,
        vdavydov.dev@gmail.com, hannes@cmpxchg.org
Subject: Re: inotify_init1() syscall creates memcg-uncharged objects
Message-ID: <20210415124848.GD25217@quack2.suse.cz>
References: <39472b9e.5a92d.178d5843523.Coremail.ytyang@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39472b9e.5a92d.178d5843523.Coremail.ytyang@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-04-21 20:31:54, Yutian Yang wrote:
> Hi, our team has found a bug in fsnotify_alloc_group() on Linux kernel
> v5.10.19, which leads to memcg accounting bypassing.
> 
> The bug is caused by the code snippets listed below:
> 
> /*--------------- fs/notify/group.c --------------------*/
> ...
> 119 struct fsnotify_group *group;
> 120 
> 121 group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
> ...
> 
> 
> /*------------------------ end --------------------------*/
> 
> The code can be triggered by syscall inotify_init1() and causes uncharged
> fsnotify_group objects. A user could repeatedly make the syscall and
> trigger the bug to occupy more and more memory. In fact, fsnotify_group
> objects could be allocated by users and are also controllable by users.
> As a result, they need to be charged and we suggest the following patch:
> 
> /*--------------- fs/notify/group.c --------------------*/
> ...
> 119 struct fsnotify_group *group;
> 120 
> 121 group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL_ACCOUNT);
> ...
> 
> /*------------------------ end --------------------------*/

This was mostly by design since number of inotify groups is limited to
relatively low number anyway. But what you ask for has already happened in
commit ac7b79fd190b0 merged to 5.12-rc1 anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
