Return-Path: <linux-fsdevel+bounces-36278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB09E0D2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C68FB68120
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7281DE3AF;
	Mon,  2 Dec 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDXFsGp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2D70805;
	Mon,  2 Dec 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164606; cv=none; b=S2PZSqjnv6Ql4keBSjm6fQyRZJ7uzuK6XPFZe1gDs73GI8DTjYczVxkgaaiYGdZwKXi2AGRMxtfaLRvNjwjYjS/d2Qfd9QVo+19+2Qmy6uEmLx4IOYIrj4IugEWXkfgeTi1Oie4W8FxO9DvEic3bgX5NHXH0P69Plx1iaeZhVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164606; c=relaxed/simple;
	bh=SV0a41+RDhocvfEPEyv80/bq/ZSJlaeMPldbjOpf4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9HJhF4+GIFOjAsVV1EJcYU9Ffk7plVU51R6VUy+X1Z17p5U/q+2XGyHxIF0TJwhP5drNuOsccN6SO1nrX3gJNKG5J67m7oEC5mdgkH37HVLY9H2SMvCO+iNa5MjCfZ7UpWP6vlk6dsTB5EDgnAXK8dsmw/DbHef3XelyzH2wM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDXFsGp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98048C4CED2;
	Mon,  2 Dec 2024 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733164605;
	bh=SV0a41+RDhocvfEPEyv80/bq/ZSJlaeMPldbjOpf4GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDXFsGp6SVShBJ3Ui0hgJsz5amcbCq/I/bbNbZ2kUyQfWOw2ZS5q9ExO9fJelmJDV
	 JoTW7+mVoW8JQm4aPfX9GffJUvsXf9CKpTJVs952AAHPXkRtNMzStQxAzUh/Zv0IAM
	 0fAcJug/ASl+Poqji32qvlgh2ELNQMPdZwK3F2r+xv/iG/DXptEJg9zeHdsn/Jb+Iz
	 0ftJTTXMZjBNyUB0xZcMDq65RoPvWTKPBxqqHxCCvmsG4BmH9jMW9szDkcIz+t9UOi
	 mrIcG+VFSZqEP8KKocQ42uPkXDpb8JEBmQ5qSM4KpHB9tjvuVuaI9zpuuXloq4bRbo
	 YzTBzB4DMLNQw==
Date: Mon, 2 Dec 2024 10:36:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Gaurav Kashyap <quic_gaurkash@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Om Prakash Singh <quic_omprsing@quicinc.com>
Subject: Re: [PATCH RESEND v7 00/17] Hardware wrapped key support for QCom
 ICE and UFS core
Message-ID: <20241202183643.GB2037@sol.localdomain>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>

On Mon, Dec 02, 2024 at 01:02:16PM +0100, Bartosz Golaszewski wrote:
> The previous iteration[1] has been on the list for many weeks without
> receiving any comments - neither positive nor negative. If there are no
> objections - could we start discussing how to make these patches go
> upstream for v6.14?

The way to do it will be for the block patches to be taken through the block
tree first.  That will unblock the rest, which can be taken through their
respective trees in subsequent cycles.

I'm really hoping to be able to test these patches with upstream myself, which
I'm not able to do yet.  I'll try to leave some review comments on the parts not
authored by me the mean time.  Anyway, thanks for continuing to work on this.

> Tested on sm8650-qrd.
> 
> How to test:
> 
> Use the wip-wrapped-keys branch from https://github.com/ebiggers/fscryptctl
> to build a custom fscryptctl that supports generating wrapped keys.
> 
> Enable the following config options:
> CONFIG_BLK_INLINE_ENCRYPTION=y
> CONFIG_QCOM_INLINE_CRYPTO_ENGINE=m
> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
> CONFIG_SCSI_UFS_CRYPTO=y
> 
> $ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/userdata
> $ mount /dev/disk/by-partlabel/userdata -o inlinecrypt /mnt
> $ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/userdata > /mnt/key.longterm
> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/userdata < /mnt/key.longterm > /tmp/key.ephemeral
> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> $ rm -rf /mnt/dir
> $ mkdir /mnt/dir
> $ fscryptctl set_policy --hw-wrapped-key --iv-ino-lblk-64 "$KEYID" /mnt/dir
> $ dmesg > /mnt/dir/test.txt
> $ sync
> 
> Reboot the board
> 
> $ mount /dev/disk/by-partlabel/userdata -o inlinecrypt /mnt
> $ ls /mnt/dir
> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/userdata < /mnt/key.longterm > /tmp/key.ephemeral
> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> $ fscryptctl set_policy --hw-wrapped-key --iv-ino-lblk-64 "$KEYID" /mnt/dir
> $ cat /mnt/dir/test.txt # File should now be decrypted

That doesn't verify that the encryption is being done correctly, which is the
most important thing to test.  For that we'll need to resurrect the following
patchset for xfstests:
https://lore.kernel.org/fstests/20220228074722.77008-1-ebiggers@kernel.org/

- Eric

