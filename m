Return-Path: <linux-fsdevel+bounces-27659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976929633D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B3B1C2363D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1C1ACE10;
	Wed, 28 Aug 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOpyQjSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C111AAE0D;
	Wed, 28 Aug 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880418; cv=none; b=Lkg4odpcI71ZbKZtsWmLAEL2EkFFlLHHpuBd8/f4JiTTMpirMAqiAouOW7hbFlaxZcnRlMeZwtKX3Hf6p5B8+Fi2Cm7AaHqo5cG8+sNZK+0N0ZBc1xdBkuSDPsmekhNKnDL0E4Ssnrz1U2cmg+tUFgNDeHqMKZ92eauT7ggnOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880418; c=relaxed/simple;
	bh=vGx9HlegbSiFbbKaNUoRuWhVR+WntfoN9NTC7WHE02Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxnybIm3m/El6vUyt3oBieuChSiXIzO1swCdguVjMLQ/7FcjN8H0e0SPMBDThQ4uxeMx6rG/JXJJk7UxScm1O1ZS9NUNTSa8UTjuJU9cZxeE1ABzYRJrdDQpCtUlg6yz41NKvCIICITuMyJraVJ/DIYVrNM9+GAhBvblSu7rA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QOpyQjSw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0LhlfCKQ+1SzuxGlLV2cm1LHeLbux8Kp6w9vH1H+QGU=; b=QOpyQjSwc7hQC4dANP6cDjFxy/
	vFwAoAhwmL5ZBNs5AVYoRjsJVMVx1pc92FHsoI8gJmLHEnJinnEJcZ06c5/TpmT+uIV3HTtnjyw4K
	k5fDViZ1RumFOlRM/ngORHSzt014fwADpWegOqkHNisAMcY9gwRmV7lZSn5t5neZGUwEoRyGQGsZf
	twHarXZAF6wRDrA9KD9M30IOWgLOnIoVq+TWoUplw3NH43YIdAWIobVkNSuOJPrvEVCHN+58fDoao
	OPIDkv8RkIahBHXik3H6mqwWbWTXE+900bUvpFctPYRnIw3YZP+FY9uftY2W5+QQ8l38gdAF4lqyW
	UTaIH5KA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjQBo-0000000H3xz-3WdR;
	Wed, 28 Aug 2024 21:26:52 +0000
Date: Wed, 28 Aug 2024 14:26:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Message-ID: <Zs-WHKj4Jn6Beoon@bombadil.infradead.org>
References: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Aug 27, 2024 at 04:15:05PM -0700, Nathan Chancellor wrote:
> When building for a 32-bit architecture, where 'size_t' is 'unsigned
> int', there is a warning due to use of '%ld', the specifier for a 'long
> int':
> 
>   In file included from fs/xfs/xfs_linux.h:82,
>                    from fs/xfs/xfs.h:26,
>                    from fs/xfs/xfs_super.c:7:
>   fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
>   fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
>         |                                                        ~~~~~~~~~~~~~~
>         |                                                        |
>         |                                                        size_t {aka unsigned int}
>   ...
>   fs/xfs/xfs_super.c:1654:58: note: format string is defined here
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         |                                                        ~~^
>         |                                                          |
>         |                                                          long int
>         |                                                        %d
> 
> Use the proper 'size_t' specifier, '%zu', to resolve the warning.
> 
> Fixes: 0ab3ca31b012 ("xfs: enable block size larger than page size support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

