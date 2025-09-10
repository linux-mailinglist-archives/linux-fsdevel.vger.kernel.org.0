Return-Path: <linux-fsdevel+bounces-60731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F6DB50C10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289474E4ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA11DFDAB;
	Wed, 10 Sep 2025 03:01:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1E4315F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473314; cv=none; b=u+zd7OOch14XaPh9KNZGY45lQ0dMhSXXUnUo8PkbXTiqTVCjtFAc0D3R7K16nWBuYBgVs5Yx4tKKUCnlIhBLg47PecSU8AesRiBMbdxP3JXk2KqX12eX+e6bSXN6HLfHa2CcxjtzE47NDm/HpUE7Yijh1zm0ATcBuvL5BQbVoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473314; c=relaxed/simple;
	bh=qRdR8yaK6R/QiXvyHdYLurz13ixAhZMP2gTrBMgWVuo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bDV83MEq3nk55xUY+c81uEcCDjPQHnHGt2vPBFA2wmSYswrqfyZk76S/8NFFM1UmGq5e9m0vV9arCp2GeifQMgGIU64iOayax0bwCeu8KDb940sz7omtbz92qcU+zRIexwXAQRETF68UI7bXsiKI0BfvvAKQnKK93n6iAkf33jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwB5f-008tmN-O0;
	Wed, 10 Sep 2025 03:01:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
In-reply-to: <20250909081949.GM31600@ZenIV>
References: <>, <20250909081949.GM31600@ZenIV>
Date: Wed, 10 Sep 2025 13:01:49 +1000
Message-id: <175747330917.2850467.10031339002768914482@noble.neil.brown.name>

On Tue, 09 Sep 2025, Al Viro wrote:
> On Tue, Sep 09, 2025 at 02:43:21PM +1000, NeilBrown wrote:
> 
> >  	d_instantiate(dentry, inode);
> > -	dget(dentry);
> > -fail:
> > -	inode_unlock(d_inode(parent));
> > -	return dentry;
> > +	return simple_end_creating(dentry);
> 
> No.  This is the wrong model - dget() belongs with d_instantiate()
> here; your simple_end_creating() calling conventions are wrong.

I can see that I shouldn't have removed the dget() there - thanks.
It is not entirely clear why hypfs_create_file() returns with two
references held to the dentry....
I see now one is added either to ->update_file or the list at
hypfs_last_dentry, and the other is disposed of by kill_litter_super().

But apart from that one error is there something broader wrong with the
patch?  You say "the wrong model" but I don't see it.

Thanks,
NeilBrown


> 
> What really happens is a controlled leak.  simple_start_creating()
> in the beginning is correct, but the right model here is to have
> identical refcounting logics on the exits - the only difference
> should be in having done that combination on success.
> 
> Please, leave those alone for now.
> 


