Return-Path: <linux-fsdevel+bounces-35847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DA39D8E3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA0B22D54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550791C9DD8;
	Mon, 25 Nov 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhWwfw4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0D14F9CF;
	Mon, 25 Nov 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732571431; cv=none; b=TZ9k9J3BsOrIRKf7TboLzRb583c07ZLYXv5e3SC5sKxxHIK3MoBe7qtDCGTIY6vDaOQB7SUVehQsegQ2VmnTdwofVvADYkg+Ug55UWjsScJjqpOWH/quyx5F6pYf3v6O1GT3qj8QGUJ7Q11Plv1P38KIeIubCv7xrPLK7PMMXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732571431; c=relaxed/simple;
	bh=Ho81cwI8Sw/bUh83arJ5JE5Z1llPVi4xgJbEuPe6ju0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1q8/PMypWImzy0Y+LhcjVyzJ6QcSGcKOhwqdy2JCf0XoCzoALYcf1V/we/UIddg0NKnoWpjlygqY8Cs97+AYNuQMQWOTfCYvw5SWuSnYV6d4VtqJSOWC7g28crrd+x2lBf3gVcMGHOtCmPD76XxNYjUnPlLqzreS3kYAfqrjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DhWwfw4d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PpZ+jkkcRHZq4GTxws+FtRb213eyx+uTZB3qAleBC50=; b=DhWwfw4dDuH6OERREKFR5Vt12Z
	DY7CVXMxbdn99GEQ3sTapVYkVqkvCHc3bzSHMal10rN643MTGDlUHN58X68HFE1dGY4U/YiDzAsX6
	1mDZm0LgV4w0jRMsxVjR/byo3+P8v+GUE4evwBtdy+i5F4p2G04VriGqMttEAGkr8zCfClsg4/r4M
	BzqQjDz2IVDHiIrd47Y5WmpmGeCnpmfsJPAuSpaRNOOoXdJOP9ZwzY4Vot2rm9P39Nfug05u9RQRA
	Q+wfI4DSE2s0kRRFHdSOtMrj8m3UeBZbRtBpQbMDpOBWE1WEulHGNUseZCDrdj5ifrGR5qQjI9b+J
	3ZKSm3hQ==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFgyN-000000099yI-1uQP;
	Mon, 25 Nov 2024 21:50:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] fs_parser: update mount_api doc to match function signature
Date: Mon, 25 Nov 2024 13:50:21 -0800
Message-ID: <20241125215021.231758-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing 'name' parameter to the mount_api documentation for
fs_validate_description().

Fixes: 96cafb9ccb15 ("fs_parser: remove fs_parameter_description name field")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/mount_api.rst |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20241122.orig/Documentation/filesystems/mount_api.rst
+++ linux-next-20241122/Documentation/filesystems/mount_api.rst
@@ -770,7 +770,8 @@ process the parameters it is given.
 
    * ::
 
-       bool fs_validate_description(const struct fs_parameter_description *desc);
+       bool fs_validate_description(const char *name,
+                                    const struct fs_parameter_description *desc);
 
      This performs some validation checks on a parameter description.  It
      returns true if the description is good and false if it is not.  It will

