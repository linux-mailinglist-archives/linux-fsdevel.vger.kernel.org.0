Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520257A8042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 14:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjITMfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjITMfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:35:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773B92
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 05:35:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so111422581fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695213302; x=1695818102; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWfO/q21DE+wQvTCQ68tPrDZBt2LprrmHc00k705cSo=;
        b=HoExN5eTUYwNRRE06gRDjqmdSWkRqOyp4STA8/8jCvggskz2SClzohK3osJiA+l1Ui
         S4L3lmtJyPbIikgq5VYw8qkMr1AGeS11RZUM8jMoXkNluSYTstnQDJSwpRdMtHcMDtFN
         nP3G7l657a+Odx1XaWeFuwN2HS7fp3j+o3tXyeaO1S9DW3fRU5L2VWBO77PJrXavJ1dG
         x/q7tJ9vt7OXDyXWPInYrqxEIAhjA9s0M9Z8SQK4Kh01/cYDgk1Ue2fZi13WXD+yGUQa
         boRn7GwBuF0WU9eIWsPZ6+DkDLIzLniQHlrn6Pv6YRJ5CxxTfKJE7mHrbih9xseCsNCz
         amLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213302; x=1695818102;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWfO/q21DE+wQvTCQ68tPrDZBt2LprrmHc00k705cSo=;
        b=vIt/f0wP3djp9IGj9V1JXJ+HvXHQ3+Peaxb9H3c/xCWNH/Eon5NWs5lMP4NIvCQjt5
         Ft5HY4ZInB2ZjAJZ4iWn6jAG3Qf0q9smexqS2q6IYxBP9pPw/YZNG8WrxmP+qIbNfmpf
         eFyhI8Of/LYk5V+yr+MNSIMZrV+1BFNQUZK+064WK8EOD1EPyaTuoaleK6FdE9WT8x/T
         yU7fPrCkGmjM14VRc0TioNRZJNysNkHZgY2kP9XEWnjiGWN5osyV3PuJfcaT6LIuMx4G
         6fhQUjodFeMMvezndRTqbIdTPAhqk8Gt9fM4t7z8MFOLTHgGyXQjjfmjYHAqkhc54lu6
         7wdA==
X-Gm-Message-State: AOJu0YzD3grTDLLQUO8Z+XZXqF6jP6OnYHTckS0xQ8L0s0vWy+CUkWbK
        d13EugAhjUOKPc57LMrrq3faCVNgIlO+yH6Fbquhwa7/F/UnRfQV6uQ=
X-Google-Smtp-Source: AGHT+IHeC+jA7L6XqdlU6xW7x98tbNi3fNQnoZ4OtF5jjDX3x9btNFbijcqriCs1dxqsoFz473gQ0Hg1IRrRRs72phc=
X-Received: by 2002:a2e:9090:0:b0:2bf:f5d4:6b5a with SMTP id
 l16-20020a2e9090000000b002bff5d46b5amr2194443ljg.41.1695213302397; Wed, 20
 Sep 2023 05:35:02 -0700 (PDT)
MIME-Version: 1.0
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 20 Sep 2023 14:34:51 +0200
Message-ID: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
Subject: When to lock pipe->rd_wait.lock?
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm trying to understand the code that allocates a new buffer from a
pipe's buffer ring. I'd like to write a patch that eliminates some
duplicate code, to make it less error prone.

In fs/pipe.c, pipe_write() locks pipe->rd_wait.lock while the pipe's
head gets evaluated and incremented (all while pipe->mutex is locked).
My limited understand is that holding this spinlock is important
because it protects the head/tail accesses in pipe_readable() which is
gets called by wait_event while the spinlock is held, but without
pipe->mutex.

However in fs/splice.c, splice_pipe_to_pipe() contains very similar
code; a new buffer gets allocated, head gets incremented - but without
caring for pipe->rd_wait.lock.
Please help me understand the point of locking pipe->rd_wait.lock, and
why it's necessary in pipe_write() but not in splice_pipe_to_pipe().
Is that a bug or am I missing something?

Max
