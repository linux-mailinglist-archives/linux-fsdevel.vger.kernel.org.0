Return-Path: <linux-fsdevel+bounces-5769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489280FBDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8494BB20FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105965C;
	Wed, 13 Dec 2023 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WSxI4cRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F711D;
	Tue, 12 Dec 2023 16:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FXY889v1wCRjtooR2/EYQR2p4xIuOC6TaQ69pJbqVUc=; b=WSxI4cRALwEpA7/P5n/LMCrkOA
	wVDhRoN3mgpRMLOSV7aLMX92N/SKUp/7FZIR0RLay7LuwHRUsdZ4RhjypiW4rQuAxNVmJCGxVAkNW
	xFhOWjDpM43gbgqlvZBM8mituZTNlH4qs0fwuBTaPwKlIF4VzzvRYIDTsAGo2Pnmanfu2Chlglog5
	ivcdAzRQRs8PRfdcqXm0yqIIMnPZEnefxPUjl32mL59AMs+PmhXNDN7fbGwWbjh5Fauc7tsJLXP1h
	+qpWpZsiN2aCqKN6nmY0ol3OW5M/l5n0goqkUz09/AIBAgvAX3lDvAA+CcfyYTHQf0PABGkI6OrpY
	4gwXAJBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCm9-00BWxH-02;
	Wed, 13 Dec 2023 00:06:57 +0000
Date: Wed, 13 Dec 2023 00:06:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [minixfs] conversion to kmap_local_page()
Message-ID: <20231213000656.GI1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Sat around since March; rebased to 6.7-rc1, the only
change is put_and_unmap_page() renamed to unmap_and_put_page() ;-)
That's a minixfs counterpart of ext2 and sysv patchsets.

	Lives in vfs.git #work.minix, individual patches in
followups.

Shortlog:
Al Viro (4):
      minixfs: use offset_in_page()
      minixfs: change the signature of dir_get_page()
      minixfs: Use dir_put_page() in minix_unlink() and minix_rename()
      minixfs: switch to kmap_local_page()

Diffstat:
 fs/minix/dir.c   | 83 +++++++++++++++++++++++---------------------------------
 fs/minix/namei.c | 12 +++-----
 2 files changed, 38 insertions(+), 57 deletions(-)

