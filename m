Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00F149C54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 19:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAZSa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 13:30:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:46171 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgAZSa4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:30:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 10:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="246214021"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2020 10:30:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivmg0-000EPW-GT; Mon, 27 Jan 2020 02:30:28 +0800
Date:   Mon, 27 Jan 2020 02:30:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 8/8] ubifs: Add quota support
Message-ID: <202001270202.ewwgFh1r%lkp@intel.com>
References: <20200124131323.23885-9-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124131323.23885-9-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sascha,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ext3/for_next]
[also build test WARNING on linus/master v5.5-rc7]
[cannot apply to rw-ubifs/next next-20200122]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Sascha-Hauer/Add-quota-support-to-UBIFS/20200125-175919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-153-g47b6dfef-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/ubifs/super.c:154:43: sparse: sparse: incorrect type in argument 2 (different base types)
>> fs/ubifs/super.c:154:43: sparse:    expected long long [usertype] bytes
>> fs/ubifs/super.c:154:43: sparse:    got restricted __le64 [usertype] size
--
>> fs/ubifs/tnc.c:603:5: sparse: sparse: symbol 'tnc_next' was not declared. Should it be static?
   fs/ubifs/tnc.c:2870:35: sparse: sparse: Using plain integer as NULL pointer

Please review and possibly fold the followup patch.

