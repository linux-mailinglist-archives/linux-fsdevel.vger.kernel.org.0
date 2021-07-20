Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A143CF700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGTI5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhGTI5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626773872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4D2NuOdEFzSecXucr6t1df5IFRevzpAexYM41MlgGtE=;
        b=X39u6bveDUD8MwA/QqOSHNICMjyATVEZEJR5KqukNenKtkikMiqn8B5WExxDc2z7GPrZ1D
        3pfipNjr6UqCWiQG1t/y4m3KitCD7ZkGNKS5zmp/6RwRleZOuYkXpiQf9NZZxzAXZhrunl
        f5P14EuitPyvSoiFuw/wuAXWzKDHKhc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-52A7BYlzOgaMV9yHbO7GBg-1; Tue, 20 Jul 2021 05:37:51 -0400
X-MC-Unique: 52A7BYlzOgaMV9yHbO7GBg-1
Received: by mail-ed1-f70.google.com with SMTP id n6-20020a05640205c6b02903a65bbc4aebso10545594edx.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 02:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4D2NuOdEFzSecXucr6t1df5IFRevzpAexYM41MlgGtE=;
        b=OKdv/8o+VaMQYL0NjQFJZNBH6gVICEqpwvDXAz7/ajk/SIl0lQ7WWCLiQScAyod5ER
         1uq+aj2prdpHTQLouiUdid1CjDAYyeymIzlgUuSaOLJFedq7ng/XBQYTCfF7Ajrbb90s
         UVSnLLE91kObfNPav1SZtq5fmqEciJN8eSrWlwMhr4sEm+S+8wrQX4HdvWs7xek9pDQ2
         50i26q6EfNkLXVCAp0m9vYQgdGzSkzxMFxEo0Bc+lgBvQVxFugTAi9jFZBuw8ob6K/2D
         8N4KhHKFEfl0ksYstL1SGHZ2wXnC1wXqKIknYBgoNrximAnR7rV2iSXm1Vu1rko3JxI+
         T7/Q==
X-Gm-Message-State: AOAM5328gbYCVLhXW+tCPVJPAIF15wn+PrFCUdXpBymiS6wsnPdQMaUr
        CmGYC/1bctbCkxS7JMr7reNt6lxPBJmmwtsNc1XphYwqf+NsRDRmcyz2gViyOMODYhKuxeh1sPM
        sOpzmgXqLWn/Pn50VgfSeZg+WPuQLKnwXvC9msr8x/rx6Mkieo2JYsYX43j+RzZhRKg5E7J1r2R
        o/
X-Received: by 2002:a17:906:1997:: with SMTP id g23mr31257611ejd.304.1626773869639;
        Tue, 20 Jul 2021 02:37:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8qrMe7tsPFUg7wZdt8UK0EDiNCQz7rYGwWbtFj4If/qGNQFXwBLTtgYxPeW9IIOdZSnQt9A==
X-Received: by 2002:a17:906:1997:: with SMTP id g23mr31257598ejd.304.1626773869420;
        Tue, 20 Jul 2021 02:37:49 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id d18sm6888195ejr.50.2021.07.20.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:37:48 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     cem@redhat.com
Subject: [PATCH 0/1] exfat: Add fiemap support
Date:   Tue, 20 Jul 2021 11:37:47 +0200
Message-Id: <20210720093748.180714-1-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simple patch adds support for fiemap to exfat.

Pavel Reichl (1):
  exfat: Add fiemap support

 fs/exfat/exfat_fs.h | 3 +++
 fs/exfat/file.c     | 1 +
 fs/exfat/inode.c    | 8 ++++++++
 3 files changed, 12 insertions(+)

-- 
2.31.1

