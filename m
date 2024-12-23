Return-Path: <linux-fsdevel+bounces-38078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE209FB65A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4B3165F74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE501D7982;
	Mon, 23 Dec 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eE7HLCq7";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vKSo9bra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3581D63DC;
	Mon, 23 Dec 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734990251; cv=none; b=SDzus9rtv6iRbKcpSzqbszb57hyYiOMPF/1f4Bjcm8Yflm3pDnpUE+HJBhE637+qGs2E7gWMEonYnYMR9fHKq1jTSO30e6qHUWVzxeNFoRbXpHJFNfiMW5TWMqwAe5f2bdzABYZbrW0Brwp+Y3NxMc22vRXZEelUQQ1cPgTF+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734990251; c=relaxed/simple;
	bh=IBqDvmDVSSsTLtlIeGkc8FfpczNDY8FTAmu6Omg8pao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euV+QWqac978j5xiAe/2DI3TM3Yj1J/u6IxmZzcdz+V9KXp0R6oNUKwOMpPCqhSfG8hwfI9yzYTlpe6B5CLZL12lYLGfE6rVBYZMxlwoGjD+nRubU+VmAHypXOq2U6pA5z176flrgyMHGY8jCwHONmm9iXeg3ghVs070pA15k5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eE7HLCq7; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=vKSo9bra; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734990250;
	bh=IBqDvmDVSSsTLtlIeGkc8FfpczNDY8FTAmu6Omg8pao=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eE7HLCq7gv2SVZZVWiG6pFM5u4mD77HDSxEUy/AACR5mCunja8lI45lSlKhnUqsUj
	 ljXSFMw2Iwe1JeEYyUjkX6/EPjzMkn5v74scjxej++aeNVFFuhA0RV8mSQgeA9KwSe
	 keqsHWyTdpLWt4o9idXQmizzZllj57p/VCjKRcjo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 035E11286640;
	Mon, 23 Dec 2024 16:44:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WpSzPgyu_Ipn; Mon, 23 Dec 2024 16:44:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734990249;
	bh=IBqDvmDVSSsTLtlIeGkc8FfpczNDY8FTAmu6Omg8pao=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=vKSo9bra2T8GCC0B7M+cqoeo3uWVEmZHvm0FSDp5ZdaZJOM/clejAxLbQ7lmdO07D
	 vg4x8zyMZB92Aep1HfXrY2vFqlP6GmDoJbLs34pX0Lq6UdNpvaBDNsO569I8HGJhZd
	 rJhTFvrkH0hEUgALt9rKTZwIDzoRpHoQvHpf2XCU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5101B1286172;
	Mon, 23 Dec 2024 16:44:09 -0500 (EST)
Message-ID: <759f9ce7e632f71136bb17a2d9d5f347898743b4.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/6] efivarfs: make variable_is_present use dcache lookup
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 23 Dec 2024 16:44:07 -0500
In-Reply-To: <20241223202029.GP1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
	 <20241223202029.GP1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-23 at 20:20 +0000, Al Viro wrote:
> On Tue, Dec 10, 2024 at 12:02:21PM -0500, James Bottomley wrote:
> > Instead of searching the variable entry list for a variable, use
> > the
> > dcache lookup functions to find it instead.  Also add an efivarfs_
> > prefix to the function now it is no longer static.
> 
> > +bool efivarfs_variable_is_present(efi_char16_t *variable_name,
> > +                                 efi_guid_t *vendor, void *data)
> > +{
> > +       char *name = efivar_get_utf8name(variable_name, vendor);
> > +       struct super_block *sb = data;
> > +       struct dentry *dentry;
> > +       struct qstr qstr;
> > +
> > +       if (!name)
> > +               return true;
> > +
> > +       qstr.name = name;
> > +       qstr.len = strlen(name);
> > +       dentry = d_hash_and_lookup(sb->s_root, &qstr);
> > +       kfree(name);
> > +       if (dentry)
> > +               dput(dentry);
> 
> If that ever gets called with efivarfs_valid_name(name, strlen(name))
> being false, that's going to oops...

Well for the current use case that can't happen because a) that check
is gone from efivarfs_d_hash and b) the name is constructed to pass
this check anyway.  But I'm guessing you mean I should be doing

if (dentry && !IS_ERR(dentry))
   dput(dentry);

?

Regards,

James


