Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452A3638657
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKYJbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYJbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:31:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D224BFC
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669368619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24Z7En0xfg8G2ELZp5SaTrXiZJYh62zfumT0VIZ8vB0=;
        b=I83reglTtXbun+8P1qkOitvOGUCDfhBaumwflHq9JQnxFoIn8xneXoGoQyBEyameG9N+rB
        0+pP839vWHRRbNFntQ+n+g6dur8aPC912F0u93ZuX7+sAaQ37KPvoXtrqIifzB1Js77ND5
        6ZTNxoIkQaWJyWtq/cBD6yVRzcVsILc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-5DcVCENbPzqTEz0Co3nOMA-1; Fri, 25 Nov 2022 04:30:14 -0500
X-MC-Unique: 5DcVCENbPzqTEz0Co3nOMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12AC61C0512B;
        Fri, 25 Nov 2022 09:30:14 +0000 (UTC)
Received: from fedora (ovpn-193-67.brq.redhat.com [10.40.193.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A93DF111F3C1;
        Fri, 25 Nov 2022 09:30:12 +0000 (UTC)
Date:   Fri, 25 Nov 2022 10:30:10 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <20221125093010.usb5ampqpthe5wae@fedora>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <20221123170739.sugph5ixr7m3ejk6@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123170739.sugph5ixr7m3ejk6@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 06:07:39PM +0100, Jan Kara wrote:
> On Mon 21-11-22 15:28:52, Lukas Czerner wrote:
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
> 
> I was thinking about this somewhat and sketching some code on my computer
> to make things even simpler. See suggestions below.

Thanks Honzo.

> 
> > diff --git a/fs/quota/Makefile b/fs/quota/Makefile
> > index 9160639daffa..935be3f7b731 100644
> > --- a/fs/quota/Makefile
> > +++ b/fs/quota/Makefile
> > @@ -5,3 +5,4 @@ obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
> >  obj-$(CONFIG_QUOTA_TREE)	+= quota_tree.o
> >  obj-$(CONFIG_QUOTACTL)		+= quota.o kqid.o
> >  obj-$(CONFIG_QUOTA_NETLINK_INTERFACE)	+= netlink.o
> > +obj-$(CONFIG_QFMT_MEM)		+= quota_mem.o
> 
> So I wouldn't go for new generic quota format. Instead I'd define &
> register private quota format in mm/shmem.c like:
> 
> static struct quota_format_type shmem_quota_format = {
>         .qf_fmt_id      = QFMT_SHMEM,
>         .qf_ops         = &shmem_quota_format_ops,
>         .qf_owner       = THIS_MODULE
> };
> 
> OCFS2 already does the very same thing so you can take some inspiration
> from it. Also all the ops will be private to shmem.

Ok.

> 
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
> 
> I'd leave dquot reclaim alone. See below how to avoid loosing usage
> information / limits.

Yes, if the idea is to keep the version of the limits per id in shmem.c
then this won't be needed.

> 
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
> 
> These would then become shmem private defaults.
> 
> > +struct quota_id {
> > +	struct rb_node	node;
> > +	qid_t		id;
> > +};
> 
> Instead of this I'd define:
> 
> struct shmem_dquot {
>         struct rb_node node;
>         qid_t id;
> 	qsize_t bhardlimit;
> 	qsize_t bsoftlimit;
> 	qsize_t ihardlimit;
> 	qsize_t isoftlimit;
> };
> 
> It would be kept in rbtree like you do with quota_id but it will be also
> used as ultimate "persistent" storage of quota information when dquot gets
> reclaimed. We don't need to store grace times or usage information because
> if there is non-zero usage, dquot is referenced from the inode and thus
> cannot be reclaimed.

Ok, this approach will duplicate the limits, but has advantage of having
much smaller footprint than entire dquot so in case we don't have any
usage in dquot we can safely reclaim it if needed without loosing user
provided limits. Probably a worthwhile trade-off.

Or perhaps we can eliminate the duplicity when we store it in the tree on
->destroy_dquot() and free it after we load the limits into dquot on
->acquire_dquo().

> 
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
> 
> No need for dqio_sem here...
> 
> > +	if (info->dqi_fmt_id != QFMT_MEM_ONLY) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> 
> Also this check is not needed.
> 
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
> 
> These should be all ops that are needed for the quota format. So quota
> format ops can be just:
> 
> static const struct quota_format_ops shmem_format_ops = {
>         .check_quota_file       = shmem_check_quota_file,
>         .read_file_info         = shmem_read_file_info,
>         .write_file_info        = shmem_write_file_info,
>         .free_file_info         = shmem_free_file_info,
> };
> 
> We deal with remaining operations by diverting quota callbacks earlier in
> filesystem hooks like:
> 
> static const struct dquot_operations shmem_quota_operations = {
> 	.acquire_dquot		= shmem_acquire_dquot,
> 	..release_dquot		= shmem_release_dquot,
> 	.alloc_dquot		= dquot_alloc,
> 	.destroy_dquot		= dquot_destroy,
> 	.write_info		= <do nothing>,
> 	.mark_dirty		= <do nothing>,
> 	.get_next_id		= shmem_get_next_id,
> };
> 
> Now shmem_get_next_id() will basically do what you do in mem_get_next_id()
> just you need to wrap it in sb_has_quota_active() check as
> dquot_get_next_id() does.
> 
> shmem_acquire_dquot() will do what you do in mem_read_dquot(), just if we
> find the id in the rbtree, we copy limits into the dquot structure.
> 
> shmem_release_dquot() will just copy current limits to the structure in the
> rbtree. It can also verify there's no usage. It can also just delete the
> structure from the rbtree if the limits match the default ones.
> 
> And that should be it.

Makes sense. Thanks for the suggestions. I'll work on v3.

-Lukas

> 
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
> > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > +	int ret = 0;
> > +
> > +	down_write(&dqopt->dqio_sem);
> > +
> > +	while (*n) {
> > +		parent = *n;
> > +		entry = rb_entry(parent, struct quota_id, node);
> > +
> > +		if (id < entry->id)
> > +			n = &(*n)->rb_left;
> > +		else if (id > entry->id)
> > +			n = &(*n)->rb_right;
> > +		else
> > +			goto out_unlock;
> > +	}
> > +
> > +	new_entry = kmalloc(sizeof(struct quota_id), GFP_NOFS);
> > +	if (!new_entry) {
> > +		ret = -ENOMEM;
> > +		goto out_unlock;
> > +	}
> > +
> > +	new_entry->id = id;
> > +	new_node = &new_entry->node;
> > +	rb_link_node(new_node, parent, n);
> > +	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
> > +	dquot->dq_off = 1;
> > +	/*
> > +	 * Make sure dquot is never released by a shrinker because we
> > +	 * rely on quota infrastructure to store mem_dqblk in dquot.
> > +	 */
> > +	set_bit(DQ_NO_SHRINK_B, &dquot->dq_flags);
> > +	set_bit(DQ_FAKE_B, &dquot->dq_flags);
> > +
> > +out_unlock:
> > +	up_write(&dqopt->dqio_sem);
> > +	return ret;
> > +}
> > +
> > +static int mem_write_dquot(struct dquot *dquot)
> > +{
> > +	/* There is no real quota file, nothing to do */
> > +	return 0;
> > +}
> > +
> ...
> 
> > +static int mem_get_next_id(struct super_block *sb, struct kqid *qid)
> > +{
> > +	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
> > +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> > +	qid_t id = from_kqid(&init_user_ns, *qid);
> > +	struct quota_info *dqopt = sb_dqopt(sb);
> > +	struct quota_id *entry = NULL;
> > +	int ret = 0;
> > +
> > +	down_read(&dqopt->dqio_sem);
> > +	while (node) {
> > +		entry = rb_entry(node, struct quota_id, node);
> > +
> > +		if (id < entry->id)
> > +			node = node->rb_left;
> > +		else if (id > entry->id)
> > +			node = node->rb_right;
> > +		else
> > +			goto got_next_id;
> > +	}
> > +
> > +	if (!entry) {
> > +		ret = -ENOENT;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (id > entry->id) {
> > +		node = rb_next(&entry->node);
> > +		if (!node) {
> > +			ret = -ENOENT;
> > +			goto out_unlock;
> > +		}
> > +		entry = rb_entry(node, struct quota_id, node);
> > +	}
> > +
> > +got_next_id:
> > +	*qid = make_kqid(&init_user_ns, qid->type, entry->id);
> > +out_unlock:
> > +	up_read(&dqopt->dqio_sem);
> > +	return ret;
> > +}
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

