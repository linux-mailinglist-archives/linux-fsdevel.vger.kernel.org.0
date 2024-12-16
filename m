Return-Path: <linux-fsdevel+bounces-37520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E99F3964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AF18881E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D386207A35;
	Mon, 16 Dec 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL/8K94b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BA20767A;
	Mon, 16 Dec 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375404; cv=none; b=Pgv7F0rmUUKTJYZxCyYuFWiE0icp7HIK425rWhK0FMeJ853jArBQgfIh2BMW39vP7ZmgN2B1ahiRL1u/Go0CZtJsra1/k4jodxmpaEs9nOwMW3VVMhNRANlxywuPeSM/Hj+shtLZgQuFdKYBt6orY9dYvHr1MxCPD5svop7gyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375404; c=relaxed/simple;
	bh=jQqbBOb+E43+hPO1peHJzewU9cr88vaZCS1ujUob/JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpbcwTKGhP6Q3p76FONc5HFQ4ZLUpJc3CrqbZnnPG+2JpQZcVzB/IvRsM7iVS4MPZILIG19PxAwZBDIRs0wqOCbHSVTsQcETG25pJUDyCFPIyakRQhjyVsJoWp/Z/tnyNW5ikFltJcSydgeeIyzJksT8SaSnXJGx0JTsVDVEX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL/8K94b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A06C4CED0;
	Mon, 16 Dec 2024 18:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734375404;
	bh=jQqbBOb+E43+hPO1peHJzewU9cr88vaZCS1ujUob/JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XL/8K94b0BkJs5Mft8XdhrnKfzHUkspUBRWfaLpHGLCEaiKZ9Z7ROiu5g8xtiutXI
	 /OU+wjHGqgxO4Dn/cMgiZJ30IGj/lUa6cvztzC1QLY7mHJTgzzX7lnX/gvOg4e+je+
	 Y6l1dx6zi+yd0ChVy1ByPoqGM93T3zPORn9cufWae9vG5YKD7HtbBn1+Z8/IZoCEmO
	 uGZZik01l9teWXxCK1ikEXAM8FFnVXlpmt/Z2+IjYn+DQiXa25taIgWwiXXFNI+Wdi
	 ZHXD++EuYFXstkNStmsSjJNow1VF1j699eiXKcR1lObv9SzVk7ul/MG1mxXFbfe3NS
	 3nf5th2W4SK4g==
Date: Mon, 16 Dec 2024 10:56:42 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hch@lst.de, hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC v2 02/11] fs/buffer: add a for_each_bh() for
 block_read_full_folio()
Message-ID: <Z2B36lejOx434hAR@bombadil.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-3-mcgrof@kernel.org>
 <Z10DbUnisJJMl0zW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z10DbUnisJJMl0zW@casper.infradead.org>

On Sat, Dec 14, 2024 at 04:02:53AM +0000, Matthew Wilcox wrote:
> On Fri, Dec 13, 2024 at 07:10:40PM -0800, Luis Chamberlain wrote:
> > -	do {
> > +	for_each_bh(bh, head) {
> >  		if (buffer_uptodate(bh))
> >  			continue;
> >  
> > @@ -2454,7 +2464,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
> >  				continue;
> >  		}
> >  		arr[nr++] = bh;
> > -	} while (i++, iblock++, (bh = bh->b_this_page) != head);
> > +		i++;
> > +		iblock++;
> > +	}
> 
> This is non-equivalent.  That 'continue' you can see would increment i
> and iblock.  Now it doesn't.

Thanks, not sure how I missed that! With that fix in place I ran a full
baseline against ext4 and all XFS profiles.

For ext4 the new failures I see are just:

  * generic/044
  * generic/045
  * generic/046

For cases where we race writing a file, truncate it and check to verify
if the file is non-zero it should have extents. I'll do a regression test
to see which commit messes this up.

For XFS I've tested 20 XFS proflies (non-LBS) and 4 LBS profiles, and
using the latest kdevops-results-archive test results for "fixes-6.13_2024-12-11"
as the baseline and these paatches + the loop fix you mentioned as a
test I mostly see these I need to look into:

  * xfs/009
  * xfs/059
  * xfs/155
  * xfs/168
  * xfs/185
  * xfs/301
  * generic/753

I'm not sure yet if these are flaky or real. The LBS profiles are using 4k sector sizes.

Also when testing with the xfs 32k secttor size profile generic/470
reveals device mapper needs to be updated to reject larger sector sizes
if it does not yet support it as we do with nvme block driver.

The full set of failures for XFS with 32k sector sizes:

generic/054 generic/055 generic/081 generic/102 generic/172 generic/223
generic/347 generic/405 generic/455 generic/457 generic/482 generic/500
generic/741 xfs/014 xfs/020 xfs/032 xfs/049 xfs/078 xfs/129 xfs/144
xfs/149 xfs/164 xfs/165 xfs/170 xfs/174 xfs/188 xfs/206 xfs/216 xfs/234
xfs/250 xfs/253 xfs/284 xfs/289 xfs/292 xfs/294 xfs/503 xfs/514 xfs/522
xfs/524 xfs/543 xfs/597 xfs/598 xfs/604 xfs/605 xfs/606 xfs/614 xfs/631
xfs/806

The full output I get by comparing the test results from
fixes-6.13_2024-12-11 and the run I just did with inside
kdevops-results-archive:

./bin/compare-results-fstests.py d48182fc621f87bc941ef4445e4585a3891923e9 cd7aa6fc6e46733a5dcf6a10b89566cabe0beaf

Comparing commits:
Baseline:      d48182fc621f | linux-xfs-kpd: Merge tag 'fixes-6.13_2024-12-11' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into next-rc
Test:          cd7aa6fc6e46 | linux-xfs-kpd: loop fix noted by willy

Baseline Kernel:6.13.0-rc2+
Test Kernel:   6.13.0-rc2+

Test Results Comparison:
================================================================================

Profile: xfs_crc
  New Failures:
    + xfs/059

Profile: xfs_crc_rtdev_extsize_28k
  New Failures:
    + xfs/301
  Resolved Failures:
    - xfs/185

Profile: xfs_crc_rtdev_extsize_64k
  New Failures:
    + xfs/155
    + xfs/301
  Resolved Failures:
    - xfs/629

Profile: xfs_nocrc
  New Failures:
    + generic/753

Profile: xfs_nocrc_2k
  New Failures:
    + xfs/009

Profile: xfs_nocrc_4k
  New Failures:
    + xfs/301

Profile: xfs_reflink_1024
  New Failures:
    + xfs/168
  Resolved Failures:
    - xfs/033

Profile: xfs_reflink_16k_4ks
  New Failures:
    + xfs/059

Profile: xfs_reflink_8k_4ks
  New Failures:
    + xfs/301

Profile: xfs_reflink_dir_bsize_8k
  New Failures:
    + xfs/301

Profile: xfs_reflink_stripe_len
  New Failures:
    + xfs/301

[0] https://github.com/linux-kdevops/kdevops-results-archive

  Luis

