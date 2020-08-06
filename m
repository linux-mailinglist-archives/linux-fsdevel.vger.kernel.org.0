Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713DD23D7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHFHvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 03:51:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39576 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728430AbgHFHvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596700264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xB6SfwN9zZAFK1inviExT4PSWJ9s32aoWCOt/UwHdpI=;
        b=eQz1qoPFxrjCeWxiJ/wfF+IACxjm0WO2CnCV+5v/9p6j5On/YGFmxugrHiSb8uFwKLyt/D
        BqopthElF6VkC+SmlNZ0/dosJg59Y/6gFPidv2bSUUEbHpg3ETUpowi7Rkp9Hyt7XbU7LJ
        sTVmU6Y36cCzZWo5dWCtOs7LfE6RNr0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-fMv3oKVrNWi-eyOAQSWscQ-1; Thu, 06 Aug 2020 03:49:38 -0400
X-MC-Unique: fMv3oKVrNWi-eyOAQSWscQ-1
Received: by mail-wr1-f69.google.com with SMTP id s23so14261098wrb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2020 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xB6SfwN9zZAFK1inviExT4PSWJ9s32aoWCOt/UwHdpI=;
        b=lIhSZApxqX4C9uhxb93PRp9Yt5w1jXqSn7oJPyMBw3Hdokxv6jKefPyM0q72kxx5re
         +ojsb3vahPain19O8q7kuW3aTqZ8flEqi4VOUNhHFp7s3ZmFHv1Eck5lBLCZGl+I38NT
         Og+QJx+jKZVfkhWWB6ZqytVl6V6gQaAimsvb08TAmiXzUZabWpHH2W9oDFH/74ZtOhGF
         iuHDkSAzxFKFINpSz2Zmv1EDL9NwYzz23RkrMuARh8Q28lfZlzNwRg7kclj11/DJTy0u
         DYnWJHi5tgyXrnNe3YUCFYeQ3QFQaccxL1o4EQpHNG2O3MtvlG8hTmtMuw1IrXFyppX5
         LXYQ==
X-Gm-Message-State: AOAM531vm4YveuKMl7whZz2JDR+2SVrp+ZB+upOLaQqLJMr4JHBkY8Pe
        LYCQcNcVzLmTtZlKkddLyWUu+KEJ6HCf4Gwy71ZKE37gHq1VP+PQYSqejpMSkGwVP4GA2YUhwAv
        lQjcqFjpAHWNIWcweFlSNjfeW6Q==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr6663776wmg.34.1596700177238;
        Thu, 06 Aug 2020 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ5kIFKf/UdkmWPj9U+O2NxXnYswiWnhDgQNIX/nObMw+EYpBVxwz7xoUqJ3nnWezsts3JEg==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr6663754wmg.34.1596700176991;
        Thu, 06 Aug 2020 00:49:36 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id l18sm5580825wrm.52.2020.08.06.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 00:49:36 -0700 (PDT)
Date:   Thu, 6 Aug 2020 09:49:29 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200806074929.bl6utxrmmx3hf2y2@steredhat>
References: <20200728160101.48554-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728160101.48554-1-sgarzare@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gentle ping.

I'll rebase on master, but if there are any things that I can improve,
I'll be happy to do.

Thanks,
Stefano

On Tue, Jul 28, 2020 at 06:00:58PM +0200, Stefano Garzarella wrote:
> v3:
>  - added IORING_RESTRICTION_SQE_FLAGS_ALLOWED and
>    IORING_RESTRICTION_SQE_FLAGS_REQUIRED
>  - removed IORING_RESTRICTION_FIXED_FILES_ONLY opcode
>  - enabled restrictions only when the rings start
> 
> RFC v2: https://lore.kernel.org/io-uring/20200716124833.93667-1-sgarzare@redhat.com
> 
> RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com
> 
> Following the proposal that I send about restrictions [1], I wrote this series
> to add restrictions in io_uring.
> 
> I also wrote helpers in liburing and a test case (test/register-restrictions.c)
> available in this repository:
> https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)
> 
> Just to recap the proposal, the idea is to add some restrictions to the
> operations (sqe opcode and flags, register opcode) to safely allow untrusted
> applications or guests to use io_uring queues.
> 
> The first patch changes io_uring_register(2) opcodes into an enumeration to
> keep track of the last opcode available.
> 
> The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
> handle restrictions.
> 
> The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
> allowing the user to register restrictions, buffers, files, before to start
> processing SQEs.
> 
> Comments and suggestions are very welcome.
> 
> Thank you in advance,
> Stefano
> 
> [1] https://lore.kernel.org/io-uring/20200609142406.upuwpfmgqjeji4lc@steredhat/
> 
> Stefano Garzarella (3):
>   io_uring: use an enumeration for io_uring_register(2) opcodes
>   io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
>   io_uring: allow disabling rings during the creation
> 
>  fs/io_uring.c                 | 167 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/io_uring.h |  60 +++++++++---
>  2 files changed, 207 insertions(+), 20 deletions(-)
> 
> -- 
> 2.26.2
> 

