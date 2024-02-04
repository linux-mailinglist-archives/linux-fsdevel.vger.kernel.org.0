Return-Path: <linux-fsdevel+bounces-10218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FB848D2F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 12:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFCB1F22492
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394D22307;
	Sun,  4 Feb 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQVoJwzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD121A19
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Feb 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046951; cv=none; b=pO5d4UhkpT5OqZKvqo00m1G/0alMwoWWFrzCCqMsG7ghbvf5niW15qmJU1dGcb+5ifgkqSWtZJ5d8zrz+K2ouHATGTkyQF1XKQdE14eGNO/eGcIeD4Z3l46UEngN6pIuLKlcWYj6JsoIwMN8iYjAucGvSENNAqw4CVaHJJO72gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046951; c=relaxed/simple;
	bh=KGDpUThHtAKqkOgWRCAPT9jQfnmE7CzSh7uY2Rj7gh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m27pzNO8q8ebfu+y08LZFrcFR2p1C9zL6eod5+fuAVCsh3k3F56HWPLcQJ11vzYfCYdzU/gl73D38sGlyVLYXpO2WvJTzUxbocKb43vU/rFCfEg2QfhoKBdrNv+MTLgIoWPltP0Y6sLWi8ITz7xIH0E1ZXKGjb9fShRS+XBr8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQVoJwzN; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707046948; x=1738582948;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KGDpUThHtAKqkOgWRCAPT9jQfnmE7CzSh7uY2Rj7gh0=;
  b=XQVoJwzNaI3TCfZCDXdXHMr4MoptlwIV+VacdJnEgv4JXFoopCY/sfVO
   oq2H4LMJhhHSQCF4X8iadNlFDiz8EREpAVZ4HnIJBUtgECvdfTLs+/C1a
   jWno9dfT1NqsZUGjBzU2+u3qw4XvJ2HAIRkuTGuomu6KvcRRor+yy7ZOO
   LxkgBaFn0ZXzQDd+GA+revQ638e6xvlk9ouhlLol/oN7bN5uW/zDIdtX8
   VJgICIQ2Y8IcsOvcYyMLYTDgTmI3DHLYoi4UM3HcNz5Iukoz2a/7du74V
   msKIERhXfgbHIZ/7zHWV9nYYb/eVzelhE9aLceGENp3xk5qMZAOy4KXI1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="435522418"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="435522418"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 03:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="812941"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Feb 2024 03:42:26 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWatD-0006IO-0e;
	Sun, 04 Feb 2024 11:42:23 +0000
Date: Sun, 4 Feb 2024 19:42:17 +0800
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [viro-vfs:work.misc 6/6] fs/splice.c:743:9: error: call to
 undeclared function 'call_write_iter'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202402041909.VYei40Zu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
