Return-Path: <linux-fsdevel+bounces-8635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41438839DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED93D28D0CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 01:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE271396;
	Wed, 24 Jan 2024 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GP56geRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDD1866;
	Wed, 24 Jan 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058867; cv=none; b=GComsHvfIIVW3nlJNqYTsWS4+UI/aU/4Jairj6c9U3vhrnu+AGkk42yA3Ax3nragcnzeN2oiDS9hsiha1LB5egTS+DJEYLWizKr6AgPA1KyQu0c8C41IyvjxWuZdoY4pg0tZDpLLa79r3B+d5SIcJdDcfJCRAaTjMJX9z7pk+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058867; c=relaxed/simple;
	bh=yKJVCYJO6LmBcJdeoH6hLuQIoDPeuwMJxL6h7ZsUMQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHSwN94AWGO4oHThiOQsUHRZ34zW+6pS9WwNo7V6eqI6GMcTNNsUQMxRlsBvOWDQOesvJQlXEcY1SAcXsQF5vHxRdFL5ZI1sD28uV8iC3b5Zt20SPEzwfyu/E/mDxUBe3fmt4pKcnvLkm4RUSoYTW6ejehY30SONlqZxuJJg4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GP56geRv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+XPiFTLPLUOZgR0hfpGzNmizWWKsQoXSd2FCd32Eaow=; b=GP56geRv6qlS+ZE4PnNIkyW54i
	fHOFqZs9BaUU0VN1iqchLKOBL7rNslDZYnf65Rdz2BUIDNMPVp0gKzZ0suorNgM+iLDDrzteB16av
	0jbzgT0BrKSCVnMQoHKCnVDtGk2ZP73+OrxspHTUM/SMNMWMinxnwR6R03TJsi9sd0Fe/2vM32k6x
	VrvEkTglgd4bsb69EX8w09EOPfClDv6nSmtiseW95G+6SjkUJA++BQZAmsG1MzsN912GtHtTm0zRv
	e4f1evO9schqkj2DJrHsVgzJtYAn278eDrbvm8g2EfasZF9gu2AsKVOTbdWcVP+WCvlAXhcyEM89w
	jV8WHnrg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSRqS-000zBs-34;
	Wed, 24 Jan 2024 01:14:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH -next] fs: remove NTFS classic from docum. index
Date: Tue, 23 Jan 2024 17:14:24 -0800
Message-ID: <20240124011424.731-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the remove of the NTFS classic filesystem, also remove its
documentation entry from the filesystems index to prevent a
kernel-doc warning:

Documentation/filesystems/index.rst:63: WARNING: toctree contains reference to nonexisting document 'filesystems/ntfs'

Fixes: 9c67092ed339 ("fs: Remove NTFS classic")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/index.rst |    1 -
 1 file changed, 1 deletion(-)

diff -- a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -98,7 +98,6 @@ Documentation for filesystem implementat
    isofs
    nilfs2
    nfs/index
-   ntfs
    ntfs3
    ocfs2
    ocfs2-online-filecheck

