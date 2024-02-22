Return-Path: <linux-fsdevel+bounces-12491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF785FD80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9E31C246AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA4150988;
	Thu, 22 Feb 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PS7wXuAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9314F9E7;
	Thu, 22 Feb 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617804; cv=none; b=KZO9JwL4+YA56d613zqzJINxFGAnQMudg0NaGN1ThWB6SX4ToZBXjFX6cHaxPRBpY82sC5eNIxQTSdDBoqD890KOFo12wohUHPALldDlzn+XExaxcs5rLPZjUJN8eWJZoCgFzaLYPmgS/tTER0ijiCIFsau7obKXL8nI9B/XdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617804; c=relaxed/simple;
	bh=/wFw9YSuI9zcQ/LNkPy0aQWduY5c3j/BYq0CnuD5GsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOQzEVlzyczduGUwsi+rH6bVw8p4BtPcHHVHG5U4529hkIuPJdStEkvk0RoHXvf7oSrjuRF6sw3NxbgrLc5Eu8XuU1Tr+Z7XgCMkvmQUGKxBqDqDEN23aMaD6ISeiu6+YHjmEX5ixwOl6d91lLOWxEy+jyxhXNRME8H5HxTsdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PS7wXuAw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=hTo2vh8op0bT3tEUtwhGOi1VLFI+ijx3iYvYYb7CfwI=; b=PS7wXuAw8lZ8GBrFmVpTkfUOGH
	6W0EWv2KQFOAZU8YkN1qlzhthap25pdsmMxha+7oQW8VHAUR/Vm9zaQC5pyl5aSxpqh0p0RJy3k7F
	Xr8OOUKPjXXKFqPnkiOz59lZeN59A5x82yKYHgNrOZ3SRxjk3XZOMxE+PkbCSgKi47YlfwxsdVbj3
	D3zeBJx7Poy66QyzmC6JrC0CMK4sTBuok7/hvVZArSQkybxkWQoTHjY503K/r5enpDsbnz2CmZZVd
	AOudf+5EmYTxTIcPCEL6+A7WihJsnXjq7fWh4KQq4kVZuKLB5q78mdZK5Yp2lEjwm2CHPSKqhkxg+
	vA6R/wLw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBXc-00000005XBO-2mrq;
	Thu, 22 Feb 2024 16:03:20 +0000
Date: Thu, 22 Feb 2024 08:03:20 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] sysctl: move sysctl type to ctl_table_header
Message-ID: <ZddwSOaFcr0jUmdA@bombadil.infradead.org>
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Feb 22, 2024 at 08:07:35AM +0100, Thomas Weißschuh wrote:
> Praparation series to enable constification of struct ctl_table further
> down the line.
> No functional changes are intended.
> 
> These changes have been split out and reworked from my original
> const sysctl patchset [0].
> I'm resubmitting the patchset in smaller chunks for easier review.
> Each split-out series is meant to be useful on its own.
> 
> Changes since the original series:
> * Explicit initializartion of header->type in init_header()
> * Some additional cleanups
> 
> [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/

This all looks super sexy to me, but I'd love Eric's feedback on patch
series before merging as he may know some other facts over sysctl_mount_point
I might be missing.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

