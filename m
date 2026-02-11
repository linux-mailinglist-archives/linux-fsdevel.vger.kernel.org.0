Return-Path: <linux-fsdevel+bounces-76965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGGGwnKjGlktAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 19:27:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F37126DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 19:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64D6E301BA5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB85A352C37;
	Wed, 11 Feb 2026 18:27:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F7313552;
	Wed, 11 Feb 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834431; cv=none; b=Zl3a1wP6W6qLZyOp+x9YJL/HPwQ/z1+4vx8qdZ6KN4WmDG0qr04UR8WsSC/6tzeR1yocOEMUwp2ne7W+cWMUt1jkcXs0yPlJ+zRR9nU4kAy2vklVmBiJMceKcCoDyQs5zwfI7NLkO79ocayQoP5ST5+BtrjhNut0fheLjQYaO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834431; c=relaxed/simple;
	bh=DA75yQkDj/Z2tNiQKbeA1QvuEo25JclknMPaMA/g9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGQuJCq5cLG+rikkW46mZvO80tncFRinJowFnLZ4K7HrlqltWutA2CQvp3L2NiaFyAIrl1lqS7tlZPIB3V8o4CerOiNwWS9l+yo68up0n4Hzr4X1tP1TjsFHGvlXPyToTXnQ+JnZK+Ois/JgjRA8TwhkMw6rkmlBJyoIGFn1kEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 953B559211;
	Wed, 11 Feb 2026 18:26:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf03.hostedemail.com (Postfix) with ESMTPA id DE05260010;
	Wed, 11 Feb 2026 18:26:48 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:26:47 -0600
From: John Groves <john@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
Message-ID: <aYy_c3Wh6RbJflvs@groves.net>
References: <20260116125831.953.compound@groves.net>
 <20260116185911.1005-10-john@jagalactic.com>
 <20260116185911.1005-1-john@jagalactic.com>
 <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
 <aXoarMgfbL6rh6xi@groves.net>
 <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com>
 <0100019c05067b3b-b9ab2963-ace5-481f-8969-c11f80a74423-000000@email.amazonses.com>
 <CAJnrk1Y6HayeS-C3sOEOc_CgaS_K=SedZNpHASAXAkgZyp3Xsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Y6HayeS-C3sOEOc_CgaS_K=SedZNpHASAXAkgZyp3Xsg@mail.gmail.com>
