Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729AD23D01C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgHET3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:29:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728144AbgHERLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWci/+5/mBvE1F6mvnsX+8niF7C1kxp9FouMHNJqkcQ=;
        b=C/P1apBNT/jE4tOqyqX76DgexJ9pXdPDyHbr3zPcVGdhfKxhshlhkz1R89HirnOIXfTtyh
        IvId8gGijFkhXF8URRBZiKv2N8Qp6Dyh9FSkebqPzkdBhB0rDlV+lHRRfE8JrejOOdC0cG
        CSFt2TEhcw2yufN4bmK+f6TXjLBpLfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-lSIuujD0MOmtbhrI7xr45A-1; Wed, 05 Aug 2020 09:44:43 -0400
X-MC-Unique: lSIuujD0MOmtbhrI7xr45A-1
Received: by mail-wm1-f71.google.com with SMTP id q15so2738981wmj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWci/+5/mBvE1F6mvnsX+8niF7C1kxp9FouMHNJqkcQ=;
        b=Z4Ae2wJPZMaBcDAF8hTeCXtNI1EI3XIJ/uhVYAqxOrzwV4OBzoYdx3nuojcT/vPafY
         x6fIKRjtxDrPcgiZexN3VeYKXSVeBWzZXuTvDkOyaurQlutJurNLwn7VZzdynjJpDtQD
         U9XP5jro0goUTMkltVzp1OnBbNFr0+YtcV0gO0SPJFzXjAWT52k7+LKun6R5tCdF+sjH
         N12mlatWLm0i4zyGiukt3PxjMVCSdXLwWxXFG7TGh7MWtTu2vILuaIRDVflR3YqO06aF
         ojKSUd4S6yp5wHK1k4o79m4AiOX0ANJnMhOcN/1m9/HS/FeTg52Zn9sZ91cqKpqBGAI7
         g3Gg==
X-Gm-Message-State: AOAM5309cpL1l/9ya8hPPGvMSlx7c2+g1ly6g+fIh9R+nMxG5LMgKQf4
        Xemoxb/Bcx461VpGbgGIC2uLPwspWeZv0PofNCAA94foSu7Pit3z3ma836hdHFlz+c3Kw3Uzxy8
        6627nSwwEQV+A9dD3ZZLRowwkWg==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr2648509wrx.33.1596635082515;
        Wed, 05 Aug 2020 06:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh/KIN/KZmvjqAkTq6wQd3jfmeRt/1lbO1zvA9EzKkakixioTV1omDTRNwjFLeWiuqYQR30A==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr2648497wrx.33.1596635082345;
        Wed, 05 Aug 2020 06:44:42 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id j5sm2967022wmb.15.2020.08.05.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:41 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 31/38] virtio_fs: convert to LE accessors
Message-ID: <20200805134226.1106164-32-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Virtio fs is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4c4ef5d69298..104f35de5270 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -606,8 +606,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	unsigned int i;
 	int ret = 0;
 
-	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
-		     &fs->num_request_queues);
+	virtio_cread_le(vdev, struct virtio_fs_config, num_request_queues,
+			&fs->num_request_queues);
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-- 
MST

