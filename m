Return-Path: <linux-fsdevel+bounces-35624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273689D670E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 02:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A968B1608F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A342A95;
	Sat, 23 Nov 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="COUITAv5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91B14A91;
	Sat, 23 Nov 2024 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325579; cv=none; b=plwF7y6zfrZaSj13U6fQD2jgRZ8zmEEMGsG8cpGMCljUHeoap9PstbMIAwSm0kmoVgs2z4+gHcw5T9XaA6IdhliiWo2haRX/7/4Yym2tldNYvOlAuKEIAPkZ0obRTAYCAI7DyOvyRIe1/NIyxvWwkgkOB6rYLzB+vthVtlZzmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325579; c=relaxed/simple;
	bh=Qhjd+yj4xOJOyXsRDetZco33mNnv7mlY44Cg6pvhjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpFZFolzeuxIrySniJVwSfR4vUDhL86ELQtRWEoXUgIKlxBLqtzGzP8v/u/fCSUQb5kxO6Wgaa6+HNpBeYmKuUgAQi5tA+UZhmGKPfATaMjNDpU1vcudR+D4PrUe2ZJBhSrrwj/gkf6skCuXKL4mCysVhyL0epOyEo2SWaZ+E4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=COUITAv5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qhjd+yj4xOJOyXsRDetZco33mNnv7mlY44Cg6pvhjSM=; b=COUITAv5LV9yRL4EOMeVgtXHsM
	AupzkkydcbKaRa9UA1kuo2Pabfzr9+Ldoh+EuSM7DFRGvBMzY5Fg39O21/3/T8YH3H99w2zJ1fEv6
	BD0t6NPZ+N/5+hE+v/S1V9v1t1SAThUE0LdV3vR1cOdfIO41gznUwjom1/Lfwuvr8HBvCvQ8ATn0L
	0KrQ5JhPdQ87OjgDrDYH2sXJCo8ZfXO2TrQn/Mghrgw5fqR1jp3qMzt5YcITpBr038JW/XbbD28Cy
	+uU38ITBSzPG908m9V3BMQmgZh3RRNm5Jq+kUuGLTs/VZuaExSekyCywlS1RcDewrbH+c+58LV5+i
	jslPDVUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEf12-00000000Zl0-0tft;
	Sat, 23 Nov 2024 01:32:52 +0000
Date: Sat, 23 Nov 2024 01:32:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V5] fs/ntfs3: check if the inode is bad before creating
 symlink
Message-ID: <20241123013252.GQ3387508@ZenIV>
References: <20241122074952.1585521-1-lizhi.xu@windriver.com>
 <20241123010956.1590799-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123010956.1590799-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 23, 2024 at 09:09:56AM +0800, Lizhi Xu wrote:

[snip]

hardlink, surely?

