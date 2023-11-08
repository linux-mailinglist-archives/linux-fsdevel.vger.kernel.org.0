Return-Path: <linux-fsdevel+bounces-2375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC367E5256
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFF728163F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E32DDDB;
	Wed,  8 Nov 2023 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXBfmcmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B56DDB7;
	Wed,  8 Nov 2023 09:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EBFC433C8;
	Wed,  8 Nov 2023 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699434222;
	bh=yZPwswZOAsJvBUrGtw1f+G5JjyO3i5Gz/Jxlh+Mv2Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXBfmcmkVYjm28MqUDzN7yGewkbP2xI7jvHCot+NjADACFfH9bdpTuknB4ay6Gc6Y
	 UPfleMYARjjOLmRFV+33vqMTeaOvE582WtMfYYwTeoK2brG/ckxuZsSUdMAzEn1Jiy
	 lGV8t+g4XBTzzBvwF18GNnVrvZZuahd5OGorzLSZ0XS9j3dTtSYiyA81k8+AZE9J8m
	 yiiB6dptfged1n1oYYS/BVvxW3BZm1kF1flqJGMVIeHCzRr5Pu52FVLOxfN1AGhIA4
	 +7BcKMk29DsS3KsSlqcKkt53GOTxrNjK2iV0BrZTHTFjr4bygZ3y9nL0CundUngyzB
	 vfC9agpp4Eo1A==
Date: Wed, 8 Nov 2023 10:03:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/18] btrfs: switch to the new mount API
Message-ID: <20231108-staunen-zugang-dc611d903181@brauner>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <2a6839a7f8a7769e13d03f39064f96180fba7432.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a6839a7f8a7769e13d03f39064f96180fba7432.1699308010.git.josef@toxicpanda.com>

>  static struct file_system_type btrfs_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "btrfs",
> -	.mount		= btrfs_mount,
> -	.kill_sb	= btrfs_kill_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
> -};
> -
> -static struct file_system_type btrfs_root_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "btrfs",
> -	.mount		= btrfs_mount_root,
> -	.kill_sb	= btrfs_kill_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
> -};
> +	.owner			= THIS_MODULE,
> +	.name			= "btrfs",
> +	.init_fs_context	= btrfs_init_fs_context,
> +	.parameters		= btrfs_fs_parameters,
> +	.kill_sb		= btrfs_kill_super,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,

Just in case this was an accident. This patch seems to drop
FS_BINARY_MOUNTDATA from fs_flags. 

