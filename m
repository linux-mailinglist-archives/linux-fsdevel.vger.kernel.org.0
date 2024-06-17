Return-Path: <linux-fsdevel+bounces-21804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E690A7BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C48B22448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41BB18FDAB;
	Mon, 17 Jun 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIg+uePk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDCA38396;
	Mon, 17 Jun 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610807; cv=none; b=ssuqCQp80dGahfsTYyG3jNl2QUWZ1Vg1h94kUwphfnvaF7D+u2bw2b7BFFs9qkl9eiK04uYHq2Ycdm45PB+oJ4AiXP+7/3BJroFBb2dljMwkbO5GoD3O5/yuq9MU710wj0saA8wXmhzFwM848SshQ03AANsbLfTaNQ2W9ioyp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610807; c=relaxed/simple;
	bh=2k6bPclIn2GsbnEqlby1rhyXy6ssf+kHi4IqMQnI2/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9VCdzLS7MfGhPPLhMGRk//Tz355CTG0vON5T+GScQOBtz2R45kiGuV6hvWS/HQb85ngOR5PHdhvbMZTWqFJaJ4Ks5eg/8L0V17ML/LSBmbNm6InOWx6TwLtf2tIl7p3M46QS9w2rgC1AN8GqPH0kqZE7l3QZJoF1dLz2ok2n8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIg+uePk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B14C2BD10;
	Mon, 17 Jun 2024 07:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718610806;
	bh=2k6bPclIn2GsbnEqlby1rhyXy6ssf+kHi4IqMQnI2/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIg+uePkldUC/VrJAexZhHCL+eEEzPHle3s9C60hhK22AbeMqbe5RouYAcPIA8r8E
	 pK5JOIRc7cQw2jpWk3DmZ9adCp2kORGKZjm7g8LygQxJOiasAONtEGZdEorV2knBb2
	 8BVzMYLFNohvmd1bIoXXUIN4aKD6x/b0x86Eit917aToJcrgAwYcFnZOssVQydRekR
	 Kub82chV9LahellrWLmLjG1++I4WYPO3za1A6+8MzkEIKVTc54kWq4SbqONu2sFGpT
	 TLx8WZVEwKJyOHNVx9ORQ2cebFHPZAvJzo4O763Gr/m9DH7lvcTs5I5NB/lpJfjsr6
	 T5j1x0r9O5Kxw==
Date: Mon, 17 Jun 2024 09:53:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: How to create new file in idmapped mountpoint
Message-ID: <20240617-backfisch-chilipulver-77c21e2b338c@brauner>
References: <e4f9392e-b5b6-4063-aecb-4d034c5d2bb6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4f9392e-b5b6-4063-aecb-4d034c5d2bb6@huawei.com>

On Fri, Jun 14, 2024 at 03:09:22PM GMT, Hongbo Li wrote:
> Hi everyone !
> 
> How can I create new file in idmapped mountpoint in ext4?
> 
> I try to do the following test:
> ```
> losetup /dev/loop1 ext4.img
> mkfs.ext4 /dev/loop1
> mount /dev/loop1 /mnt/ext4
> ./mount-idmapped --map-mount b:0:1001:1 /mnt/ext4 /mnt/idmapped1
> cp testfile /mnt/idmapped1
> ```
> then it rebacks me:
> ```
> cp: cannot create regular file '/mnt/idmapped1/testfile': Value too large
> for defined data type
> ```
> Did I use it incorrectly?

You're setting up a mount in which uid 1001 maps to uid 0. So if you
create files as uid 1001 they will map to uid 0 on-disk.

But you haven't mapped uid 0 to anything so the mount doesn't allow the
root user to create files. In order to that you could e.g., do:

sudo mount --bind -o X-mount.idmap='0:1001:1 1001:0:1' /mnt/ex4/ /mnt/idmapped1/

If you now (as root) do cp testfile /mnt/idmapped1/ it will work and
files created by root will show up as being owned by uid 1001 on disk.

