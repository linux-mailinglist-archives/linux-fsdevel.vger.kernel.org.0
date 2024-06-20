Return-Path: <linux-fsdevel+bounces-22014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB58910F01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C91C237E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433681BE866;
	Thu, 20 Jun 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cr2wmYJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D31BE85B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904771; cv=none; b=qqbO+wgD9ggNhEdo3prbGuNYR7Go+fQjeu5lL9ZCnNrBwFFRX1WGwF0Cb0NccQ1WymVqhb16WefKxd/c7SmvOuPVQACfyaG4CXIDECBLsdM70lm3uRDPwXk0Cy8k7TX/NP5oQj/lkYa+jXqc/Wkko60PX5Ad2GSF/VLusXlr7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904771; c=relaxed/simple;
	bh=++FZtOyTYIJI/XEHDGIcpQZYCcY6q8jpP5Q3welVLhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyHIwcDXrI05xOUr0oySyTvMHxOoCFuxhT3xdxXiKymTmTdE/Y7JbHV0ybTYjYoLnG3BMu+Hf5oKFWgQP9xGaEzvMtr4IyZipPLIymcOTnYH0WXjXFajKH44opMvPakN7LFqAG1HNPiD2kK9fEQNP5KH+cMTMhowOX+CQXKzSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cr2wmYJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+6UwHgWPCU3as5VcBuF/bmsEb6ZpHwJQoR4UTelMjE=;
	b=Cr2wmYJf5seh5LCrRXw+0JLkEpwuzuHlJBqw5TvkUp19niMlyI3VAVuxvu17/tHlfpqWTj
	9N4C4sOU02AebNWtoC7mpmLkRhLsNeH7oubP5NKcXYLWwnMoK0flkJplXhOI3OW0KXu4Rd
	D+BpS9c9x98iaUz9aifBFfeNVI6Flw0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-6nmBBFraPjiFkZ70vE544A-1; Thu,
 20 Jun 2024 13:32:45 -0400
X-MC-Unique: 6nmBBFraPjiFkZ70vE544A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7B2E19560A0;
	Thu, 20 Jun 2024 17:32:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0BA41956052;
	Thu, 20 Jun 2024 17:32:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 06/17] 9p: Enable multipage folios
Date: Thu, 20 Jun 2024 18:31:24 +0100
Message-ID: <20240620173137.610345-7-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Enable support for multipage folios on the 9P filesystem.  This is all
handled through netfslib and is already enabled on AFS and CIFS also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: v9fs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index fd72fc38c8f5..effb3aa1f3ed 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -295,6 +295,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			inode->i_op = &v9fs_file_inode_operations;
 			inode->i_fop = &v9fs_file_operations;
 		}
+		mapping_set_large_folios(inode->i_mapping);
 
 		break;
 	case S_IFLNK:


