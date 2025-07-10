Return-Path: <linux-fsdevel+bounces-54424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52CAFF896
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24225544204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 05:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359E286D50;
	Thu, 10 Jul 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W4G1mxwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0514286892
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126370; cv=none; b=rAocdQTq1g4yIt0xQjjTD1y08uonuCLsBcfParCGuxVYyhwPdiXPt+S3JP9Pobw2U1DouA2m716SYTwAtoOrrokcJN0fYXVy+Bpanrfu1xQl6ZNNYGY2d0rZdRXu621/r3ClZHyvnhXtjV4bh6UNQ+1GRG++S5D3UuOFWNuoxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126370; c=relaxed/simple;
	bh=uohBvjm2gs0gbp3HX9QoVBFtZTDUET5yqcY1+I6wOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nXxGqwGhYOCJMlKVoeuGXN7ldqA1D3l9nEC99KHCWQoJ5JrutYeFEAL0QqP3BkAl3sxw2HpSuqrNGCYZ+FKPPieu47HDqsX+yO4s8szOAxmRT3JkSHp4hQVUFyqSrlIayyCIamjH5FWOeVBttm+LeBPMDhT5GaKB0Q0EVYA4zjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W4G1mxwR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+BrQ34ImVeUoEUFQ5hdWj1gOyCJHuNzia9MKuE/+6Do=; b=W4G1mxwRXWLjXjCfVjabmcb0tE
	+SLbngdma4lIzgT+2FXO/3DxsQPNF6cJpBwS3Vf9TNZLhZLZpKXMu6esHqOCiVBuGrZ5IPDTC6VhJ
	TJGJ+HniVYcFA3oJJia8udGYUfHMaCSuXZkxwWCKGEhdb4wfJ4J7t0LrTcfJlnVp30HluXdzlDLsy
	A/JjR7N8y49VOvGlugDTFkMntPcBWOjkziQ43uXYK0xVtXl9FHgKRhd4P4DXQcA6exc7ugkambRmH
	fbdOu8i9rsmqae+DPXij1rW3++3pmIDQCqlmPtmGUAOWjpNzwq+IU9hGuoRAQW4fFVEsOOQKR3Cmw
	5ogKzJ6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZk6e-00000005wHK-3BuZ;
	Thu, 10 Jul 2025 05:46:04 +0000
Date: Thu, 10 Jul 2025 06:46:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] gpib: use file_inode()
Message-ID: <20250710054604.GV1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index a193d64db033..38c6abc2ffd2 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -610,7 +610,7 @@ int ibclose(struct inode *inode, struct file *filep)
 
 long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
-	unsigned int minor = iminor(filep->f_path.dentry->d_inode);
+	unsigned int minor = iminor(file_inode(filep));
 	struct gpib_board *board;
 	struct gpib_file_private *file_priv = filep->private_data;
 	long retval = -ENOTTY;

