Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D463C0C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiK2NOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 08:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiK2NN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:13:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6716150F
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669727518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IANhrpwcy7m+n5oAxgyx5D6DmMTL5sIdzk3gLF3Gsq8=;
        b=cC0FKd/MeYLOeVzN9G3E5CHAmE+xJF/NH7dfEsfgxPH1ssQtgbmOLrhltmbv4+HVza0RHA
        zP5kA6BVgQo2tFqojxElJaggMix5NflcST+lQ+dB/Sfzj8XYaQcALVy45tP6lk/vmVx8+g
        gm8uQj2qtyxVxIUPv/KTiDh6xB9l88A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-2pefXe3HMlmTTbo74XM2nw-1; Tue, 29 Nov 2022 08:11:55 -0500
X-MC-Unique: 2pefXe3HMlmTTbo74XM2nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 317ED3C02B84;
        Tue, 29 Nov 2022 13:11:55 +0000 (UTC)
Received: from ovpn-192-24.brq.redhat.com (ovpn-192-24.brq.redhat.com [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6BC6C15BA4;
        Tue, 29 Nov 2022 13:11:53 +0000 (UTC)
Date:   Tue, 29 Nov 2022 14:11:51 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <20221129131151.bwnsjgatly2vhkpa@ovpn-192-24.brq.redhat.com>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <20221129112133.rrpoywlwdw45k3qa@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129112133.rrpoywlwdw45k3qa@wittgenstein>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:21:33PM +0100, Christian Brauner wrote:
> On Mon, Nov 21, 2022 at 03:28:52PM +0100, Lukas Czerner wrote:
> > In memory quota format relies on quota infrastructure to store dquot
> > information for us. While conventional quota formats for file systems
> > with persistent storage can load quota information into dquot from the
> > storage on-demand and hence quota dquot shrinker can free any dquot that
> > is not currently being used, it must be avoided here. Otherwise we can
> > lose valuable information, user provided limits, because there is no
> > persistent storage to load the information from afterwards.
> > 
> > One information that in-memory quota format needs to keep track of is a
> > sorted list of ids for each quota type. This is done by utilizing an rb
> > tree which root is stored in mem_dqinfo->dqi_priv for each quota type.
> > 
> > This format can be used to support quota on file system without persistent
> > storage such as tmpfs.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  fs/quota/Kconfig           |   8 ++
> >  fs/quota/Makefile          |   1 +
> >  fs/quota/dquot.c           |   3 +
> >  fs/quota/quota_mem.c       | 260 +++++++++++++++++++++++++++++++++++++
> >  include/linux/quota.h      |   7 +-
> >  include/uapi/linux/quota.h |   1 +
> >  6 files changed, 279 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/quota/quota_mem.c
> > 
> > diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> > index b59cd172b5f9..8ea9656ca37b 100644
> > --- a/fs/quota/Kconfig
> > +++ b/fs/quota/Kconfig
> > @@ -67,6 +67,14 @@ config QFMT_V2
> >  	  also supports 64-bit inode and block quota limits. If you need this
> >  	  functionality say Y here.
> >  
> > +config QFMT_MEM
> > +	tristate "Quota in-memory format support "
> > +	depends on QUOTA
> > +	help
> > +	  This config option enables kernel support for in-memory quota
> > +	  format support. Useful to support quota on file system without
> > +	  permanent storage. If you need this functionality say Y here.
> > +
> >  config QUOTACTL
> >  	bool
> >  	default n
> > diff --git a/fs/quota/Makefile b/fs/quota/Makefile
> > index 9160639daffa..935be3f7b731 100644
> > --- a/fs/quota/Makefile
> > +++ b/fs/quota/Makefile
> > @@ -5,3 +5,4 @@ obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
> >  obj-$(CONFIG_QUOTA_TREE)	+= quota_tree.o
> >  obj-$(CONFIG_QUOTACTL)		+= quota.o kqid.o
> >  obj-$(CONFIG_QUOTA_NETLINK_INTERFACE)	+= netlink.o
> > +obj-$(CONFIG_QFMT_MEM)		+= quota_mem.o
> > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> > index 0427b44bfee5..f1a7a03632a2 100644
> > --- a/fs/quota/dquot.c
> > +++ b/fs/quota/dquot.c
> > @@ -736,6 +736,9 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  	spin_lock(&dq_list_lock);
> >  	while (!list_empty(&free_dquots) && sc->nr_to_scan) {
> >  		dquot = list_first_entry(&free_dquots, struct dquot, dq_free);
> > +		if (test_bit(DQ_NO_SHRINK_B, &dquot->dq_flags) &&
> > +		    !test_bit(DQ_FAKE_B, &dquot->dq_flags))
> > +			continue;
> >  		remove_dquot_hash(dquot);
> >  		remove_free_dquot(dquot);
> >  		remove_inuse(dquot);
> > diff --git a/fs/quota/quota_mem.c b/fs/quota/quota_mem.c
> > new file mode 100644
> > index 000000000000..7d5e82122143
> > --- /dev/null
> > +++ b/fs/quota/quota_mem.c
> > @@ -0,0 +1,260 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * In memory quota format relies on quota infrastructure to store dquot
> > + * information for us. While conventional quota formats for file systems
> > + * with persistent storage can load quota information into dquot from the
> > + * storage on-demand and hence quota dquot shrinker can free any dquot
> > + * that is not currently being used, it must be avoided here. Otherwise we
> > + * can lose valuable information, user provided limits, because there is
> > + * no persistent storage to load the information from afterwards.
> > + *
> > + * One information that in-memory quota format needs to keep track of is
> > + * a sorted list of ids for each quota type. This is done by utilizing
> > + * an rb tree which root is stored in mem_dqinfo->dqi_priv for each quota
> > + * type.
> > + *
> > + * This format can be used to support quota on file system without persistent
> > + * storage such as tmpfs.
> > + */
> > +#include <linux/errno.h>
> > +#include <linux/fs.h>
> > +#include <linux/mount.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/rbtree.h>
> > +
> > +#include <linux/quotaops.h>
> > +#include <linux/quota.h>
> > +
> > +MODULE_AUTHOR("Lukas Czerner");
> > +MODULE_DESCRIPTION("Quota in-memory format support");
> > +MODULE_LICENSE("GPL");
> > +
> > +/*
> > + * The following constants define the amount of time given a user
> > + * before the soft limits are treated as hard limits (usually resulting
> > + * in an allocation failure). The timer is started when the user crosses
> > + * their soft limit, it is reset when they go below their soft limit.
> > + */
> > +#define MAX_IQ_TIME  604800	/* (7*24*60*60) 1 week */
> > +#define MAX_DQ_TIME  604800	/* (7*24*60*60) 1 week */
> > +
> > +struct quota_id {
> > +	struct rb_node	node;
> > +	qid_t		id;
> > +};
> > +
> > +static int mem_check_quota_file(struct super_block *sb, int type)
> > +{
> > +	/* There is no real quota file, nothing to do */
> > +	return 1;
> > +}
> > +
> > +/*
> > + * There is no real quota file. Just allocate rb_root for quota ids and
> > + * set limits
> > + */
> > +static int mem_read_file_info(struct super_block *sb, int type)
> > +{
> > +	struct quota_info *dqopt = sb_dqopt(sb);
> > +	struct mem_dqinfo *info = &dqopt->info[type];
> > +	int ret = 0;
> > +
> > +	down_read(&dqopt->dqio_sem);
> > +	if (info->dqi_fmt_id != QFMT_MEM_ONLY) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	info->dqi_priv = kzalloc(sizeof(struct rb_root), GFP_NOFS);
> > +	if (!info->dqi_priv) {
> > +		ret = -ENOMEM;
> > +		goto out_unlock;
> > +	}
> > +
> > +	/*
> > +	 * Used space is stored as unsigned 64-bit value in bytes but
> > +	 * quota core supports only signed 64-bit values so use that
> > +	 * as a limit
> > +	 */
> > +	info->dqi_max_spc_limit = 0x7fffffffffffffffLL; /* 2^63-1 */
> > +	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
> > +
> > +	info->dqi_bgrace = MAX_DQ_TIME;
> > +	info->dqi_igrace = MAX_IQ_TIME;
> > +	info->dqi_flags = 0;
> > +
> > +out_unlock:
> > +	up_read(&dqopt->dqio_sem);
> > +	return ret;
> > +}
> > +
> > +static int mem_write_file_info(struct super_block *sb, int type)
> > +{
> > +	/* There is no real quota file, nothing to do */
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Free all the quota_id entries in the rb tree and rb_root.
> > + */
> > +static int mem_free_file_info(struct super_block *sb, int type)
> > +{
> > +	struct mem_dqinfo *info = &sb_dqopt(sb)->info[type];
> > +	struct rb_root *root = info->dqi_priv;
> > +	struct quota_id *entry;
> > +	struct rb_node *node;
> > +
> > +	info->dqi_priv = NULL;
> > +	node = rb_first(root);
> > +	while (node) {
> > +		entry = rb_entry(node, struct quota_id, node);
> > +		node = rb_next(&entry->node);
> > +
> > +		rb_erase(&entry->node, root);
> > +		kfree(entry);
> > +	}
> > +
> > +	kfree(root);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * There is no real quota file, nothing to read. Just insert the id in
> > + * the rb tree.
> > + */
> > +static int mem_read_dquot(struct dquot *dquot)
> > +{
> > +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > +	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> > +	struct rb_node *parent = NULL, *new_node = NULL;
> > +	struct quota_id *new_entry, *entry;
> > +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> 
> Hey Lukas,
> 
> tmpfs instances can be mounted inside of mount namespaces owned by user
> namespaces as is the case in unprivileged containers. An easy example is:
> 
> unshare --mount --user --map-root
> mount -t tmpfs tmpfs /mnt
> 
> This tmpfs instances will be mounted with sb->s_user_ns set to the
> userns just created during the unshare call and not to init_user_ns. So
> this means that the filesystem idmapping isn't a 1:1 mapping. This needs
> to be taken into account:
> 
> qid_t id = from_kqid(sb->s_user_ns, dquot->dq_id);
> 
> similar below.
> 
> But dquot_load_quota_sb() which you use in a later patch is restricted
> to the init_user_ns which means that your patch as it stands is only
> useable for tmpfs instances mounted in the init_user_ns.
> 
> If that's intentional then the code above is probably fine but if it's
> not then you need preliminary patches to support quotas from filesystems
> mountable in non-initial user namespaces.
> 
> Enabling this shouldn't be a big deal as it mostly involves updating
> callsites to account for sb->s_user_ns when reading and writing quotas.
> I've looked at that a while ago but there was no filesystem with quota
> support that was also mountable in a user namespaces. Idmapped mounts
> are already taken care of.
> 

Hi Christian,

that's a good point, thank you for bringing that to my attention I
didn't think of that at all. I'll have to think about whether it makes
sense to enable it outside init_user_ns as well. Can't think of why not
atm.

Thanks!
-Lukas

