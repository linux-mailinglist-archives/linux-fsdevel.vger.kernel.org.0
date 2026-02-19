Return-Path: <linux-fsdevel+bounces-77724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJZ1N3M7l2l2vwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:33:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C3C160B70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18672302D5FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497D34CFC7;
	Thu, 19 Feb 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFfqr9/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633F21A444;
	Thu, 19 Feb 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518822; cv=none; b=My0BCAgPUxZYOPPjVIUz8PBAVWaJwYOirVYJxGfmfirxarDUSMcbhAVuXq3ueoE74VYEOYQ/bLUd2uWEguj08AzRbFUgy9RhlV3Tm5GHShdQ5XcrD3fwMD3QypZFChK1cQYpXcw04wI7KYL0gA9RywhaKP//KmvqIdoaF/BMF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518822; c=relaxed/simple;
	bh=HcnGHINgEGT5Xiu43clzTLxVroTc1PypRcM9ag1ryk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZqtNfvZNYEPYNbxAylA9zvlUY7azDNEUSFfwYUeUGfCAZdK5UheOtKu0owlhQPOwS13ZgGwHZfovMjgUR4488jjYTHG0LHZwA7KFu6tgjwJodUxo57gQ07hG27uclWoaO+DREih5ZEehr4+alkNYbP2AEF8fp9lEyYnGuP2SBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFfqr9/v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771518821; x=1803054821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HcnGHINgEGT5Xiu43clzTLxVroTc1PypRcM9ag1ryk8=;
  b=UFfqr9/vgxZiGt0qxN7igUg2Dqps7hHHfLkUzEPXUhgaL//YNWBbSMVg
   dwRoFtw5UlJyK6CzBJkyTF102HFbCPAE9EqZ63AaqLktF+8L4ocr5mWaK
   ++5tKkv7Mue30RuhSSeDSG9mJQGkoI4KJlLwC5Zt07lERY9BRcAUoxvOS
   qgjS24hLZwmMY5EikpiV33mp3OWK2Ahu7bLSNOmqWnM9S4WyTqYJSo+mJ
   JUMZ6mqkM1qDAsUMuh/u1YOWw1vtmzmKFVzgUcqTWLhKXf6ADxbFZ8ad1
   aD5kdO2XPu58iz0QjfylPLi3bYzlhZB8yw0hJa25lb2dsYdlpExaZHL8p
   Q==;
