Return-Path: <linux-fsdevel+bounces-37689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE119F5CA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C61188DEEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784597F48C;
	Wed, 18 Dec 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6MOC46G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2579C4;
	Wed, 18 Dec 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487789; cv=none; b=CB5hBE86m6x1gijk9AeJeMTFQZqe/UwlsuFIaJLEtw0fLeAI8Wowq8MGWeOFxRVp7wNtsYbEvZlHgr2fvmEE6XeSi69CDk8q1j1YCrJt1GtjXUyrXYSzg0QZgJMdAT5HXPc4hbyJTX8E2vI7oVZFOlLDEHC8gJDrO6AlyyrVwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487789; c=relaxed/simple;
	bh=zG/whhhNwLnOVwHT2f1CvLCAZE+XgnbcCpgmM3fSNqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaR17a1aBh7whqzP62JVci2crk8s0iTU49OU3r5OEL9SEcciYGFsQQE7ygOC2BQsYTpFPG0wiAgkkX+7W7nCjsEEBANL5u+rUr0Okr4h9jjlU6Ctniefqk3PCEZeK5RITq10TPPI+L4X65DanfZNZtkL4Il8kYOGvyesmTSp5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6MOC46G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFF0C4CED3;
	Wed, 18 Dec 2024 02:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734487789;
	bh=zG/whhhNwLnOVwHT2f1CvLCAZE+XgnbcCpgmM3fSNqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6MOC46Gd+klvCb6BOmTrMmJrw+i1YGlzdodWC5IU14uH+u0ta1iPQZZ1UmqAHUwZ
	 rlzioyRjod0vGBluJRIgctxOvhHSQqscj5Vkvhv0GOvBZj2oEKWar0XfHGD1WGSGZK
	 JWn8tjSDAEZcoWAna/ehvixb/zG1YLCGXBP3jMvpnqKMMzr8NiWGzsucsvhG1L99aO
	 9xVSmjE2fVnNAR25jyAUnDTI635p3/Q9CMl0ajT5GL5Q6+9IOdq4YfWt/y4TVKu3A7
	 hJK9Oitw+22qYPSPKRHJpH6hsTa/kweO81dtv4qMFBafqmsoAsFO1HSzt7lAEkRp4D
	 z5j2D7GjGCKlw==
Date: Tue, 17 Dec 2024 19:09:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, hare@suse.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, willy@infradead.org,
	dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH 0/2] block size limit cleanups
Message-ID: <Z2Iu6bSbUzl27mxt@kbusch-mbp.dhcp.thefacebook.com>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>

On Tue, Dec 17, 2024 at 06:02:10PM -0800, Luis Chamberlain wrote:
> This spins off two change which introduces no functional changes from the
> bs > ps block device patch series [0]. These are just cleanups.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