head:   8f5893b867907f2e6d6451cca3b397e655f7c094
commit: 8f5893b867907f2e6d6451cca3b397e655f7c094 [6/6] remove call_{read,write}_iter() functions
config: i386-randconfig-001-20240204 (https://download.01.org/0day-ci/archive/20240204/202402041909.VYei40Zu-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041909.VYei40Zu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041909.VYei40Zu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/splice.c:743:9: error: call to undeclared function 'call_write_iter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     743 |                 ret = call_write_iter(out, &kiocb, &from);
         |                       ^
   1 error generated.


vim +/call_write_iter +743 fs/splice.c

6da61809822c22 Mark Fasheh       2006-10-17  651  
8d0207652cbe27 Al Viro           2014-04-05  652  /**
8d0207652cbe27 Al Viro           2014-04-05  653   * iter_file_splice_write - splice data from a pipe to a file
8d0207652cbe27 Al Viro           2014-04-05  654   * @pipe:	pipe info
8d0207652cbe27 Al Viro           2014-04-05  655   * @out:	file to write to
8d0207652cbe27 Al Viro           2014-04-05  656   * @ppos:	position in @out
8d0207652cbe27 Al Viro           2014-04-05  657   * @len:	number of bytes to splice
8d0207652cbe27 Al Viro           2014-04-05  658   * @flags:	splice modifier flags
8d0207652cbe27 Al Viro           2014-04-05  659   *
8d0207652cbe27 Al Viro           2014-04-05  660   * Description:
8d0207652cbe27 Al Viro           2014-04-05  661   *    Will either move or copy pages (determined by @flags options) from
8d0207652cbe27 Al Viro           2014-04-05  662   *    the given pipe inode to the given file.
8d0207652cbe27 Al Viro           2014-04-05  663   *    This one is ->write_iter-based.
8d0207652cbe27 Al Viro           2014-04-05  664   *
8d0207652cbe27 Al Viro           2014-04-05  665   */
8d0207652cbe27 Al Viro           2014-04-05  666  ssize_t
8d0207652cbe27 Al Viro           2014-04-05  667  iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
8d0207652cbe27 Al Viro           2014-04-05  668  			  loff_t *ppos, size_t len, unsigned int flags)
8d0207652cbe27 Al Viro           2014-04-05  669  {
8d0207652cbe27 Al Viro           2014-04-05  670  	struct splice_desc sd = {
8d0207652cbe27 Al Viro           2014-04-05  671  		.total_len = len,
8d0207652cbe27 Al Viro           2014-04-05  672  		.flags = flags,
8d0207652cbe27 Al Viro           2014-04-05  673  		.pos = *ppos,
8d0207652cbe27 Al Viro           2014-04-05  674  		.u.file = out,
8d0207652cbe27 Al Viro           2014-04-05  675  	};
6718b6f855a0b4 David Howells     2019-10-16  676  	int nbufs = pipe->max_usage;
d53471ba6f7ae9 Amir Goldstein    2023-11-23  677  	struct bio_vec *array;
8d0207652cbe27 Al Viro           2014-04-05  678  	ssize_t ret;
8d0207652cbe27 Al Viro           2014-04-05  679  
d53471ba6f7ae9 Amir Goldstein    2023-11-23  680  	if (!out->f_op->write_iter)
d53471ba6f7ae9 Amir Goldstein    2023-11-23  681  		return -EINVAL;
d53471ba6f7ae9 Amir Goldstein    2023-11-23  682  
d53471ba6f7ae9 Amir Goldstein    2023-11-23  683  	array = kcalloc(nbufs, sizeof(struct bio_vec), GFP_KERNEL);
8d0207652cbe27 Al Viro           2014-04-05  684  	if (unlikely(!array))
8d0207652cbe27 Al Viro           2014-04-05  685  		return -ENOMEM;
8d0207652cbe27 Al Viro           2014-04-05  686  
8d0207652cbe27 Al Viro           2014-04-05  687  	pipe_lock(pipe);
8d0207652cbe27 Al Viro           2014-04-05  688  
8d0207652cbe27 Al Viro           2014-04-05  689  	splice_from_pipe_begin(&sd);
8d0207652cbe27 Al Viro           2014-04-05  690  	while (sd.total_len) {
d53471ba6f7ae9 Amir Goldstein    2023-11-23  691  		struct kiocb kiocb;
8d0207652cbe27 Al Viro           2014-04-05  692  		struct iov_iter from;
ec057595cb3fb3 Linus Torvalds    2019-12-06  693  		unsigned int head, tail, mask;
8d0207652cbe27 Al Viro           2014-04-05  694  		size_t left;
8cefc107ca54c8 David Howells     2019-11-15  695  		int n;
8d0207652cbe27 Al Viro           2014-04-05  696  
8d0207652cbe27 Al Viro           2014-04-05  697  		ret = splice_from_pipe_next(pipe, &sd);
8d0207652cbe27 Al Viro           2014-04-05  698  		if (ret <= 0)
8d0207652cbe27 Al Viro           2014-04-05  699  			break;
8d0207652cbe27 Al Viro           2014-04-05  700  
6718b6f855a0b4 David Howells     2019-10-16  701  		if (unlikely(nbufs < pipe->max_usage)) {
8d0207652cbe27 Al Viro           2014-04-05  702  			kfree(array);
6718b6f855a0b4 David Howells     2019-10-16  703  			nbufs = pipe->max_usage;
8d0207652cbe27 Al Viro           2014-04-05  704  			array = kcalloc(nbufs, sizeof(struct bio_vec),
8d0207652cbe27 Al Viro           2014-04-05  705  					GFP_KERNEL);
8d0207652cbe27 Al Viro           2014-04-05  706  			if (!array) {
8d0207652cbe27 Al Viro           2014-04-05  707  				ret = -ENOMEM;
8d0207652cbe27 Al Viro           2014-04-05  708  				break;
8d0207652cbe27 Al Viro           2014-04-05  709  			}
8d0207652cbe27 Al Viro           2014-04-05  710  		}
8d0207652cbe27 Al Viro           2014-04-05  711  
ec057595cb3fb3 Linus Torvalds    2019-12-06  712  		head = pipe->head;
ec057595cb3fb3 Linus Torvalds    2019-12-06  713  		tail = pipe->tail;
ec057595cb3fb3 Linus Torvalds    2019-12-06  714  		mask = pipe->ring_size - 1;
ec057595cb3fb3 Linus Torvalds    2019-12-06  715  
8d0207652cbe27 Al Viro           2014-04-05  716  		/* build the vector */
8d0207652cbe27 Al Viro           2014-04-05  717  		left = sd.total_len;
0f1d344feb5345 Pavel Begunkov    2021-01-09  718  		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++) {
8cefc107ca54c8 David Howells     2019-11-15  719  			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
8d0207652cbe27 Al Viro           2014-04-05  720  			size_t this_len = buf->len;
8d0207652cbe27 Al Viro           2014-04-05  721  
0f1d344feb5345 Pavel Begunkov    2021-01-09  722  			/* zero-length bvecs are not supported, skip them */
0f1d344feb5345 Pavel Begunkov    2021-01-09  723  			if (!this_len)
0f1d344feb5345 Pavel Begunkov    2021-01-09  724  				continue;
0f1d344feb5345 Pavel Begunkov    2021-01-09  725  			this_len = min(this_len, left);
8d0207652cbe27 Al Viro           2014-04-05  726  
fba597db4218ac Miklos Szeredi    2016-09-27  727  			ret = pipe_buf_confirm(pipe, buf);
8d0207652cbe27 Al Viro           2014-04-05  728  			if (unlikely(ret)) {
8d0207652cbe27 Al Viro           2014-04-05  729  				if (ret == -ENODATA)
8d0207652cbe27 Al Viro           2014-04-05  730  					ret = 0;
8d0207652cbe27 Al Viro           2014-04-05  731  				goto done;
8d0207652cbe27 Al Viro           2014-04-05  732  			}
8d0207652cbe27 Al Viro           2014-04-05  733  
664e40789abaad Christoph Hellwig 2023-02-03  734  			bvec_set_page(&array[n], buf->page, this_len,
664e40789abaad Christoph Hellwig 2023-02-03  735  				      buf->offset);
8d0207652cbe27 Al Viro           2014-04-05  736  			left -= this_len;
0f1d344feb5345 Pavel Begunkov    2021-01-09  737  			n++;
8d0207652cbe27 Al Viro           2014-04-05  738  		}
8d0207652cbe27 Al Viro           2014-04-05  739  
de4eda9de2d957 Al Viro           2022-09-15  740  		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
d53471ba6f7ae9 Amir Goldstein    2023-11-23  741  		init_sync_kiocb(&kiocb, out);
d53471ba6f7ae9 Amir Goldstein    2023-11-23  742  		kiocb.ki_pos = sd.pos;
d53471ba6f7ae9 Amir Goldstein    2023-11-23 @743  		ret = call_write_iter(out, &kiocb, &from);
d53471ba6f7ae9 Amir Goldstein    2023-11-23  744  		sd.pos = kiocb.ki_pos;
8d0207652cbe27 Al Viro           2014-04-05  745  		if (ret <= 0)
8d0207652cbe27 Al Viro           2014-04-05  746  			break;
8d0207652cbe27 Al Viro           2014-04-05  747  
8d0207652cbe27 Al Viro           2014-04-05  748  		sd.num_spliced += ret;
8d0207652cbe27 Al Viro           2014-04-05  749  		sd.total_len -= ret;
dbe4e192a234cd Christoph Hellwig 2015-01-25  750  		*ppos = sd.pos;
8d0207652cbe27 Al Viro           2014-04-05  751  
8d0207652cbe27 Al Viro           2014-04-05  752  		/* dismiss the fully eaten buffers, adjust the partial one */
8cefc107ca54c8 David Howells     2019-11-15  753  		tail = pipe->tail;
8d0207652cbe27 Al Viro           2014-04-05  754  		while (ret) {
8cefc107ca54c8 David Howells     2019-11-15  755  			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
8d0207652cbe27 Al Viro           2014-04-05  756  			if (ret >= buf->len) {
8d0207652cbe27 Al Viro           2014-04-05  757  				ret -= buf->len;
8d0207652cbe27 Al Viro           2014-04-05  758  				buf->len = 0;
a779638cf622f0 Miklos Szeredi    2016-09-27  759  				pipe_buf_release(pipe, buf);
8cefc107ca54c8 David Howells     2019-11-15  760  				tail++;
8cefc107ca54c8 David Howells     2019-11-15  761  				pipe->tail = tail;
8d0207652cbe27 Al Viro           2014-04-05  762  				if (pipe->files)
8d0207652cbe27 Al Viro           2014-04-05  763  					sd.need_wakeup = true;
8d0207652cbe27 Al Viro           2014-04-05  764  			} else {
8d0207652cbe27 Al Viro           2014-04-05  765  				buf->offset += ret;
8d0207652cbe27 Al Viro           2014-04-05  766  				buf->len -= ret;
8d0207652cbe27 Al Viro           2014-04-05  767  				ret = 0;
8d0207652cbe27 Al Viro           2014-04-05  768  			}
8d0207652cbe27 Al Viro           2014-04-05  769  		}
8d0207652cbe27 Al Viro           2014-04-05  770  	}
8d0207652cbe27 Al Viro           2014-04-05  771  done:
8d0207652cbe27 Al Viro           2014-04-05  772  	kfree(array);
8d0207652cbe27 Al Viro           2014-04-05  773  	splice_from_pipe_end(pipe, &sd);
8d0207652cbe27 Al Viro           2014-04-05  774  
8d0207652cbe27 Al Viro           2014-04-05  775  	pipe_unlock(pipe);
8d0207652cbe27 Al Viro           2014-04-05  776  
8d0207652cbe27 Al Viro           2014-04-05  777  	if (sd.num_spliced)
8d0207652cbe27 Al Viro           2014-04-05  778  		ret = sd.num_spliced;
8d0207652cbe27 Al Viro           2014-04-05  779  
8d0207652cbe27 Al Viro           2014-04-05  780  	return ret;
8d0207652cbe27 Al Viro           2014-04-05  781  }
8d0207652cbe27 Al Viro           2014-04-05  782  

:::::: The code at line 743 was first introduced by commit
:::::: d53471ba6f7ae97a4e223539029528108b705af1 splice: remove permission hook from iter_file_splice_write()

:::::: TO: Amir Goldstein <amir73il@gmail.com>
:::::: CC: Christian Brauner <brauner@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

