Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A523F77C869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHOHRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjHOHQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:16:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082D10F9;
        Tue, 15 Aug 2023 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083794; x=1723619794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMwrqtr45I6Xt2txlh4kL6vnb5x1hLG6Ric5UOBb0SQ=;
  b=XsntEcRXsMVDQb6Q0id+2gpg+XNe9m0jF7BEztI2MftJjN5swokk7wyv
   s9c7wSY7taK4/C2EXVkEsttYkArM1gLxxelV7gK48BGXNNwATsgkKQ8yD
   bfqNd69maJsWYWz9o5dVKQxf5ce7Yw2ElAGZvFlf4cniD4658rRozufys
   sjP3nZZ+papWVOIi+/xJ+TImGal3EyGzPofj+/JPhAWrxFStdQXYv2Xbk
   6oZBkwzRZHpHurTFBtxPvfgPekvKrCB513RObSKolkg/DHnNlPzGzclC0
   RmWEAJU7uJ20Y5tU3KAf4BDHpxIq+2PO9fBOKtVjUD0NtiD1FWXSXPUED
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369692388"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="369692388"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733750362"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733750362"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 00:16:30 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVoI1-0000l3-1S;
        Tue, 15 Aug 2023 07:16:29 +0000
Date:   Tue, 15 Aug 2023 15:16:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manas Ghandat <ghandatmanas@gmail.com>, anton@tuxera.com,
        linkinjeon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: Re: [PATCH v5] ntfs : fix shift-out-of-bounds in ntfs_iget
Message-ID: <202308151536.ErfTUJ9J-lkp@intel.com>
References: <20230815052251.107732-1-ghandatmanas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815052251.107732-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Manas,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manas-Ghandat/ntfs-fix-shift-out-of-bounds-in-ntfs_iget/20230815-132656
base:   linus/master
patch link:    https://lore.kernel.org/r/20230815052251.107732-1-ghandatmanas%40gmail.com
patch subject: [PATCH v5] ntfs : fix shift-out-of-bounds in ntfs_iget
config: mips-randconfig-r002-20230815 (https://download.01.org/0day-ci/archive/20230815/202308151536.ErfTUJ9J-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308151536.ErfTUJ9J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308151536.ErfTUJ9J-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ntfs/inode.c: In function 'ntfs_read_locked_inode':
>> fs/ntfs/inode.c:1081:36: error: 'ntfs_volume' has no member named 'sparse_compression_unit'
    1081 |                                 vol->sparse_compression_unit) {
         |                                    ^~
   In file included from fs/ntfs/inode.h:25,
                    from fs/ntfs/aops.h:18,
                    from fs/ntfs/inode.c:18:
   fs/ntfs/inode.c:1085:44: error: 'ntfs_volume' has no member named 'sparse_compression_unit'
    1085 |                                         vol->sparse_compression_unit);
         |                                            ^~
   fs/ntfs/debug.h:55:73: note: in definition of macro 'ntfs_error'
      55 | #define ntfs_error(sb, f, a...)         __ntfs_error(__func__, sb, f, ##a)
         |                                                                         ^


