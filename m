Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097161F9482
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFOKVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 06:21:09 -0400
Received: from nautica.notk.org ([91.121.71.147]:53115 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOKVJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:21:09 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 341B6C01C; Mon, 15 Jun 2020 12:21:08 +0200 (CEST)
Date:   Mon, 15 Jun 2020 12:20:53 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
Message-ID: <20200615102053.GA11026@nautica>
References: <20200615012153.89538-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615012153.89538-1-zhengbin13@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zheng Bin wrote on Mon, Jun 15, 2020:
> v9fs_mount
>   v9fs_session_init
>     v9fs_cache_session_get_cookie
>       v9fs_random_cachetag                     -->alloc cachetag
>       v9ses->fscache = fscache_acquire_cookie  -->maybe NULL
>   sb = sget                                    -->fail, goto clunk
> clunk_fid:
>   v9fs_session_close
>     if (v9ses->fscache)                        -->NULL
>       kfree(v9ses->cachetag)
> 
> Thus memleak happens.
> 
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Thanks, will run tests & queue next weekend

-- 
Dominique
