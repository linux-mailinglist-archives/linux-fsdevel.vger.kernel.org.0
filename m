Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A858EF78DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKQeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 11:34:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:59414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfKKQeu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:34:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42899B157;
        Mon, 11 Nov 2019 16:34:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF7D21E47E5; Mon, 11 Nov 2019 17:34:46 +0100 (CET)
Date:   Mon, 11 Nov 2019 17:34:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] ubifs: Add quota support
Message-ID: <20191111163446.GF13307@quack2.suse.cz>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
 <20191106091537.32480-8-s.hauer@pengutronix.de>
 <20191106101428.GD16085@quack2.suse.cz>
 <20191111085745.t6qbckcxt6byaoxq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111085745.t6qbckcxt6byaoxq@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sascha!

On Mon 11-11-19 09:57:45, Sascha Hauer wrote:
> On Wed, Nov 06, 2019 at 11:14:28AM +0100, Jan Kara wrote:
> > > +/**
> > > + * ubifs_dqblk_find_next - find the next qid
> > > + * @c: UBIFS file-system description object
> > > + * @qid: The qid to look for
> > > + *
> > > + * Find the next dqblk entry with a qid that is bigger or equally big than the
> > > + * given qid. Returns the next dqblk entry if found or NULL if no dqblk exists
> > > + * with a qid that is at least equally big.
> > > + */
> > > +static struct ubifs_dqblk *ubifs_dqblk_find_next(struct ubifs_info *c,
> > > +						 struct kqid qid)
> > > +{
> > > +	struct rb_node *node = c->dqblk_tree[qid.type].rb_node;
> > > +	struct ubifs_dqblk *next = NULL;
> > > +
> > > +	while (node) {
> > > +		struct ubifs_dqblk *ud = rb_entry(node, struct ubifs_dqblk, rb);
> > > +
> > > +		if (qid_eq(qid, ud->kqid))
> > > +			return ud;
> > > +
> > > +		if (qid_lt(qid, ud->kqid)) {
> > > +			if (!next || qid_lt(ud->kqid, next->kqid))
			^^^
This condition looks superfluous as it should be always true. The last node
where you went left should be the least greater node if you didn't find the
exact match...

> > > +				next = ud;
> > > +
> > > +			node = node->rb_left;
> > > +		} else {
> > > +			node = node->rb_right;
> > > +		}
> > > +	}
> > > +
> > > +	return next;
> > > +}
> > 
> > Why not use rb_next() here? It should do what you need, shouldn't it?
> 
> I could use rb_next(), but it defeats the purpose of a tree to iterate
> over the whole tree to find an entry. If I wanted that I would have used
> a list.

I wasn't quite clear in my suggestion and now that I look at it it was
actually misleading. I'm sorry for that. So a second try :):

You have ubifs_dqblk_find() and ubifs_dqblk_find_next() doing very similar
rbtree traversal. I think you could remove that duplication by using
ubifs_dqblk_find_next() from ubifs_dqblk_find()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
