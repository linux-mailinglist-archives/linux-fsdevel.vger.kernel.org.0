Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989147987D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbjIHN3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjIHN3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:29:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461A1BF5
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 06:29:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so1984119f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694179746; x=1694784546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJOaV6rVOAx8Ozdr0JwuLpbAei25nZNEqenU0HisAnY=;
        b=V7Ilklv4XFOqZBKdKqjPFYF2PPHz4H+RcEe9VBPub8KL0JNQ+1LFyBwZTVOdDLLgIQ
         O+ElYINpw5hXuy9oAZcQ7PYwPZAYrWDVZk9mjVNInF1B+S4+JTk04MD9fFli/31GJoj3
         ZyO1KnsA4Sl8D6N5kMFl06BK15Icvysd+4zRB2egvvXKhykqrsqoNHlkZgODPHOGuLs9
         EM/k28NYOJGkofRAxtjN+G14/qzghW8t38aEMmBF53h9lg/zzZNTQJabMN5vBzAARSyS
         L4LwFrYjKolTIZCIa1sYL/bp3G3kpLGCMHZOmS9fB5QnrCRV9H5wTwuMyJwm8NAC5QnW
         r6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179746; x=1694784546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJOaV6rVOAx8Ozdr0JwuLpbAei25nZNEqenU0HisAnY=;
        b=DnFI7dJcx5NY8AmLoHxz+JBe1wClefxltg3XAQqAVq1e26ybVJ3SKYihBgvaREfXW3
         2tw7FpnrQwrrqWJF6N0U4UVOwKWpayLSQvG5TP8lPFdnWjyMxrsoksfhLkuw0BSlVN1U
         kxsanXiICaNhqAzVsn8Robik5/QqMwygmIqCzmpzM/23dtB4i1jTSXchiIJ78hAD1MTv
         WNBCDM2b6zbnRJw2TIgmJ1wcf71GPFP2RIuvjFDVp0M8l5jRWeWq/6BwC5Qig4luOPaQ
         WaINrpYg+1efuhWDAA/NTNkFAPj7JfpUqEJN6kjQvnU3l3BwlBq4ga6Ln/2I2gL1X7rc
         t8ng==
X-Gm-Message-State: AOJu0YzHhtAGDI0ELEl1QYIQvBIcOgYGddZdDRSKpDBt8Kbfc7V7XRFO
        NxDPNcKoOZcJ80UdSadkUq8=
X-Google-Smtp-Source: AGHT+IHaZUg/l8Skg/DVhgxFIApBF6nGY8fQIDTKuh1B0rnwcYKCwYOo73EooWyxo0TDEErSIpJEyQ==
X-Received: by 2002:adf:f010:0:b0:31a:d6cf:7709 with SMTP id j16-20020adff010000000b0031ad6cf7709mr1845037wro.22.1694179746313;
        Fri, 08 Sep 2023 06:29:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c249200b003fe1a96845bsm5248747wms.2.2023.09.08.06.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:29:05 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Rename and export some vfs helpers
Date:   Fri,  8 Sep 2023 16:28:58 +0300
Message-Id: <20230908132900.2983519-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian,

This is the rename that you proposed, for the helpers needed by
overlayfs.

I could stage this in the overlayfs tree for 6.7, but it has a bit
of conflict potential, so maybe best if you stage this in vfs tree.

Perhaps on a topic branch that is expected to be a little more steady
than 'vfs.misc', so that I can base overlayfs-next on it?

Thanks,
Amir.


Amir Goldstein (2):
  fs: rename __mnt_{want,drop}_write*() helpers
  fs: export mnt_{get,put}_write_access() to modules

 fs/inode.c            |  8 ++++----
 fs/internal.h         | 12 ++++++------
 fs/namespace.c        | 36 +++++++++++++++++++-----------------
 fs/open.c             |  2 +-
 include/linux/mount.h |  4 ++--
 kernel/acct.c         |  4 ++--
 6 files changed, 34 insertions(+), 32 deletions(-)

-- 
2.34.1

