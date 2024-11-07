Return-Path: <linux-fsdevel+bounces-33915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEF9C09C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4661F24D87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997BD2141BB;
	Thu,  7 Nov 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fZqihrX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF3213141
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992404; cv=none; b=dGvBNEjJoNRJ9rAfaEEFqlhev7PXgfDSHXGNbnOt1n7M28mNilB+9QUQNjjsAKovivvlVh2K3ig4G92UVhIVKfwG7yKpqqppjG0v2dhSLNT5/+ujMkLt46OI018M3ugzmnfujzVGHPBLz2MtfqXxDzESyYgKvMoAh+z0VLflj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992404; c=relaxed/simple;
	bh=6l5mXSUwsa0e8zSOdsjdHS2z8nTbsBhCbURZxcPvnow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbK+IcZv+TS2kTcsiGaVImQXx+1ZGDi8drPXWFkF4fNJS3nWCbuvPK3O3lN1DAfNcdzrJkdrAnpwxPGpPVVAHj3u09uAWM5D1qtRf48I7wLeCJjlHHGHwy8b+1JTzFZyQdH/oT2YPDs1S88SVxf4FVFGhmaUTG67WSs6i6+DaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fZqihrX1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD64X003521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992388; bh=gF6tgpZVjlzW/6qkLSleVCiPXZtrJcTCC1bsI96b+2Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fZqihrX1H038m4g9Wwz5BfzkGzj86qnu+ER5o7lZc6DTQAFCkFc5NvsxjT+aaTFKJ
	 6QlnvAqXE59Mu68ChrzNjTPdRqBvb2ks2yzhlG/giyWfHzKGiv4prmfmIYKQOQyyiu
	 VxD5G0TlKKKwvcq/2txDZcM+PdZNrYrvEI2jhFo6lBNMitrNxB9KfJKrgE+n5WGVaq
	 9Hmz5YW44SGzLEmexigOHOUzrlXV9ESO5bjhANvHLeF5PeL0YEuZuezRKGG+YuedEV
	 vm5YHdLs1JJwxDo+mFsXjz50ueuHooPueysF4jWeH1z0a99dE1XCiq/TI1lSpCoVBF
	 IK4pESH8nb15Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 42DDF15C0332; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Brian Foster <bfoster@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] ext4, mm: improve partial inode eof zeroing
Date: Thu,  7 Nov 2024 10:12:55 -0500
Message-ID: <173099237654.321265.9905047947203401102.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919160741.208162-1-bfoster@redhat.com>
References: <20240919160741.208162-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 19 Sep 2024 12:07:39 -0400, Brian Foster wrote:
> I've been poking around at testing zeroing behavior after a couple
> recent enhancements to iomap_zero_range() and fsx[1]. Running [1] on
> ext4 has uncovered a couple issues that I think share responsibility
> between the fs and pagecache.
> 
> The details are in the commit logs, but patch 1 updates ext4 to do
> partial eof block zeroing in more cases and patch 2 tweaks
> pagecache_isize_extended() to do eof folio zeroing similar to as is done
> during writeback (i.e., ext4_bio_write_folio(),
> iomap_writepage_handle_eof(), etc.). These kind of overlap, but the fs
> changes handle the case of a block straddling eof (so we're writing to
> disk in that case) and the pagecache changes handle the case of a folio
> straddling eof that might be at least partially hole backed (i.e.
> sub-page block sizes, so we're just clearing pagecache).
> 
> [...]

Applied, thanks!

[1/2] ext4: partial zero eof block on unaligned inode size extension
      commit: 462a214e71f3fbc40d28f0a00fe6f0d4c4041c98
[2/2] mm: zero range of eof folio exposed by inode size extension
      commit: faf7bba6b84981443773952289571e5ebeda1767

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

