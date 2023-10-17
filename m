Return-Path: <linux-fsdevel+bounces-508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E867CBA5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 07:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0B21C20B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 05:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC6C155;
	Tue, 17 Oct 2023 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G/8MMlC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D168C134
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 05:50:44 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E2B9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uVNo3e2jqLDSok7VxZ2csgFZJHEvyUH0i7SUrzYWQzw=; b=G/8MMlC9GhkGCanSlYwLbU2rXu
	GJtod75SbNjbQgELtBRbKsLLMxjwNAWLoW0GWQjaGrmNn3uRJwUemISdJJe3DNcHEFfW3iryKEWOk
	wWTG6740X8KkVbQyjXGwNNCoNogPBBFn0kEj6t6nRSsGNEDZTnyHmqKKOHEV3uwuDP2c7Y5mp1FAb
	QcBI2Wtu+cyI1F9+YtAyzKo0+9HeYXLXvMcbTPO9wqLdFoS6wVZmAkBD7HQ+HOw57iUodc9FRTq7L
	VHO/r/udaKsKDwpYKE418WbxfcO27+ADxa1VwYyuR0LBqa7Y/otuRUTFGCkqdYJVlIriw53a8RdI7
	hWBLwyag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qscyW-001x8d-2o;
	Tue, 17 Oct 2023 05:50:41 +0000
Date: Tue, 17 Oct 2023 06:50:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [RFC] weirdness in f2fs_rename() with RENAME_WHITEOUT
Message-ID: <20231017055040.GN800259@ZenIV>
References: <20231011195620.GW800259@ZenIV>
 <20231011203412.GA85476@ZenIV>
 <CAHk-=wjSbompMCgMwR2-MB59QDB+OZ7Ohp878QoDc9o7z4pbNg@mail.gmail.com>
 <20231011215138.GX800259@ZenIV>
 <20231011230105.GA92231@ZenIV>
 <CAHfrynNbfPtAjY4Y7N0cyWyH35dyF_BcpfR58ASCCC7=-TfSFw@mail.gmail.com>
 <20231012050209.GY800259@ZenIV>
 <20231012103157.mmn6sv4e6hfrqkai@quack3>
 <20231012145758.yopnkhijksae5akp@quack3>
 <20231012191551.GZ800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012191551.GZ800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[f2fs folks Cc'd]

	There's something very odd in f2fs_rename();
this:
        f2fs_down_write(&F2FS_I(old_inode)->i_sem);
        if (!old_dir_entry || whiteout)
                file_lost_pino(old_inode);
        else   
                /* adjust dir's i_pino to pass fsck check */
                f2fs_i_pino_write(old_inode, new_dir->i_ino);
        f2fs_up_write(&F2FS_I(old_inode)->i_sem);
and this:
                if (old_dir != new_dir && !whiteout)
                        f2fs_set_link(old_inode, old_dir_entry,
                                                old_dir_page, new_dir);
                else
                        f2fs_put_page(old_dir_page, 0);
The latter really stinks, especially considering
struct dentry *f2fs_get_parent(struct dentry *child)
{
        struct page *page;
        unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &page);

        if (!ino) {
                if (IS_ERR(page))
                        return ERR_CAST(page);
                return ERR_PTR(-ENOENT);
        }
        return d_obtain_alias(f2fs_iget(child->d_sb, ino));
}

You want correct inumber in the ".." link.  And cross-directory
rename does move the source to new parent, even if you'd been asked
to leave a whiteout in the old place.

Why is that stuff conditional on whiteout?  AFAICS, that went into the
tree in the same commit that added RENAME_WHITEOUT support on f2fs,
mentioning "For now, we just try to follow the way that xfs/ext4 use"
in commit message.  But ext4 does *NOT* do anything of that sort -
at the time of that commit the relevant piece had been
        if (old.dir_bh) {
		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
and old.dir_bh is set by
                retval = ext4_rename_dir_prepare(handle, &old);
a few lines prior, which is not conditional upon the whiteout.

What am I missing there?

