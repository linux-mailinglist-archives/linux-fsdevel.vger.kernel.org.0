Return-Path: <linux-fsdevel+bounces-59055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E790CB3404F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4716206CE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5741F1313;
	Mon, 25 Aug 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWGM1Tzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254D2B9A7;
	Mon, 25 Aug 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127008; cv=none; b=uCOtIk3i6ceURJAsxqWsjgo5ZGl7G+ZJ0IinfH/sw48gU9k/Eg+JdFfIV3JK0miM4B7Y3QDPszd2wm3pupL+aafQ8XSq2dbWzPOcchcTf/BpYAPXM0MGUGBBLyjdxKgBszNH8R47xbCfIai/WzzjLVP6mgrsyYO9+52o2FQW318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127008; c=relaxed/simple;
	bh=h8vW146cQOAZMeAF8OQcaqbM9C49DYmOGJ545rMirD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTJx9B/5Ma3682zKPJI6Pa1CSHdt2BQS6omVEdFW/2cWr/+GNXCvh+T8M/QWcgtrVd3qIJMolZP4+g6UnizUH6H5+UnDCMtf7LKfPxnr6ooFo87jU5MsYVEQHMteiml2zRZ8CLsjYcTtxSrxZxObCWIh29uWqSso1F3wcypSm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jWGM1Tzr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hsGYF0FaLs7v3MHjFI3tJ5DbO+nCiLN104h3lCxUDJs=; b=jWGM1TzrJfeUb+QUcZa6LoHkBz
	2m1cvVi3H3l7ouqIkH8UodE29ymG8/+bI7/XOp3KkyCY1pvVhiIsk5sgPlVM86NBwzv6R1T3Ma6Uz
	5NtOZ5QST5Gn/epzZPNSjPpyDTN51xklK1r3INXttahp6p3A8JkTbl4z9k1HQAJo3+LpS1fBx7gm9
	/Zg2FzC/uYbldSop2u449Ox1RCdNgqSbZMY6YKrmjeBFRgFMkvHmUt4xl4/jpmku46/02dptGZ2Kj
	d+sNCwsdlt95Vi4Xq/s3VqERK9YRzGo11AgHGKT96wkjHO8KP4gyC+grXHxfF3adHKRIgjGptboJ+
	6mNxW8Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqWr5-0000000EGgg-0jha;
	Mon, 25 Aug 2025 13:03:23 +0000
Date: Mon, 25 Aug 2025 14:03:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
Message-ID: <aKxfGix_o4glz8-Z@casper.infradead.org>
References: <20250824221055.86110-1-rdunlap@infradead.org>
 <aKuedOXEIapocQ8l@casper.infradead.org>
 <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>

On Sun, Aug 24, 2025 at 04:54:50PM -0700, Randy Dunlap wrote:
> In file included from ../samples/vfs/test-statx.c:23:
> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>   159 | #define AT_RENAME_NOREPLACE     0x0001
> In file included from ../samples/vfs/test-statx.c:13:
> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE

Oh dear.  This is going to be libc-version-dependent.

$ grep -r AT_RENAME_NOREPLACE /usr/include
/usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE	0x0001

It's not in stdio.h at all.  This is with libc6 2.41-10

