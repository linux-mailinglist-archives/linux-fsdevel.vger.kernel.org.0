Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B566434359B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 00:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCUXEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 19:04:52 -0400
Received: from sandeen.net ([63.231.237.45]:33210 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCUXEU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 19:04:20 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id C8E11552431;
        Sun, 21 Mar 2021 18:03:36 -0500 (CDT)
To:     David Mozes <david.mozes@silk.us>,
        Eric Sandeen <sandeen@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <AM6PR04MB5639492BE427FDA2E1A9F74BF16B9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <4c7da46e-283b-c1e3-132a-2d8d5d9b2cea@sandeen.net>
 <AM6PR04MB563935FDA6010EA1383AA08BF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <AM6PR04MB5639629BAB2CD2981BAA3AFDF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <80aafc03-90b2-ed68-54a9-0af1499854ec@redhat.com>
 <AM6PR04MB56399D13C91C1F49ACFD3294F1669@AM6PR04MB5639.eurprd04.prod.outlook.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: fs: avoid softlockups in s_inodes iterators commit
Message-ID: <4e264417-96fd-dc06-2b59-bc0dcdce5376@sandeen.net>
Date:   Sun, 21 Mar 2021 18:04:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB56399D13C91C1F49ACFD3294F1669@AM6PR04MB5639.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/21/21 6:47 AM, David Mozes wrote:
> 
> Our light custom is enabled us to load a very high load  IO on the VM/kernel.

If you can't explain what this change is, I'm afraid the default assumption will be
that your <unspecified> changes have contributed to the problem.

> In case  I remove them, we will not be able to generate such a high load on the Kernel.
> 
> Eric, after I moved the cond_resched to the place you asked for
> See below:
> 
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -35,11 +35,11 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>                 spin_unlock(&inode->i_lock);
>                 spin_unlock(&sb->s_inode_list_lock);
>  
> +               cond_resched();
>                 invalidate_mapping_pages(inode->i_mapping, 0, -1);
>                 iput(toput_inode);
>                 toput_inode = inode;
> 
> We got stuck again after one and a half-day of running under the heavy load:
> What we saw on the node is:

<a different backtrace than before with the actual warning omitted>

Ok, then the change you flagged from my commit is not the root cause of your problem.

At this point, I can only presume that your "light custom" is the root cause.

If you can't reproduce the problem on a stock kernel, then I don't think we can proceed
further.

-Eric
