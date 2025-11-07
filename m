Return-Path: <linux-fsdevel+bounces-67504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFEEC41D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AC33AD291
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F7314A67;
	Fri,  7 Nov 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gwskUpuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A052192EE;
	Fri,  7 Nov 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554927; cv=none; b=VEMmWm+StNGd9+3I2NLgfIvkLmxKS3F3IuT6lOsChqK49yfSWqrhBm6EeytqgewZGUsWot0DB2Da34oMteEa5Z+jCRg3Gjw0uQ7I4xpZZBxORlA+7OA2Jjz6kTYvpDiNM0AU+cA+KSjUmqND0kKnuNvbOaAi/0fqNrFDhkei2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554927; c=relaxed/simple;
	bh=XFl4H7zlaSjNeZC0YFUU21tNjZ/wnYPimecT/uq5tKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1xtH2u4rErEkLWHkV8kpO0zban8Az3Fo5CgS3FzsfqI7gAcBe9jwQcf/kEBHs/+oD0CROQFAF5+/7CmLYxDyVKG0JtNYN6j17lP22Sxuz8necqIIgcp6xrjpwNdZRVyOj2kZL8+zlc08KJQvi+MxucdhheR5s4Z9MjQV2dvD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gwskUpuJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 65A4040AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762554918; bh=1SMRxhNRshB8vecJq42CGMcQSf+tMG9pcOEmrtJR/2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gwskUpuJ4a2g0JY5PiFttMjCeJQuS5S9UEPZocWG6S53nMlyt4gNfosYgLoQ6Jwhj
	 dtsb6S+afpYrUIi0QfyDP5S6e0bDBizWxKwt/uIC0tV/2BUoFA5ZIOjasCC/wOB6C5
	 IvBnQSvlGwdiy84Vv7DtwNnU0ThlI1+rpNmvLMNs2Mlba7j5UvudGA8dWS/wNWoEhb
	 QQZECfmiJHj8aTYEDJFrkXseci/C7M7RQmHvvaOKNnK8EDDOg1KshyEqtA+pwvZFub
	 CJuACGdj/HuNVrTYEYhxm/X8rI6+e/rYpIzGlIZWWTn5T4qJ87Gv51ZI5YPYmAqjvD
	 ATLFFKQC18bmQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 65A4040AED;
	Fri,  7 Nov 2025 22:35:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian
 Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Tigran
 A. Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
 Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang
 Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
 <chao@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Miklos
 Szeredi <miklos@szeredi.hu>, Andreas Gruenbacher <agruenba@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Mikulas Patocka
 <mikulas@artax.karlin.mff.cuni.cz>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Amir Goldstein
 <amir73il@gmail.com>, Steve French <sfrench@samba.org>, Paulo Alcantara
 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM
 <bharathsm@microsoft.com>, Zhihao Cheng <chengzhihao1@huawei.com>, Hans de
 Goede <hansg@kernel.org>, Carlos Maiolino <cem@kernel.org>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew
 Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, Jeff Layton
 <jlayton@kernel.org>
Subject: LLM disclosure (was: [PATCH v2] vfs: remove the excl argument from
 the ->create() inode_operation)
In-Reply-To: <176255458305.634289.5577159882824096330@noble.neil.brown.name>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
 <176255458305.634289.5577159882824096330@noble.neil.brown.name>
Date: Fri, 07 Nov 2025 15:35:17 -0700
Message-ID: <87ikfl1nfe.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

NeilBrown <neilb@ownmail.net> writes:

> On Sat, 08 Nov 2025, Jeff Layton wrote:

>> Full disclosure: I did use Claude code to generate the first
>> approximation of this patch, but I had to fix a number of things that it
>> missed.  I probably could have given it better prompts. In any case, I'm
>> not sure how to properly attribute this (or if I even need to).
>
> My understanding is that if you fully understand (and can defend) the
> code change with all its motivations and implications as well as if you
> had written it yourself, then you don't need to attribute whatever fancy
> text editor or IDE (e.g.  Claude) that you used to help produce the
> patch.

The proposed policy for such things is here, under review right now:

  https://lore.kernel.org/all/20251105231514.3167738-1-dave.hansen@linux.intel.com/

jon

