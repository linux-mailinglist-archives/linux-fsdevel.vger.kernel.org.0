Return-Path: <linux-fsdevel+bounces-78399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPWTIi1qn2lRagQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:31:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582C19DDBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C90D3053B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F15315D49;
	Wed, 25 Feb 2026 21:30:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FD1DB95E;
	Wed, 25 Feb 2026 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055042; cv=none; b=uUTxot/A911lZcGn3jZuSH5dHehcjguFoQNsfIz3M2PtbwudBBE/FkmI/p4dkq3IZwUt/ju1uXxM9H3lHMXqGI45gZCrQTSH2/myaz/q46Tio7nAbdvxrOb8nc+dBjU5HWAmuwK8QYm3ZHiLveb/0bMz/HsowBZ59Na9CYhiKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055042; c=relaxed/simple;
	bh=15YHxE2GDWdChKLq4T4FsYInpOS4b288SrSVzv9HBFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbaBMxu5LRAORqPVBX652ei1+xNGuCRmBiiw1TN05xmMEGfm6KVDwE/ih80XulPAeMIVTd7e1g3bLMOv8PKbtxXZ2mPefX6w28EurEFVv7qIDGsSANqjATrimmVYu49icAnmKXUbSyAoUaayUAG6WGtpzzn4lEJvfs9aJk8T7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0FFCA8C39D;
	Wed, 25 Feb 2026 21:30:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf13.hostedemail.com (Postfix) with ESMTPA id 750152000D;
	Wed, 25 Feb 2026 21:30:19 +0000 (UTC)
