Return-Path: <linux-fsdevel+bounces-62326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B2B8D6DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC0189E27E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704702D3721;
	Sun, 21 Sep 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uletbFZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D13FB31;
	Sun, 21 Sep 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440220; cv=none; b=o2i0WkY7l98BNH+KigEoeQATR5K+qPOKQDks9o3Yz3c0k3uTEbZijliDlEzZGSAePgwnz1jAaBsO2p4gU8WRyJy+JyzpPzj+1ha2uCbsdyMXCsseNZ06AIm9UfpJbTcljWIl8cIhMOKKwdzjGPPpxN3AP/dSRuvE4phartavJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440220; c=relaxed/simple;
	bh=/E3C2COga/lhAJ68ZH59KbvFlrQtoaDi2hkv/5s4edA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XJ4sz8v1+n0q9McqhbWFPV1xj6C/QjIb6aUo4f1WUlL2iIZcAZsk2SyIJrRN5LM47N2s3uxDCZwmTkYUjHg5KKQmImFotE/U6/qN7qWX2l4I2bzNhCpbbETstxYKGwiPm/uEk2jb0uBA1fkegxz2kwP/wUa2IhvTgNa6OlKxBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uletbFZm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JN4VxLUlUvS8osIIS5RdIG8Kr7QcOQ9Mak7eMcJ0O/0=; b=uletbFZmxXzVLwOsIrw/aJAQ4V
	QcbG4+19/ScYoaqLqVkmM2hZFfB1KrgRMoz1OFp7D5ljdLwa6/pSrEr89eg81ZPEjyHSFBAj9QNbN
	WNtxgTAxOpR/c76fEIKc4zsCe6LM6QOTWZ0emcSkn+SmCJd2EAte6ESq5MO/owsQgaNOpJHp9JwZJ
	CYkZ1obm3KW15XMRJXUiu6ahb6pa9JK1cWWUrI7l+GMWEazj15GrijlmF6INw9cigzGR/6Zmq71b0
	K4vHQq101IbmEzEFHQJSJWSDUXe1laTpxeHfTzV3mcs82AaIoFL9m9AXca03AWSLD/Gg7jdA95A7j
	9dTU6BWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Ecx-0000000CbvI-1i02;
	Sun, 21 Sep 2025 07:36:55 +0000
Date: Sun, 21 Sep 2025 08:36:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: what's going on with aa_destroy_aafs() call in apparmor_init()?
Message-ID: <20250921073655.GM39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Correct me if I'm wrong, but as far as I can tell apparmor_init()
ends up being called from security_init(), which is called before the call
of vfs_caches_init(), not to mention fs_initcall stuff.

	If that's the case, what is this doing there?
error:
        aa_destroy_aafs();
	AA_ERROR("Error creating AppArmor securityfs\n");
	return error;

aa_create_aafs() is called via fs_initcall; moreover, it will bail out
if called before apparmor_initialized has become true, so...

While we are at it, what will happen if apparmor_init() succeeds, but
aa_create_fs() fails afterwards?

If nothing else, aa_null_path will be left {NULL, NULL}, which will
immediately oops dentry_open() in aa_inherit_files()...

