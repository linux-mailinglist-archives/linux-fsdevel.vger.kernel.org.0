Return-Path: <linux-fsdevel+bounces-76303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFlfD3Img2kxigMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 11:58:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5068E4D52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 11:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1971E301AB93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8933DA7F6;
	Wed,  4 Feb 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/rXH+g6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1B39903E;
	Wed,  4 Feb 2026 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202721; cv=none; b=DpdIpIKv48+G1be8XRNZ1Y01uf/bErvMnI4bJU+Vj5rWZ6WwTgL8ZE5VmgdKmhvdsypt5xoyDff9OK1a/4yfZL/W54oBGLg4Gr+Nbr9ulsIjdJ30E4azzB/NAA2qV4uV5Fd/jNqJu7MUFZJj4XJT+P4xmiHZZhHmwFMy9XTGV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202721; c=relaxed/simple;
	bh=e4OYY/P0s+n3f6l0Un+2wnNzSCxA9PSWh2mQE2h/QLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfSqTBetpmnUBCBZUYYLO9V3Z35kpksT6kzY+xJhIlpc6tMwbrPvrD18nN/1gu+iHyWhiokZdqENJZl8v+quNXF0FT4eBDWpKS3EnD8lrlGXn7UYGWYfbBeYNzWw9jXpw0Ol6GxMEveGaTVkYYzhhzAFinlC5pbmmHBzcMjSc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/rXH+g6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770202721; x=1801738721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4OYY/P0s+n3f6l0Un+2wnNzSCxA9PSWh2mQE2h/QLI=;
  b=P/rXH+g67RmGvsKf8fW9NdXPYHiQBhjsXbEl5xs9cdbkru+GcsMpIjPF
   ZgAZq2ETt877WT5m1Nx94gr4d/N8pblUQCmq0mKcAFYCIgNnY/plSvsix
   hRJI37HGYUCi6SsOHqLspIZPElnW8hWE1s7I4u8Jn5ukSrBFAhWLIpE3Q
   /PbylfvfXNN1S6/ThdghhLi0XtxG+ti5kvtasAmdX1ChGVh0jl0Z5jj93
   EcqXLKNG+XUJW/L18PkEMzfb7RMvEgbHyog1thFe9zVGQxO2yc22+6sth
   uwrsDhQoDtZsGIHRiQ3nKCCICPIvXqgCFaQPD2nPLnkzN30pOaAj//87J
   w==;
X-CSE-ConnectionGUID: Uqeby7skSJGEmc0KRBFotA==
X-CSE-MsgGUID: qm180nDqQvud+jqMORzq4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88807943"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88807943"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:58:40 -0800
X-CSE-ConnectionGUID: oBTx9fyySBW7CeLiYKyMow==
X-CSE-MsgGUID: 6hswnyijS3qwmcCTJ28ksw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209230824"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2026 02:58:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnaaN-00000000hii-2R8J;
	Wed, 04 Feb 2026 10:58:15 +0000
Date: Wed, 4 Feb 2026 18:58:08 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@ownmail.net>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 04/13] Apparmor: Use simple_start_creating() /
 simple_done_creating()
Message-ID: <202602041851.x2RfFgKO-lkp@intel.com>
References: <20260204050726.177283-5-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204050726.177283-5-neilb@ownmail.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76303-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: B5068E4D52
X-Rspamd-Action: no action

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on viro-vfs/for-next linus/master v6.19-rc8 next-20260203]
[cannot apply to pcmoore-selinux/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/fs-proc-Don-t-lock-root-inode-when-creating-self-and-thread-self/20260204-131659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260204050726.177283-5-neilb%40ownmail.net
patch subject: [PATCH 04/13] Apparmor: Use simple_start_creating() / simple_done_creating()
config: arm-randconfig-r133-20260204 (https://download.01.org/0day-ci/archive/20260204/202602041851.x2RfFgKO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602041851.x2RfFgKO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602041851.x2RfFgKO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/apparmor/apparmorfs.c:295:16: sparse: sparse: Using plain integer as NULL pointer

vim +295 security/apparmor/apparmorfs.c

   247	
   248	/**
   249	 * aafs_create - create a dentry in the apparmorfs filesystem
   250	 *
   251	 * @name: name of dentry to create
   252	 * @mode: permissions the file should have
   253	 * @parent: parent directory for this dentry
   254	 * @data: data to store on inode.i_private, available in open()
   255	 * @link: if symlink, symlink target string
   256	 * @fops: struct file_operations that should be used for
   257	 * @iops: struct of inode_operations that should be used
   258	 *
   259	 * This is the basic "create a xxx" function for apparmorfs.
   260	 *
   261	 * Returns a pointer to a dentry if it succeeds, that must be free with
   262	 * aafs_remove(). Will return ERR_PTR on failure.
   263	 */
   264	static struct dentry *aafs_create(const char *name, umode_t mode,
   265					  struct dentry *parent, void *data, void *link,
   266					  const struct file_operations *fops,
   267					  const struct inode_operations *iops)
   268	{
   269		struct dentry *dentry;
   270		struct inode *dir;
   271		int error;
   272	
   273		AA_BUG(!name);
   274		AA_BUG(!parent);
   275	
   276		if (!(mode & S_IFMT))
   277			mode = (mode & S_IALLUGO) | S_IFREG;
   278	
   279		error = simple_pin_fs(&aafs_ops, &aafs_mnt, &aafs_count);
   280		if (error)
   281			return ERR_PTR(error);
   282	
   283		dir = d_inode(parent);
   284	
   285		dentry = simple_start_creating(parent, name);
   286		if (IS_ERR(dentry)) {
   287			error = PTR_ERR(dentry);
   288			goto fail;
   289		}
   290	
   291		error = __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iops);
   292		simple_done_creating(dentry);
   293		if (error)
   294			goto fail;
 > 295		return 0;
   296	fail:
   297		simple_release_fs(&aafs_mnt, &aafs_count);
   298		return ERR_PTR(error);
   299	}
   300	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

