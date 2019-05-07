Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B6D15724
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 03:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEGBCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 21:02:43 -0400
Received: from fieldses.org ([173.255.197.46]:58610 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfEGBCn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 21:02:43 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A6D24C57; Mon,  6 May 2019 21:02:42 -0400 (EDT)
Date:   Mon, 6 May 2019 21:02:42 -0400
To:     Andrew W Elble <aweits@rit.edu>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, abe@purdue.edu,
        lsof-l@lists.purdue.edu, util-linux@vger.kernel.org,
        jlayton@redhat.com
Subject: Re: [PATCH 09/10] nfsd: expose some more information about NFSv4
 opens
Message-ID: <20190507010242.GB4835@fieldses.org>
References: <1556201060-7947-1-git-send-email-bfields@redhat.com>
 <1556201060-7947-10-git-send-email-bfields@redhat.com>
 <786E0C83-A22D-461A-A9D1-AF7B42018CE9@redhat.com>
 <m2k1f8hmr5.fsf@discipline.rit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k1f8hmr5.fsf@discipline.rit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 11:58:06AM -0400, Andrew W Elble wrote:
> Benjamin Coddington <bcodding@redhat.com> writes:
> 
> > On 25 Apr 2019, at 10:04, J. Bruce Fields wrote:
> >
> >> From: "J. Bruce Fields" <bfields@redhat.com>
> >>
> >> Add open modes, device numbers, inode numbers, and open owners to each
> >> line of nfsd/clients/#/opens.
> >>
> >> Open owners are totally opaque but seem to sometimes have some useful
> >> ascii strings included, so passing through printable ascii characters
> >> and escaping the rest seems useful while still being machine-readable.
> >> ---
> >>  fs/nfsd/nfs4state.c            | 40
> >> ++++++++++++++++++++++++++++------
> >>  fs/nfsd/state.h                |  2 +-
> >>  fs/seq_file.c                  | 17 +++++++++++++++
> >>  include/linux/seq_file.h       |  2 ++
> >>  include/linux/string_helpers.h |  1 +
> >>  lib/string_helpers.c           |  5 +++--
> >>  6 files changed, 57 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >> index 829d1e5440d3..f53621a65e60 100644
> >> --- a/fs/nfsd/nfs4state.c
> >> +++ b/fs/nfsd/nfs4state.c
> >> @@ -42,6 +42,7 @@
> >>  #include <linux/sunrpc/svcauth_gss.h>
> >>  #include <linux/sunrpc/addr.h>
> >>  #include <linux/jhash.h>
> >> +#include <linux/string_helpers.h>
> >>  #include "xdr4.h"
> >>  #include "xdr4cb.h"
> >>  #include "vfs.h"
> >> @@ -2261,16 +2262,41 @@ static void opens_stop(struct seq_file *s,
> >> void *v)
> >>  static int opens_show(struct seq_file *s, void *v)
> >>  {
> >>  	struct nfs4_stid *st = v;
> >> -	struct nfs4_ol_stateid *os;
> >> -	u64 stateid;
> >> +	struct nfs4_ol_stateid *ols;
> >> +	struct nfs4_file *nf;
> >> +	struct file *file;
> >> +	struct inode *inode;
> >> +	struct nfs4_stateowner *oo;
> >> +	unsigned int access, deny;
> >>
> >>  	if (st->sc_type != NFS4_OPEN_STID)
> >>  		return 0; /* XXX: or SEQ_SKIP? */
> >> -	os = openlockstateid(st);
> >> -	/* XXX: get info about file, etc., here */
> >> +	ols = openlockstateid(st);
> >> +	oo = ols->st_stateowner;
> >> +	nf = st->sc_file;
> >> +	file = find_any_file(nf);
> 
> Is there a matching fput() missing somewhere, or did I just not see it...?

Oops, fixed.

> >> +	inode = d_inode(file->f_path.dentry);
> >> +
> >> +	seq_printf(s, STATEID_FMT, STATEID_VAL(&st->sc_stateid));
> >
> > Should we match the byte order printed with what wireshark/tshark sees?
> 
> ^^ +1

Yeah, I agree, I'm changing that to just be a "%16phN", which should
give us what wireshark does.

Thanks for the review!

--b.
