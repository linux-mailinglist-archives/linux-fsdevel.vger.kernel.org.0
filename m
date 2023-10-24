Return-Path: <linux-fsdevel+bounces-972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA987D4746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67743281818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830110A29;
	Tue, 24 Oct 2023 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CORXTW5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0001FB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:18:56 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B8C0;
	Mon, 23 Oct 2023 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=X1BeEIUyP17Oc9/0An+VaavshAKOs04P4D2EreDhKvc=; b=CORXTW5x4gbqjM5cBxVaG0J30z
	3I20kBgT+earPcSSpcv9EBDHv4PCVBDJl1ORE3v/5qtO1bOqiyaoiiX+SW0JI6KwvE7IWacrucQSz
	Ujstk3J7ZB7jIUb/bt8g/0P5EqsbA+Tw63X/madTNBecf0c8bkAJ1Z75sZ/y/3bSqAr7cNnh29cnD
	R7ZX7VhM0D1yNobnGpGlUR3t1tKcAfLPhSOoLy0LrPMPGuWJIveGFDLdFl40VIfAjh7QIO9JXkwHJ
	gf5jm3srib3kfacHoFcrTttv6smsKSAxrdIJSQE4Qt7QahYnyRapUqResrQSSrsV6L8H2FFXZNoDO
	jQT/2V0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAkf-004nKI-25;
	Tue, 24 Oct 2023 06:18:53 +0000
Date: Tue, 24 Oct 2023 07:18:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [git pull] nfsd fix
Message-ID: <20231024061853.GG800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Catch from lock_rename() audit; nfsd_rename() checked that both directories
belonged to the same filesystem, but only after having done lock_rename().
Trivial fix, tested and acked by nfs folks.  Sat in -next for a while...

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsd-fix

for you to fetch changes up to 1aee9158bc978f91701c5992e395efbc6da2de3c:

  nfsd: lock_rename() needs both directories to live on the same fs (2023-10-17 00:24:35 -0400)

----------------------------------------------------------------
fix for lock_rename() misuse in nfsd

----------------------------------------------------------------
Al Viro (1):
      nfsd: lock_rename() needs both directories to live on the same fs

 fs/nfsd/vfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

