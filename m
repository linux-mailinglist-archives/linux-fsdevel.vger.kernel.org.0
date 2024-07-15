Return-Path: <linux-fsdevel+bounces-23686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033AB931465
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC65B1F21EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469818C356;
	Mon, 15 Jul 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdz5R4gx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343D188CDE;
	Mon, 15 Jul 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046943; cv=none; b=ZGRiY4tTdltebefmaOj7/MoQt3WmrQXal8T6Uhc+sETmkwy7zcpHqD7F3XMyfKi0x5jrrbBqn+Juxq0PEEybqXdTdlSWyIULVCF/uI6GoxbAYIQGB2HL9hnzLjn4FuMZBa/5DqOro9AY6auL8BqXGe9nQqBNtoSFB7Cw60whlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046943; c=relaxed/simple;
	bh=Am2JlZy50pvx4FuYaYro9SMRfrvDmOtYcr/luTobwjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHdeKgawSgZD9fVoJI4tsLHtV4G44pRt4qNsz98rOLYLNBGrNETsTOEmwWXj/aphM216Dbo9h4isNoQhUjiacQ/xfmQVZmIwG97FpnlLTkG4XedoSn7oP5/X3F7v/dEL2LFpfBdSW5icvppeHBKpMRyAx5v0yzpAqK+fuDzo+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdz5R4gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D5C4AF0B;
	Mon, 15 Jul 2024 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721046943;
	bh=Am2JlZy50pvx4FuYaYro9SMRfrvDmOtYcr/luTobwjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bdz5R4gxJ6Ql8J56U35nW3YJFoCxycQ3kqm/w93AMzJBgOYYgAskgX3gPKobqBgaW
	 InVTSK9IwUIDsyF7+2dIofE/S5K3eMrZYhEtRi/iUuyRnHxq41nErZ0quiloXbumOT
	 A2o3t2Hfyv3s7gNESOzpEHSOxPrKWfOu454PL5baht1XXtIJWzSCfrltGPBy1D6WHG
	 HMBOgdAMgaeKZFg2UkNBQffvbtt0tkttLQ2lrb6TN511Zw2BiAr4PZqcvC75ODb0XP
	 XcuIxMH/E0TtKJ2AVmYwlgWsLO0lh4hdKY3147sfGPaFc2XeHELvyGr4xTjtuqZiZA
	 FminSopmobn3w==
Date: Mon, 15 Jul 2024 14:35:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs: ensure mount source is set to "none" if empty
 string specified
Message-ID: <20240715-abgibt-akkreditieren-7ac23ec2413c@brauner>
References: <1720729462-30935-1-git-send-email-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1720729462-30935-1-git-send-email-prakash.sangappa@oracle.com>

> The issue can be easily reproduced.
>  #mount -t tmpfs "" /tmp/tdir
>  #grep "/tmp/tdir" /proc/$$/mountinfo

The kernel has accepted "" before the new mount api was introduced. So
the regression was showing "none" when userspace requested "" which got
fixed. The patch proposed right here would reintroduce the regression:

(1) 4.15
    root@b1:~# cat /proc/self/mountinfo | grep mnt
    386 28 0:52 / /mnt rw,relatime shared:223 - tmpfs  rw

(2) 5.4
    root@f1:~# cat /proc/self/mountinfo | grep mnt
    584 31 0:55 / /mnt rw,relatime shared:336 - tmpfs none rw

(3) 6.10-rc6
    root@localhost:~# cat /proc/self/mountinfo | grep mnt
    62 130 0:60 / /mnt rw,relatime shared:135 - tmpfs  rw,inode64

