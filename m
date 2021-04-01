Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B223517A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhDARmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhDARlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:20 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E5C08EADE
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 06:37:12 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id h11so1239357vsl.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3RICVK9N6jKbelHnVhbtTzO/l3t9YgrOgzyc42q1sJ0=;
        b=k2pYug0td7o0nQuQ2bUhFIdscUQq6n0joLcaMYwuY6y3wtRYrzuUAtPHVy3B5TRlHy
         sqDBvlZeP8RJrWfR4LYaaG2KrGOb2SV3inWNSZpxxf2Q0VQREF98zrj2Ss/i1Aa7iiIE
         KZCZ58UdmIJBGBUKh8ybxlTzoy09T1PMnagTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3RICVK9N6jKbelHnVhbtTzO/l3t9YgrOgzyc42q1sJ0=;
        b=IvV79WjmZDn2wiRPVF8YthqNlU6KRpwwnj5x7URPVMllmgPApyyKC46aiYCpgyfvk4
         tOVV1qONvc2QoTBbLpP3mrmBFevc4JKUxpX+biLkc688CDIAORHnqcnxAdbDaHq98QvS
         gQqwTd45aW8cON/Qo1zvWHolkdISpFYKP/ELubrNQeHPqlDIrXth07FYDRCYXoK50Ac5
         7lvngIzopf057j9pP4lCsV5fLmVXHZ+icLu2h1+YaeoCenUjGZcsjMGGUHofN4ri9hwe
         Hv0nAfHBa9RjDYgedSvkIxjGz3WlrYk7GrqcS3waIhbgrkZtgCRjcCGb0xK9BrWjJhpF
         qxIw==
X-Gm-Message-State: AOAM532PdfGWQfzHU/tUmNeE7/teHcJPidEKSJuzr2eM6jXOjV4Yr5dO
        SCJgQ0HQH836YbM2u40CYSplMVgR992Rv2RO4i+47Q==
X-Google-Smtp-Source: ABdhPJyuqNjNWR2Rbuv/sEwvP8rSoTNNxpH5aQr/KX1UN60llLGGV2f3cwvL4u6Tu+hM04IJVKnzOgq+zxB//km6IvQ=
X-Received: by 2002:a67:b005:: with SMTP id z5mr4863878vse.47.1617284232031;
 Thu, 01 Apr 2021 06:37:12 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Apr 2021 15:37:00 +0200
Message-ID: <CAJfpegtUOVF-_GWk8Z-zUHUss0=GAd7HOY_qPSNroUx9og_deA@mail.gmail.com>
Subject: overlayfs: overlapping upperdir path
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 146d62e5a586 ("ovl: detect overlapping layers") made sure we
don't have overapping layers, but it also broke the arguably valid use
case of

 mount -olowerdir=/,upperdir=/subdir,..

where subdir also resides on the root fs.

I also see that we check for a trap at lookup time, so the question is
what does the up-front layer check buy us?

Thanks,
Miklos