X-Stat-Signature: mszmxb1niyybftty888ayigfeewrxk5w
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1+KXnzzANVxzbiGeTDo5d+sSgfjIkuJfLM=
X-HE-Tag: 1770834408-954054
X-HE-Meta: U2FsdGVkX1+7bvXhDhZh4y00uxQaD/gK/MyNUYhY/zCkfqrEwHZLdWxm68ym0hX2uElF0aWR0ZllEr9HXUvIpxr8eTG+soW3z5OCPe9+awVkjGXTDYdJQ/xjeO3619mAysxgE+e9wNmSh75m3d2KYJrRUs4yoxY3gktZ3P49RQJI/g9mo56oFQahnU4YpJk7jWSqezC4s5hI1dey4atCG/eYyw8PxoPpAA3qHrapHVqGa8LK0Uo/VE3l7taAmp11vyWefYpdB4+XSJDFZ5KrnKAnpqYgaaBjNuua16PBQCbPiI+yZOoeGlewPsB+Qjg6TNbNXDqZuvVLAHOsf2/9Odc/in2wB7D7i4V/DocTXH5lQjIUfeCaR4wlOjfMEGJHHX5lC4IB+/3NpUdp50DTyQmWf9WKQ5ft8PnsnB0Jo4OiMfcBQLzNQp2g4P1nKFeGubd3IZl6786MDF1/5WWDjA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	TAGGED_FROM(0.00)[bounces-76965-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[groves.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john@groves.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23F37126DA0
X-Rspamd-Action: no action

On 26/01/28 10:54AM, Joanne Koong wrote:
> On Wed, Jan 28, 2026 at 6:33 AM John Groves <john@jagalactic.com> wrote:
> >
> > On 26/01/27 01:55PM, Joanne Koong wrote:
> > > On Fri, Jan 16, 2026 at 11:52 AM John Groves <john@jagalactic.com> wrote:
> > > >
> > > > From: John Groves <john@groves.net>
> > > >
> > > > Famfs distinguishes between its on-media and in-memory superblocks. This
> > > > reserves the numbers, but they are only used by the user space
> > > > components of famfs.
> > > >
> > > > Signed-off-by: John Groves <john@groves.net>
> > > > ---
> > > >  include/uapi/linux/magic.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > > index 638ca21b7a90..712b097bf2a5 100644
> > > > --- a/include/uapi/linux/magic.h
> > > > +++ b/include/uapi/linux/magic.h
> > > > @@ -38,6 +38,8 @@
> > > >  #define OVERLAYFS_SUPER_MAGIC  0x794c7630
> > > >  #define FUSE_SUPER_MAGIC       0x65735546
> > > >  #define BCACHEFS_SUPER_MAGIC   0xca451a4e
> > > > +#define FAMFS_SUPER_MAGIC      0x87b282ff
> > > > +#define FAMFS_STATFS_MAGIC      0x87b282fd
> > >
> > > Could you explain why this needs to be added to uapi? If they are used
> > > only by userspace, does it make more sense for these constants to live
> > > in the userspace code instead?
> > >
> > > Thanks,
> > > Joanne
> >
> > Hi Joanne,
> >
> > I think this is where it belongs; one function of uapi/linux/magic.h is as
> > a "registry" of magic numbers, which do need to be unique because they're
> > the first step of recognizing what is on a device.
> >
> > This is a well-established ecosystem with block devices. Blkid / libblkid
> > scan block devices and keep a database of what devices exist and what
> > appears to be on them. When one adds a magic number that applies to block
> > devices, one sends a patch to util-linux (where blkid lives) to add ability
> > to recognize your media format (which IIRC includes the second recognition
> > step - if the magic # matches, verify the superblock checksum).
> >
> > For character dax devices the ecosystem isn't really there yet, but the
> > pattern is the same - and still makes sense.
> >
> > Also, 2 years ago in the very first public famfs patch set (pre-fuse),
> > Christian Brauner told me they belong here [1].

Apologies for not responding to this sooner.

First, FAMFS_STATFS_MAGIC will be dropped for sure. At one point I thought
I'd be able to override FUSE_SUPER_MAGIC in the output from statfs, but
that's not currently true. I've had to take a different approach in the 
famfs user space for definitively identifying whether a path falls in a 
famfs file system...

> 
> Hi John,
> 
> Thanks for the context. I was under the impression include/uapi/ was
> only for constants the kernel exposes as part of its ABI. If I'm
> understanding it correctly, FAMFS_SUPER_MAGIC is used purely as an
> on-disk format marker for identification by userspace tools. Why
> doesn't having the magic number defined in the equivalent of
> blkid/libblkid for dax devices and defined/used in the famfs
> server-side implementation suffice for that purpose? I'm asking in
> part because it seems like a slippery slope to me where any fuse
> server could make the same argument in the future that their magic
> constant should be added to uapi.

Right now there is no equivalent of util-linux/blkid for character device
superblock identification. Therefore this seems better than nothing to
record FAMFS_SUPER_MAGIC, since keeping it unique is a public good and
it is an actual on-media magic number. Although it's not currently used
on block devices, there is a very real possibility of famfs on block
devices in the future (pmem is block, and fs-dax, supporting that with
famfs would be straightforward, and there are problems for which it's a
good solution...)

There doesn't seem to be an explicit maintainer of magic.h; if somebody
can speak for the intent, or the rules etc., that would be helpful. I don't
want to abandon this based on general uapi guidelines alone. Is there
anybody in particular who should make a ruling here?

I don't really see a slippery slope; this isn't an arbitrary constant, 
it's an actual on-media magic number. 

> 
> For Christian's comment, my understanding was that with the pre-fuse
> patchset, it did need to be in uapi because the kernel explicitly set
> sb->s_magic to it, but with famfs now going through fuse, sb->s_magic
> uses FUSE_SUPER_MAGIC.

Even in the before-times with standalone famfs, on media (in-memory)
metadata was not accessed directly from the kernel module. So that didn't 
change with the fuse port (though it's possible that detail of the prior
implementation wasn't broadly understood...).

Would anybody like to weigh in to swing consensus here?

Thanks,
John


