Return-Path: <linux-fsdevel+bounces-22685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3991B041
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C46281E59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C719DF49;
	Thu, 27 Jun 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fl17DrTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6919AD58
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519644; cv=none; b=ns07pxd2yYy1QhiwaSgbPEvb//Ncqc7+/ElQjeGv4akPOxZ5Y4IbQaZT88zg3eNdOUymyVLIMfX5phIb3c/Nh71adXUrJ7dycNfQ/FUDgIz7B/dNHry1uS9KKisTgGkKszu8IAhw4oBH1bMpb0IE1vQ0YjdKV37CXw/acTMsbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519644; c=relaxed/simple;
	bh=OXJiBBaFNNTePTOekfrLrNoxaM+AW+3/asjN77aGn8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwGi5KW6KMYGsIAl8RkiZ4+6AE+XLAT2eckSC+Zhu/0mUiMiB8Bi91LhqKZqP8/qDdV/pdaHet+Ilhu1euXcsiIlPIOv3JGlb1ht1beRrvmzeebc1zdYkmGpuQjYVwMjAKv4YZUlOz+BKb4LBeSaebrggLnQ9KDgVm0zESQ4/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fl17DrTA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45RKKN8J031179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719519625; bh=s+rFpXLKQ2ZhL/W/oYJbr5AUZbSOpyEQSq/ARRRaQ2M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fl17DrTA9niz3J7NcW9+dmQ6WH86zi8MsyrKlnzYwm1+AMpX58HZs7q/kvUpIOmnJ
	 VNh/95H/+NWAqO2mXk50tImiWBAqklNTMG8UMAQp2BoYYZvtfDvRA2YSFLNApquLcf
	 kgHcYNU5s0n4USTcYV9NTybl1YAl8cT2OUKLYHXwLBVurBDBqyWiCyL7Gw0gAH/hcz
	 TNlEzGo0iH8Fni3nRquYNQVw/YnHtJBbrPVVn8McpSAV2qszDU+m+M2lDaVccpazCa
	 81SVG8fkniKHWQiOn7VTRrFX4sTazvRV/dgMOyJzUJcCiksfKyY5Zv2z8djRUILJnT
	 qyd64FSbPp58Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D36C715C626C; Thu, 27 Jun 2024 16:20:22 -0400 (EDT)
Date: Thu, 27 Jun 2024 16:20:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/2] ext4: Remove array of buffer_heads from
 mext_page_mkuptodate()
Message-ID: <20240627202022.GC419129@mit.edu>
References: <20240516181651.2879778-1-willy@infradead.org>
 <20240516181651.2879778-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516181651.2879778-2-willy@infradead.org>

On Thu, May 16, 2024 at 07:16:51PM +0100, Matthew Wilcox (Oracle) wrote:
> The current code iterates over the list of buffer_heads, finds the
> !uptodate ones and reads them, waiting for each one before submitting
> the next one.  Instead, submit all the read requests before waiting
> for each of the needed ones.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Hey Willy,

This patch is causing ext4/020 (which tests the EXT4_IOC_MOVE_EXT
ioctl used by e4defrag).  This can be easily reproduced via:
"kvm-xfstests -c ext4/4k ext4/020".  From
/results/ext4/results-4k/ext4/020.out.bad:

   QA output created by 020
   wrote 1048576/1048576 bytes at offset 0
   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
   wrote 1023/1023 bytes at offset 0
   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
   md5sum: WARNING: 1 computed checksum did NOT match
   SCRATCH_MNT/020.orig: FAILED

I'm going to drop both this patch and the preceeding patch in this
series ("ext4: reduce stack usage in ext4_mpage_readpages()") pending
further investigation.

							- Ted

