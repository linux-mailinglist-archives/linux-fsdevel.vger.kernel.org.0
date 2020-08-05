Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1023D014
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgHET3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:29:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728562AbgHERKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uSDwrcCetgi4o90pPq2a185JxUqvTMJB/oDG7IEBOg=;
        b=ckbDlnzHVb8+0VTyn4dEN5UPG1k56gdg/kIcBEu04AWf+fPAPeeyrx2cKCjR6kbhUYcr3g
        +5zocUljjKDGsIrzHSS8N/Ymw+ig/xxr+Y3yfgqlyfnrk39A7f7Ys9xN4yW7bC8BxbIeZ0
        afaWkP/ZBvJKeKhXlQZNX9Pa/CwLvBk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-x0zjmcJmP1CaaEo4RxYN2Q-1; Wed, 05 Aug 2020 09:43:43 -0400
X-MC-Unique: x0zjmcJmP1CaaEo4RxYN2Q-1
Received: by mail-wr1-f71.google.com with SMTP id b13so10874719wrq.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uSDwrcCetgi4o90pPq2a185JxUqvTMJB/oDG7IEBOg=;
        b=elPaSVbMcqvZ6OUYrWT4MRGn9j2YoAT2kPwnI4c/pge2/CqRBJyRZFfaynDoDRZ+5m
         gJhIJmPOnxvDmyer5p2C07VOijkmKdjUqAyZedvtgcfap1KjMo50pnschxYDpYTDWvy8
         7JvA6ZOxf4hkY3XfwAkJ419f89falGAJmbCenm4Nt0nUVLCzsHztuN3wKp2dPqx4I9W0
         uYArZon9LPxLOmCGA0mdGER9dJMA64KcFxJNrZbqPOi0cxVY8Nys9PAgYuOWFmYkmIgw
         ramMMfQHnTfxVevq/jsGvxNNuIeftMs2ux3KxTebDt41nw7J/1W4XpQ5bDE7xxJpNXoH
         e89A==
X-Gm-Message-State: AOAM531COAdoqRdv735IdxIeOOplIiGPbnfD5B5jHuYo+AjAkpFFOyEx
        9BdpHGEGPQm+BwFWR0wQOGAosownTGHAvxW3ZaF7wuOd3W87lrHxW0B8KSKCgN08hMBQwXMUBSl
        Ruow8r+gp0yq5k2wvi/Q/M3ygZA==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr2990188wrn.2.1596635022299;
        Wed, 05 Aug 2020 06:43:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcyZAwzw/sc3TIrW5clO3yeQkU/17FbRDELsyAj0Cdv9z6ug93Lv7U5iCEnIGFjwxAFgiVMg==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr2990172wrn.2.1596635022086;
        Wed, 05 Aug 2020 06:43:42 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id y203sm2957420wmc.29.2020.08.05.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:41 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/38] virtio_fs: correct tags for config space fields
Message-ID: <20200805134226.1106164-10-mst@redhat.com>
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

Since fs is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index b02eb2ac3d99..3056b6e9f8ce 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -13,7 +13,7 @@ struct virtio_fs_config {
 	__u8 tag[36];
 
 	/* Number of request queues */
-	__u32 num_request_queues;
+	__le32 num_request_queues;
 } __attribute__((packed));
 
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
MST

