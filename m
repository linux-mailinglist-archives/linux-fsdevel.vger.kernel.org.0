Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548441BD79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 05:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbhI2DdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 23:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbhI2DdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:33:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83DC06161C;
        Tue, 28 Sep 2021 20:31:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k24so1272802pgh.8;
        Tue, 28 Sep 2021 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ArQkjCc4vsCmHmWMsVJOpMVQpa+Be2imxx1cbWLAfi4=;
        b=f98Do7ckW3J3vx2/CoLf2UJMnHv944ufva886iGwgLxFS1iS/CnwkVbGhJ1YBo+Vkb
         wMt/j6Kdt6Myjt6lYwHzpAHdj50sLgEHqQpUJ0OHSdpAp/X1VlNQGUbh42OhsQVtYMbW
         DymGzpKwOo5PU3sX3YbCTLXvjcQ5tGkOiYyiaOYzRWMV5tcgWJZHGA2C17Zx8zTwQj4g
         +LFA0hX+aMrarMz4mU0rvIiAMFcypvaJ+rwGP94YjM/R8kCc6gfzm57NpuF+MFUV4PJp
         awGk9xD1/tDwz8MlO8WRPq0hL1Fw7XaGcPeqfpkQ2MI9M7cismBfZzqL9I80a/nCcWS5
         uZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ArQkjCc4vsCmHmWMsVJOpMVQpa+Be2imxx1cbWLAfi4=;
        b=LT/cv72S5pKcy2U70FoxaI5L6xGYsYdVjlsSy9ikSR7VyY3Mw9opfzDwWoGOw22PJ0
         2ZUkkVue8rAiLCgTiEJcmEtvA2oA8d/o/L+60AkjclsDc/01TzyFZ6YDoXnEhbpG4xjx
         dvEHjsEN21UOW52P+V/R4ABfYQhxFLAedzsP2iZqWa9jCjg0G/f4gyym3YYDSkuiLcq9
         AQJgsu3jFqQUc9f9utcjiC5BIo09YaS1gapSYtlRFfcmNOX7AA2CTJ+tLufI4mXMQOyi
         GDYiV9rsD6H5AMnXL1heQ7keoVtGqNUcLGu8WtYvQ8PyQYuJyzu6/IFlW7Bd5VlSUuy6
         QkEQ==
X-Gm-Message-State: AOAM53218W5XSW+/BRLizNhUDokBYIHHROgtQbQgVcX3NZKfzynWOeJZ
        8TqBmW/0DEQZEud28NwKrNE=
X-Google-Smtp-Source: ABdhPJyWh+gdl3UeGQo48SNtJ2uAwQGbVGviwF2YJNlnWgFDmQZ/JSBMSTbMy6eQzhFrw0v008G1wg==
X-Received: by 2002:a62:5e05:0:b0:44b:34af:af0d with SMTP id s5-20020a625e05000000b0044b34afaf0dmr9095117pfb.54.1632886294250;
        Tue, 28 Sep 2021 20:31:34 -0700 (PDT)
Received: from localhost.localdomain ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id y15sm518573pfq.32.2021.09.28.20.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:31:33 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     miklos@szeredi.hu
Cc:     chenguanyou9338@gmail.com, chenguanyou@xiaomi.com,
        ed.tsai@mediatek.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanley.chu@mediatek.com
Subject: Re:[PATCH] fuse: alloc_page nofs avoid deadlock
Date:   Wed, 29 Sep 2021 11:31:27 +0800
Message-Id: <20210929033127.9152-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YVMz8E1Lg/GZQcjw@miu.piliscsaba.redhat.com>
References: <YVMz8E1Lg/GZQcjw@miu.piliscsaba.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

With pleasure.

Thanks,
Guanyou.Chen
