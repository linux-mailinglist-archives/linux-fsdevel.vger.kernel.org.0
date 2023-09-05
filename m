Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0D7924D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjIEP7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354042AbjIEJ1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:27:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC819B
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 02:27:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-402bec56ca6so170395e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693906021; x=1694510821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QivlHq495u/KUMjd8H66huPqjXNAmSye3h8RVHL8dfQ=;
        b=kHWjUPh5E9P0PuMc1KvzZrpbBJIlK+fqtQ51r5spaT/X71HFQ1cFrIYmojupmeatNc
         iK9Jf6KueruDB3aavndU6yXWEyu4UokzrV0ad20yU9W+Vjl7OPwUSGH6oaCtW601eiBq
         8pgqVZ4bYHmcU9fGUepyeF+I1+Ia3NddyVr09DtoXzsalyaR3ygWs4rLiLAO/xeOSqRJ
         HQGg+4zYX2hwLIzgjwzq2kE9X/ZBWHMIuGjrtGa3bHwmYTCxnYFV5YwFHFK5OQsxvgTk
         IHTAmTWdYteCZS+OW/u8OBXW/XkP1OnALba/BEfDbpXYFFm1t2CdP5Oc9xUvw/nuSKAj
         +WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906021; x=1694510821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QivlHq495u/KUMjd8H66huPqjXNAmSye3h8RVHL8dfQ=;
        b=CT8yKOyaLd4gPwj/52YjpyMCzTgdgOeose4lvEfaqikF1X+wkPgYWbS8GiO3oYkIHS
         9Vm5uY1wumpgbWtdljMELVi9LMFF0X9gN9XjQdaEwEobZ7pru119XsBtAULUPD1EFiiC
         UZmkGCn+El1IR9bQY1/99ol9ves5Eoyg3QwEdG9zJ1wjqStjltabgfvbw++vsILxORag
         NU05ua2iuqJ7KKBCNQNEvZloFIvBnwqWq17R8otj3m/l+CQ2JQpOqHLY9rp8xRMPteDb
         ENboa4Kd3+cYqN5siD4kTeBTZB3PzJkMXNwrXVQwt/mUG2idQNrgyOFT03BxISMYIYq1
         rZEA==
X-Gm-Message-State: AOJu0Yx4BbzzYP65NjAoZVJnKYbgI7uymdRTmVUCcDfR/PujVT6KKtWC
        YaA9HazKdTmVzVGczkckxb+E1kryXh52ABmiuwkyyA==
X-Google-Smtp-Source: AGHT+IGENfu5/HhYPIWUo6x3+albtxhQtbOQlDFueHeuAVWyG78SAwIxkvUDeE8EOtxevF3nTDBpl1nNYQYGKf57LhM=
X-Received: by 2002:a05:600c:512a:b0:3fe:e9ea:9653 with SMTP id
 o42-20020a05600c512a00b003fee9ea9653mr263627wms.4.1693906020688; Tue, 05 Sep
 2023 02:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e76944060483798d@google.com> <ZPbcdagjHgbBE6A8@infradead.org>
In-Reply-To: <ZPbcdagjHgbBE6A8@infradead.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 5 Sep 2023 11:26:48 +0200
Message-ID: <CANp29Y65sCETzq3CttPHww40W_tQ2S=0HockV-aSUi9dE8HGow@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] [ext4?] kernel BUG in __block_write_begin_int
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yukuai3@huawei.com, zhang_shurong@foxmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 5, 2023 at 9:45=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> syz test: git://git.infradead.org/users/hch/misc.git bdev-iomap-fix

A minor correction:

#syz test: git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
