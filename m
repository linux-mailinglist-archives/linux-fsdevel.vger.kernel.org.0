Return-Path: <linux-fsdevel+bounces-10566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B284C4FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AD61F23EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945F1CD36;
	Wed,  7 Feb 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FXK8EYdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D611CD21;
	Wed,  7 Feb 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287375; cv=none; b=jt86n/CAjgFmlx4+W8cKi4CmDvhloRStb70KDkFQe7ih9bcVcoHK8WJqcGNlXW63i7K68KTJtQ77ZwnCRmwS1CFAuBsLoCRFMOcxYfWerTdtBrIsqi0iUYlKt2AVhwRBZVgSWYZ3PBg37K4Kz5yILw4O0BcdwKPIqI2Y+bmDMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287375; c=relaxed/simple;
	bh=6x3vJX6kM7wbhftNznZY29HcJYqFphVVNiA4oZaqOm0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0/bNLq1/Tep4PGbXLDT9W1eIouy1JMseU0r5hJuI1W341WpZVhd+OcjPSfFUcwtlGqYPg8ljOgMnxGXRqZwgTCpgFsbvwQ3FaBB+AosQ61q5339abugChtTPt47tucP4tdGtKOZiBNJ59ylBAmrkjZQ6JwcZwyg/j1hBIUZXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FXK8EYdf; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707287366; bh=mNrdqudaAezA3ReLcqQ98vWG/2UD8jZsIyyvnfXThzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FXK8EYdfIZZYQy2+TsZiJzp8jZ5b4gtkdftggD9GxQLUHoF2VWUGafTMRsQAtBcsL
	 HoX/syskOK6JlpU7U6HTDvX57W6wPLqRxl6Xu2coYNwnx3jro/WSIKEk8+eyobRE8U
	 2q2thQOvIg9ulfdB4Wf/gmNcUJrBvCoypQqG49qE=
Received: from pek-lxu-l1.wrs.com ([117.61.28.82])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 5CE1508B; Wed, 07 Feb 2024 14:23:14 +0800
X-QQ-mid: xmsmtpt1707286994t3ux03k23
Message-ID: <tencent_F5A5644EB770B776C6C9B369E36F0963A305@qq.com>
X-QQ-XMAILINFO: Mkw1Oys1xyjCZNP3mdVVjbU48w+tp+OLCqZBqFjenDCoYA031dEv6nCMD7qnJt
	 D9jrpfBJyuFZntkoxKvK4TqMiQjCPP0VO3yR/LO4CWeHUwFR+BvVjbx0SXVaPTOR95PjPzayBcWA
	 wBqcloRjcIL0T6/Nk98zyXmCUELYhM/4z4cPApTgLmHlCQF9JwQgU2TV+xyP1/Rtv4dsyYb4N+FT
	 /fqAKBAFJ8IAh9hgATOMBQZaqeub8+B55OQagUseKqQ4yIZKZmfM8r9ARhMm3rnpHVVTMGc2nczJ
	 gbkD5G/79uclVkUKpdJeFJZk7YWzBzhQyFGtXIPozOuwVjeWkoVtQzFyxd+xcItXRE2jao9U07kT
	 EBP5VTTn0wz8cdHKxwm4Huv1v/EkgZfTKGNKT+yX7+B7sMUMUe/7TF15vmAS1cZ2lhxeaejkw3qG
	 VQuRBA9wJsIXszPieKKGJVNHkDflH3zk3WzZ5Isvxfp5DYRo/K7ndKFzmaPNbZ9XT1GHy1qw2tzU
	 6yq2O1Gdch0eHSWc2IDBKJfzLxyLMpUTndC2jzwCy4EwuCku/rok/hWVKzveoltU8aysOFYtLvbG
	 njjrZIXjiPY3Atrz8eSX0RixjKpjpQ1tbp5q3iHGsZCtG1AFjqFGb7tELC27SPx6ilhkN/8EEl9B
	 lTEkao5LXA7/bmyTFMKMp+xDVFXsUCXtNBeIf4J+G3wsMyWFRnQFCYahD/gitXDU5XXpymv5vNT+
	 eORU8Yb2dJYGE+Jy1a3Wd9FOedpArkR1xtkoqNVwrporjY+UZXz4aVbHEdk3RWNva4FehaXhLQ5n
	 GkKujxF0hce4kIRl6ENDQd8Xcmlyu2whrxAME5UA+LJZgeJQRzQTpr4J4EhOZPCLVLxsvQchDOof
	 smMZLUnK4/Ab0wjJ91Jhq9jIL97yXbiPZEp8lJ/NBjLgFx+hLSdDjcfnXdKNT9/72Eag3TP4uAVF
	 6mVBz/SPgNtUsc1E/QpbDcauEhOUpnxfYtc/658qS959xKDDixkwdVaYHUeXdj
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: slava@dubeyko.com
Cc: eadavis@qq.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH next] hfsplus: fix oob in hfsplus_bnode_read_key
Date: Wed,  7 Feb 2024 14:23:13 +0800
X-OQ-MSGID: <20240207062313.2891520-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9DB6A341-5689-4E4A-B485-A798810751F8@dubeyko.com>
References: <9DB6A341-5689-4E4A-B485-A798810751F8@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 6 Feb 2024 15:05:23 +0300, Viacheslav Dubeyko <slava@dubeyko.com> wrote: 
> > In hfs_brec_insert(), if data has not been moved to "data_off + size", the size
> > should not be added when reading search_key from node->page.
> >
> > Reported-and-tested-by: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > fs/hfsplus/brec.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > index 1918544a7871..9e0e0c1f15a5 100644
> > --- a/fs/hfsplus/brec.c
> > +++ b/fs/hfsplus/brec.c
> > @@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
> > * at the start of the node and it is not the new node
> > */
> > if (!rec && new_node != node) {
> > - hfs_bnode_read_key(node, fd->search_key, data_off + size);
> 
> As far as I can see, likewise pattern 'data_off + size’ is used multiple times in hfs_brec_insert().
> It’s real source of potential bugs, for my taste. Could we introduce a special variable (like offset)
> that can keep calculated value?
The code after "skip:" only adds size at this point, so currently there is no
need to add variables for separate management.
> 
> > + hfs_bnode_read_key(node, fd->search_key, data_off +
> > + (idx_rec_off == data_rec_off ? 0 : size));
> 
> I believe the code of hfs_brec_insert() is complicated enough.
> It will be great to rework this code and to add comments with
> reasonable explanation of the essence of modification. It’s not so easy
> to follow how moving is related to read the key operation.
As the case may be, other code is just complex but no issues have been reported.
It is not recommended to make unfounded optimizations.
> 
> What do you think?
Thanks,
Edward.


