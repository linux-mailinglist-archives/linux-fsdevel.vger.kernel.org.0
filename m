Return-Path: <linux-fsdevel+bounces-51822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7DADBD52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 00:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65393188E580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5A22A4F6;
	Mon, 16 Jun 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9LuBOmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695842264B2;
	Mon, 16 Jun 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114450; cv=none; b=uShQ17Lm273lxbpC5DNmWcsi3TI599mE7bvNqCiT0kWngLYGD1EyAc/1jfmd5J2DlxrfxWNldF3wEEznsFj17UTziR2mCgGsv55djTUkcQ79oDc4rbWqQ3bKYX5uvB4OhgIf0gwOVQdC3PUNSeDG1MyTZQLHlTASQuLBRsX3ksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114450; c=relaxed/simple;
	bh=2rQ4MWMNuiiZXr3ruKby+3pF9PtUetUIutSjWGs52xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEFL7P7/Pt3Bw7drXhTdN861rZn1o4JPEunz+07SMZNkdqN+F8Lig/lYbfOrHWPAW7dso9Bhi1ha53GxcYvHZYSVzGdRnWky5/FhhejL2pQQF8z3VhNd2tU2Z5z/AuRVVjdCoOQP45fiPZ+1SZ4TtfDgH8cBanmOyey3FC6pQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9LuBOmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F658C4CEEA;
	Mon, 16 Jun 2025 22:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750114450;
	bh=2rQ4MWMNuiiZXr3ruKby+3pF9PtUetUIutSjWGs52xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9LuBOmFGkwzRdPq0c3k3DFo+Gg7PbA5ztEVsDN9YZvn/BtbR0RubCEEUAupc/0QN
	 UyKsXWg+3Xgr8jYaXCDMYIX9AMo3NmXmNJWlhYEhfQb2Sm0ZC+2euqRHnrYZxtOuoI
	 /XOGCT4NNqf3QLkRtC5atg5JemfK28tCQYDxQ+vvt7VJIHaxKtebm4/Pva1Y9ypu3C
	 0i5AHJz8+318CUMsMSF8zAEbryPRnLo/KnKQMO3Ip+RltAyo1TepCJSxqJg7VUGaup
	 0RxiaVHPlYYqHNPaSdRNrmN5q1z0dDh0yP0RcMExF7vaS/owYzg4U/4qGi5HRJ5JK3
	 4Jr+e8uabprHQ==
Message-ID: <60615f31-7a58-4336-adaa-129408c90000@kernel.org>
Date: Tue, 17 Jun 2025 07:51:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for simple
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe
 <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
 Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
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
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng
 <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-mm@kvack.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 4:33 AM, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
> 
> This callback is invoked in the mmap() logic far earlier, so error handling
> can be performed more safely without complicated and bug-prone state
> unwinding required should an error arise.
> 
> This hook also avoids passing a pointer to a not-yet-correctly-established
> VMA avoiding any issues with referencing this data structure.
> 
> It rather provides a pointer to the new struct vm_area_desc descriptor type
> which contains all required state and allows easy setting of required
> parameters without any consideration needing to be paid to locking or
> reference counts.
> 
> Note that nested filesystems like overlayfs are compatible with an
> .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare()
> compatibility layer for nested file systems").
> 
> In this patch we apply this change to file systems with relatively simple
> mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> orangefs, nilfs2, romfs, ramfs and aio.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

For zonefs,

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

