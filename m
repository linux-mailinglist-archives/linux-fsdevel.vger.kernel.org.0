Return-Path: <linux-fsdevel+bounces-53726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03339AF63D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0053B3DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B92376FF;
	Wed,  2 Jul 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h8ZwZyK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D52DE700
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491014; cv=none; b=EBFAjYlL4VWU4/f0HarXkBlD0LR3ZHSaTgfBLE7yPC04TZZDiTnRzz1wznyXooi6HHEM0ApNqPZBo4vLpCWCLqY3GS8bot5ks/ZS73Y/PyMpn0ZrU4i61fKOcE6eqvdcd9P5jp+DBGGRvJ2ZQUbe+YdnZ4Cedrkw7uQO3S7HpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491014; c=relaxed/simple;
	bh=gsfr/y/mIxWa7ZjptiRq/PSEUbt7oIsh06fy5sY1ZiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYggNrxqrP3Y5UuP0RT8kgIoCXOpce+294U5GTbWyyIlBHtWtzxrREHbE9yDDBXvzgNQeKucnuWRf85G1Cgm8MnN28LiAqxqRL4uX+10QBTPFJeccwUlOQkMlejoilRAhcZT8aoPEDh/GbSg0bDcddCaC1h889RY/+fnK2tvBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h8ZwZyK/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=thXWZGDHon4YUzzB+qOxQzP7LsdI5zSjUlTN//9j/jo=; b=h8ZwZyK/x2TUU75O+OPxCeBX1j
	2yxaen6EB+WcSYOUOxHB9ljMZOn1b9Qd9z4YVzMy8SDxLOpzeCttLVT9Jeyl49/adey/ImRcOahcg
	AoNadlbtY3u04Z7VkaSkjtHk/2a3sKGL4pm+YJrTqYHnPlEcKto9i+ydGkU7cQKm+Qm9ybzhvNpVD
	z3LQ/vGERFRgqpOikoT6ehp0t2sKVqS/RXy1BFZ7clRGsqGzPE9l/EINpSBexDP4dc4NSV3d0Rm/C
	EIEoI2W3e9daJvr57aUeVnfg6j4O1oBYQyOy4JQa80HhIE9Ve7uLtqSHBM1ZMkV55ce5WfwQl8GL6
	BWFsrQew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4p0-0000000EK4y-3FNo;
	Wed, 02 Jul 2025 21:16:50 +0000
Date: Wed, 2 Jul 2025 22:16:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 04/11] resctrl: get rid of pointless debugfs_file_{get,put}()
Message-ID: <20250702211650.GD3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

->write() of file_operations that gets used only via debugfs_create_file()
is called only under debugfs_file_get()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/resctrl/pseudo_lock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index ccc2f9213b4b..87bbc2605de1 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -764,13 +764,9 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
 	if (ret == 0) {
 		if (sel != 1 && sel != 2 && sel != 3)
 			return -EINVAL;
-		ret = debugfs_file_get(file->f_path.dentry);
-		if (ret)
-			return ret;
 		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
 		if (ret == 0)
 			ret = count;
-		debugfs_file_put(file->f_path.dentry);
 	}
 
 	return ret;
-- 
2.39.5


