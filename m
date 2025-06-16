Return-Path: <linux-fsdevel+bounces-51812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70272ADBA7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB4F1890967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E89289E03;
	Mon, 16 Jun 2025 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIbLmxFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CD69D2B;
	Mon, 16 Jun 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104062; cv=none; b=OAFKhK2dwusAsaI9I92YGmgUbfBMYO8ToH6mSxLnpGw85SZ4ISzuOyG9odnflyU60nDL+mHI9o2hq3HnmMiWJQoPnvV/iQf68xJapFUgZu5IzV2pvdKGd5sJ7WUlLeK6n1i3OdvDMcJS0ix3LCQ5LIQSnKmNBROQlBojoHwM3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104062; c=relaxed/simple;
	bh=63g4BFyDRQ9zPpgQi+aKRKc8QZqr403zshqDeyAnLYU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jIc2r6LRBQWcnqoBcRYMje1JBF1wpMfBaJ9IJDGtv5E3BNw6b1fQMYrYTPc0Ki/OJUQI4q+W+mVf98FcrbXSdnoD8LwLXfSjO4uopwW1NE1Az3erIrSgTPcfbUj2oeXqZu7rkJNpmGY1Ah6kR1307S3uP4u7Apa/GQXYTflahFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIbLmxFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77AC4CEEA;
	Mon, 16 Jun 2025 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750104061;
	bh=63g4BFyDRQ9zPpgQi+aKRKc8QZqr403zshqDeyAnLYU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MIbLmxFkQvDlWahGwOzhitZt0cSzoXdhWUHu8g8OkqZLAupve4SlpvOS2uS1ZEWmj
	 UwQ2s8yA8tAesX44zSYXdwSfJqH8TXAO82zH05g97Z/1UOjr1700+pmtNnzQBgsvl8
	 4ex7UC260hPMrrevOuoNx+ItcoPEWmxAHO8kKS0LskJGXsmB+Lw+lBdLI7AmEbxTyi
	 Xaylvf43oG7bbuZKo2MFBbk3fvcCNc7E3lsmsbzOnTEhXlMNNdjS9szSMRmncYZuuz
	 cV+XE+08Pnq5bgJ/0F99pB6Ea9gbVg9z6nnYTpH3+D1YHFBxVujigA5wdVTvZ/xroj
	 anLaWnk5pcMew==
Date: Mon, 16 Jun 2025 13:01:00 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
CC: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Tigran A . Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>,
 Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng <chengzhihao1@huawei.com>,
 Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-aio@kvack.org,
 linux-unionfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_03/10=5D_fs=3A_consistently_u?=
 =?US-ASCII?Q?se_file=5Fhas=5Fvalid=5Fmmap=5Fhooks=28=29_helper?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b68145b609532e62bab603dd9686faa6562046ec.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com> <b68145b609532e62bab603dd9686faa6562046ec.1750099179.git.lorenzo.stoakes@oracle.com>
Message-ID: <E0284B4E-A675-4855-87C8-CD13979710D6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 16, 2025 12:33:22 PM PDT, Lorenzo Stoakes <lorenzo=2Estoakes@oracl=
e=2Ecom> wrote:
>Since commit c84bf6dd2b83 ("mm: introduce new =2Emmap_prepare() file
>callback"), the f_op->mmap() hook has been deprecated in favour of
>f_op->mmap_prepare()=2E
>
>Additionally, commit bb666b7c2707 ("mm: add mmap_prepare() compatibility
>layer for nested file systems") permits the use of the =2Emmap_prepare() =
hook
>even in nested filesystems like overlayfs=2E
>
>There are a number of places where we check only for f_op->mmap - this is
>incorrect now mmap_prepare exists, so update all of these to use the
>general helper file_has_valid_mmap_hooks()=2E
>
>Most notably, this updates the elf logic to allow for the ability to
>execute binaries on filesystems which have the =2Emmap_prepare hook, but
>additionally we update nested filesystems=2E
>
>Signed-off-by: Lorenzo Stoakes <lorenzo=2Estoakes@oracle=2Ecom>
>---
> fs/backing-file=2Ec     | 2 +-
> fs/binfmt_elf=2Ec       | 4 ++--
> fs/binfmt_elf_fdpic=2Ec | 2 +-

Thanks for the refactoring!

Acked-by: Kees Cook<kees@kernel=2Eorg>


--=20
Kees Cook

