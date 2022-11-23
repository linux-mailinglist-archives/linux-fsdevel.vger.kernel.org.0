Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB1635CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 13:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiKWMdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 07:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiKWMdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DF3DEBA
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669206760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FpFpxeFdsSK6mmxipUFiUgujWvfNh6gCaJcaHB6xtWE=;
        b=cK1F2OMZmzQh38E5rt7K4EznkLKVLcH7L4CyUoBrnksNoow8m4kmPWlgxRCI6zQiiAF/3X
        eIUJwD23m7U/OruBS4CJaqThYPKUK6/ZmJt5cWIl1wQ0CJAd2ks3dVpWQ159sEgzAe7bSS
        FgXdPxp2W5EhPEX0zWu5DO0/nYx+iiA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-ETlCzRTNNDCnkjJzSccZ6w-1; Wed, 23 Nov 2022 07:32:37 -0500
X-MC-Unique: ETlCzRTNNDCnkjJzSccZ6w-1
Received: by mail-qt1-f198.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so16961480qtb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpFpxeFdsSK6mmxipUFiUgujWvfNh6gCaJcaHB6xtWE=;
        b=lRc1Hw5xwHGEFD1NPV7yxF0gSx83zP0ty0zuTcuuaGRrajcHP+TjhrtPlHb4QD0/Iv
         WzrisXEGKqJzqGlDxBkPiW3G3fkv9oGDxjb3yu3V6nn/g00QwLSp2tmDDOgbwzGgn2BF
         rXC4rndF8uV5KY+IL/cfsbL3VM2sCkqGJ1rJpE28ovA9WHxdYXE2EHz9vHPxwFYA5/Oe
         w6qjrG5stIqVtmgtYBzK7RmDnbaz8UTsfLhk7FXS/MVCjGxlLTTcRY3QnOiI1RI+ri6/
         4nIfmFb+W6GK4F4EXuSUyK5qZAzEJPOCqALDq0iIWiOf86NMDSjfzFyPGYPSxj8rfS7n
         YZWQ==
X-Gm-Message-State: ANoB5pmXOWXkkUYNOvNuOkf3GJs9wZ/ylpBpYwT/mOsXHV1L0kIuTMqc
        awVZikKS8tKT5Tir4v3jrvceLngp/YLlNNqPOF2qlSgPNh/Jy/jboO/vKIVO1MxalX4iwN+qPW9
        +FIuqPRQqXwiE6QqyX+RaJfCwTA==
X-Received: by 2002:a37:8807:0:b0:6f9:47f5:8ce9 with SMTP id k7-20020a378807000000b006f947f58ce9mr25009637qkd.578.1669206756288;
        Wed, 23 Nov 2022 04:32:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5yQs3XiB3EC4uyVDW97P+2TjBYGqp7VKR3pJ5EQI6aHlgpVf3sl0QWxL+lWZzls21kJHtBSg==
X-Received: by 2002:a37:8807:0:b0:6f9:47f5:8ce9 with SMTP id k7-20020a378807000000b006f947f58ce9mr25009607qkd.578.1669206755929;
        Wed, 23 Nov 2022 04:32:35 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm9565800qtg.77.2022.11.23.04.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:32:35 -0800 (PST)
Date:   Wed, 23 Nov 2022 07:32:41 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <Y34S6bBPFd1STX6V@bfoster>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <Y3u54l2CVapQmK/w@magnolia>
 <20221122090448.x2vouglhpnh75exh@fedora>
 <Y3zpjRtbGXMcXSiK@bfoster>
 <20221123095227.ilii5htnlh3o6wil@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123095227.ilii5htnlh3o6wil@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:52:27AM +0100, Lukas Czerner wrote:
