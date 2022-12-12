Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488AD64A869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiLLUIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 15:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiLLUIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:08:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B81758B
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 12:08:49 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m15so3962364ilq.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 12:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u3BbrByAFw5FT9NX4KXUG8TigR7i4VY21tkW7nPDLs=;
        b=rPFcGDSMOiyERlwpwMaWLd0MxC0uN6qZp8sUs82oNJ+/vv/SQQ5Vs2T7ItQahjUrHA
         zr47H97j/9YwOEBXnkzzDZgSqnLXrCikvlvk5mVSOVFTwKDWMg+h1y25aTnDhwThVP7R
         cOIThXzzpSKjkcxmbBBqw6xsnpB98qbi0kAF6PVbdlITgENMm9k+lygLk2LBiIFg2XFC
         znDbm/2BLalWFIBAY8TijAzAMqN/5T8DnyXCRbFdK8SNtpSTa1kG2HdQb83feq9rTOtC
         YeSFvWHUkc37qvRm+KjUqN15Xje4pJ4xSga3agGtMxuskamwPC8lkettdc9hLAxX6JoA
         nepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u3BbrByAFw5FT9NX4KXUG8TigR7i4VY21tkW7nPDLs=;
        b=BNvOrQ8IBXruPHD4GFIWFDDFAJWvkcpVWhtEwTVQ8bNU1+GjEmEadtuQMAPWRxOrq+
         WlqoGzX3+qFjOQDB0xKhcViyRr1ExMCzoTBS0v8Iwwo1a0OsuqmkbL+U/XUJpgmjuu9K
         Fy7MrtprvA40sF6ePe4BjfNPwaZBlWjSXYTmwtqwRiLFCfXmkbd6m4oB3ivR6Y9EVH4v
         AYSitwABy9Ee7EHbMHR1f5OF45BkxIFZ7nukYaKBg2MISEu17+YJYSsiNSeCO5B+tCWJ
         zeC40bWpAKFIX6ZFnribA76V7w0lkPAFhGZJWae+Y7iv+WWd/7oyBQ4IRyPoDxlUVIvh
         eVMg==
X-Gm-Message-State: ANoB5pkoXcFX0v4oAvD/FPqRrKuxdHv1m2blYmD0BxYahyRGs4TDDCTj
        CJvOBfMgRmQK2POI1hMIM/NVyZKMZ4SSsySH414=
X-Google-Smtp-Source: AA0mqf4pJ4wO2v9jD/pB6XWrFMs0+uWOv0L8NrCB6UU/gYgAbFG5Dihb1Wk3ECAjQRnLYux9qByecw==
X-Received: by 2002:a05:6e02:ed0:b0:304:ac4f:a79b with SMTP id i16-20020a056e020ed000b00304ac4fa79bmr988073ilk.3.1670875728764;
        Mon, 12 Dec 2022 12:08:48 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j192-20020a0263c9000000b0038a2bc43350sm209290jac.53.2022.12.12.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:08:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
In-Reply-To: <20221212113633.29181-1-jack@suse.cz>
References: <20221212113633.29181-1-jack@suse.cz>
Subject: Re: [PATCH v2] writeback: Add asserts for adding freed inode to lists
Message-Id: <167087572772.15871.5272301302729257239.b4-ty@kernel.dk>
Date:   Mon, 12 Dec 2022 13:08:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, 12 Dec 2022 12:36:33 +0100, Jan Kara wrote:
> In the past we had several use-after-free issues with inodes getting
> added to writeback lists after evict() removed them. These are painful
> to debug so add some asserts to catch the problem earlier. The only
> non-obvious change in the commit is that we need to tweak
> redirty_tail_locked() to avoid triggering assertion in
> inode_io_list_move_locked().
> 
> [...]

Applied, thanks!

[1/1] writeback: Add asserts for adding freed inode to lists
      commit: a9438b44bc7015b18931e312bbd249a25bb59a65

Best regards,
-- 
Jens Axboe


