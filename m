Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B66253ECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH0HSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 03:18:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48976 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbgH0HSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598512691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9fFbu1GhOR5EEBDVCiFc4v2JfgRv9dRTWq43a81ToQ=;
        b=RGBDWIK3G1NQQkSAwosQoT3Q5eSWHJy201C0S2AGNDU0gCkW+f9WfkL69xlIj1++3JQoCx
        pKTlR9dwzOjmcAcImxT0vWTNEWM/p5456/vkfwhwwoA3sfYF6h+YqZ+VVzGjHm4wfKiLOY
        2kMHQSTJuQ9xPuZn0+I8NVoR3TuMTBk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-bt7MBzwUMOCWRrpPH4lALw-1; Thu, 27 Aug 2020 03:18:08 -0400
X-MC-Unique: bt7MBzwUMOCWRrpPH4lALw-1
Received: by mail-wr1-f70.google.com with SMTP id a10so1158685wra.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 00:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9fFbu1GhOR5EEBDVCiFc4v2JfgRv9dRTWq43a81ToQ=;
        b=Z4k+ZNg84uep2jVAsOPKnmILovIOqhdGddey29ynp5ChGaC/KdF2ZANRBXuEA5CUjB
         jQ04KcG9BmlJAgAqHD3R87qwGP+mxRBthjHPdGPNWJMkZ4lfGydwb/laNE7WKcLavRjq
         pC9CN9Z2stiUXquVOcpAfth0T3Aab63hlMdNDD7HOkcDGGjsP09Ufns4dpJ33CMSMMz9
         D/23b4c26yMcznaFLXUpVO5mWkto9pVwlH92wD69cr0Av2FW7q9aYr7s7P7WrzoNqHnG
         sL3Dpuch3H8QrJ+dRmrB3aPaeiNoNLF/70vwmOFVa5KBLLJXFItg2ACy1EY0+8abM7ns
         45bw==
X-Gm-Message-State: AOAM532javm9djpZ2/ZjptZXOtomwDgLmaGr0OxgQpo+vhhx2+no98gF
        w0d8FNzHkg1tU0BqU+bswspVHQpY0+QVzvWyWO1nG4pOWVbouZB+0ABiqOvXVaVTu8zXTH8U39p
        7N3fnzM5njKGk1LeQDkP5BSp5Jw==
X-Received: by 2002:adf:b349:: with SMTP id k9mr13694174wrd.135.1598512687410;
        Thu, 27 Aug 2020 00:18:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwtPSLbAoCV+fY+tWZVhYam7dcbiUmX7cOj0w7rM1ddAdGJMa85Kp5T8Bt7PKtypBfPZj1aw==
X-Received: by 2002:adf:b349:: with SMTP id k9mr13694156wrd.135.1598512687137;
        Thu, 27 Aug 2020 00:18:07 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id s12sm3022065wmj.26.2020.08.27.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:18:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:18:02 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20200827071802.6tzntmixnxc67y33@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-4-sgarzare@redhat.com>
 <202008261248.BB37204250@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008261248.BB37204250@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:50:31PM -0700, Kees Cook wrote:
> On Thu, Aug 13, 2020 at 05:32:54PM +0200, Stefano Garzarella wrote:
> > This patch adds a new IORING_SETUP_R_DISABLED flag to start the
> > rings disabled, allowing the user to register restrictions,
> > buffers, files, before to start processing SQEs.
> > 
> > When IORING_SETUP_R_DISABLED is set, SQE are not processed and
> > SQPOLL kthread is not started.
> > 
> > The restrictions registration are allowed only when the rings
> > are disable to prevent concurrency issue while processing SQEs.
> > 
> > The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
> > opcode with io_uring_register(2).
> > 
> > Suggested-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Where can I find the io_uring selftests? I'd expect an additional set of
> patches to implement the selftests for this new feature.

Since the io_uring selftests are stored in the liburing repository, I created
a new test case (test/register-restrictions.c) in my fork and I'll send it
when this series is accepted. It's available in this repository:

https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)

Thanks for the review,
Stefano

