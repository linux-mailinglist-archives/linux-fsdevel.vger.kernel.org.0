Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55533254681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH0OKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:10:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55742 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728105AbgH0OKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598537411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3UaJor8m6UPSLfz0Cwgwz9tei6T+Ko+yHdee7F5pCI=;
        b=U3hgkicwANJkdU0V4e1fkj6xC1xjHJzZDJI0K86zdcAgU52LwoDNH7yDlqXKJIAbxAkv9v
        9OQiRlUN9WbLIiQabAluz0YjHk0xssVBM5H/HQcDF40mJJ0fKi/wI+LPBmuybrU6NaGZ1h
        RXyMzQnKYUa380uCGPIosDcicNq8I3A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-uT119_zgMfu_pbE0VD9unQ-1; Thu, 27 Aug 2020 10:10:08 -0400
X-MC-Unique: uT119_zgMfu_pbE0VD9unQ-1
Received: by mail-wr1-f71.google.com with SMTP id b18so1584058wrn.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 07:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3UaJor8m6UPSLfz0Cwgwz9tei6T+Ko+yHdee7F5pCI=;
        b=snY5k9+ClFn12Wy+/KgWfB6GjxhgCf+WEr2caJbYkHfVVX0vw96cruKH3bmsu2USNz
         cGZZl3JDGDxB6jKZraudHnWc9qHATHrSgNdeFCqxbEQaVqnFyLI68HZYe6upd41iY08R
         8AKTO9dluXowbJ01kK9VwsEkfZ7YnZGMrX4QLmAA7R00qdxKY15q3T3sex7SBsrtt5Q/
         L2ahdlM2rujjbIlAtQBQcDk0+pgPh0HE+mum+80HcB3aUztFDZLgNZrOhRQFz4Qzk8Im
         JTmZ8+PJz08hqkBtYY7xxy2D2AydtA1sDYlNe4WVtEcf3vEbr+tK8D4wtA8cMdZROzQG
         BbJw==
X-Gm-Message-State: AOAM530NrHyooBfLIpcjCqyASEpVRYkimyDotYtXABLXtWM/jb/V2fND
        p9KttQS/95Oi5HcY1uAjFgD5mmyVi55fvGRUNrPkRXh8T8bt200tEDJtRAISeSaWdWZMXBLTycq
        zkS8PKtUV7v704TULwxxTKJc2cg==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr18400752wrm.285.1598537407344;
        Thu, 27 Aug 2020 07:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIyoHL6pydlVZ4mUCwXiexrkWU5beyLiimAC7oyStXfYcu8GXZZ2ytD3aLAfsrScWOA6WOpQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr18400722wrm.285.1598537407089;
        Thu, 27 Aug 2020 07:10:07 -0700 (PDT)
Received: from steredhat.lan ([5.171.209.212])
        by smtp.gmail.com with ESMTPSA id p8sm6052216wrq.9.2020.08.27.07.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:10:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 16:10:02 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200827141002.an34n2nx6m4dfhce@steredhat.lan>
References: <20200827134044.82821-1-sgarzare@redhat.com>
 <2ded8df7-6dcb-ee8a-c1fd-e0c420b7b95d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ded8df7-6dcb-ee8a-c1fd-e0c420b7b95d@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:50:44AM -0600, Jens Axboe wrote:
> On 8/27/20 7:40 AM, Stefano Garzarella wrote:
> > v5:
> >  - explicitly assigned enum values [Kees]
> >  - replaced kmalloc/copy_from_user with memdup_user [kernel test robot]
> >  - added Kees' R-b tags
> > 
> > v4: https://lore.kernel.org/io-uring/20200813153254.93731-1-sgarzare@redhat.com/
> > v3: https://lore.kernel.org/io-uring/20200728160101.48554-1-sgarzare@redhat.com/
> > RFC v2: https://lore.kernel.org/io-uring/20200716124833.93667-1-sgarzare@redhat.com
> > RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com
> > 
> > Following the proposal that I send about restrictions [1], I wrote this series
> > to add restrictions in io_uring.
> > 
> > I also wrote helpers in liburing and a test case (test/register-restrictions.c)
> > available in this repository:
> > https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)
> > 
> > Just to recap the proposal, the idea is to add some restrictions to the
> > operations (sqe opcode and flags, register opcode) to safely allow untrusted
> > applications or guests to use io_uring queues.
> > 
> > The first patch changes io_uring_register(2) opcodes into an enumeration to
> > keep track of the last opcode available.
> > 
> > The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
> > handle restrictions.
> > 
> > The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
> > allowing the user to register restrictions, buffers, files, before to start
> > processing SQEs.
> > 
> > Comments and suggestions are very welcome.
> 
> Looks good to me, just a few very minor comments in patch 2. If you
> could fix those up, let's get this queued for 5.10.
> 

Sure, I'll fix the issues. This is great :-)

Thanks,
Stefano

