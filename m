Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C849253889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHZTuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHZTue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:50:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD8C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 12:50:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so1636204pgb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uxqzqvKmp7TiheniHf4IhKcDFcjxbiVLlnBXpofjwMk=;
        b=aU8siOppe3gnQyuaHzROkStSBHp1R5OW7cyHZa9Qz7+3P9SoF3bduzgEtFv0LgQ6EB
         SoPfRvVMaGGz7cgLY3D80QJOfKTkdjKYwQBRF982bGuQfjWlAASB6m3+ZBBr5WHfyh2w
         9WogV6NaCd7ry+cSTti/fvS9ekjLyQoNnN7HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxqzqvKmp7TiheniHf4IhKcDFcjxbiVLlnBXpofjwMk=;
        b=hRo8jhDiUT2ac1OJW2rPixHNKeKswtAQUWeiUoWW4bTbG7200sqZD/rVwKO/dvGU1N
         c5lMhtchbM3YeBYmKVbeF87C0PPI9ZT/TLVHHu+ti8M4AIN/Pb20PIhUG0GxwuROFNqS
         sFMaXQLPLKGOg/hba2YHn4+Y83zG4UPrb3ZnlWVikfXiWG2sxuXH59CT36nVxlK2vE4U
         WrsRC3PrumdrW4mLPF2s/vduCKYcipS83pQgBzP/DNX4xfoacqPKMxj4LCh0vJxASWcs
         BYw1jH/NZIulW+SGo1ZvNoEJMGG9WSK+EhCKhWysDLiSF4KSGyUINY+PeUGhqURwm7Ht
         vM4w==
X-Gm-Message-State: AOAM533kCKyqsgm+08kpVeL/3ZtgtO5983usnv1TldCvzUADthAy8VgT
        fZ0IiIs4Be51nbTTulOJG5fDDA==
X-Google-Smtp-Source: ABdhPJzxqVFKo5Bu6GBfBDh+chu3duJcUOhxiTiRE4q8mDWtHYdG37wKhgbCE4yKAY4sw60hABcZoA==
X-Received: by 2002:a63:df13:: with SMTP id u19mr11904336pgg.275.1598471433358;
        Wed, 26 Aug 2020 12:50:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a200sm3921461pfd.182.2020.08.26.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 12:50:32 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:50:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH v4 3/3] io_uring: allow disabling rings during the
 creation
Message-ID: <202008261248.BB37204250@keescook>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813153254.93731-4-sgarzare@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:32:54PM +0200, Stefano Garzarella wrote:
> This patch adds a new IORING_SETUP_R_DISABLED flag to start the
> rings disabled, allowing the user to register restrictions,
> buffers, files, before to start processing SQEs.
> 
> When IORING_SETUP_R_DISABLED is set, SQE are not processed and
> SQPOLL kthread is not started.
> 
> The restrictions registration are allowed only when the rings
> are disable to prevent concurrency issue while processing SQEs.
> 
> The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
> opcode with io_uring_register(2).
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Where can I find the io_uring selftests? I'd expect an additional set of
patches to implement the selftests for this new feature.

-- 
Kees Cook