Date: Wed, 25 Feb 2026 15:30:18 -0600
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
Subject: Re: [PATCH V7 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <aZ9pfsYIyHHKoM_k@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223307.92562-1-john@jagalactic.com>
 <0100019bd33daee6-f6b270fd-c943-4643-8d21-5621fdef3572-000000@email.amazonses.com>
 <987f1b61-3471-4779-a05c-a00f3f8e9a5e@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <987f1b61-3471-4779-a05c-a00f3f8e9a5e@intel.com>
X-Stat-Signature: jma4crquaxpirbwqknrgdwsc4bp8hh36
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX18u8k0QruGqo8tXCCQJwzopIy2ZEfIp0fI=
X-HE-Tag: 1772055019-212042
X-HE-Meta: U2FsdGVkX19itpu70faJr6hTGAoijujR7iwYzqrLr0UekiMsf8igQhvWkXLeHApQV76128UpRPN8PTuxDuY1dRRcG57AXLmObqE9LAI1xIIG/OOk+2+ZBULVO//Y3HRw6Qj5KgIkThyMy+DbeuTvFVg8v+a+numbfN54D2pqvMrXbpseh+dDwpqPmY9c8caoNECA/iy9h6lq9ZQ1hkbnkwW+KVHp1dd1swwA+RSjPJhcIr8ezc21PvW+abhssMc4FLMXrXXKMMhf75HD/t2ERT2rDa4kyfPd3Po+7l+BdMXkhJfL2RLskfSGfaqERHxuBCJU09l0ecysfBfUZA5EpR150jEsaMIoy6FSKBsJLSIcfVgOBzpCSCZs1QpmV0ow4XdjWfrwZp1mk9RcTQk0rw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[jagalactic.com,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-78399-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[groves.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John@groves.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0582C19DDBE
X-Rspamd-Action: no action

On 26/02/19 11:31AM, Dave Jiang wrote:
> 
> 
> On 1/18/26 3:33 PM, John Groves wrote:
> > From: John Groves <john@groves.net>
> > 
> > On completion of GET_FMAP message/response, setup the full famfs
> > metadata such that it's possible to handle read/write/mmap directly to
> > dax. Note that the devdax_iomap plumbing is not in yet...
> > 
> > * Add famfs_kfmap.h: in-memory structures for resolving famfs file maps
> >   (fmaps) to dax.
> > * famfs.c: allocate, initialize and free fmaps
> > * inode.c: only allow famfs mode if the fuse server has CAP_SYS_RAWIO
> > * Update MAINTAINERS for the new file.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  MAINTAINERS               |   1 +
> >  fs/fuse/famfs.c           | 339 +++++++++++++++++++++++++++++++++++++-
> >  fs/fuse/famfs_kfmap.h     |  67 ++++++++
> >  fs/fuse/fuse_i.h          |   8 +-
> >  fs/fuse/inode.c           |  19 ++-
> >  include/uapi/linux/fuse.h |  56 +++++++
> >  6 files changed, 480 insertions(+), 10 deletions(-)
> >  create mode 100644 fs/fuse/famfs_kfmap.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e3d0aa5eb361..6f8a7c813c2f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10386,6 +10386,7 @@ L:	linux-cxl@vger.kernel.org
> >  L:	linux-fsdevel@vger.kernel.org
> >  S:	Supported
> >  F:	fs/fuse/famfs.c
> > +F:	fs/fuse/famfs_kfmap.h
> >  
> >  FUTEX SUBSYSTEM
> >  M:	Thomas Gleixner <tglx@kernel.org>
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index 615819cc922d..a9728e11f1dd 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> > @@ -18,9 +18,339 @@
> >  #include <linux/namei.h>
> >  #include <linux/string.h>
> >  
> > +#include "famfs_kfmap.h"
> >  #include "fuse_i.h"
> >  
> >  
> > +/***************************************************************************/
> > +
> > +void __famfs_meta_free(void *famfs_meta)
> > +{
> > +	struct famfs_file_meta *fmap = famfs_meta;
> > +
> > +	if (!fmap)
> > +		return;
> > +
> > +	switch (fmap->fm_extent_type) {
> > +	case SIMPLE_DAX_EXTENT:
> > +		kfree(fmap->se);
> > +		break;
> > +	case INTERLEAVED_EXTENT:
> > +		if (fmap->ie) {
> > +			for (int i = 0; i < fmap->fm_niext; i++)
> > +				kfree(fmap->ie[i].ie_strips);
> > +		}
> > +		kfree(fmap->ie);
> > +		break;
> > +	default:
> > +		pr_err("%s: invalid fmap type\n", __func__);
> > +		break;
> > +	}
> > +
> > +	kfree(fmap);
> > +}
> > +DEFINE_FREE(__famfs_meta_free, void *, if (_T) __famfs_meta_free(_T))
> > +
> > +static int
> > +famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)
> > +{
> > +	int errs = 0;
> > +
> > +	if (se->dev_index != 0)
> > +		errs++;
> > +
> > +	/* TODO: pass in alignment so we can support the other page sizes */
> > +	if (!IS_ALIGNED(se->ext_offset, PMD_SIZE))
> > +		errs++;
> > +
> > +	if (!IS_ALIGNED(se->ext_len, PMD_SIZE))
> > +		errs++;
> > +
> > +	return errs;
> > +}
> > +
> > +/**
> > + * famfs_fuse_meta_alloc() - Allocate famfs file metadata
> > + * @fmap_buf:  fmap buffer from fuse server
> > + * @fmap_buf_size: size of fmap buffer
> > + * @metap:         pointer where 'struct famfs_file_meta' is returned
> > + *
> > + * Returns: 0=success
> > + *          -errno=failure
> > + */
> > +static int
> > +famfs_fuse_meta_alloc(
> > +	void *fmap_buf,
> > +	size_t fmap_buf_size,
> > +	struct famfs_file_meta **metap)
> > +{
> > +	struct famfs_file_meta *meta __free(__famfs_meta_free) = NULL;
> 
> declare when it gets allocated

Done, thanks!

> 
> > +	struct fuse_famfs_fmap_header *fmh;
> > +	size_t extent_total = 0;
> > +	size_t next_offset = 0;
> > +	int errs = 0;
> > +	int i, j;
> > +
> > +	fmh = fmap_buf;
> > +
> > +	/* Move past fmh in fmap_buf */
> > +	next_offset += sizeof(*fmh);
> > +	if (next_offset > fmap_buf_size) {
> > +		pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> > +		       __func__, __LINE__, next_offset, fmap_buf_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fmh->nextents < 1) {
> > +		pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
> > +		pr_err("%s: nextents %d > max (%d) 1\n",
> > +		       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
> > +		return -E2BIG;
> > +	}
> 
> Both checks for nextents can be -ERANGE?

Done, Thx

> 
> > +
> > +	meta = kzalloc(sizeof(*meta), GFP_KERNEL);
> > +	if (!meta)
> > +		return -ENOMEM;
> > +
> > +	meta->error = false;
> > +	meta->file_type = fmh->file_type;
> > +	meta->file_size = fmh->file_size;
> > +	meta->fm_extent_type = fmh->ext_type;
> > +
> > +	switch (fmh->ext_type) {
> > +	case FUSE_FAMFS_EXT_SIMPLE: {
> > +		struct fuse_famfs_simple_ext *se_in;
> > +
> > +		se_in = fmap_buf + next_offset;
> > +
> > +		/* Move past simple extents */
> > +		next_offset += fmh->nextents * sizeof(*se_in);
> > +		if (next_offset > fmap_buf_size) {
> > +			pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> > +			       __func__, __LINE__, next_offset, fmap_buf_size);
> > +			return -EINVAL;
> > +		}
> > +
> > +		meta->fm_nextents = fmh->nextents;
> > +
> > +		meta->se = kcalloc(meta->fm_nextents, sizeof(*(meta->se)),
> > +				   GFP_KERNEL);
> > +		if (!meta->se)
> > +			return -ENOMEM;
> > +
> > +		if ((meta->fm_nextents > FUSE_FAMFS_MAX_EXTENTS) ||
> > +		    (meta->fm_nextents < 1))
> > +			return -EINVAL;
> > +> +		for (i = 0; i < fmh->nextents; i++) {
> > +			meta->se[i].dev_index  = se_in[i].se_devindex;
> > +			meta->se[i].ext_offset = se_in[i].se_offset;
> > +			meta->se[i].ext_len    = se_in[i].se_len;
> > +
> > +			/* Record bitmap of referenced daxdev indices */
> > +			meta->dev_bitmap |= (1 << meta->se[i].dev_index);
> > +
> > +			errs += famfs_check_ext_alignment(&meta->se[i]);
> > +
> > +			extent_total += meta->se[i].ext_len;
> > +		}
> > +		break;
> > +	}
> > +
> > +	case FUSE_FAMFS_EXT_INTERLEAVE: {
> > +		s64 size_remainder = meta->file_size;
> > +		struct fuse_famfs_iext *ie_in;
> > +		int niext = fmh->nextents;
> > +
> > +		meta->fm_niext = niext;
> > +
> > +		/* Allocate interleaved extent */
> > +		meta->ie = kcalloc(niext, sizeof(*(meta->ie)), GFP_KERNEL);
> > +		if (!meta->ie)
> > +			return -ENOMEM;
> > +
> > +		/*
> > +		 * Each interleaved extent has a simple extent list of strips.
> > +		 * Outer loop is over separate interleaved extents
> > +		 */
> > +		for (i = 0; i < niext; i++) {
> > +			u64 nstrips;
> > +			struct fuse_famfs_simple_ext *sie_in;
> > +
> > +			/* ie_in = one interleaved extent in fmap_buf */
> > +			ie_in = fmap_buf + next_offset;
> > +
> > +			/* Move past one interleaved extent header in fmap_buf */
> > +			next_offset += sizeof(*ie_in);
> > +			if (next_offset > fmap_buf_size) {
> > +				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> > +				       __func__, __LINE__, next_offset,
> > +				       fmap_buf_size);
> > +				return -EINVAL;
> > +			}
> > +
> > +			if (!IS_ALIGNED(ie_in->ie_chunk_size, PMD_SIZE)) {
> > +				pr_err("%s: chunk_size %lld not PMD-aligned\n",
> > +				       __func__, meta->ie[i].fie_chunk_size);
> > +				return -EINVAL;
> > +			}
> > +
> > +			if (ie_in->ie_nbytes == 0) {
> > +				pr_err("%s: zero-length interleave!\n",
> > +				       __func__);
> > +				return -EINVAL;
> > +			}
> > +
> > +			nstrips = ie_in->ie_nstrips;
> > +			meta->ie[i].fie_chunk_size = ie_in->ie_chunk_size;
> > +			meta->ie[i].fie_nstrips    = ie_in->ie_nstrips;
> > +			meta->ie[i].fie_nbytes     = ie_in->ie_nbytes;
> > +
> > +			/* sie_in = the strip extents in fmap_buf */
> > +			sie_in = fmap_buf + next_offset;
> > +
> > +			/* Move past strip extents in fmap_buf */
> > +			next_offset += nstrips * sizeof(*sie_in);
> > +			if (next_offset > fmap_buf_size) {
> > +				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> > +				       __func__, __LINE__, next_offset,
> > +				       fmap_buf_size);
> > +				return -EINVAL;
> > +			}
> > +
> > +			if ((nstrips > FUSE_FAMFS_MAX_STRIPS) || (nstrips < 1)) {
> > +				pr_err("%s: invalid nstrips=%lld (max=%d)\n",
> > +				       __func__, nstrips,
> > +				       FUSE_FAMFS_MAX_STRIPS);
> > +				errs++;
> > +			}
> > +
> > +			/* Allocate strip extent array */
> > +			meta->ie[i].ie_strips =
> > +				kcalloc(ie_in->ie_nstrips,
> > +					sizeof(meta->ie[i].ie_strips[0]),
> > +					GFP_KERNEL);
> > +			if (!meta->ie[i].ie_strips)
> > +				return -ENOMEM;
> > +
> > +			/* Inner loop is over strips */
> > +			for (j = 0; j < nstrips; j++) {
> > +				struct famfs_meta_simple_ext *strips_out;
> > +				u64 devindex = sie_in[j].se_devindex;
> > +				u64 offset   = sie_in[j].se_offset;
> > +				u64 len      = sie_in[j].se_len;
> > +
> > +				strips_out = meta->ie[i].ie_strips;
> > +				strips_out[j].dev_index  = devindex;
> > +				strips_out[j].ext_offset = offset;
> > +				strips_out[j].ext_len    = len;
> > +
> > +				/* Record bitmap of referenced daxdev indices */
> > +				meta->dev_bitmap |= (1 << devindex);
> > +
> > +				extent_total += len;
> > +				errs += famfs_check_ext_alignment(&strips_out[j]);
> > +				size_remainder -= len;
> > +			}
> > +		}
> > +
> > +		if (size_remainder > 0) {
> > +			/* Sum of interleaved extent sizes is less than file size! */
> > +			pr_err("%s: size_remainder %lld (0x%llx)\n",
> > +			       __func__, size_remainder, size_remainder);
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	}
> > +
> > +	default:
> > +		pr_err("%s: invalid ext_type %d\n", __func__, fmh->ext_type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (errs > 0) {
> > +		pr_err("%s: %d alignment errors found\n", __func__, errs);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* More sanity checks */
> > +	if (extent_total < meta->file_size) {
> > +		pr_err("%s: file size %ld larger than map size %ld\n",
> > +		       __func__, meta->file_size, extent_total);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cmpxchg(metap, NULL, meta) != NULL) {
> > +		pr_debug("%s: fmap race detected\n", __func__);
> > +		return 0; /* fmap already installed */
> > +	}
> > +	meta = NULL; /* disarm __free() - the meta struct was consumed */
> 
> I think you can do:
> retain_and_null_ptr(meta);

Ah, I didn't know that one!

Done

> 
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * famfs_file_init_dax() - init famfs dax file metadata
> > + *
> > + * @fm:        fuse_mount
> > + * @inode:     the inode
> > + * @fmap_buf:  fmap response message
> > + * @fmap_size: Size of the fmap message
> > + *
> > + * Initialize famfs metadata for a file, based on the contents of the GET_FMAP
> > + * response
> > + *
> > + * Return: 0=success
> > + *          -errno=failure
> > + */
> > +int
> > +famfs_file_init_dax(
> > +	struct fuse_mount *fm,
> > +	struct inode *inode,
> > +	void *fmap_buf,
> > +	size_t fmap_size)
> > +{
> > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > +	struct famfs_file_meta *meta = NULL;
> > +	int rc;
> > +
> > +	if (fi->famfs_meta) {
> > +		pr_notice("%s: i_no=%ld fmap_size=%ld ALREADY INITIALIZED\n",
> > +			  __func__,
> > +			  inode->i_ino, fmap_size);
> > +		return 0;
> > +	}
> > +
> > +	rc = famfs_fuse_meta_alloc(fmap_buf, fmap_size, &meta);
> > +	if (rc)
> > +		goto errout;
> > +
> > +	/* Publish the famfs metadata on fi->famfs_meta */
> > +	inode_lock(inode);
> > +
> > +	if (famfs_meta_set(fi, meta) == NULL) {
> > +		i_size_write(inode, meta->file_size);
> > +		inode->i_flags |= S_DAX;
> > +	} else {
> > +		pr_debug("%s: file already had metadata\n", __func__);
> > +		__famfs_meta_free(meta);
> > +		/* rc is 0 - the file is valid */
> > +	}
> > +
> > +	inode_unlock(inode);
> > +	return 0;
> > +
> > +errout:
> > +	if (rc)
> > +		__famfs_meta_free(meta);
> > +
> > +	return rc;
> > +}
> > +
> >  #define FMAP_BUFSIZE PAGE_SIZE
> >  
> >  int
> > @@ -64,11 +394,8 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
> >  	}
> >  	fmap_size = rc;
> >  
> > -	/* We retrieved the "fmap" (the file's map to memory), but
> > -	 * we haven't used it yet. A call to famfs_file_init_dax() will be added
> > -	 * here in a subsequent patch, when we add the ability to attach
> > -	 * fmaps to files.
> > -	 */
> > +	/* Convert fmap into in-memory format and hang from inode */
> > +	rc = famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);
> >  
> > -	return 0;
> > +	return rc;
> >  }
> > diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> > new file mode 100644
> > index 000000000000..18ab22bcc5a1
> > --- /dev/null
> > +++ b/fs/fuse/famfs_kfmap.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * famfs - dax file system for shared fabric-attached memory
> > + *
> > + * Copyright 2023-2026 Micron Technology, Inc.
> > + */
> > +#ifndef FAMFS_KFMAP_H
> > +#define FAMFS_KFMAP_H
> > +
> > +/*
> > + * The structures below are the in-memory metadata format for famfs files.
> > + * Metadata retrieved via the GET_FMAP response is converted to this format
> > + * for use in resolving file mapping faults.
> > + *
> > + * The GET_FMAP response contains the same information, but in a more
> > + * message-and-versioning-friendly format. Those structs can be found in the
> > + * famfs section of include/uapi/linux/fuse.h (aka fuse_kernel.h in libfuse)
> > + */
> > +
> > +enum famfs_file_type {
> > +	FAMFS_REG,
> > +	FAMFS_SUPERBLOCK,
> > +	FAMFS_LOG,
> > +};
> > +
> > +/* We anticipate the possibility of supporting additional types of extents */
> > +enum famfs_extent_type {
> > +	SIMPLE_DAX_EXTENT,
> > +	INTERLEAVED_EXTENT,
> > +	INVALID_EXTENT_TYPE,
> > +};
> > +
> > +struct famfs_meta_simple_ext {
> > +	u64 dev_index;
> > +	u64 ext_offset;
> > +	u64 ext_len;
> > +};
> > +
> > +struct famfs_meta_interleaved_ext {
> > +	u64 fie_nstrips;
> > +	u64 fie_chunk_size;
> > +	u64 fie_nbytes;
> > +	struct famfs_meta_simple_ext *ie_strips;
> > +};
> > +
> > +/*
> > + * Each famfs dax file has this hanging from its fuse_inode->famfs_meta
> > + */
> > +struct famfs_file_meta {
> > +	bool                   error;
> > +	enum famfs_file_type   file_type;
> > +	size_t                 file_size;
> > +	enum famfs_extent_type fm_extent_type;
> > +	u64 dev_bitmap; /* bitmap of referenced daxdevs by index */
> > +	union {
> > +		struct {
> > +			size_t         fm_nextents;
> > +			struct famfs_meta_simple_ext  *se;
> > +		};
> > +		struct {
> > +			size_t         fm_niext;
> > +			struct famfs_meta_interleaved_ext *ie;
> > +		};
> > +	};
> > +};
> > +
> > +#endif /* FAMFS_KFMAP_H */
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index b66b5ca0bc11..dbfec5b9c6e1 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1642,6 +1642,9 @@ extern void fuse_sysctl_unregister(void);
> >  /* famfs.c */
> >  
> >  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +int famfs_file_init_dax(struct fuse_mount *fm,
> > +			struct inode *inode, void *fmap_buf,
> > +			size_t fmap_size);
> >  void __famfs_meta_free(void *map);
> >  
> >  /* Set fi->famfs_meta = NULL regardless of prior value */
> > @@ -1659,7 +1662,10 @@ static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> >  
> >  static inline void famfs_meta_free(struct fuse_inode *fi)
> >  {
> > -	famfs_meta_set(fi, NULL);
> > +	if (fi->famfs_meta != NULL) {
> > +		__famfs_meta_free(fi->famfs_meta);
> > +		famfs_meta_set(fi, NULL);
> > +	}
> >  }
> >  
> >  static inline int fuse_file_famfs(struct fuse_inode *fi)
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index f2d742d723dc..b9933d0fbb9f 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1464,8 +1464,21 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >  				timeout = arg->request_timeout;
> >  
> >  			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > -			    flags & FUSE_DAX_FMAP)
> > -				fc->famfs_iomap = 1;
> > +			    flags & FUSE_DAX_FMAP) {
> > +				/* famfs_iomap is only allowed if the fuse
> > +				 * server has CAP_SYS_RAWIO. This was checked
> > +				 * in fuse_send_init, and FUSE_DAX_IOMAP was
> > +				 * set in in_flags if so. Only allow enablement
> > +				 * if we find it there. This function is
> > +				 * normally not running in fuse server context,
> > +				 * so we can't do the capability check here...
> > +				 */
> > +				u64 in_flags = ((u64)ia->in.flags2 << 32)
> 
> FIELD_PREP()?
> 
> DJ

Another new one to me!

Done.

Thanks Dave!

[snip]


