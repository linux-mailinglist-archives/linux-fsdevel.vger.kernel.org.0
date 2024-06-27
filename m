Return-Path: <linux-fsdevel+bounces-22625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169C91A6F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A095B20999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFE178CCB;
	Thu, 27 Jun 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D3WZqQWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35C1482F5;
	Thu, 27 Jun 2024 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492690; cv=none; b=qUMSWRy1Gz3PGZbrjhg6WGnJ/Rj1iMBYZHNnO6bCh4k/aLmmq5OyyAsx5RrbukgVfv9Q/SyeqWdSJUHnSAH4IVskonMATclrIAISfWpKFhICIrNmQwlyi+eQ+DLCZNYkKaoqoqTKBdO0ce4qBdQYNW4hAsKy7siVBoDcW9OrinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492690; c=relaxed/simple;
	bh=G43gEWKZg+rlGXNL/C54KPYv2KQ3OCfmDFUhBLC4xMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB9gNjIxFpMpRfvFPcJPsN0CpFP+XBV6kOfurbTIFlBlqYVqrtxpcl1ZoK4JC+C3+SOf8Db0/fXP6aWjwWeeSy6+rkyyfsquMlgwKl87Bc1oq9F22CaYtOk+db1k8eWHgeiw8xr6LP2YQYUzM0tluQsBZtd4YBo1Fgq2Nd/MLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=D3WZqQWX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EfO/Ili60E4aw0klTOm4lymg/x/5oHDvgXlSEsbvz64=; b=D3WZqQWXy6KVl7cJvum6Rcfx52
	LQ6YIyqk/Lfa7Liw12YS/5LmUZv17oKflmjqzEZ2AOlyhVs3bZpz8E/tahjNfyj0/oXp1UPlfcmia
	/ycmaZGr2ndqPMKAt+k1+EBs05sytWrmlrSINN/PCK3xfIifdHzBO/e6wqeCN0lDkCI8KWhU1aRe5
	v2qr9SUJ+xpNVd+iLxGz6I6hrESkP9iXpGCW/s44hIp7sBXhx/Wge/4X0Zgt/eEHev+YqeOG0QKS0
	SeqsUx/SIJzrQCC0vCJlNwYupr+vB5Y+AKJXlFa6hu9DjmlGK74xuW4YyWlv1orF5lAvuabgliKYp
	cWNgQMaA==;
Received: from 179-125-70-190-dinamico.pombonet.net.br ([179.125.70.190] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sMoau-00843I-KG; Thu, 27 Jun 2024 14:51:21 +0200
Date: Thu, 27 Jun 2024 09:51:13 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH v2 2/2] fat: always use dir_emit_dots and ignore . and ..
 entries
Message-ID: <Zn1gQeWToPNkp9nt@quatroqueijos.cascardo.eti.br>
References: <20240625175133.922758-1-cascardo@igalia.com>
 <20240625175133.922758-3-cascardo@igalia.com>
 <871q4kae58.fsf@mail.parknet.co.jp>
 <ZnxwEtmYeZcKopJK@quatroqueijos.cascardo.eti.br>
 <87a5j7v517.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5j7v517.fsf@mail.parknet.co.jp>

On Thu, Jun 27, 2024 at 05:10:44AM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> >> Unacceptable to change the correct behavior to broken format. And
> >> unlikely break the userspace, however this still has the user visible
> >> change of seek pos.
> >> 
> >> Thanks.
> >> 
> >
> > I agree that if this breaks userspace with a good filesystem or regresses
> > in a way that real applications would break, that this needs to be redone.
> >
> > However, I spent a few hours doing some extra testing (I had already run
> > some xfstests that include directory testing) and I failed to find any
> > issues with this fix.
> >
> > If this would break, it would have broken the root directory. In the case
> > of a directory including the . and .. entries, the d_off for the .. entry
> > will be set for the first non-dot-or-dotdot entry. For ., it will be set as
> > 1, which, if used by telldir (or llseek), will emit the .. entry, as
> > expected.
> >
> > For the case where both . and .. are absent, the first real entry will have
> > d_off as 2, and it will just work.
> >
> > So everything seems to work as expected. Do you see any user visible change
> > that would break any applications?
> 
> First of all, I'm not thinking this is the fix, I'm thinking this as the
> workaround of broken formatter (because the windows's fsck also think it
> as broken). So very low priority to support.
> 
> As said, I also think low chance to break the userspace. However it
> changes real offset to pseudo offset. So if userspace saved it to
> persistent space, breaks userspace. Unlikely, but I think there is no
> value to change the behavior for workaround.
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

I looked at that perspective, but still wanted to allow users to use such
filesystems, even if they needed to fsck it first.

But there is the issue that when such filesystems are mounted, they are
further corrupted, preventing such fsck from correctly fixing and allowing
access to the data.

So I started doing some investigation and that lead me to the following
code from fs/fat/inode.c:

static void fat_evict_inode(struct inode *inode)
{
	truncate_inode_pages_final(&inode->i_data);
	if (!inode->i_nlink) {
		inode->i_size = 0;
		fat_truncate_blocks(inode, 0);
	} else
		fat_free_eofblocks(inode);
[...]

That is, since the directory has no links, once it is evicted (which
happens right after reading the number of subdirectories and failing
verification), it is truncated. That means all clusters are marked as FREE.
Then, later, if trying to fsck or mount this filesystem again, the
directory entry is removed or further errors show up (as an EOF is
expected, not a FREE cluster).

And that is caused by attributing a number of 0 links. I looked it up on
how other filesystems handle this situation and I found out that exfat adds
2 to the number of subdirectories, just as I am suggesting. When
enumerating the directories (at its readdir), it also relies on
dir_emit_dots for all cases.

As for programs persisting the offset, the manpage for telldir has on its
NOTES section:

"""
Application programs should treat this strictly as an opaque value, making
no assumptions about its contents.
"""

I know this doesn't refer to persisting or not that opaque value, but any
other changes to the directory would change the offset of its current
subdirectories and given those values are opaque, no assumptions should be
made. And unless we find such programs in the wild, the same argunent could
be made that there may be programs that expect . and .. to be at offset 0
and 1, like every filesystem that uses dir_emit_dots does.

I understand the cautiousness to prevent regressions, but I did the work
here to test and understand the changes that are being proposed. I even
looked into another way of preventing the further corruption, but that
convinced me even more that the right fix is to assign a minimum number of
links to directories and I found precedence to this.

Thanks.
Cascardo.


