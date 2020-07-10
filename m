Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6E21BAAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGJQU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 12:20:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728003AbgGJQU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594398026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9OBXiOBnT1mGmZ2eGcWLsQs9qpaRL+ZvL1+d8k1S8o=;
        b=Zp5ERXHJY51EYfXqtCeh+E+JBz9Z47e1rrre6/mQi1htpjr3rt43zdxrc1HcrdRlwpGvKe
        VIvBzi/sLKEHIzMYHTjwQzq0qJvDJheI5PEn7FT/VDoJ/4+Xc8/aZfjL9r4rpXV35fdEci
        3arew0jfnUcgj3Ty4OA7QlW9Ey0BpWU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-BdNU9N9HMFKFlhH1fYPzSA-1; Fri, 10 Jul 2020 12:20:24 -0400
X-MC-Unique: BdNU9N9HMFKFlhH1fYPzSA-1
Received: by mail-wm1-f70.google.com with SMTP id s134so7168112wme.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 09:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9OBXiOBnT1mGmZ2eGcWLsQs9qpaRL+ZvL1+d8k1S8o=;
        b=M7ddjiYSbiIEproYBaXer46wy0ZmS+ED+0eO3nubPLCWulMzcHxWHlkjU3Y1sjOU+B
         /q5sXk2w4+cBjn7clM9jUtv/gaZKOVnmk4OztReqFMqf+5Y2oCnqPLFGA7Z1ZAcsgHxQ
         TNMtNPN7ndPy//1TZwo7HIxRk1cvyo2PRKnGz2TPi9baYUUXUepy8ojpACFYsRt5QDHb
         PD7cdza9dXrQkLhAyFOEIhLvhQX2MCij8CAGeb/g/U0tMNds8BAIclg3U+6rZKR9F/rG
         wAb23FgmZR4KbpX1lOhx+yMu45gkH5kAe6xh756SHHCkUh7s3w6SFohOWfzGpFzThHAg
         aTsQ==
X-Gm-Message-State: AOAM531eXF9P1rT3s2Rt1knUaYrxAeroDny8wZqjUM0HyxnrNjv/vRc2
        +wTKP0xkw9E+YF0Qr2TdVS8YhOX4qoSn6bCgVYY/Ow1h3sD0GIl0ZOspa5dbodb2f9xn/LpVJmM
        qssHYqp4Iw1+lVBBO7ZxS/QDoqg==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr75515903wru.158.1594398022819;
        Fri, 10 Jul 2020 09:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNg29SHEj/1kCIq20X+QBQi6Vi8ell7jTihmuv4S0/ilMJ558e1BkioaTjMsJllIACTM1T8A==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr75515878wru.158.1594398022605;
        Fri, 10 Jul 2020 09:20:22 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id 129sm10475853wmd.48.2020.07.10.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:20:22 -0700 (PDT)
Date:   Fri, 10 Jul 2020 18:20:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <asarai@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH RFC 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200710162017.qdu34ermtxh3rfgl@steredhat>
References: <20200710141945.129329-1-sgarzare@redhat.com>
 <20200710153309.GA4699@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710153309.GA4699@char.us.oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konrad,

On Fri, Jul 10, 2020 at 11:33:09AM -0400, Konrad Rzeszutek Wilk wrote:
> .snip..
> > Just to recap the proposal, the idea is to add some restrictions to the
> > operations (sqe, register, fixed file) to safely allow untrusted applications
> > or guests to use io_uring queues.
> 
> Hi!
> 
> This is neat and quite cool - but one thing that keeps nagging me is
> what how much overhead does this cut from the existing setup when you use
> virtio (with guests obviously)?

I need to do more tests, but the preliminary results that I reported on
the original proposal [1] show an overhead of ~ 4.17 uS (with iodepth=1)
when I'm using virtio ring processed in a dedicated iothread:

  - 73 kIOPS using virtio-blk + QEMU iothread + io_uring backend
  - 104 kIOPS using io_uring passthrough

>                                 That is from a high level view the
> beaty of io_uring being passed in the guest is you don't have the
> virtio ring -> io_uring processing, right?

Right, and potentially we can share the io_uring queues directly to the
guest userspace applications, cutting down the cost of Linux block
layer in the guest.

Thanks for your feedback,
Stefano

[1] https://lore.kernel.org/io-uring/20200609142406.upuwpfmgqjeji4lc@steredhat/

