Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC123F8BD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 10:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLJbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 04:31:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:50038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfKLJbr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:31:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2110B3B7;
        Tue, 12 Nov 2019 09:31:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DBBE1E47E5; Tue, 12 Nov 2019 10:31:44 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:31:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] ubifs: Add quota support
Message-ID: <20191112093144.GB1241@quack2.suse.cz>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
 <20191106091537.32480-8-s.hauer@pengutronix.de>
 <20191106101428.GD16085@quack2.suse.cz>
 <20191111085745.t6qbckcxt6byaoxq@pengutronix.de>
 <20191111163446.GF13307@quack2.suse.cz>
 <20191112085941.dg2wchto7iaczarr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112085941.dg2wchto7iaczarr@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-11-19 09:59:41, Sascha Hauer wrote:
> On Mon, Nov 11, 2019 at 05:34:46PM +0100, Jan Kara wrote:
> > Hi Sascha!
> > 
> > On Mon 11-11-19 09:57:45, Sascha Hauer wrote:
> > > On Wed, Nov 06, 2019 at 11:14:28AM +0100, Jan Kara wrote:
> > > > > +/**
> > > > > + * ubifs_dqblk_find_next - find the next qid
> > > > > + * @c: UBIFS file-system description object
> > > > > + * @qid: The qid to look for
> > > > > + *
> > > > > + * Find the next dqblk entry with a qid that is bigger or equally big than the
> > > > > + * given qid. Returns the next dqblk entry if found or NULL if no dqblk exists
> > > > > + * with a qid that is at least equally big.
> > > > > + */
> > > > > +static struct ubifs_dqblk *ubifs_dqblk_find_next(struct ubifs_info *c,
> > > > > +						 struct kqid qid)
> > > > > +{
> > > > > +	struct rb_node *node = c->dqblk_tree[qid.type].rb_node;
> > > > > +	struct ubifs_dqblk *next = NULL;
> > > > > +
> > > > > +	while (node) {
> > > > > +		struct ubifs_dqblk *ud = rb_entry(node, struct ubifs_dqblk, rb);
> > > > > +
> > > > > +		if (qid_eq(qid, ud->kqid))
> > > > > +			return ud;
> > > > > +
> > > > > +		if (qid_lt(qid, ud->kqid)) {
> > > > > +			if (!next || qid_lt(ud->kqid, next->kqid))
> > 			^^^
> > This condition looks superfluous as it should be always true. The last node
> > where you went left should be the least greater node if you didn't find the
> > exact match...
> 
> You are right. I can't say why I thought this is necessary when I wrote
> this.
> 
> > 
> > > > > +				next = ud;
> > > > > +
> > > > > +			node = node->rb_left;
> > > > > +		} else {
> > > > > +			node = node->rb_right;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return next;
> > > > > +}
> > > > 
> > > > Why not use rb_next() here? It should do what you need, shouldn't it?
> > > 
> > > I could use rb_next(), but it defeats the purpose of a tree to iterate
> > > over the whole tree to find an entry. If I wanted that I would have used
> > > a list.
> > 
> > I wasn't quite clear in my suggestion and now that I look at it it was
> > actually misleading. I'm sorry for that. So a second try :):
> > 
> > You have ubifs_dqblk_find() and ubifs_dqblk_find_next() doing very similar
> > rbtree traversal. I think you could remove that duplication by using
> > ubifs_dqblk_find_next() from ubifs_dqblk_find()?
> 
> Ok, with this the two functions can be simplified to:
> 
> /**
>  * ubifs_dqblk_find_next - find the next qid
>  * @c: UBIFS file-system description object
>  * @qid: The qid to look for
>  *
>  * Find the next dqblk entry with a qid that is bigger or equally big than the
>  * given qid. Returns the next dqblk entry if found or NULL if no dqblk exists
>  * with a qid that is at least equally big.
>  */
> static struct ubifs_dqblk *ubifs_dqblk_find_next(struct ubifs_info *c,
> 						 struct kqid qid)
> {
> 	struct rb_node *node = c->dqblk_tree[qid.type].rb_node;
> 	struct ubifs_dqblk *next = NULL;
> 
> 	while (node) {
> 		struct ubifs_dqblk *ud = rb_entry(node, struct ubifs_dqblk, rb);
> 
> 		if (qid_eq(qid, ud->kqid))
> 			return ud;
> 
> 		if (qid_lt(qid, ud->kqid)) {
> 			next = ud;
> 			node = node->rb_left;
> 		} else {
> 			node = node->rb_right;
> 		}
> 	}
> 
> 	return next;
> }
> 
> /**
>  * ubifs_dqblk_find - find qid in tree
>  * @c: UBIFS file-system description object
>  * @qid: The qid to look for
>  *
>  * This walks the dqblk tree and searches a given qid. Returns the dqblk entry
>  * when found or NULL otherwise.
>  */
> static struct ubifs_dqblk *ubifs_dqblk_find(struct ubifs_info *c,
> 					    struct kqid qid)
> {
> 	struct ubifs_dqblk *next = NULL;
> 
> 	next = ubifs_dqblk_find_next(c, qid);
> 
> 	if (next && qid_eq(qid, next->kqid))
> 		return next;
> 
> 	return NULL;
> }

Yep, look good to me. Thanks!

> If this looks good now I'll integrate it for the next round. I'll delay
> sending a new version until Richard has had a look into this series.

Sure.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
