Return-Path: <linux-fsdevel+bounces-15081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33478886DE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A321C21F5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE944C8F;
	Fri, 22 Mar 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIKzBgZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852F45BED;
	Fri, 22 Mar 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115636; cv=none; b=doO3d/IoYt45eZBw7g2yRjIeHrvKLAoFvApMl+E/9IjK42bnrCyT++5fcFTt527yUyE3Rox7Drfn4dVMpFvvoe/vFdr6BNR8qspPqJN2ZjRfkDy7IpK9Lvv6Bs7Tq7ZMw2Km2nkOgDR8kKkaqUjXXw8tLolKhsgkn4IG95USn9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115636; c=relaxed/simple;
	bh=BOjDt8Sw8y5kxf0RMot6mNm/oYPB2drdqZSQ5Sd1iSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urIFn3dKjFiR6lXgtkHbiwh1btZBsQQXCAsgWunR8Dtd82Q+HmcU/bD/B1lTEei1/ON+pvGU0j+sWGjZUnEUnrM2iCYxzEW3cKv1d9ge407batX43neUzrsWnWXZU17hff467TbgHzcNc1ENNq40+FRFRcm6afks+gvzxsHcEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIKzBgZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B8BC433C7;
	Fri, 22 Mar 2024 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711115635;
	bh=BOjDt8Sw8y5kxf0RMot6mNm/oYPB2drdqZSQ5Sd1iSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIKzBgZJaNhXV0N7X9A/Zq/0txgQ86SktENCCbpwoZrG3sqQWwS/mbNV59Oco0Vkw
	 Ty2ntpVELq5LVkMlq7FuzXe4e1QsJqvOSiZZy3RM6FLFORiJAy87rYKGjW+BU5QQkh
	 FL4fLQRYUMgX1ndDHXnZWFRJ9DPG8qdHXc0UahvLwlbthvHU8hCQIS62vP2OmGdE+W
	 wB/Ct0z4wW1GyLXecyyt0L9tF9vQMh1Wn881VRa76Jmcvfrd6I4B9JMb0ebocWNep4
	 hA04OeCPL0agDsetkW6Ry1OAdYJxENOwpINwvWjOIf5o+cUk5EWMYqu63+LikbHANY
	 zG8Ct6U30F0Dg==
Date: Fri, 22 Mar 2024 14:53:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240322-abverlangen-rache-f6dae0656ba2@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <ZfyyEwu9Uq5Pgb94@casper.infradead.org>
 <20240322-subsumieren-dennoch-647522c899e7@brauner>
 <Zf18I2UOGQxeN-Z1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zf18I2UOGQxeN-Z1@casper.infradead.org>

On Fri, Mar 22, 2024 at 12:40:03PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 22, 2024 at 01:31:23PM +0100, Christian Brauner wrote:
> > > ** mkfs failed with extra mkfs options added to "-m reflink=1,rmapbt=1 -i sparse=1,nrext64=1" by test 015 **
> > > ** attempting to mkfs using only test 015 options: -d size=268435456 -b size=4096 **
> > > mkfs.xfs: cannot open /dev/vdc: Device or resource busy
> > > mkfs failed
> > > 
> > > About half the xfstests fail this way (722 of 1387 tests)
> > 
> > Thanks for the report. Can you please show me the kernel config and the
> > xfstests config that was used for this?
> 
> Kernel config attached.
> 
> I'll have to defer to Kent on the xfstests config that's used.  It might
> be this:
> 
>     cat << EOF > /ktest/tests/xfstests/local.config
> TEST_DEV=${ktest_scratch_dev[0]}
> TEST_DIR=$TEST_DIR
> SCRATCH_DEV=${ktest_scratch_dev[1]}
> SCRATCH_MNT=/mnt/scratch
> LOGWRITES_DEV=${ktest_scratch_dev[2]}
> RESULT_BASE=/ktest-out/xfstests
> LOGGER_PROG=true
> EOF
> 
> 
> Also, while generic/015 is the first to fail, you can't just run
> generic/015.  You can't even just run 012, 013, 014, 015.  I haven't
> bisected to exactly how many predecessor tests are necessary to get
> a failure.

Thanks for the info. So it's as I suspected. The config that was used
has
# CONFIG_BLK_DEV_WRITE_MOUNTED is not set
That means it isn't possible to write to mounted block devices. The
default is CONFIG_BLK_DEV_WRITE_MOUNTED=y.

I go through all block-based filesystems with xfstests for such changes
wit various config options. My test matrix hasn't been updated to
specifically unset CONFIG_BLK_DEV_WRITE_MOUNTED which is why this
escaped. I'll send a fix shortly.

