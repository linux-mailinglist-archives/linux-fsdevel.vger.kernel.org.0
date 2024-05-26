Return-Path: <linux-fsdevel+bounces-20169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDB8CF313
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE6D1C21A1F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE2B647;
	Sun, 26 May 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpO+942e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE78F54;
	Sun, 26 May 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716715541; cv=none; b=Ls6MlNDyDJaYoP8bwnloBQbnrkweoMquuacYpH0GqwASBIS88U7EKnqp5goDxIUD2EHcJHdJPuPS5dLTtCxHMSVSmoKoh8Vzc1YYbvb1DrZCrwUaXlqgWPRLNw3RV6mHePMANRmVL754uC2srNjW7AWTnTgCnVfYcDfYUJUSe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716715541; c=relaxed/simple;
	bh=J3+xwB/7tX6Bth1ZZZOnPESeYeIK5qF5WnmoEBO+q5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2qAmq/68Th4F892GZSTGJB/IW/6eyAuFAynTOIlVLyxgxda3ApVX66Rn+R6LA+C8AN41E5bb3wr09nJVBq+778Ml14ks+Y+fO4WUroMxEn9ogQFbIHTLu2RvvRaUkguD5eMj5H6F1X70enhsUTCI1FPr8BXw1mW43+QcrUqX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hpO+942e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D7h0RhNkAKCic1Da42IZ3OgM6xXPiv190nM0wcYEFcg=; b=hpO+942ekCMbNp/hrhH5qKrYdX
	qceekPpSF2doKYsp7ncNpU4saNLeCFGJoOGvO5XdMPt6ftuSEAPsQv7NAPmNAaKzI2ADfe2PKK+J0
	rUqaroxmw0TEHUMQtFF3NUWbNJ4ix3BQxOO7Hmgo71z1xf31vnK640NH2JV75MPOD1grAxAhItkAR
	wNdDEPBWZn/CESAi3dZNVlrWEq0D90TpLROmj3rTLV72X9k1sm3zMRDYkK62RxR/FqKDO8teppyA2
	YLrA87ZjjpldN2mnlaejkPoej/0ggLAnyZBBYRodIeY4srlY9CTuY98PT0un15ilHaZO4gjmZGFS/
	CPCdIexg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBA8E-0000000CQp5-39By;
	Sun, 26 May 2024 09:25:34 +0000
Date: Sun, 26 May 2024 02:25:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlMADupKkN0ITgG5@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 23, 2024 at 01:57:32PM -0700, Aleksa Sarai wrote:
> Now that we provide a unique 64-bit mount ID interface in statx, we can
> now provide a race-free way for name_to_handle_at(2) to provide a file
> handle and corresponding mount without needing to worry about racing
> with /proc/mountinfo parsing.

file handles are not tied to mounts, they are tied to super_blocks,
and they can survive reboots or (less relevant) remounts.  This thus
seems like a very confusing if not wrong interfaces.


