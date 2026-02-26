Return-Path: <linux-fsdevel+bounces-78503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BQqL1VboGm3igQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:40:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC191A7BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 786D03192248
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E833D5223;
	Thu, 26 Feb 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xptgD2FT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839133ED109
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116195; cv=none; b=dCTWVE3Rz/ZNMl/UtUcXXtdi5WDYMG91yCzt+vapD7X+wACo071iI2iGdjDbzGVX1Pgat26Cs/IW4lLsSw3VUdWcfB9pJREzVmhZb7JQojKb2mCsiQm8LZkARhFVePzVcuoM/Dw0BWb7oBdG1gczyU2lY4k1uRLVc8TLUByy1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116195; c=relaxed/simple;
	bh=09Rjq9YUiTCfdOZtaVDiYYUcU1HlVXywZdVoE4L+UrI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nLBVe4sXk1nKoE6yv8SAX6MRtKAg8Bm/EcGs9hVStnhxGopguuQ6h5UQZuCRF8f/YIhXZFI7O1YHn++7bkWe+6M5tzD8ocSHJkCGVf01M1nsfT3xmZA1ob7CWgv9VI4CYq699O17SUVE3EkMBF4X4ylGNGMgiZZLSEnrfkK1FhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xptgD2FT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772116185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAX4WJ2Ss7mjZl94h6x1hLn056hNxjHN1j/COBhWBBI=;
	b=xptgD2FTlKgBhNODGcIrRBp5blA/GA2rw0WiznS6TETnPB6o8qUhsVJg7xmMni+6JRIITy
	GfcBPBhdnXx+9cHUaLcfBCHSLjGA/YNS/kr/PSdgC4DD2iinr47MB0lewbNYLKnnWWgaIm
	ttz9L60EnqKSXm99wwPsa0f42GEZLTw=
Date: Thu, 26 Feb 2026 14:29:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <655d0b2af1814312929e9e094854dd3ab029d094@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm: annotate data race of f_ra.prev_pos
To: "Jan Kara" <jack@suse.cz>
Cc: linux-mm@kvack.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com, "Theodore Ts'o"
 <tytso@mit.edu>, "Andreas Dilger" <adilger.kernel@dilger.ca>, "Konstantin
 Komarov" <almaz.alexandrovich@paragon-software.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hugh
 Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Jan Kara" <jack@suse.cz>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
In-Reply-To: <2xzc3lp6ehtjwbzip4i5muh4g6oep4l72zh3j6sablfghbvbau@kh7famgorzrh>
References: <20260226084020.163720-1-jiayuan.chen@linux.dev>
 <2xzc3lp6ehtjwbzip4i5muh4g6oep4l72zh3j6sablfghbvbau@kh7famgorzrh>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78503-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,6880f676b265dbd42d63];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,linux.dev:mid,linux.dev:dkim,appspotmail.com:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AC191A7BD6
X-Rspamd-Action: no action

February 26, 2026 at 21:21, "Jan Kara" <jack@suse.cz mailto:jack@suse.cz?=
to=3D%22Jan%20Kara%22%20%3Cjack%40suse.cz%3E > wrote:


>=20
>=20On Thu 26-02-26 16:40:07, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  KCSAN reports a data race when concurrent readers access the same
> >  struct file:
> >=20=20
>=20>  BUG: KCSAN: data-race in filemap_read / filemap_splice_read
> >=20=20
>=20>  write to 0xffff88811a6f8228 of 8 bytes by task 10061 on cpu 0:
> >  filemap_splice_read+0x523/0x780 mm/filemap.c:3125
> >  ...
> >=20=20
>=20>  write to 0xffff88811a6f8228 of 8 bytes by task 10066 on cpu 1:
> >  filemap_read+0x98d/0xa10 mm/filemap.c:2873
> >  ...
> >=20=20
>=20>  Both filemap_read() and filemap_splice_read() update f_ra.prev_pos
> >  without synchronization. This is a benign race since prev_pos is onl=
y
> >  used as a hint for readahead heuristics in page_cache_sync_ra(), and=
 a
> >  stale or torn value merely results in a suboptimal readahead decisio=
n,
> >  not a correctness issue.
> >=20=20
>=20>  Use WRITE_ONCE/READ_ONCE to annotate all accesses to prev_pos acro=
ss
> >  the tree for consistency and silence KCSAN.
> >=20=20
>=20>  Reported-by: syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com
> >  Link: https://syzkaller.appspot.com/bug?extid=3D6880f676b265dbd42d63
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20Given this, I think it would be much less intrusive and also more
> explanatory to just mark prev_pos with __data_racy with appropriate rea=
son
> you're mentioning in the changelog.


Thanks for the suggestion. I'm fine either way =E2=80=94 __data_racy is i=
ndeed
cleaner and less intrusive for a purely heuristic field like this.

I'll wait a bit to see if Andrew or other mm folks have a preference
before resending. Happy to go with whichever approach they prefer.

