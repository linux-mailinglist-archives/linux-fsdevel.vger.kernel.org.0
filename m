Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC353F6FF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 09:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKI6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 03:58:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39877 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKI6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:58:02 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iU5WB-0006td-AQ; Mon, 11 Nov 2019 09:57:51 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iU5W5-0003uA-PV; Mon, 11 Nov 2019 09:57:45 +0100
Date:   Mon, 11 Nov 2019 09:57:45 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Dongsheng Yang <yangds.fnst@cn.fujitsu.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] ubifs: Add quota support
Message-ID: <20191111085745.t6qbckcxt6byaoxq@pengutronix.de>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
 <20191106091537.32480-8-s.hauer@pengutronix.de>
 <20191106101428.GD16085@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106101428.GD16085@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:34 up 126 days, 14:59, 123 users,  load average: 0.12, 0.11,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Wed, Nov 06, 2019 at 11:14:28AM +0100, Jan Kara wrote:
> > +/**
> > + * ubifs_dqblk_find_next - find the next qid
> > + * @c: UBIFS file-system description object
> > + * @qid: The qid to look for
> > + *
> > + * Find the next dqblk entry with a qid that is bigger or equally big than the
> > + * given qid. Returns the next dqblk entry if found or NULL if no dqblk exists
> > + * with a qid that is at least equally big.
> > + */
> > +static struct ubifs_dqblk *ubifs_dqblk_find_next(struct ubifs_info *c,
> > +						 struct kqid qid)
> > +{
> > +	struct rb_node *node = c->dqblk_tree[qid.type].rb_node;
> > +	struct ubifs_dqblk *next = NULL;
> > +
> > +	while (node) {
> > +		struct ubifs_dqblk *ud = rb_entry(node, struct ubifs_dqblk, rb);
> > +
> > +		if (qid_eq(qid, ud->kqid))
> > +			return ud;
> > +
> > +		if (qid_lt(qid, ud->kqid)) {
> > +			if (!next || qid_lt(ud->kqid, next->kqid))
> > +				next = ud;
> > +
> > +			node = node->rb_left;
> > +		} else {
> > +			node = node->rb_right;
> > +		}
> > +	}
> > +
> > +	return next;
> > +}
> 
> Why not use rb_next() here? It should do what you need, shouldn't it?

I could use rb_next(), but it defeats the purpose of a tree to iterate
over the whole tree to find an entry. If I wanted that I would have used
a list.

> 
> 
> > @@ -435,6 +438,9 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
> >  	else if (c->mount_opts.chk_data_crc == 1)
> >  		seq_puts(s, ",no_chk_data_crc");
> >  
> > +	if (c->quota_enable)
> > +		seq_puts(s, ",quota");
> > +
> 
> I'd expect here to see 'usrquota', 'grpquota', 'prjquota' etc. to match
> mount options user has used.

Ok, will fix in the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