vim +154 fs/ubifs/super.c

    88	
    89	struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
    90	{
    91		int err;
    92		union ubifs_key key;
    93		struct ubifs_ino_node *ino;
    94		struct ubifs_info *c = sb->s_fs_info;
    95		struct inode *inode;
    96		struct ubifs_inode *ui;
    97	
    98		dbg_gen("inode %lu", inum);
    99	
   100		inode = iget_locked(sb, inum);
   101		if (!inode)
   102			return ERR_PTR(-ENOMEM);
   103		if (!(inode->i_state & I_NEW))
   104			return inode;
   105		ui = ubifs_inode(inode);
   106	
   107		ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
   108		if (!ino) {
   109			err = -ENOMEM;
   110			goto out;
   111		}
   112	
   113		ino_key_init(c, &key, inode->i_ino);
   114	
   115		err = ubifs_tnc_lookup(c, &key, ino);
   116		if (err)
   117			goto out_ino;
   118	
   119		inode->i_flags |= S_NOCMTIME;
   120	
   121		if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
   122			inode->i_flags |= S_NOATIME;
   123	
   124		set_nlink(inode, le32_to_cpu(ino->nlink));
   125		i_uid_write(inode, le32_to_cpu(ino->uid));
   126		i_gid_write(inode, le32_to_cpu(ino->gid));
   127		inode->i_atime.tv_sec  = (int64_t)le64_to_cpu(ino->atime_sec);
   128		inode->i_atime.tv_nsec = le32_to_cpu(ino->atime_nsec);
   129		inode->i_mtime.tv_sec  = (int64_t)le64_to_cpu(ino->mtime_sec);
   130		inode->i_mtime.tv_nsec = le32_to_cpu(ino->mtime_nsec);
   131		inode->i_ctime.tv_sec  = (int64_t)le64_to_cpu(ino->ctime_sec);
   132		inode->i_ctime.tv_nsec = le32_to_cpu(ino->ctime_nsec);
   133		inode->i_mode = le32_to_cpu(ino->mode);
   134		inode->i_size = le64_to_cpu(ino->size);
   135	
   136		ui->data_len    = le32_to_cpu(ino->data_len);
   137		ui->flags       = le32_to_cpu(ino->flags);
   138		ui->compr_type  = le16_to_cpu(ino->compr_type);
   139		ui->creat_sqnum = le64_to_cpu(ino->creat_sqnum);
   140		ui->xattr_cnt   = le32_to_cpu(ino->xattr_cnt);
   141		ui->xattr_size  = le32_to_cpu(ino->xattr_size);
   142		ui->xattr_names = le32_to_cpu(ino->xattr_names);
   143		ui->synced_i_size = ui->ui_size = inode->i_size;
   144		ui->projid = make_kprojid(&init_user_ns, le32_to_cpu(ino->projid));
   145	
   146		ui->xattr = (ui->flags & UBIFS_XATTR_FL) ? 1 : 0;
   147	
   148		err = validate_inode(c, inode);
   149		if (err)
   150			goto out_invalid;
   151	
   152		switch (inode->i_mode & S_IFMT) {
   153		case S_IFREG:
 > 154			inode_set_bytes(inode, ino->size);
   155			inode->i_mapping->a_ops = &ubifs_file_address_operations;
   156			inode->i_op = &ubifs_file_inode_operations;
   157			inode->i_fop = &ubifs_file_operations;
   158			if (ui->xattr) {
   159				ui->data = kmalloc(ui->data_len + 1, GFP_NOFS);
   160				if (!ui->data) {
   161					err = -ENOMEM;
   162					goto out_ino;
   163				}
   164				memcpy(ui->data, ino->data, ui->data_len);
   165				((char *)ui->data)[ui->data_len] = '\0';
   166			} else if (ui->data_len != 0) {
   167				err = 10;
   168				goto out_invalid;
   169			}
   170			break;
   171		case S_IFDIR:
   172			inode->i_op  = &ubifs_dir_inode_operations;
   173			inode->i_fop = &ubifs_dir_operations;
   174			if (ui->data_len != 0) {
   175				err = 11;
   176				goto out_invalid;
   177			}
   178			break;
   179		case S_IFLNK:
   180			inode->i_op = &ubifs_symlink_inode_operations;
   181			if (ui->data_len <= 0 || ui->data_len > UBIFS_MAX_INO_DATA) {
   182				err = 12;
   183				goto out_invalid;
   184			}
   185			ui->data = kmalloc(ui->data_len + 1, GFP_NOFS);
   186			if (!ui->data) {
   187				err = -ENOMEM;
   188				goto out_ino;
   189			}
   190			memcpy(ui->data, ino->data, ui->data_len);
   191			((char *)ui->data)[ui->data_len] = '\0';
   192			break;
   193		case S_IFBLK:
   194		case S_IFCHR:
   195		{
   196			dev_t rdev;
   197			union ubifs_dev_desc *dev;
   198	
   199			ui->data = kmalloc(sizeof(union ubifs_dev_desc), GFP_NOFS);
   200			if (!ui->data) {
   201				err = -ENOMEM;
   202				goto out_ino;
   203			}
   204	
   205			dev = (union ubifs_dev_desc *)ino->data;
   206			if (ui->data_len == sizeof(dev->new))
   207				rdev = new_decode_dev(le32_to_cpu(dev->new));
   208			else if (ui->data_len == sizeof(dev->huge))
   209				rdev = huge_decode_dev(le64_to_cpu(dev->huge));
   210			else {
   211				err = 13;
   212				goto out_invalid;
   213			}
   214			memcpy(ui->data, ino->data, ui->data_len);
   215			inode->i_op = &ubifs_file_inode_operations;
   216			init_special_inode(inode, inode->i_mode, rdev);
   217			break;
   218		}
   219		case S_IFSOCK:
   220		case S_IFIFO:
   221			inode->i_op = &ubifs_file_inode_operations;
   222			init_special_inode(inode, inode->i_mode, 0);
   223			if (ui->data_len != 0) {
   224				err = 14;
   225				goto out_invalid;
   226			}
   227			break;
   228		default:
   229			err = 15;
   230			goto out_invalid;
   231		}
   232	
   233		kfree(ino);
   234		ubifs_set_inode_flags(inode);
   235		unlock_new_inode(inode);
   236		return inode;
   237	
   238	out_invalid:
   239		ubifs_err(c, "inode %lu validation failed, error %d", inode->i_ino, err);
   240		ubifs_dump_node(c, ino);
   241		ubifs_dump_inode(c, inode);
   242		err = -EINVAL;
   243	out_ino:
   244		kfree(ino);
   245	out:
   246		ubifs_err(c, "failed to read inode %lu, error %d", inode->i_ino, err);
   247		iget_failed(inode);
   248		return ERR_PTR(err);
   249	}
   250	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
