Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400D41C9F5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 01:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgEGX5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbgEGX5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82C3C05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 16:57:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t12so3398794ile.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9gJYJ3n1PrzT+nVQdUcEY+WLY9HYwAvNWuv9VcAD6k=;
        b=iiPl+40u0RQVypHXIV4K4Yl6qfR28bqEuxAHmloqQhk0MSlpzXevMLAmCM4B6z1N9b
         87knCEH46hb0HrDrwdHqbj7o73S0KioLHNwAo9sd/VBR58PAvOVCuIf0RayDDHIcnstm
         zh33AoFq2C5Rx1SvngiB8CHjBFL4XvVSsR4LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9gJYJ3n1PrzT+nVQdUcEY+WLY9HYwAvNWuv9VcAD6k=;
        b=dp/cskoNe9QQTstoS9Y6kcMmnPbZqD8MVOEVkmiJ6WafC08G+V/nGze1xa204/ohvO
         vG24skZriuGEC2KQYIdD0wH8wtZcsZteaE4y5oHPTfCB8Ee+LVXDc5EHlCHbhf9u9G25
         2jQFY1RS40zbjrw69JA+ELQip+Ex3SH6CC4j549Rj21s8aXvECAWzgl5KW9tAM1W3lT9
         ei/twZczYy5jm345GlwmLDHaGV7ZWEY0ONYvXq8YyYpiu2jPf7ECihf+oFgz8gAqnzOc
         dv4wt9vhyy9IQnslNFkKCJaGEow0v38FXBNpl9j8kcYL75N0T8/tCzcpj7uuahpNZmFQ
         rfog==
X-Gm-Message-State: AGi0PuZrT0ZDUkxEcaE0JwvcjvEgQh6Q3l/rfOiGhQ/XnDxk641mOF6t
        MiHDtYnSi+gJdcgOVbA1fAtemQ==
X-Google-Smtp-Source: APiQypJCB+O0RXyXnDGd+gJg6HKweApSFsEIoGzatAvFK5k9aENS5j4AucalIRSxvrc/d106AIHzIg==
X-Received: by 2002:a92:84c1:: with SMTP id y62mr17356445ilk.116.1588895834251;
        Thu, 07 May 2020 16:57:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f19sm1369893ioc.9.2020.05.07.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:57:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fs: avoid fdput() after failed fdget()
Date:   Thu,  7 May 2020 17:57:08 -0600
Message-Id: <cover.1588894359.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While debugging an unrelated problem that got me down the path of
reviewing at all the fdget() and fdput() paths in the kernel.

While doing the review, I noticed these two places where fdput()
is called after failed fdget(). Fixing them in these two patches.
  
Shuah Khan (2):
  fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
  fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()

 fs/exec.c | 2 +-
 fs/sync.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

