Return-Path: <linux-fsdevel+bounces-3820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E09EB7F8E79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 21:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E243B2107B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF030653;
	Sat, 25 Nov 2023 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aRn1Xupi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D87E1;
	Sat, 25 Nov 2023 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oif89apAGYgGnDl0vJMd7EqSUxKrNFIEx0+6HyACgJ8=; b=aRn1XupieKieAwUmxQOvJGQjKt
	t1hEjUhurIhjMcjA1qqBfMFvJOOENq58MfXV8eD+910i3kEz1M8et6gutiSMdySwzMg49yOrPa5cX
	8pAYwlTuOv4VicS1DwmGZ6PeoQRnh/D3sHmfmL0n4NV4pDkEN7ra7EFsI+yYgtwaWKVzCN355h9++
	Qwv+Nz+YtHl6Iwn+3AzrXKUJmcaQFDTu0pisiSWfBH9io43h931RUMsYVZVgeMoePc2vC21eOeXlI
	EKspJ+HV+t3YHaXBhr0zKmRo+mUS7sjMmTBWvLw50luyiPov4Q5XzrtwQpCmpBNbdx7avhmTrbDZR
	xNeeveBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6yyl-003A29-2N;
	Sat, 25 Nov 2023 20:10:15 +0000
Date: Sat, 25 Nov 2023 20:10:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCHES v2][CFT] rename deadlock fixes
Message-ID: <20231125201015.GA38156@ZenIV>
References: <20231122193028.GE38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122193028.GE38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Updated variant forced-pushed into #work.rename; changes since v1:
	* rebased on top of #merged-selinux, to avoid a bisection hazard;
selinuxfs used to abuse lock_rename() badly enough to trigger the checks
in the last commit.  Fixed in #merged-selinux (which consists of a commit
already in selinux git tree), and rebase on top of that does not require
any changes in the series.
	* (hopefully) fixed the markup in directory-locking.rst.  I would
really appreciate if somebody familiar with reST took a look at that.
	* fixed another part of directory-locking.rst, not touched in v1 -
the proof that operations will not introduce loops if none had been present
should've been updated when RENAME_EXCHANGE got introduced; it hadn't been.
Rewritten.

Same branch, same overall description, individual patches in followups.