vim +1081 fs/ntfs/inode.c

   497	
   498	/**
   499	 * ntfs_read_locked_inode - read an inode from its device
   500	 * @vi:		inode to read
   501	 *
   502	 * ntfs_read_locked_inode() is called from ntfs_iget() to read the inode
   503	 * described by @vi into memory from the device.
   504	 *
   505	 * The only fields in @vi that we need to/can look at when the function is
   506	 * called are i_sb, pointing to the mounted device's super block, and i_ino,
   507	 * the number of the inode to load.
   508	 *
   509	 * ntfs_read_locked_inode() maps, pins and locks the mft record number i_ino
   510	 * for reading and sets up the necessary @vi fields as well as initializing
   511	 * the ntfs inode.
   512	 *
   513	 * Q: What locks are held when the function is called?
   514	 * A: i_state has I_NEW set, hence the inode is locked, also
   515	 *    i_count is set to 1, so it is not going to go away
   516	 *    i_flags is set to 0 and we have no business touching it.  Only an ioctl()
   517	 *    is allowed to write to them. We should of course be honouring them but
   518	 *    we need to do that using the IS_* macros defined in include/linux/fs.h.
   519	 *    In any case ntfs_read_locked_inode() has nothing to do with i_flags.
   520	 *
   521	 * Return 0 on success and -errno on error.  In the error case, the inode will
   522	 * have had make_bad_inode() executed on it.
   523	 */
   524	static int ntfs_read_locked_inode(struct inode *vi)
   525	{
   526		ntfs_volume *vol = NTFS_SB(vi->i_sb);
   527		ntfs_inode *ni;
   528		struct inode *bvi;
   529		MFT_RECORD *m;
   530		ATTR_RECORD *a;
   531		STANDARD_INFORMATION *si;
   532		ntfs_attr_search_ctx *ctx;
   533		int err = 0;
   534	
   535		ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
   536	
   537		/* Setup the generic vfs inode parts now. */
   538		vi->i_uid = vol->uid;
   539		vi->i_gid = vol->gid;
   540		vi->i_mode = 0;
   541	
   542		/*
   543		 * Initialize the ntfs specific part of @vi special casing
   544		 * FILE_MFT which we need to do at mount time.
   545		 */
   546		if (vi->i_ino != FILE_MFT)
   547			ntfs_init_big_inode(vi);
   548		ni = NTFS_I(vi);
   549	
   550		m = map_mft_record(ni);
   551		if (IS_ERR(m)) {
   552			err = PTR_ERR(m);
   553			goto err_out;
   554		}
   555		ctx = ntfs_attr_get_search_ctx(ni, m);
   556		if (!ctx) {
   557			err = -ENOMEM;
   558			goto unm_err_out;
   559		}
   560	
   561		if (!(m->flags & MFT_RECORD_IN_USE)) {
   562			ntfs_error(vi->i_sb, "Inode is not in use!");
   563			goto unm_err_out;
   564		}
   565		if (m->base_mft_record) {
   566			ntfs_error(vi->i_sb, "Inode is an extent inode!");
   567			goto unm_err_out;
   568		}
   569	
   570		/* Transfer information from mft record into vfs and ntfs inodes. */
   571		vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
   572	
   573		/*
   574		 * FIXME: Keep in mind that link_count is two for files which have both
   575		 * a long file name and a short file name as separate entries, so if
   576		 * we are hiding short file names this will be too high. Either we need
   577		 * to account for the short file names by subtracting them or we need
   578		 * to make sure we delete files even though i_nlink is not zero which
   579		 * might be tricky due to vfs interactions. Need to think about this
   580		 * some more when implementing the unlink command.
   581		 */
   582		set_nlink(vi, le16_to_cpu(m->link_count));
   583		/*
   584		 * FIXME: Reparse points can have the directory bit set even though
   585		 * they would be S_IFLNK. Need to deal with this further below when we
   586		 * implement reparse points / symbolic links but it will do for now.
   587		 * Also if not a directory, it could be something else, rather than
   588		 * a regular file. But again, will do for now.
   589		 */
   590		/* Everyone gets all permissions. */
   591		vi->i_mode |= S_IRWXUGO;
   592		/* If read-only, no one gets write permissions. */
   593		if (IS_RDONLY(vi))
   594			vi->i_mode &= ~S_IWUGO;
   595		if (m->flags & MFT_RECORD_IS_DIRECTORY) {
   596			vi->i_mode |= S_IFDIR;
   597			/*
   598			 * Apply the directory permissions mask set in the mount
   599			 * options.
   600			 */
   601			vi->i_mode &= ~vol->dmask;
   602			/* Things break without this kludge! */
   603			if (vi->i_nlink > 1)
   604				set_nlink(vi, 1);
   605		} else {
   606			vi->i_mode |= S_IFREG;
   607			/* Apply the file permissions mask set in the mount options. */
   608			vi->i_mode &= ~vol->fmask;
   609		}
   610		/*
   611		 * Find the standard information attribute in the mft record. At this
   612		 * stage we haven't setup the attribute list stuff yet, so this could
   613		 * in fact fail if the standard information is in an extent record, but
   614		 * I don't think this actually ever happens.
   615		 */
   616		err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
   617				ctx);
   618		if (unlikely(err)) {
   619			if (err == -ENOENT) {
   620				/*
   621				 * TODO: We should be performing a hot fix here (if the
   622				 * recover mount option is set) by creating a new
   623				 * attribute.
   624				 */
   625				ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute "
   626						"is missing.");
   627			}
   628			goto unm_err_out;
   629		}
   630		a = ctx->attr;
   631		/* Get the standard information attribute value. */
   632		if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
   633				+ le32_to_cpu(a->data.resident.value_length) >
   634				(u8 *)ctx->mrec + vol->mft_record_size) {
   635			ntfs_error(vi->i_sb, "Corrupt standard information attribute in inode.");
   636			goto unm_err_out;
   637		}
   638		si = (STANDARD_INFORMATION*)((u8*)a +
   639				le16_to_cpu(a->data.resident.value_offset));
   640	
   641		/* Transfer information from the standard information into vi. */
   642		/*
   643		 * Note: The i_?times do not quite map perfectly onto the NTFS times,
   644		 * but they are close enough, and in the end it doesn't really matter
   645		 * that much...
   646		 */
   647		/*
   648		 * mtime is the last change of the data within the file. Not changed
   649		 * when only metadata is changed, e.g. a rename doesn't affect mtime.
   650		 */
   651		vi->i_mtime = ntfs2utc(si->last_data_change_time);
   652		/*
   653		 * ctime is the last change of the metadata of the file. This obviously
   654		 * always changes, when mtime is changed. ctime can be changed on its
   655		 * own, mtime is then not changed, e.g. when a file is renamed.
   656		 */
   657		vi->i_ctime = ntfs2utc(si->last_mft_change_time);
   658		/*
   659		 * Last access to the data within the file. Not changed during a rename
   660		 * for example but changed whenever the file is written to.
   661		 */
   662		vi->i_atime = ntfs2utc(si->last_access_time);
   663	
   664		/* Find the attribute list attribute if present. */
   665		ntfs_attr_reinit_search_ctx(ctx);
   666		err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
   667		if (err) {
   668			if (unlikely(err != -ENOENT)) {
   669				ntfs_error(vi->i_sb, "Failed to lookup attribute list "
   670						"attribute.");
   671				goto unm_err_out;
   672			}
   673		} else /* if (!err) */ {
   674			if (vi->i_ino == FILE_MFT)
   675				goto skip_attr_list_load;
   676			ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
   677			NInoSetAttrList(ni);
   678			a = ctx->attr;
   679			if (a->flags & ATTR_COMPRESSION_MASK) {
   680				ntfs_error(vi->i_sb, "Attribute list attribute is "
   681						"compressed.");
   682				goto unm_err_out;
   683			}
   684			if (a->flags & ATTR_IS_ENCRYPTED ||
   685					a->flags & ATTR_IS_SPARSE) {
   686				if (a->non_resident) {
   687					ntfs_error(vi->i_sb, "Non-resident attribute "
   688							"list attribute is encrypted/"
   689							"sparse.");
   690					goto unm_err_out;
   691				}
   692				ntfs_warning(vi->i_sb, "Resident attribute list "
   693						"attribute in inode 0x%lx is marked "
   694						"encrypted/sparse which is not true.  "
   695						"However, Windows allows this and "
   696						"chkdsk does not detect or correct it "
   697						"so we will just ignore the invalid "
   698						"flags and pretend they are not set.",
   699						vi->i_ino);
   700			}
   701			/* Now allocate memory for the attribute list. */
   702			ni->attr_list_size = (u32)ntfs_attr_size(a);
   703			ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
   704			if (!ni->attr_list) {
   705				ntfs_error(vi->i_sb, "Not enough memory to allocate "
   706						"buffer for attribute list.");
   707				err = -ENOMEM;
   708				goto unm_err_out;
   709			}
   710			if (a->non_resident) {
   711				NInoSetAttrListNonResident(ni);
   712				if (a->data.non_resident.lowest_vcn) {
   713					ntfs_error(vi->i_sb, "Attribute list has non "
   714							"zero lowest_vcn.");
   715					goto unm_err_out;
   716				}
   717				/*
   718				 * Setup the runlist. No need for locking as we have
   719				 * exclusive access to the inode at this time.
   720				 */
   721				ni->attr_list_rl.rl = ntfs_mapping_pairs_decompress(vol,
   722						a, NULL);
   723				if (IS_ERR(ni->attr_list_rl.rl)) {
   724					err = PTR_ERR(ni->attr_list_rl.rl);
   725					ni->attr_list_rl.rl = NULL;
   726					ntfs_error(vi->i_sb, "Mapping pairs "
   727							"decompression failed.");
   728					goto unm_err_out;
   729				}
   730				/* Now load the attribute list. */
   731				if ((err = load_attribute_list(vol, &ni->attr_list_rl,
   732						ni->attr_list, ni->attr_list_size,
   733						sle64_to_cpu(a->data.non_resident.
   734						initialized_size)))) {
   735					ntfs_error(vi->i_sb, "Failed to load "
   736							"attribute list attribute.");
   737					goto unm_err_out;
   738				}
   739			} else /* if (!a->non_resident) */ {
   740				if ((u8*)a + le16_to_cpu(a->data.resident.value_offset)
   741						+ le32_to_cpu(
   742						a->data.resident.value_length) >
   743						(u8*)ctx->mrec + vol->mft_record_size) {
   744					ntfs_error(vi->i_sb, "Corrupt attribute list "
   745							"in inode.");
   746					goto unm_err_out;
   747				}
   748				/* Now copy the attribute list. */
   749				memcpy(ni->attr_list, (u8*)a + le16_to_cpu(
   750						a->data.resident.value_offset),
   751						le32_to_cpu(
   752						a->data.resident.value_length));
   753			}
   754		}
   755	skip_attr_list_load:
   756		/*
   757		 * If an attribute list is present we now have the attribute list value
   758		 * in ntfs_ino->attr_list and it is ntfs_ino->attr_list_size bytes.
   759		 */
   760		if (S_ISDIR(vi->i_mode)) {
   761			loff_t bvi_size;
   762			ntfs_inode *bni;
   763			INDEX_ROOT *ir;
   764			u8 *ir_end, *index_end;
   765	
   766			/* It is a directory, find index root attribute. */
   767			ntfs_attr_reinit_search_ctx(ctx);
   768			err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE,
   769					0, NULL, 0, ctx);
   770			if (unlikely(err)) {
   771				if (err == -ENOENT) {
   772					// FIXME: File is corrupt! Hot-fix with empty
   773					// index root attribute if recovery option is
   774					// set.
   775					ntfs_error(vi->i_sb, "$INDEX_ROOT attribute "
   776							"is missing.");
   777				}
   778				goto unm_err_out;
   779			}
   780			a = ctx->attr;
   781			/* Set up the state. */
   782			if (unlikely(a->non_resident)) {
   783				ntfs_error(vol->sb, "$INDEX_ROOT attribute is not "
   784						"resident.");
   785				goto unm_err_out;
   786			}
   787			/* Ensure the attribute name is placed before the value. */
   788			if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
   789					le16_to_cpu(a->data.resident.value_offset)))) {
   790				ntfs_error(vol->sb, "$INDEX_ROOT attribute name is "
   791						"placed after the attribute value.");
   792				goto unm_err_out;
   793			}
   794			/*
   795			 * Compressed/encrypted index root just means that the newly
   796			 * created files in that directory should be created compressed/
   797			 * encrypted. However index root cannot be both compressed and
   798			 * encrypted.
   799			 */
   800			if (a->flags & ATTR_COMPRESSION_MASK)
   801				NInoSetCompressed(ni);
   802			if (a->flags & ATTR_IS_ENCRYPTED) {
   803				if (a->flags & ATTR_COMPRESSION_MASK) {
   804					ntfs_error(vi->i_sb, "Found encrypted and "
   805							"compressed attribute.");
   806					goto unm_err_out;
   807				}
   808				NInoSetEncrypted(ni);
   809			}
   810			if (a->flags & ATTR_IS_SPARSE)
   811				NInoSetSparse(ni);
   812			ir = (INDEX_ROOT*)((u8*)a +
   813					le16_to_cpu(a->data.resident.value_offset));
   814			ir_end = (u8*)ir + le32_to_cpu(a->data.resident.value_length);
   815			if (ir_end > (u8*)ctx->mrec + vol->mft_record_size) {
   816				ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
   817						"corrupt.");
   818				goto unm_err_out;
   819			}
   820			index_end = (u8*)&ir->index +
   821					le32_to_cpu(ir->index.index_length);
   822			if (index_end > ir_end) {
   823				ntfs_error(vi->i_sb, "Directory index is corrupt.");
   824				goto unm_err_out;
   825			}
   826			if (ir->type != AT_FILE_NAME) {
   827				ntfs_error(vi->i_sb, "Indexed attribute is not "
   828						"$FILE_NAME.");
   829				goto unm_err_out;
   830			}
   831			if (ir->collation_rule != COLLATION_FILE_NAME) {
   832				ntfs_error(vi->i_sb, "Index collation rule is not "
   833						"COLLATION_FILE_NAME.");
   834				goto unm_err_out;
   835			}
   836			ni->itype.index.collation_rule = ir->collation_rule;
   837			ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
   838			if (ni->itype.index.block_size &
   839					(ni->itype.index.block_size - 1)) {
   840				ntfs_error(vi->i_sb, "Index block size (%u) is not a "
   841						"power of two.",
   842						ni->itype.index.block_size);
   843				goto unm_err_out;
   844			}
   845			if (ni->itype.index.block_size > PAGE_SIZE) {
   846				ntfs_error(vi->i_sb, "Index block size (%u) > "
   847						"PAGE_SIZE (%ld) is not "
   848						"supported.  Sorry.",
   849						ni->itype.index.block_size,
   850						PAGE_SIZE);
   851				err = -EOPNOTSUPP;
   852				goto unm_err_out;
   853			}
   854			if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
   855				ntfs_error(vi->i_sb, "Index block size (%u) < "
   856						"NTFS_BLOCK_SIZE (%i) is not "
   857						"supported.  Sorry.",
   858						ni->itype.index.block_size,
   859						NTFS_BLOCK_SIZE);
   860				err = -EOPNOTSUPP;
   861				goto unm_err_out;
   862			}
   863			ni->itype.index.block_size_bits =
   864					ffs(ni->itype.index.block_size) - 1;
   865			/* Determine the size of a vcn in the directory index. */
   866			if (vol->cluster_size <= ni->itype.index.block_size) {
   867				ni->itype.index.vcn_size = vol->cluster_size;
   868				ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
   869			} else {
   870				ni->itype.index.vcn_size = vol->sector_size;
   871				ni->itype.index.vcn_size_bits = vol->sector_size_bits;
   872			}
   873	
   874			/* Setup the index allocation attribute, even if not present. */
   875			NInoSetMstProtected(ni);
   876			ni->type = AT_INDEX_ALLOCATION;
   877			ni->name = I30;
   878			ni->name_len = 4;
   879	
   880			if (!(ir->index.flags & LARGE_INDEX)) {
   881				/* No index allocation. */
   882				vi->i_size = ni->initialized_size =
   883						ni->allocated_size = 0;
   884				/* We are done with the mft record, so we release it. */
   885				ntfs_attr_put_search_ctx(ctx);
   886				unmap_mft_record(ni);
   887				m = NULL;
   888				ctx = NULL;
   889				goto skip_large_dir_stuff;
   890			} /* LARGE_INDEX: Index allocation present. Setup state. */
   891			NInoSetIndexAllocPresent(ni);
   892			/* Find index allocation attribute. */
   893			ntfs_attr_reinit_search_ctx(ctx);
   894			err = ntfs_attr_lookup(AT_INDEX_ALLOCATION, I30, 4,
   895					CASE_SENSITIVE, 0, NULL, 0, ctx);
   896			if (unlikely(err)) {
   897				if (err == -ENOENT)
   898					ntfs_error(vi->i_sb, "$INDEX_ALLOCATION "
   899							"attribute is not present but "
   900							"$INDEX_ROOT indicated it is.");
   901				else
   902					ntfs_error(vi->i_sb, "Failed to lookup "
   903							"$INDEX_ALLOCATION "
   904							"attribute.");
   905				goto unm_err_out;
   906			}
   907			a = ctx->attr;
   908			if (!a->non_resident) {
   909				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
   910						"is resident.");
   911				goto unm_err_out;
   912			}
   913			/*
   914			 * Ensure the attribute name is placed before the mapping pairs
   915			 * array.
   916			 */
   917			if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
   918					le16_to_cpu(
   919					a->data.non_resident.mapping_pairs_offset)))) {
   920				ntfs_error(vol->sb, "$INDEX_ALLOCATION attribute name "
   921						"is placed after the mapping pairs "
   922						"array.");
   923				goto unm_err_out;
   924			}
   925			if (a->flags & ATTR_IS_ENCRYPTED) {
   926				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
   927						"is encrypted.");
   928				goto unm_err_out;
   929			}
   930			if (a->flags & ATTR_IS_SPARSE) {
   931				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
   932						"is sparse.");
   933				goto unm_err_out;
   934			}
   935			if (a->flags & ATTR_COMPRESSION_MASK) {
   936				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
   937						"is compressed.");
   938				goto unm_err_out;
   939			}
   940			if (a->data.non_resident.lowest_vcn) {
   941				ntfs_error(vi->i_sb, "First extent of "
   942						"$INDEX_ALLOCATION attribute has non "
   943						"zero lowest_vcn.");
   944				goto unm_err_out;
   945			}
   946			vi->i_size = sle64_to_cpu(a->data.non_resident.data_size);
   947			ni->initialized_size = sle64_to_cpu(
   948					a->data.non_resident.initialized_size);
   949			ni->allocated_size = sle64_to_cpu(
   950					a->data.non_resident.allocated_size);
   951			/*
   952			 * We are done with the mft record, so we release it. Otherwise
   953			 * we would deadlock in ntfs_attr_iget().
   954			 */
   955			ntfs_attr_put_search_ctx(ctx);
   956			unmap_mft_record(ni);
   957			m = NULL;
   958			ctx = NULL;
   959			/* Get the index bitmap attribute inode. */
   960			bvi = ntfs_attr_iget(vi, AT_BITMAP, I30, 4);
   961			if (IS_ERR(bvi)) {
   962				ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
   963				err = PTR_ERR(bvi);
   964				goto unm_err_out;
   965			}
   966			bni = NTFS_I(bvi);
   967			if (NInoCompressed(bni) || NInoEncrypted(bni) ||
   968					NInoSparse(bni)) {
   969				ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
   970						"and/or encrypted and/or sparse.");
   971				goto iput_unm_err_out;
   972			}
   973			/* Consistency check bitmap size vs. index allocation size. */
   974			bvi_size = i_size_read(bvi);
   975			if ((bvi_size << 3) < (vi->i_size >>
   976					ni->itype.index.block_size_bits)) {
   977				ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) "
   978						"for index allocation (0x%llx).",
   979						bvi_size << 3, vi->i_size);
   980				goto iput_unm_err_out;
   981			}
   982			/* No longer need the bitmap attribute inode. */
   983			iput(bvi);
   984	skip_large_dir_stuff:
   985			/* Setup the operations for this inode. */
   986			vi->i_op = &ntfs_dir_inode_ops;
   987			vi->i_fop = &ntfs_dir_ops;
   988			vi->i_mapping->a_ops = &ntfs_mst_aops;
   989		} else {
   990			/* It is a file. */
   991			ntfs_attr_reinit_search_ctx(ctx);
   992	
   993			/* Setup the data attribute, even if not present. */
   994			ni->type = AT_DATA;
   995			ni->name = NULL;
   996			ni->name_len = 0;
   997	
   998			/* Find first extent of the unnamed data attribute. */
   999			err = ntfs_attr_lookup(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx);
  1000			if (unlikely(err)) {
  1001				vi->i_size = ni->initialized_size =
  1002						ni->allocated_size = 0;
  1003				if (err != -ENOENT) {
  1004					ntfs_error(vi->i_sb, "Failed to lookup $DATA "
  1005							"attribute.");
  1006					goto unm_err_out;
  1007				}
  1008				/*
  1009				 * FILE_Secure does not have an unnamed $DATA
  1010				 * attribute, so we special case it here.
  1011				 */
  1012				if (vi->i_ino == FILE_Secure)
  1013					goto no_data_attr_special_case;
  1014				/*
  1015				 * Most if not all the system files in the $Extend
  1016				 * system directory do not have unnamed data
  1017				 * attributes so we need to check if the parent
  1018				 * directory of the file is FILE_Extend and if it is
  1019				 * ignore this error. To do this we need to get the
  1020				 * name of this inode from the mft record as the name
  1021				 * contains the back reference to the parent directory.
  1022				 */
  1023				if (ntfs_is_extended_system_file(ctx) > 0)
  1024					goto no_data_attr_special_case;
  1025				// FIXME: File is corrupt! Hot-fix with empty data
  1026				// attribute if recovery option is set.
  1027				ntfs_error(vi->i_sb, "$DATA attribute is missing.");
  1028				goto unm_err_out;
  1029			}
  1030			a = ctx->attr;
  1031			/* Setup the state. */
  1032			if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
  1033				if (a->flags & ATTR_COMPRESSION_MASK) {
  1034					NInoSetCompressed(ni);
  1035					if (vol->cluster_size > 4096) {
  1036						ntfs_error(vi->i_sb, "Found "
  1037								"compressed data but "
  1038								"compression is "
  1039								"disabled due to "
  1040								"cluster size (%i) > "
  1041								"4kiB.",
  1042								vol->cluster_size);
  1043						goto unm_err_out;
  1044					}
  1045					if ((a->flags & ATTR_COMPRESSION_MASK)
  1046							!= ATTR_IS_COMPRESSED) {
  1047						ntfs_error(vi->i_sb, "Found unknown "
  1048								"compression method "
  1049								"or corrupt file.");
  1050						goto unm_err_out;
  1051					}
  1052				}
  1053				if (a->flags & ATTR_IS_SPARSE)
  1054					NInoSetSparse(ni);
  1055			}
  1056			if (a->flags & ATTR_IS_ENCRYPTED) {
  1057				if (NInoCompressed(ni)) {
  1058					ntfs_error(vi->i_sb, "Found encrypted and "
  1059							"compressed data.");
  1060					goto unm_err_out;
  1061				}
  1062				NInoSetEncrypted(ni);
  1063			}
  1064			if (a->non_resident) {
  1065				NInoSetNonResident(ni);
  1066				if (NInoCompressed(ni) || NInoSparse(ni)) {
  1067					if (NInoCompressed(ni) && a->data.non_resident.
  1068							compression_unit != 4) {
  1069						ntfs_error(vi->i_sb, "Found "
  1070								"non-standard "
  1071								"compression unit (%u "
  1072								"instead of 4).  "
  1073								"Cannot handle this.",
  1074								a->data.non_resident.
  1075								compression_unit);
  1076						err = -EOPNOTSUPP;
  1077						goto unm_err_out;
  1078					}
  1079					if (NInoSparse(ni) && a->data.non_resident.compression_unit &&
  1080					a->data.non_resident.compression_unit !=
> 1081					vol->sparse_compression_unit) {
  1082						ntfs_error(vi->i_sb,
  1083						"Found non-standard compression unit (%u instead of 0 or %d).  Cannot handle this.",
  1084						a->data.non_resident.compression_unit,
  1085						vol->sparse_compression_unit);
  1086						err = -EOPNOTSUPP;
  1087						goto unm_err_out;
  1088					}
  1089					if (a->data.non_resident.compression_unit) {
  1090						ni->itype.compressed.block_size = 1U <<
  1091								(a->data.non_resident.
  1092								compression_unit +
  1093								vol->cluster_size_bits);
  1094						ni->itype.compressed.block_size_bits =
  1095								ffs(ni->itype.
  1096								compressed.
  1097								block_size) - 1;
  1098						ni->itype.compressed.block_clusters =
  1099								1U << a->data.
  1100								non_resident.
  1101								compression_unit;
  1102					} else {
  1103						ni->itype.compressed.block_size = 0;
  1104						ni->itype.compressed.block_size_bits =
  1105								0;
  1106						ni->itype.compressed.block_clusters =
  1107								0;
  1108					}
  1109					ni->itype.compressed.size = sle64_to_cpu(
  1110							a->data.non_resident.
  1111							compressed_size);
  1112				}
  1113				if (a->data.non_resident.lowest_vcn) {
  1114					ntfs_error(vi->i_sb, "First extent of $DATA "
  1115							"attribute has non zero "
  1116							"lowest_vcn.");
  1117					goto unm_err_out;
  1118				}
  1119				vi->i_size = sle64_to_cpu(
  1120						a->data.non_resident.data_size);
  1121				ni->initialized_size = sle64_to_cpu(
  1122						a->data.non_resident.initialized_size);
  1123				ni->allocated_size = sle64_to_cpu(
  1124						a->data.non_resident.allocated_size);
  1125			} else { /* Resident attribute. */
  1126				vi->i_size = ni->initialized_size = le32_to_cpu(
  1127						a->data.resident.value_length);
  1128				ni->allocated_size = le32_to_cpu(a->length) -
  1129						le16_to_cpu(
  1130						a->data.resident.value_offset);
  1131				if (vi->i_size > ni->allocated_size) {
  1132					ntfs_error(vi->i_sb, "Resident data attribute "
  1133							"is corrupt (size exceeds "
  1134							"allocation).");
  1135					goto unm_err_out;
  1136				}
  1137			}
  1138	no_data_attr_special_case:
  1139			/* We are done with the mft record, so we release it. */
  1140			ntfs_attr_put_search_ctx(ctx);
  1141			unmap_mft_record(ni);
  1142			m = NULL;
  1143			ctx = NULL;
  1144			/* Setup the operations for this inode. */
  1145			vi->i_op = &ntfs_file_inode_ops;
  1146			vi->i_fop = &ntfs_file_ops;
  1147			vi->i_mapping->a_ops = &ntfs_normal_aops;
  1148			if (NInoMstProtected(ni))
  1149				vi->i_mapping->a_ops = &ntfs_mst_aops;
  1150			else if (NInoCompressed(ni))
  1151				vi->i_mapping->a_ops = &ntfs_compressed_aops;
  1152		}
  1153		/*
  1154		 * The number of 512-byte blocks used on disk (for stat). This is in so
  1155		 * far inaccurate as it doesn't account for any named streams or other
  1156		 * special non-resident attributes, but that is how Windows works, too,
  1157		 * so we are at least consistent with Windows, if not entirely
  1158		 * consistent with the Linux Way. Doing it the Linux Way would cause a
  1159		 * significant slowdown as it would involve iterating over all
  1160		 * attributes in the mft record and adding the allocated/compressed
  1161		 * sizes of all non-resident attributes present to give us the Linux
  1162		 * correct size that should go into i_blocks (after division by 512).
  1163		 */
  1164		if (S_ISREG(vi->i_mode) && (NInoCompressed(ni) || NInoSparse(ni)))
  1165			vi->i_blocks = ni->itype.compressed.size >> 9;
  1166		else
  1167			vi->i_blocks = ni->allocated_size >> 9;
  1168		ntfs_debug("Done.");
  1169		return 0;
  1170	iput_unm_err_out:
  1171		iput(bvi);
  1172	unm_err_out:
  1173		if (!err)
  1174			err = -EIO;
  1175		if (ctx)
  1176			ntfs_attr_put_search_ctx(ctx);
  1177		if (m)
  1178			unmap_mft_record(ni);
  1179	err_out:
  1180		ntfs_error(vol->sb, "Failed with error code %i.  Marking corrupt "
  1181				"inode 0x%lx as bad.  Run chkdsk.", err, vi->i_ino);
  1182		make_bad_inode(vi);
  1183		if (err != -EOPNOTSUPP && err != -ENOMEM)
  1184			NVolSetErrors(vol);
  1185		return err;
  1186	}
  1187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