X-CSE-ConnectionGUID: GiTnA0MzSK+sTA/KQzSzVQ==
X-CSE-MsgGUID: WjzdbcODQkKc3ecFb/ZByw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83232724"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83232724"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:33:35 -0800
X-CSE-ConnectionGUID: ttabUF5AR5yeBhkvdwUZFA==
X-CSE-MsgGUID: /XtpdxBfTNKiKHP86Xzqhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213216451"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:33:32 -0800
Message-ID: <50969479-3e9a-4d46-94bf-4e0525f6ddad@intel.com>
Date: Thu, 19 Feb 2026 09:33:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 10/19] famfs_fuse: Update macro
 s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223235.92498-1-john@jagalactic.com>
 <0100019bd33d3cb8-384cf5f0-5f7c-4d18-936c-f73381e1933c-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33d3cb8-384cf5f0-5f7c-4d18-936c-f73381e1933c-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77724-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[groves.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 42C3C160B70
X-Rspamd-Action: no action



On 1/18/26 3:32 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> Virtio_fs now needs to determine if an inode is DAX && not famfs.
> This relaces the FUSE_IS_DAX() macro with FUSE_IS_VIRTIO_DAX(),
> in preparation for famfs in later commits. The dummy
> fuse_file_famfs() macro will be replaced with a working
> function.
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/file.c   | 13 ++++++++-----
>  fs/fuse/fuse_i.h |  9 ++++++++-
>  fs/fuse/inode.c  |  4 ++--
>  fs/fuse/iomode.c |  2 +-
>  5 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4b6b3d2758ff..1400c9d733ba 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		is_truncate = true;
>  	}
>  
> -	if (FUSE_IS_DAX(inode) && is_truncate) {
> +	if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
>  		filemap_invalidate_lock(mapping);
>  		fault_blocked = true;
>  		err = fuse_dax_break_layouts(inode, 0, -1);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..093569033ed1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -252,7 +252,7 @@ static int fuse_open(struct inode *inode, struct file *file)
>  	int err;
>  	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
>  	bool is_wb_truncate = is_truncate && fc->writeback_cache;
> -	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
> +	bool dax_truncate = is_truncate && FUSE_IS_VIRTIO_DAX(fi);
>  
>  	if (fuse_is_bad(inode))
>  		return -EIO;
> @@ -1812,11 +1812,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_file *ff = file->private_data;
>  	struct inode *inode = file_inode(file);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	if (fuse_is_bad(inode))
>  		return -EIO;
>  
> -	if (FUSE_IS_DAX(inode))
> +	if (FUSE_IS_VIRTIO_DAX(fi))
>  		return fuse_dax_read_iter(iocb, to);
>  
>  	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> @@ -1833,11 +1834,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_file *ff = file->private_data;
>  	struct inode *inode = file_inode(file);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	if (fuse_is_bad(inode))
>  		return -EIO;
>  
> -	if (FUSE_IS_DAX(inode))
> +	if (FUSE_IS_VIRTIO_DAX(fi))
>  		return fuse_dax_write_iter(iocb, from);
>  
>  	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> @@ -2370,10 +2372,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_conn *fc = ff->fm->fc;
>  	struct inode *inode = file_inode(file);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>  	int rc;
>  
>  	/* DAX mmap is superior to direct_io mmap */
> -	if (FUSE_IS_DAX(inode))
> +	if (FUSE_IS_VIRTIO_DAX(fi))
>  		return fuse_dax_mmap(file, vma);
>  
>  	/*
> @@ -2934,7 +2937,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  		.mode = mode
>  	};
>  	int err;
> -	bool block_faults = FUSE_IS_DAX(inode) &&
> +	bool block_faults = FUSE_IS_VIRTIO_DAX(fi) &&
>  		(!(mode & FALLOC_FL_KEEP_SIZE) ||
>  		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..45e108dec771 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1508,7 +1508,14 @@ void fuse_free_conn(struct fuse_conn *fc);
>  
>  /* dax.c */
>  
> -#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))
> +static inline bool fuse_file_famfs(struct fuse_inode *fuse_inode) /* Will be superseded */
> +{
> +	(void)fuse_inode;
> +	return false;
> +}
> +#define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
> +					&& IS_DAX(&fuse_inode->inode)  \
> +					&& !fuse_file_famfs(fuse_inode))
>  
>  ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d66622..ed667920997f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -162,7 +162,7 @@ static void fuse_evict_inode(struct inode *inode)
>  	/* Will write inode on close/munmap and in all other dirtiers */
>  	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
>  
> -	if (FUSE_IS_DAX(inode))
> +	if (FUSE_IS_VIRTIO_DAX(fi))
>  		dax_break_layout_final(inode);
>  
>  	truncate_inode_pages_final(&inode->i_data);
> @@ -170,7 +170,7 @@ static void fuse_evict_inode(struct inode *inode)
>  	if (inode->i_sb->s_flags & SB_ACTIVE) {
>  		struct fuse_conn *fc = get_fuse_conn(inode);
>  
> -		if (FUSE_IS_DAX(inode))
> +		if (FUSE_IS_VIRTIO_DAX(fi))
>  			fuse_dax_inode_cleanup(inode);
>  		if (fi->nlookup) {
>  			fuse_queue_forget(fc, fi->forget, fi->nodeid,
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 3728933188f3..31ee7f3304c6 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
>  	 * io modes are not relevant with DAX and with server that does not
>  	 * implement open.
>  	 */
> -	if (FUSE_IS_DAX(inode) || !ff->args)
> +	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
>  		return 0;
>  
>  	/*


