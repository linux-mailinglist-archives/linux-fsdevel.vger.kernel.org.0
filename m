Return-Path: <linux-fsdevel+bounces-78421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD76CXiLn2nYcgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:53:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D398819F24A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D27E430683A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180803859E4;
	Wed, 25 Feb 2026 23:52:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03F330327;
	Wed, 25 Feb 2026 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063535; cv=none; b=hOVhXWyIBOGEtEq3UQvd6Vgy5SZr4dBhe6kxElg8Q5t/QVXpAnh7Ff670mPCkvVluYfs/7PW0XVGhlP8fVxj8HEENjNxtBSBuEMHMul/R1sOwBWfy9rGLpOjqkNFX9SLC0K1tWPo0KpwfuOyAQPYqMVwY9kdbPuAGxV1COduGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063535; c=relaxed/simple;
	bh=YcVFYGLFY2wKjuQi7G6zXpmaGF6XkHbsrhyoNWNJjOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB5oK9V0n/oCA/jHoAb3a/psetpiH7qwQtr1YCkG98DjZi9n8j0iR40TIsPe8J4qmmQYHocPrP7sC8Ps4tL2TOynE+DqJJmeDYZMxoKfnbcP1AiBFdb6MQKec7MXT9Rt8AcZlP2JtZZ1+21Yo+t+74sr2HzAcvLvPrV6/PwU4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A972B1A02C4;
	Wed, 25 Feb 2026 23:52:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf18.hostedemail.com (Postfix) with ESMTPA id 2A0DF2E;
	Wed, 25 Feb 2026 23:51:53 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:51:51 -0600
From: John Groves <John@groves.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 14/19] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <aZ-K_EwN4QR904TX@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223316.92580-1-john@jagalactic.com>
 <0100019bd33dd1f9-3e016d01-fe3b-4be0-a8d0-f566cd5e2c07-000000@email.amazonses.com>
 <80f4b014-207c-4a6d-89f3-9e49831dd691@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f4b014-207c-4a6d-89f3-9e49831dd691@intel.com>
X-Stat-Signature: wt9h6pmrcegohn1zunzhj4cp9x5zpdh1
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1/iTPeKRbORXYILIHsOhzLG+RbGZ2CU8rM=
X-HE-Tag: 1772063513-610229
X-HE-Meta: U2FsdGVkX1+fZxDP2tefbBqPEAkXzXb48jQ2oqLzMLQyrB5Fg8ij44wFvaUKzq+5Y0NRYxWEQwoVUclFUqdynD1u8Ee4M+vIvzvmL7pVIQPbTv8luB7zZ5A9uyqCuoYMYXs+2wuTSNs5ZrGnF/7KenH5YPEtwAhQGzAGHIs95ftKNYUjojemnMHh5VLaK/lFv62GUyJuD06Hot/E6KD5fFVp8+eVjGe3g3YoQh6WLFnrEBoYP+NjcTdzVA0FqPM3pt8vOfsPKJ3a19ECxBfl9BhZXwGxePTvH71jGt64fhHURh+E8M6FIE9SuG6BfoN33nUkQRQGAqoqVwtROS54ewb1F7Z6JYVDl5opegFv1vFQHBWdL9TqH9lD1JtXcug7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jagalactic.com,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78421-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[groves.net];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John@groves.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,groves.net:mid,groves.net:email]
X-Rspamd-Queue-Id: D398819F24A
X-Rspamd-Action: no action

On 26/02/19 11:51AM, Dave Jiang wrote:
> 
> 
> On 1/18/26 3:33 PM, John Groves wrote:
> > From: John Groves <john@groves.net>
> > 
> > - The new GET_DAXDEV message/response is added
> > - The famfs.c:famfs_teardown() function is added as a primary teardown
> >   function for famfs.
> > - The command it triggered by the update_daxdev_table() call, if there
> >   are any daxdevs in the subject fmap that are not represented in the
> >   daxdev_table yet.
> > - fs/namei.c: export may_open_dev()
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/famfs.c           | 230 +++++++++++++++++++++++++++++++++++++-
> >  fs/fuse/famfs_kfmap.h     |  26 +++++
> >  fs/fuse/fuse_i.h          |  19 ++++
> >  fs/fuse/inode.c           |   7 +-
> >  fs/namei.c                |   1 +
> >  include/uapi/linux/fuse.h |  20 ++++
> >  6 files changed, 301 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index a9728e11f1dd..7aa2eb2e99bf 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> > @@ -21,6 +21,231 @@
> >  #include "famfs_kfmap.h"
> >  #include "fuse_i.h"
> >  
> > +/*
> > + * famfs_teardown()
> > + *
> > + * Deallocate famfs metadata for a fuse_conn
> > + */
> > +void
> > +famfs_teardown(struct fuse_conn *fc)
> > +{
> > +	struct famfs_dax_devlist *devlist = fc->dax_devlist;
> > +	int i;
> > +
> > +	fc->dax_devlist = NULL;
> > +
> > +	if (!devlist)
> > +		return;
> > +
> > +	if (!devlist->devlist)
> > +		goto out;
> 
> I think if you declare devlist with __free(), you can just return instead of having a goto.
> 
> DJ

Nice...done.

John


