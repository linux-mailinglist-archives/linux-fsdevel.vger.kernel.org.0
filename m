Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEA1F5842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgFJPtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:49:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35550 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgFJPtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id h185so1278318pfg.2;
        Wed, 10 Jun 2020 08:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9spO8sCjIOMs0wQgccVfIprXE/wzCnPTAA23dgMAdc=;
        b=h98127/o82LX2PUy40wev+U3cj7HdHMYnU8Jv3cGah9MgwOFtgQigPyLhjMQxgfwjQ
         HILdmy+dMuwrtcvtNidCN/lgmknQnGDL/NUdUALy8r++cKG6mJzKMkSdT7cM0l6Z1id0
         QPdRlj9Yg2dS31GiVMPRfaHXY2FWVWVlCIUvoMy5FNBaKrWIh/8LYQuoKXpGDShNN00T
         lEhLAYrIOUbTplmkKywLarwm/qP0cQt8qlii3VFS6G+b/nOCBrIJW6M++qm7twFAdMS2
         lwIQOn6ijjVUt6TElXVE9AIu2OlUWSEPrChLGkZdlPkXweZ4ils+eqGHVkWy23Ip9mBi
         4HtA==
X-Gm-Message-State: AOAM5301rp10LPb2cpiCWEvjK2wL9S0WhXoqKSDp5jfLsTsfRaZ22AWD
        tX8EVJVdgthfNsGLjpD3zmo=
X-Google-Smtp-Source: ABdhPJyu1eX5pyEODFKXM1tUOb06KZbLUOW+sULR/svGLkAhoxImKT7+pXfTo+K5VKZEdMa5hV0cwg==
X-Received: by 2002:a62:aa0a:: with SMTP id e10mr3428008pff.91.1591804170947;
        Wed, 10 Jun 2020 08:49:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c12sm242070pgm.73.2020.06.10.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:49:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2C139403AB; Wed, 10 Jun 2020 15:49:25 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com
Cc:     slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/5] kmod/umh: a few fixes
Date:   Wed, 10 Jun 2020 15:49:18 +0000
Message-Id: <20200610154923.27510-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Tiezhu Yang had sent out a patch set with a slew of kmod selftest
fixes, and one patch which modified kmod to return 254 when a module
was not found. This opened up pandora's box about why that was being
used for and low and behold its because when UMH_WAIT_PROC is used
we call a kernel_wait4() call but have never unwrapped the error code.
The commit log for that fix details the rationale for the approach
taken. I'd appreciate some review on that, in particular nfs folks
as it seems a case was never really hit before.

This goes boot tested, selftested with kmod, and 0-day gives its
build blessings.

Luis Chamberlain (2):
  umh: fix processed error when UMH_WAIT_PROC is used
  selftests: simplify kmod failure value

Tiezhu Yang (3):
  selftests: kmod: Use variable NAME in kmod_test_0001()
  kmod: Remove redundant "be an" in the comment
  test_kmod: Avoid potential double free in trigger_config_run_type()

 drivers/block/drbd/drbd_nl.c         | 20 +++++------
 fs/nfsd/nfs4recover.c                |  2 +-
 include/linux/sched/task.h           | 13 ++++++++
 kernel/kmod.c                        |  5 ++-
 kernel/umh.c                         |  4 +--
 lib/test_kmod.c                      |  2 +-
 net/bridge/br_stp_if.c               | 10 ++----
 security/keys/request_key.c          |  2 +-
 tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----
 9 files changed, 71 insertions(+), 37 deletions(-)

-- 
2.26.2