> On Tue, Nov 22, 2022 at 10:23:57AM -0500, Brian Foster wrote:
> > On Tue, Nov 22, 2022 at 10:04:48AM +0100, Lukas Czerner wrote:
> > > On Mon, Nov 21, 2022 at 09:48:18AM -0800, Darrick J. Wong wrote:
> > > > On Mon, Nov 21, 2022 at 03:28:52PM +0100, Lukas Czerner wrote:
> > > > > In memory quota format relies on quota infrastructure to store dquot
> > > > > information for us. While conventional quota formats for file systems
> > > > > with persistent storage can load quota information into dquot from the
> > > > > storage on-demand and hence quota dquot shrinker can free any dquot that
> > > > > is not currently being used, it must be avoided here. Otherwise we can
> > > > > lose valuable information, user provided limits, because there is no
> > > > > persistent storage to load the information from afterwards.
> > > > > 
> > > > > One information that in-memory quota format needs to keep track of is a
> > > > > sorted list of ids for each quota type. This is done by utilizing an rb
> > > > > tree which root is stored in mem_dqinfo->dqi_priv for each quota type.
> > > > > 
> > > > > This format can be used to support quota on file system without persistent
> > > > > storage such as tmpfs.
> > > > > 
> > > > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > > > ---
> > > > >  fs/quota/Kconfig           |   8 ++
> > > > >  fs/quota/Makefile          |   1 +
> > > > >  fs/quota/dquot.c           |   3 +
> > > > >  fs/quota/quota_mem.c       | 260 +++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/quota.h      |   7 +-
> > > > >  include/uapi/linux/quota.h |   1 +
> > > > >  6 files changed, 279 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 fs/quota/quota_mem.c
> > > > > 
> > > > > diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> > > > > index b59cd172b5f9..8ea9656ca37b 100644
> > > > > --- a/fs/quota/Kconfig
> > > > > +++ b/fs/quota/Kconfig
> > > > > @@ -67,6 +67,14 @@ config QFMT_V2
> > > > >  	  also supports 64-bit inode and block quota limits. If you need this
> > > > >  	  functionality say Y here.
> > > > >  
> > > > > +config QFMT_MEM
> > > > > +	tristate "Quota in-memory format support "
> > > > > +	depends on QUOTA
> > > > > +	help
> > > > > +	  This config option enables kernel support for in-memory quota
> > > > > +	  format support. Useful to support quota on file system without
> > > > > +	  permanent storage. If you need this functionality say Y here.
> > > > > +
> > > > >  config QUOTACTL
> > > > >  	bool
> > > > >  	default n
> > > > > diff --git a/fs/quota/Makefile b/fs/quota/Makefile
> > > > > index 9160639daffa..935be3f7b731 100644
> > > > > --- a/fs/quota/Makefile
> > > > > +++ b/fs/quota/Makefile
> > > > > @@ -5,3 +5,4 @@ obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
> > > > >  obj-$(CONFIG_QUOTA_TREE)	+= quota_tree.o
> > > > >  obj-$(CONFIG_QUOTACTL)		+= quota.o kqid.o
> > > > >  obj-$(CONFIG_QUOTA_NETLINK_INTERFACE)	+= netlink.o
> > > > > +obj-$(CONFIG_QFMT_MEM)		+= quota_mem.o
> > > > > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> > > > > index 0427b44bfee5..f1a7a03632a2 100644
> > > > > --- a/fs/quota/dquot.c
> > > > > +++ b/fs/quota/dquot.c
> > > > > @@ -736,6 +736,9 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > > >  	spin_lock(&dq_list_lock);
> > > > >  	while (!list_empty(&free_dquots) && sc->nr_to_scan) {
> > > > >  		dquot = list_first_entry(&free_dquots, struct dquot, dq_free);
> > > > > +		if (test_bit(DQ_NO_SHRINK_B, &dquot->dq_flags) &&
> > > > > +		    !test_bit(DQ_FAKE_B, &dquot->dq_flags))
> > > > > +			continue;
> > > > >  		remove_dquot_hash(dquot);
> > > > >  		remove_free_dquot(dquot);
> > > > >  		remove_inuse(dquot);
> > > > > diff --git a/fs/quota/quota_mem.c b/fs/quota/quota_mem.c
> > > > > new file mode 100644
> > > > > index 000000000000..7d5e82122143
> > > > > --- /dev/null
> > > > > +++ b/fs/quota/quota_mem.c
> > > > > @@ -0,0 +1,260 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * In memory quota format relies on quota infrastructure to store dquot
> > > > > + * information for us. While conventional quota formats for file systems
> > > > > + * with persistent storage can load quota information into dquot from the
> > > > > + * storage on-demand and hence quota dquot shrinker can free any dquot
> > > > > + * that is not currently being used, it must be avoided here. Otherwise we
> > > > > + * can lose valuable information, user provided limits, because there is
> > > > > + * no persistent storage to load the information from afterwards.
> > > > 
> > > > Hmm.  dquots can't /ever/ be reclaimed?  struct dquot is ~256 bytes, and
> > > > assuming 32-bit uids, the upper bound on dquot usage is 2^(32+8) bytes
> > > > == 1TB of memory usage?  Once allocated, you'd have to reboot the whole
> > > > machine to get that memory back?
> > > 
> > > Hi Darrick,
> > > 
> > > maybe there are some improvements to the documentation to be made. The
> > > dquots will be freed on unmount as it would normaly. Also only dquots
> > > containing actual user modified limits, so only dquots that are not
> > > DQ_FAKE_B are prevented to be reclaimed by a shrinker see the condition in
> > > dqcache_shrink_scan().
> > > 
> > > > 
> > > > Would it be wise to "persist" dquot contents to a (private) tmpfs file
> > > > to facilitate incore dquot reclaim?  The tmpfs file data can be paged
> > > > out, or even punched if all the dquot records in that page go back to
> > > > default settings.
> > > 
> > > The dquot will be flagged as DQ_FAKE_B once the limits are set to 0. But
> > > when I think about it this pose a problem with the default quota limits
> > > because that would change the limits to the defaults once the dquot is
> > > reclaimed and then allocated again. This can be solved by making a
> > > custom .set_dqblk().
> > > 
> > 
> > Hi Lukas,
> > 
> > I'm a little confused.. does the above mean the dquot limit would have
> > to be explicitly set to 0 by the admin in order to be reclaimed, even
> > though that limit would be initialized to some non-zero value via the
> > mount option? If so, wouldn't we want the ability to reclaim a dquot
> > when the usage counts go down to zero (i.e., so the user/group/whatever
> > for the dquot no longer has any tmpfs inode/block footprint), assuming
> > the limit hasn't also been modified from the initial defaults?
> 
> By creating a custom ->set_dqblk() in shmem we can make sure that the
> dquot is non-reclaimable (set DQ_NO_SHRINK_B) *only* if the limits have
> been set by the user to anything other than the defaults (defaults being
> either 0, or value specified by the mount option). Also
> DQ_NO_SHRINK_B can't be set on ->dqblk_read() and the condition in
> dqcache_shrink_scan() would only test DQ_NO_SHRINK_B. Does it make more
> sense to you?
> 

Ok. Yes, I think I get the general idea. Thanks for the info.

Brian

> This is something I'd have to do for v3. Sorry for the confusion.
> 
> Thanks!
> -Lukas
> 
> > 
> > Brian
> > 
> > > Other than this problem, does this address your concern about dquot
> > > reclaim?
> > > 
> > > Thanks!
> > > -Lukas
> > > 
> > > > 
> > > > --D
> > > > 
> > > > > + *
> > > > > + * One information that in-memory quota format needs to keep track of is
> > > > > + * a sorted list of ids for each quota type. This is done by utilizing
> > > > > + * an rb tree which root is stored in mem_dqinfo->dqi_priv for each quota
> > > > > + * type.
> > > > > + *
> > > > > + * This format can be used to support quota on file system without persistent
> > > > > + * storage such as tmpfs.
> > > > > + */
> > > > > +#include <linux/errno.h>
> > > > > +#include <linux/fs.h>
> > > > > +#include <linux/mount.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/init.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/rbtree.h>
> > > > > +
> > > > > +#include <linux/quotaops.h>
> > > > > +#include <linux/quota.h>
> > > > > +
> > > > > +MODULE_AUTHOR("Lukas Czerner");
> > > > > +MODULE_DESCRIPTION("Quota in-memory format support");
> > > > > +MODULE_LICENSE("GPL");
> > > > > +
> > > > > +/*
> > > > > + * The following constants define the amount of time given a user
> > > > > + * before the soft limits are treated as hard limits (usually resulting
> > > > > + * in an allocation failure). The timer is started when the user crosses
> > > > > + * their soft limit, it is reset when they go below their soft limit.
> > > > > + */
> > > > > +#define MAX_IQ_TIME  604800	/* (7*24*60*60) 1 week */
> > > > > +#define MAX_DQ_TIME  604800	/* (7*24*60*60) 1 week */
> > > > > +
> > > > > +struct quota_id {
> > > > > +	struct rb_node	node;
> > > > > +	qid_t		id;
> > > > > +};
> > > > > +
> > > > > +static int mem_check_quota_file(struct super_block *sb, int type)
> > > > > +{
> > > > > +	/* There is no real quota file, nothing to do */
> > > > > +	return 1;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * There is no real quota file. Just allocate rb_root for quota ids and
> > > > > + * set limits
> > > > > + */
> > > > > +static int mem_read_file_info(struct super_block *sb, int type)
> > > > > +{
> > > > > +	struct quota_info *dqopt = sb_dqopt(sb);
> > > > > +	struct mem_dqinfo *info = &dqopt->info[type];
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	down_read(&dqopt->dqio_sem);
> > > > > +	if (info->dqi_fmt_id != QFMT_MEM_ONLY) {
> > > > > +		ret = -EINVAL;
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	info->dqi_priv = kzalloc(sizeof(struct rb_root), GFP_NOFS);
> > > > > +	if (!info->dqi_priv) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Used space is stored as unsigned 64-bit value in bytes but
> > > > > +	 * quota core supports only signed 64-bit values so use that
> > > > > +	 * as a limit
> > > > > +	 */
> > > > > +	info->dqi_max_spc_limit = 0x7fffffffffffffffLL; /* 2^63-1 */
> > > > > +	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
> > > > > +
> > > > > +	info->dqi_bgrace = MAX_DQ_TIME;
> > > > > +	info->dqi_igrace = MAX_IQ_TIME;
> > > > > +	info->dqi_flags = 0;
> > > > > +
> > > > > +out_unlock:
> > > > > +	up_read(&dqopt->dqio_sem);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int mem_write_file_info(struct super_block *sb, int type)
> > > > > +{
> > > > > +	/* There is no real quota file, nothing to do */
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Free all the quota_id entries in the rb tree and rb_root.
> > > > > + */
> > > > > +static int mem_free_file_info(struct super_block *sb, int type)
> > > > > +{
> > > > > +	struct mem_dqinfo *info = &sb_dqopt(sb)->info[type];
> > > > > +	struct rb_root *root = info->dqi_priv;
> > > > > +	struct quota_id *entry;
> > > > > +	struct rb_node *node;
> > > > > +
> > > > > +	info->dqi_priv = NULL;
> > > > > +	node = rb_first(root);
> > > > > +	while (node) {
> > > > > +		entry = rb_entry(node, struct quota_id, node);
> > > > > +		node = rb_next(&entry->node);
> > > > > +
> > > > > +		rb_erase(&entry->node, root);
> > > > > +		kfree(entry);
> > > > > +	}
> > > > > +
> > > > > +	kfree(root);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * There is no real quota file, nothing to read. Just insert the id in
> > > > > + * the rb tree.
> > > > > + */
> > > > > +static int mem_read_dquot(struct dquot *dquot)
> > > > > +{
> > > > > +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > > > > +	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> > > > > +	struct rb_node *parent = NULL, *new_node = NULL;
> > > > > +	struct quota_id *new_entry, *entry;
> > > > > +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > > > > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	down_write(&dqopt->dqio_sem);
> > > > > +
> > > > > +	while (*n) {
> > > > > +		parent = *n;
> > > > > +		entry = rb_entry(parent, struct quota_id, node);
> > > > > +
> > > > > +		if (id < entry->id)
> > > > > +			n = &(*n)->rb_left;
> > > > > +		else if (id > entry->id)
> > > > > +			n = &(*n)->rb_right;
> > > > > +		else
> > > > > +			goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	new_entry = kmalloc(sizeof(struct quota_id), GFP_NOFS);
> > > > > +	if (!new_entry) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	new_entry->id = id;
> > > > > +	new_node = &new_entry->node;
> > > > > +	rb_link_node(new_node, parent, n);
> > > > > +	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
> > > > > +	dquot->dq_off = 1;
> > > > > +	/*
> > > > > +	 * Make sure dquot is never released by a shrinker because we
> > > > > +	 * rely on quota infrastructure to store mem_dqblk in dquot.
> > > > > +	 */
> > > > > +	set_bit(DQ_NO_SHRINK_B, &dquot->dq_flags);
> > > > > +	set_bit(DQ_FAKE_B, &dquot->dq_flags);
> > > > > +
> > > > > +out_unlock:
> > > > > +	up_write(&dqopt->dqio_sem);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int mem_write_dquot(struct dquot *dquot)
> > > > > +{
> > > > > +	/* There is no real quota file, nothing to do */
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int mem_release_dquot(struct dquot *dquot)
> > > > > +{
> > > > > +	/*
> > > > > +	 * Everything is in memory only, release once we're done with
> > > > > +	 * quota via mem_free_file_info().
> > > > > +	 */
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int mem_get_next_id(struct super_block *sb, struct kqid *qid)
> > > > > +{
> > > > > +	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
> > > > > +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> > > > > +	qid_t id = from_kqid(&init_user_ns, *qid);
> > > > > +	struct quota_info *dqopt = sb_dqopt(sb);
> > > > > +	struct quota_id *entry = NULL;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	down_read(&dqopt->dqio_sem);
> > > > > +	while (node) {
> > > > > +		entry = rb_entry(node, struct quota_id, node);
> > > > > +
> > > > > +		if (id < entry->id)
> > > > > +			node = node->rb_left;
> > > > > +		else if (id > entry->id)
> > > > > +			node = node->rb_right;
> > > > > +		else
> > > > > +			goto got_next_id;
> > > > > +	}
> > > > > +
> > > > > +	if (!entry) {
> > > > > +		ret = -ENOENT;
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	if (id > entry->id) {
> > > > > +		node = rb_next(&entry->node);
> > > > > +		if (!node) {
> > > > > +			ret = -ENOENT;
> > > > > +			goto out_unlock;
> > > > > +		}
> > > > > +		entry = rb_entry(node, struct quota_id, node);
> > > > > +	}
> > > > > +
> > > > > +got_next_id:
> > > > > +	*qid = make_kqid(&init_user_ns, qid->type, entry->id);
> > > > > +out_unlock:
> > > > > +	up_read(&dqopt->dqio_sem);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static const struct quota_format_ops mem_format_ops = {
> > > > > +	.check_quota_file	= mem_check_quota_file,
> > > > > +	.read_file_info		= mem_read_file_info,
> > > > > +	.write_file_info	= mem_write_file_info,
> > > > > +	.free_file_info		= mem_free_file_info,
> > > > > +	.read_dqblk		= mem_read_dquot,
> > > > > +	.commit_dqblk		= mem_write_dquot,
> > > > > +	.release_dqblk		= mem_release_dquot,
> > > > > +	.get_next_id		= mem_get_next_id,
> > > > > +};
> > > > > +
> > > > > +static struct quota_format_type mem_quota_format = {
> > > > > +	.qf_fmt_id	= QFMT_MEM_ONLY,
> > > > > +	.qf_ops		= &mem_format_ops,
> > > > > +	.qf_owner	= THIS_MODULE
> > > > > +};
> > > > > +
> > > > > +static int __init init_mem_quota_format(void)
> > > > > +{
> > > > > +	return register_quota_format(&mem_quota_format);
> > > > > +}
> > > > > +
> > > > > +static void __exit exit_mem_quota_format(void)
> > > > > +{
> > > > > +	unregister_quota_format(&mem_quota_format);
> > > > > +}
> > > > > +
> > > > > +module_init(init_mem_quota_format);
> > > > > +module_exit(exit_mem_quota_format);
> > > > > diff --git a/include/linux/quota.h b/include/linux/quota.h
> > > > > index fd692b4a41d5..4398e05c8b72 100644
> > > > > --- a/include/linux/quota.h
> > > > > +++ b/include/linux/quota.h
> > > > > @@ -285,7 +285,11 @@ static inline void dqstats_dec(unsigned int type)
> > > > >  #define DQ_FAKE_B	3	/* no limits only usage */
> > > > >  #define DQ_READ_B	4	/* dquot was read into memory */
> > > > >  #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
> > > > > -#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
> > > > > +#define DQ_NO_SHRINK_B	6	/* modified dquot (not DQ_FAKE_B) is never to
> > > > > +				 * be released by a shrinker. It should remain
> > > > > +				 * in memory until quotas are being disabled on
> > > > > +				 * unmount. */
> > > > > +#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
> > > > >  				 * for the mask of entries set via SETQUOTA\
> > > > >  				 * quotactl. They are set under dq_data_lock\
> > > > >  				 * and the quota format handling dquot can\
> > > > > @@ -536,6 +540,7 @@ struct quota_module_name {
> > > > >  	{QFMT_VFS_OLD, "quota_v1"},\
> > > > >  	{QFMT_VFS_V0, "quota_v2"},\
> > > > >  	{QFMT_VFS_V1, "quota_v2"},\
> > > > > +	{QFMT_MEM_ONLY, "quota_mem"},\
> > > > >  	{0, NULL}}
> > > > >  
> > > > >  #endif /* _QUOTA_ */
> > > > > diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
> > > > > index f17c9636a859..ee9d2bad00c7 100644
> > > > > --- a/include/uapi/linux/quota.h
> > > > > +++ b/include/uapi/linux/quota.h
> > > > > @@ -77,6 +77,7 @@
> > > > >  #define	QFMT_VFS_V0 2
> > > > >  #define QFMT_OCFS2 3
> > > > >  #define	QFMT_VFS_V1 4
> > > > > +#define	QFMT_MEM_ONLY 5
> > > > >  
> > > > >  /* Size of block in which space limits are passed through the quota
> > > > >   * interface */
> > > > > -- 
> > > > > 2.38.1
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 