>  Honza
>=20
>=20>=20
>=20> ---
> >  fs/ext4/dir.c | 2 +-
> >  fs/ntfs3/fsntfs.c | 2 +-
> >  include/trace/events/readahead.h | 2 +-
> >  mm/filemap.c | 6 +++---
> >  mm/readahead.c | 4 ++--
> >  mm/shmem.c | 2 +-
> >  6 files changed, 9 insertions(+), 9 deletions(-)
> >=20=20
>=20>  diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> >  index 28b2a3deb954..1ddf7acce5ca 100644
> >  --- a/fs/ext4/dir.c
> >  +++ b/fs/ext4/dir.c
> >  @@ -200,7 +200,7 @@ static int ext4_readdir(struct file *file, struc=
t dir_context *ctx)
> >  sb->s_bdev->bd_mapping,
> >  &file->f_ra, file, index,
> >  1 << EXT4_SB(sb)->s_min_folio_order);
> >  - file->f_ra.prev_pos =3D (loff_t)index << PAGE_SHIFT;
> >  + WRITE_ONCE(file->f_ra.prev_pos, (loff_t)index << PAGE_SHIFT);
> >  bh =3D ext4_bread(NULL, inode, map.m_lblk, 0);
> >  if (IS_ERR(bh)) {
> >  err =3D PTR_ERR(bh);
> >  diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> >  index 0df2aa81d884..d1232fc03c08 100644
> >  --- a/fs/ntfs3/fsntfs.c
> >  +++ b/fs/ntfs3/fsntfs.c
> >  @@ -1239,7 +1239,7 @@ int ntfs_read_run_nb_ra(struct ntfs_sb_info *s=
bi, const struct runs_tree *run,
> >  if (!ra_has_index(ra, index)) {
> >  page_cache_sync_readahead(mapping, ra, NULL,
> >  index, 1);
> >  - ra->prev_pos =3D (loff_t)index << PAGE_SHIFT;
> >  + WRITE_ONCE(ra->prev_pos, (loff_t)index << PAGE_SHIFT);
> >  }
> >  }
> >=20=20
>=20>  diff --git a/include/trace/events/readahead.h b/include/trace/even=
ts/readahead.h
> >  index 0997ac5eceab..63d8df6c2983 100644
> >  --- a/include/trace/events/readahead.h
> >  +++ b/include/trace/events/readahead.h
> >  @@ -101,7 +101,7 @@ DECLARE_EVENT_CLASS(page_cache_ra_op,
> >  __entry->async_size =3D ra->async_size;
> >  __entry->ra_pages =3D ra->ra_pages;
> >  __entry->mmap_miss =3D ra->mmap_miss;
> >  - __entry->prev_pos =3D ra->prev_pos;
> >  + __entry->prev_pos =3D READ_ONCE(ra->prev_pos);
> >  __entry->req_count =3D req_count;
> >  ),
> >=20=20
>=20>  diff --git a/mm/filemap.c b/mm/filemap.c
> >  index 63f256307fdd..d3e2d4b826b9 100644
> >  --- a/mm/filemap.c
> >  +++ b/mm/filemap.c
> >  @@ -2771,7 +2771,7 @@ ssize_t filemap_read(struct kiocb *iocb, struc=
t iov_iter *iter,
> >  int i, error =3D 0;
> >  bool writably_mapped;
> >  loff_t isize, end_offset;
> >  - loff_t last_pos =3D ra->prev_pos;
> >  + loff_t last_pos =3D READ_ONCE(ra->prev_pos);
> >=20=20
>=20>  if (unlikely(iocb->ki_pos < 0))
> >  return -EINVAL;
> >  @@ -2870,7 +2870,7 @@ ssize_t filemap_read(struct kiocb *iocb, struc=
t iov_iter *iter,
> >  } while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
> >=20=20
>=20>  file_accessed(filp);
> >  - ra->prev_pos =3D last_pos;
> >  + WRITE_ONCE(ra->prev_pos, last_pos);
> >  return already_read ? already_read : error;
> >  }
> >  EXPORT_SYMBOL_GPL(filemap_read);
> >  @@ -3122,7 +3122,7 @@ ssize_t filemap_splice_read(struct file *in, l=
off_t *ppos,
> >  len -=3D n;
> >  total_spliced +=3D n;
> >  *ppos +=3D n;
> >  - in->f_ra.prev_pos =3D *ppos;
> >  + WRITE_ONCE(in->f_ra.prev_pos, *ppos);
> >  if (pipe_is_full(pipe))
> >  goto out;
> >  }
> >  diff --git a/mm/readahead.c b/mm/readahead.c
> >  index 7b05082c89ea..de49b35b0329 100644
> >  --- a/mm/readahead.c
> >  +++ b/mm/readahead.c
> >  @@ -142,7 +142,7 @@ void
> >  file_ra_state_init(struct file_ra_state *ra, struct address_space *m=
apping)
> >  {
> >  ra->ra_pages =3D inode_to_bdi(mapping->host)->ra_pages;
> >  - ra->prev_pos =3D -1;
> >  + WRITE_ONCE(ra->prev_pos, -1);
> >  }
> >  EXPORT_SYMBOL_GPL(file_ra_state_init);
> >=20=20
>=20>  @@ -584,7 +584,7 @@ void page_cache_sync_ra(struct readahead_contr=
ol *ractl,
> >  }
> >=20=20
>=20>  max_pages =3D ractl_max_pages(ractl, req_count);
> >  - prev_index =3D (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
> >  + prev_index =3D (unsigned long long)READ_ONCE(ra->prev_pos) >> PAGE=
_SHIFT;
> >  /*
> >  * A start of file, oversized read, or sequential cache miss:
> >  * trivial case: (index - prev_index) =3D=3D 1
> >  diff --git a/mm/shmem.c b/mm/shmem.c
> >  index 5e7dcf5bc5d3..03569199baf4 100644
> >  --- a/mm/shmem.c
> >  +++ b/mm/shmem.c
> >  @@ -3642,7 +3642,7 @@ static ssize_t shmem_file_splice_read(struct f=
ile *in, loff_t *ppos,
> >  len -=3D n;
> >  total_spliced +=3D n;
> >  *ppos +=3D n;
> >  - in->f_ra.prev_pos =3D *ppos;
> >  + WRITE_ONCE(in->f_ra.prev_pos, *ppos);
> >  if (pipe_is_full(pipe))
> >  break;
> >=20=20
>=20>  --=20
>=20>  2.43.0
> >=20
>=20--=20
>=20Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

