Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C680EB6A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfJaSLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 14:11:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729127AbfJaSLd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:11:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E4D6B28C;
        Thu, 31 Oct 2019 18:11:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A2E791E482D; Thu, 31 Oct 2019 19:11:30 +0100 (CET)
Date:   Thu, 31 Oct 2019 19:11:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Monakhov <dmonakhov@openvz.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jack@suse.cz, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH 2/2] fs/quota: Check that quota is not dirty before
 release
Message-ID: <20191031181130.GH13321@quack2.suse.cz>
References: <20191031103920.3919-1-dmonakhov@openvz.org>
 <20191031103920.3919-2-dmonakhov@openvz.org>
 <20191031180033.GF13321@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031180033.GF13321@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 31-10-19 19:00:33, Jan Kara wrote:
> On Thu 31-10-19 10:39:20, Dmitry Monakhov wrote:
> > From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> > 
> > There is a race window where quota was redirted once we drop dq_list_lock inside dqput(),
> > but before we grab dquot->dq_lock inside dquot_release()
> > 
> > TASK1                                                       TASK2 (chowner)
> > ->dqput()
> >   we_slept:
> >     spin_lock(&dq_list_lock)
> >     if (dquot_dirty(dquot)) {
> >           spin_unlock(&dq_list_lock);
> >           dquot->dq_sb->dq_op->write_dquot(dquot);
> >           goto we_slept
> >     if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
> >           spin_unlock(&dq_list_lock);
> >           dquot->dq_sb->dq_op->release_dquot(dquot);
> >                                                             dqget()
> > 							    mark_dquot_dirty()
> > 							    dqput()
> >           goto we_slept;
> >         }
> > So dquot dirty quota will be released by TASK1, but on next we_sleept loop
> > we detect this and call ->write_dquot() for it.
> > XFSTEST: https://github.com/dmonakhov/xfstests/commit/440a80d4cbb39e9234df4d7240aee1d551c36107
> 
> Yeah, good catch. Both patches look good to me. I've added them to my tree.

And forgot to add: Thanks for both patches and also the regression tests! I
really appreciate it!

								Honza


> > Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> > ---
> >  fs/ocfs2/quota_global.c  |  2 +-
> >  fs/quota/dquot.c         |  2 +-
> >  include/linux/quotaops.h | 10 ++++++++++
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
> > index 7a92219..eda8348 100644
> > --- a/fs/ocfs2/quota_global.c
> > +++ b/fs/ocfs2/quota_global.c
> > @@ -728,7 +728,7 @@ static int ocfs2_release_dquot(struct dquot *dquot)
> >  
> >  	mutex_lock(&dquot->dq_lock);
> >  	/* Check whether we are not racing with some other dqget() */
> > -	if (atomic_read(&dquot->dq_count) > 1)
> > +	if (dquot_is_busy(dquot))
> >  		goto out;
> >  	/* Running from downconvert thread? Postpone quota processing to wq */
> >  	if (current == osb->dc_task) {
> > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> > index b492b9e..72d24a5 100644
> > --- a/fs/quota/dquot.c
> > +++ b/fs/quota/dquot.c
> > @@ -497,7 +497,7 @@ int dquot_release(struct dquot *dquot)
> >  
> >  	mutex_lock(&dquot->dq_lock);
> >  	/* Check whether we are not racing with some other dqget() */
> > -	if (atomic_read(&dquot->dq_count) > 1)
> > +	if (dquot_is_busy(dquot))
> >  		goto out_dqlock;
> >  	if (dqopt->ops[dquot->dq_id.type]->release_dqblk) {
> >  		ret = dqopt->ops[dquot->dq_id.type]->release_dqblk(dquot);
> > diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> > index 185d948..91e0b76 100644
> > --- a/include/linux/quotaops.h
> > +++ b/include/linux/quotaops.h
> > @@ -54,6 +54,16 @@ static inline struct dquot *dqgrab(struct dquot *dquot)
> >  	atomic_inc(&dquot->dq_count);
> >  	return dquot;
> >  }
> > +
> > +static inline bool dquot_is_busy(struct dquot *dquot)
> > +{
> > +	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
> > +		return true;
> > +	if (atomic_read(&dquot->dq_count) > 1)
> > +		return true;
> > +	return false;
> > +}
> > +
> >  void dqput(struct dquot *dquot);
> >  int dquot_scan_active(struct super_block *sb,
> >  		      int (*fn)(struct dquot *dquot, unsigned long priv),
> > -- 
> > 2.7.4
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
