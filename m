Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE22B9E53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 00:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgKSX14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 18:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgKSX1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:27:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94BC0613D4;
        Thu, 19 Nov 2020 15:27:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cf17so4082243edb.2;
        Thu, 19 Nov 2020 15:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hj6U2aqGAiaI2X5w6M5RELHnxU1dby3I3F3VGsbvfn0=;
        b=YFLwQAGTE0YpnLDSLCme7/+JVeZ7mWbhq9+csV8NsKd+ryYUi5Hx01YOWp+oPJ1El/
         +xxyeMi5FgXjF57YEVnInu/cqd2Vn0fkKXtH8JqRJnivSnrdbhY54Qbb7cub16oP/Ksz
         qevMWC0cZBdbSSyQsjevL1kvW8bctwx8v+WJyosuZ//JCPvbHWoSeMShntMl6EE0sLye
         gpk9+dDQRjTPelPC6rnP5vH4vtvL1FEibTIyDbAEFMr+GwT9JsBVXhPPWQLY3R6dMpG/
         7KWVGNZFG7jaxWDiAudkX9hUcjvUDPdlBRlcXydwySvhzvaPbWBLv3aQfKgx1nEYofj3
         E8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hj6U2aqGAiaI2X5w6M5RELHnxU1dby3I3F3VGsbvfn0=;
        b=GsMZa6wVBRT0n5391/oNhdheqA743PvCJiUOeOeuWJ5xHh+vwRRp3EJMp9aUflP1Br
         li/o+io3aXarCigGMf/IfSijrpLj7ijh5PFOxkbDJ4Lrq7yRCvlrQWUcvEq0IgXInLlQ
         ZAI26S+oDPZXW9sMxfqZ/ktxSKv2vJH2sdSvlhc4n5E4yzFhkTrs7Pb4vVl41HhC9R8H
         zAJ2ddjfD8Op1tNs4yO2ZdlpcBRRv2NhohQVYHaIt2W0r97lxW9cFI102JGj6Bh/mqjb
         U09JqR/SnmmLIytnMGrRsSsJChfLV/nsVRjO5aTD/wXeRZWXHIIhuaMftIIYe4S8zUnj
         W1lw==
X-Gm-Message-State: AOAM531UiwZhKczQbmJ+pAt2Pm35Cxn1mzhtPtlBYJTAX1Cp7gqZiKb8
        uLDwFG3fg7hcyJgue2744u4jVavA3t31yA==
X-Google-Smtp-Source: ABdhPJy4D6cf8mozz2d2ydDUDACHAh8kZkwGzJLcpUD9Dqsv7d200oKbilZ2sCLSm0pjDN/FhwhDRg==
X-Received: by 2002:a05:6402:1acb:: with SMTP id ba11mr32018948edb.48.1605828473982;
        Thu, 19 Nov 2020 15:27:53 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id n3sm458114ejl.33.2020.11.19.15.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:27:53 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] optimise iov_iter
Date:   Thu, 19 Nov 2020 23:24:37 +0000
Message-Id: <cover.1605827965.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch optimises iov_iter_npages() for the bvec case, and the
second helps code generation to kill unreachable code.

v2: same code, stylistic message changes
    + Reviewed-by

Pavel Begunkov (2):
  iov_iter: optimise iov_iter_npages for bvec
  iov_iter: optimise iter type checking

 include/linux/uio.h | 10 +++++-----
 lib/iov_iter.c      | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.24.0

