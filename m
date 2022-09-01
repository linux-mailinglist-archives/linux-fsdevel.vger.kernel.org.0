Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155C55A9B98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiIAP1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 11:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiIAP0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEAA74E15
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=F/GvseEq137pZJHZQ7hgUdLt9b3DLURYAa2xAVuvTr+40eODQKQW/W561A+1rPp+5BRpS6
        oFcAV/81cdxm8ENb6Bum0HtIK2QplkeiUsFZUfDPXPwMFLHadw17U2ymGLtPsoCDXCxpbi
        mvxfcFLd3bSosAhZF+HhbH/XXYAI/e0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-Gk4w2atkNh2GQK7_DyDZ4g-1; Thu, 01 Sep 2022 11:26:35 -0400
X-MC-Unique: Gk4w2atkNh2GQK7_DyDZ4g-1
Received: by mail-ed1-f71.google.com with SMTP id x21-20020a05640226d500b0044856301c62so8903243edd.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=eI+oyqSREhdRN0Vfd9ehX5AlCGCTk4ziPLifTfIebXwVVWo5ATp7R/Jw6Rrcdjgo6w
         9GLKgKDqURGFQsVl8HhkBDqmvKmV2JQCuaOncS/ICMJACfE7ZTaycu0/Ui3jgFTNNDY3
         aGFfkU7CxLq9cKKqGnxSAXXr9yi9rVcunuAOB6VzFpByOrTGjjjGT23FfOgnbmia53Z/
         WWLnJqg8rPw5tfnUAf4x5iDU2ZOY3iuGVS5N87+GCdg2Nj34A+UJkOsEgqGnn8wSW4O1
         /fDB1Im2EPkeWz7vQIcuPmNnCbk1BwuzM5xT72qw8BfI25ySYnFnstBvSK+nhHhi32nr
         sA8Q==
X-Gm-Message-State: ACgBeo0ivXDq04uT6vqhcdLJyRR3UMXhRa3RDDRgm85LGH5aVCknoDMy
        F28ZhxBbqCL1Tu8Fie4v+f6IO31BgW0FVF9cf8vzNhLD4Gw4TVeZOL5Tc00XZ6zpAREQDLPJkG5
        5VZ9R4U9RBOJFyFaeD5Vl155qLw==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273245ejk.463.1662045994400;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QRSL2W4ltgrQ+2jhvMhXxgK8EO5Y0yo9Y0cYkz7dkRoZMMOmRYstqqGCjd+xE8U5lttpmRQ==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273233ejk.463.1662045994222;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Date:   Thu,  1 Sep 2022 17:26:30 +0200
Message-Id: <20220901152632.970018-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal of these patches is to avoid calling capable() unconditionally
in simple_xattr_list(), which causes issues under SELinux (see
explanation in the second patch).

The first patch tries to make this change safer by converting
simple_xattrs to use the RCU mechanism, so that capable() is not called
while the xattrs->lock is held. I didn't find evidence that this is an
issue in the current code, but it can't hurt to make that change
either way (and it was quite straightforward).

Ondrej Mosnacek (2):
  fs: convert simple_xattrs to RCU list
  fs: don't call capable() prematurely in simple_xattr_list()

 fs/xattr.c            | 39 +++++++++++++++++++++++----------------
 include/linux/xattr.h |  1 +
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.37.2

