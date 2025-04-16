Return-Path: <linux-fsdevel+bounces-46531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86308A8AF18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE3D7AB384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 04:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EB229B1C;
	Wed, 16 Apr 2025 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EqYgKWsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C04A1A;
	Wed, 16 Apr 2025 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778227; cv=none; b=OP/lcwKgpSCWVbRJiNcBhP46bH7458iGLhyCInqRtMo+sm1xKk961IRDQr1by7vQbGFLljut18jz4Ll7U9qoqAUXZDLrpgppiB6sE8VJlYbxVVgCPDrnO+yARJciwT1nKsk6la11qO2hp4qfVEbhftOodvTU8yFvN0d5tjW5V1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778227; c=relaxed/simple;
	bh=CLuTPtJ/W0nH0ifdaKYd5Lka79cNaAeH4PkTOAgL/WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFFsqk3oQuE7PA78CmhX21OiHGkDHttrJ+sGnxZvE/SGOzp/H+nxjEIUt+sqGkLKhUScIv0TccRBBWcJl+cuZRwDqyFTh39KPSxOnlkkDkYE4oQD3+A8v5PkHhwu4REtafZbFmlHityUhe8v2RqWSxnPizKwZ78ot4Fut5u4fLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EqYgKWsB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PalyFqm2a9ht5Bv38AYsElqk2gmdRQBYGnXGQdGD96s=; b=EqYgKWsBgM6sOJ30PAi7VMCSzq
	yKxQWFjE74FWHg0EAAmVlv9Eq0gFUhVO8QnR8uUiaNTPJxJ0dA9I8taYRe6YSxaZ86GtxKTwtDpge
	E3OUYRk2NCREFa0O3dKxCW2UToRIP4gop6NfChx6DYq5Vjd51vjjUDoTzdDr72zmfciPmAvyqoGCk
	AIaAElqyaB2Z2rwLQLscT7Ik9ru6qhYufQLh/vhIOtHf/Z0jxRr0r74aanxwMLveQV7Laa96EnRMp
	S/FiK+Y++yp4jLrnMjwZit8Tjgi9AewGgE41EAq7XQN9b8jNWNnvnu7tql6dUXcL6GEAKkxoURZu0
	QlGPUzyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uWG-00000008AJb-088f;
	Wed, 16 Apr 2025 04:37:04 +0000
Date: Tue, 15 Apr 2025 21:37:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jack@suse.cz, almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Message-ID: <Z_8z8CD4FKlxw5Vm@infradead.org>
References: <q5zbucxhdxsso7r3ydtnsz7jjkohc2zevz5swfbzwjizceqicp@32vssyaakhqo>
 <20250415092637.251786-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415092637.251786-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 15, 2025 at 05:26:37PM +0800, Lizhi Xu wrote:
> The ntfs3 can use the page cache directly, so its address_space_operations
> need direct_IO. 

This sentence still does not make any sense.


