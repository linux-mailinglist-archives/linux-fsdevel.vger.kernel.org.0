Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7E2ACAAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 02:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgKJBtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 20:49:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53808 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:49:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA1hoDj170038;
        Tue, 10 Nov 2020 01:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vgpk87Y2fe/gr8AkdPnT+NK3ydmP4nz4RAYDdIVewR4=;
 b=yvK38qJIBo590XWUIjP7IwK37CB8Sqcl9l8XzJDVgcpncwNUQPxQJFEuiEaWvlO1EgMW
 tndC/7HgTz/2bc9G5yjyr09fiHqVf17ZqRZiJgKknu8YDckQKfkhsAg1FyjbJrqQ330o
 RjRKa1oySbGvCrmpxm2/Qxa3l9nJLq6XsdGyZIxtqnVmdpadw4itMbuzY9+0IvNBx9x7
 +bqjnE50tDicQ+5dUColgvSwHJYIZkZnAHNBJm9hAsk/Pd479tAFTOaphLp/MKceEach
 gKSQw17rIWrts86Lg1b3TwExigE8ULuD2yWlRc1B7B5M2ANu66j4z7kuhthTCPllFV0N 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3asbuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 01:49:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA1e7aP073221;
        Tue, 10 Nov 2020 01:49:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34p5gw52te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 01:49:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AA1nRiQ029437;
        Tue, 10 Nov 2020 01:49:28 GMT
Received: from localhost (/10.159.230.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 17:49:27 -0800
Date:   Mon, 9 Nov 2020 17:49:25 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] fs: Avoid to use lockdep information if it's turned off
Message-ID: <20201110014925.GB9685@magnolia>
References: <20201110013739.686731-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110013739.686731-1-boqun.feng@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100011
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:37:37AM +0800, Boqun Feng wrote:
> Filipe Manana reported a warning followed by task hanging after attempts
> to freeze a filesystem[1]. The problem happened in a LOCKDEP=y kernel,
> and percpu_rwsem_is_held() provided incorrect results when
> debug_locks == 0. Although the behavior is caused by commit 4d004099a668
> ("lockdep: Fix lockdep recursion"): after that lock_is_held() and its
> friends always return true if debug_locks == 0. However, one could argue

...the silent trylock conversion with no checking of the return value is
completely broken.  I already sent a patch to tear all this out:

https://lore.kernel.org/linux-fsdevel/160494580419.772573.9286165021627298770.stgit@magnolia/T/#t

--D

> that querying the lock holding information regardless if the lockdep
> turn-off status is inappropriate in the first place. Therefore instead
> of reverting lock_is_held() and its friends to the previous semantics,
> add the explicit checking in fs code to avoid use the lock holding
> information if lockdpe is turned off. And since the original problem
> also happened with a silent lockdep turn-off, put a warning if
> debug_locks is 0, which will help us spot the silent lockdep turn-offs.
> 
> [1]: https://lore.kernel.org/lkml/a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com/
> 
> Reported-by: Filipe Manana <fdmanana@gmail.com>
> Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Nikolay Borisov <nborisov@suse.com>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> ---
> Hi Filipe,
> 
> I use the slightly different approach to fix this problem, and I think
> it should have the similar effect with my previous fix[2], except that
> you will hit a warning if the problem happens now. The warning is added
> on purpose because I don't want to miss a silent lockdep turn-off.
> 
> Could you and other fs folks give this a try?
> 
> Regards,
> Boqun
> 
> [2]: https://lore.kernel.org/lkml/20201103140828.GA2713762@boqun-archlinux/
> 
>  fs/super.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index a51c2083cd6b..1803c8d999e9 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1659,12 +1659,23 @@ int __sb_start_write(struct super_block *sb, int level, bool wait)
>  	 * twice in some cases, which is OK only because we already hold a
>  	 * freeze protection also on higher level. Due to these cases we have
>  	 * to use wait == F (trylock mode) which must not fail.
> +	 *
> +	 * Note: lockdep can only prove correct information if debug_locks != 0
>  	 */
>  	if (wait) {
>  		int i;
>  
>  		for (i = 0; i < level - 1; i++)
>  			if (percpu_rwsem_is_held(sb->s_writers.rw_sem + i)) {
> +				/*
> +				 * XXX: the WARN_ON_ONCE() here is to help
> +				 * track down silent lockdep turn-off, i.e.
> +				 * this warning is triggered, but no lockdep
> +				 * splat is reported.
> +				 */
> +				if (WARN_ON_ONCE(!debug_locks))
> +					break;
> +
>  				force_trylock = true;
>  				break;
>  			}
> -- 
> 2.29.2
> 
