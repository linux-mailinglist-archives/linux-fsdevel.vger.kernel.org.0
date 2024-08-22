Return-Path: <linux-fsdevel+bounces-26841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E795C098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245C61F23178
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3461D1F51;
	Thu, 22 Aug 2024 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWPAzyBz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C81D173E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364429; cv=none; b=QOoZipYVxK/D22pwYKsUsauOloV8qTMRN5anTG57eQwuffdY4qo+xS2trj4a+aVopUZSAUg++2xBChTpdtSMEkiZIOFazbwBmp/zpJRJZdKDntgM3WAvq24qIufSoSc29s7/CVYH0AcaEGW2C0xE5YKxuRA1eZEdQxh9qIePhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364429; c=relaxed/simple;
	bh=+0x8ptk6GZdmaYlM4GZuzBtebAeg0Fj/q0AjPybMKm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFAxOu5ZomIws+90zYG6EWgXfgElYM43Wh2yUyumlUi30EIGmL3kUGieczIz9Cc8PWNgn0rWoQcTuGYbDCUMbhtJnkRuWhJcW216KNOxhsnTY7YvNxNEJOxpMLcnAaMqlml52YArPcJxoNKgwLAJpLJYDBUGCCjL1CeMdYRgIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWPAzyBz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724364426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kxWA4xqBbcQ0SKYTS5195o7goMEsBuv2jCniBGikgOg=;
	b=GWPAzyBzc4C9UinSGfDX9E5FsyZWX1t7y6b3/Fo7GOyryueSKWvgJIBXYXdJHFjFJTTH99
	RmE83qjrE7jbE9laVj5gYYtPbVnaOb2TBDyrmSAhhdxU8kOx97MezHu39hZLP0Chrkz5Ps
	btEpfF3xVQQlXwneN7K6LIDnN0o1VKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-VBKT_YO7Mp2TNuZc4LfykA-1; Thu,
 22 Aug 2024 18:07:01 -0400
X-MC-Unique: VBKT_YO7Mp2TNuZc4LfykA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAE351955F45;
	Thu, 22 Aug 2024 22:06:58 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95CA019560A3;
	Thu, 22 Aug 2024 22:06:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] netfs, cifs: DIO read and read-retry fixes
Date: Thu, 22 Aug 2024 23:06:47 +0100
Message-ID: <20240822220650.318774-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Christian, Steve,

Here are a couple of fixes to DIO read handling and the retrying of reads,
particularly in relation to cifs.

 (1) Fix the missing credit renegotiation in cifs on the retrying of reads.
     The credits we had ended with the original read (or the last retry)
     and to perform a new read we need more credits otherwise the server
     can reject our read with EINVAL.

 (2) Fix the handling of short DIO reads to avoid ENODATA when the read
     retry tries to access a portion of the file after the EOF.

These were both accessible by simply trying to do a DIO read of a remote
file where the read was larger than the file.

Note that (2) might also apply to other netfslib-using filesystems.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (2):
  cifs: Fix lack of credit renegotiation on read retry
  netfs, cifs: Fix handling of short DIO read

 fs/netfs/io.c            | 19 ++++++++++++------
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 28 ++++++++++++++++++++++----
 fs/smb/client/smb2pdu.c  | 43 +++++++++++++++++++++++++++++-----------
 include/linux/netfs.h    |  1 +
 5 files changed, 70 insertions(+), 22 deletions(-)


