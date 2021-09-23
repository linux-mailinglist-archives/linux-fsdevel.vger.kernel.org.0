Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69366415543
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbhIWBxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:53:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9758 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhIWBxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:53:39 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HFJ635zsWzWMqj;
        Thu, 23 Sep 2021 09:50:51 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 09:52:02 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 09:52:02 +0800
From:   Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] kernfs: fix the race in the creation of negative dentry
To:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
CC:     <viro@ZenIV.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210911021342.3280687-1-houtao1@huawei.com>
 <7b92b158200567f0bba26a038191156890921f13.camel@themaw.net>
 <6c8088411523e52fc89b8dd07710c3825366ce64.camel@themaw.net>
 <747aee3255e7a07168557f29ad962e34e9cb964b.camel@themaw.net>
Message-ID: <e3d22860-f2f0-70c1-35ef-35da0c0a44d2@huawei.com>
Date:   Thu, 23 Sep 2021 09:52:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <747aee3255e7a07168557f29ad962e34e9cb964b.camel@themaw.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/15/2021 10:09 AM, Ian Kent wrote:
> On Wed, 2021-09-15 at 09:35 +0800, Ian Kent wrote:
>
Sorry for the late reply.
> I think something like this is needed (not even compile tested):
>
> kernfs: dont create a negative dentry if node exists
>
> From: Ian Kent <raven@themaw.net>
>
> In kernfs_iop_lookup() a negative dentry is created if associated kernfs
> node is incative which makes it visible to lookups in the VFS path walk.
>
> But inactive kernfs nodes are meant to be invisible to the VFS and
> creating a negative for these can have unexpetced side effects.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index ba581429bf7b..a957c944cf3a 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1111,7 +1111,14 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  
>  	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
>  	/* attach dentry and inode */
> -	if (kn && kernfs_active(kn)) {
> +	if (kn) {
> +		/* Inactive nodes are invisible to the VFS so don't
> +		 * create a negative.
> +		 */
> +		if (!kernfs_active(kn)) {
> +			up_read(&kernfs_rwsem);
> +			return NULL;
> +		}
>  		inode = kernfs_get_inode(dir->i_sb, kn);
>  		if (!inode)
>  			inode = ERR_PTR(-ENOMEM);
>
>
> Essentially, the definition a kernfs negative dentry, for the
> cases it is meant to cover, is one that has no kernfs node, so
> one that does have a node should not be created as a negative.
>
> Once activated a subsequent ->lookup() will then create a
> positive dentry for the node so that no invalidation is
> necessary.
I'm fine with the fix which is much simpler.
> This distinction is important because we absolutely do not want
> negative dentries created that aren't necessary. We don't want to
> leave any opportunities for negative dentries to accumulate if
> we don't have to.
>     
> I am still thinking about the race you have described.
>
> Given my above comments that race might have (maybe probably)
> been present in the original code before the rwsem change but
> didn't trigger because of the serial nature of the mutex.
I don't think there is such race before the enabling of negative dentry,
but maybe I misunderstanding something.
> So it may be wise (perhaps necessary) to at least move the
> activation under the rwsem (as you have done) which covers most
> of the change your proposing and the remaining hunk shouldn't
> do any harm I think but again I need a little more time on that.
After above fix, doing sibling tree operation and activation atomically
will reduce the unnecessary lookup, but I don't think it is necessary
for the fix of race.

Regards,
Tao
> I'm now a little concerned about the invalidation that should
> occur on deactivation so I want to have a look at that too but
> it's separate to this proposal.
> Greg, Tejun, Hou, any further thoughts on this would be most
> welcome.
>
> Ian
>>
> .

