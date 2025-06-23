Return-Path: <linux-fsdevel+bounces-52606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6906AE47D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD7E3B3F57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC626E158;
	Mon, 23 Jun 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="roV9MjDY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057B20311;
	Mon, 23 Jun 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690978; cv=none; b=Dcn1eAc9iF/iJWHcarocIIVIvCUdpCrP1XJNMqGzQ5D+PisiWQ2n+EpwjTUlSlX0BQCBRk7e7uxo4FBKSyu4LV5vpT0lNPiQZZqBISMOem4dSIdKmTGXgvcpmlKDo7xf1QfD5L3QpxkfJqPj1cadX6QNsR/2VAX5RdOM9cyKofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690978; c=relaxed/simple;
	bh=UfOOd2Kbab7saikL7iEZKu0Y3vwnaFjjDz6MgRgKufo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCtRkw0/Tl75yof7gGEylz66YU8M7HwTeIydn07454wyb3iLLV1n9dQvwOhM+dFwNGIFRpV/TW7yWQ4iyAMweJbwn3v21TbYtBIX8PHDqyy3UB3pxm4/YnK54y72XqPDczXOTfjht3adsAWR/62CwOmOgSXAg5L7mX0nS69g4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=roV9MjDY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZnkW9whxI994oPI8HPdFvYzd5zyDYY4h9RfVyAmThoE=; b=roV9MjDYuONt+tmMUd69VQ4///
	ihlu46HvY4+nNBikQyqzTNZ3hWD3fWf2HqPO3lzognOVBVOA7JFSylsueayrLS4+BImI+iMW9Acn0
	i6tEdQKSuuVhgyZNIKOBwgbxMZ91pRpib86r41fqbLj5Cq/yWZDMk6g5EbnCu4iT8SRH5hvItyOVA
	3srz4JinEm7/kfQf6+0ouA8yBYnpNke4zNri1o1iHUiBkJMe7gmC0ct//+gCczm6FNZzCd1LL9HSY
	3DB/Zi9xbF1P4srfqjMLpGO4qnmvrYLyj3khL1oORup2DXhbBTJDSeAEYx0+DyeLRmffpd/rjnvzU
	+21rlXmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTihB-0000000D96D-1Dzr;
	Mon, 23 Jun 2025 15:02:53 +0000
Date: Mon, 23 Jun 2025 16:02:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [linux-next-20250620] Fails to boot to IBM Power Server
Message-ID: <20250623150253.GC1880847@ZenIV>
References: <aafeb4a9-31ea-43ad-b807-fd082cc0c9ad@linux.ibm.com>
 <20250623135602.GA1880847@ZenIV>
 <72342657-f579-4c4a-bcda-534e28c40304@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72342657-f579-4c4a-bcda-534e28c40304@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 08:22:28PM +0530, Venkat Rao Bagalkote wrote:
> 
> On 23/06/25 7:26 pm, Al Viro wrote:
> > On Mon, Jun 23, 2025 at 07:20:03PM +0530, Venkat Rao Bagalkote wrote:
> > 
> > [NULL pointer dereference somewhere in collect_paths()]
> > 
> > Could you put objdump -d of the function in question somewhere?
> > Or just fs/namespace.o from your build...
> > 
> 
> Attached is the namespace.o file.

Huh...

That looks like NULL first argument (path), which blows up on
        struct mount *root = real_mount(path->mnt);
just prior to grabbing namespace_sem...

*blinks*
<obscenities>

Could you check if the delta below fixes it?

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 68e042ae93c7..b0eae2a3c895 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -832,7 +832,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
 	err = kern_path(tree->pathname, 0, &path);
 	if (err)
 		goto Err;
-	paths = collect_paths(paths, array, 16);
+	paths = collect_paths(&path, array, 16);
 	path_put(&path);
 	if (IS_ERR(paths)) {
 		err = PTR_ERR(paths);

