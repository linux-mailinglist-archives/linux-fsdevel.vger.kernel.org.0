Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811D253EB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 09:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgH0HMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 03:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgH0HMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598512355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JL0Nic4lUYEvTQAyILRqVFTBlq5K5PuaRWhSncRHSwg=;
        b=jCAO6CFiJ9r6N/6UpmAGenQWzEPJIHktVq1NqHm2KN58QA3uTsDaFBuus38oJ3tDapI1IC
        7wlAuPnRJmNB2qpIqoYQuaEN6W1diKZzGCWrNY5L5bjzveisDExKyUcDVsCZPcvzGSL6rT
        P1fubMEUWWDu5swIjr1Z4fzsNZh1WXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-z3wLqnbnMyG6zUUz4TPm9w-1; Thu, 27 Aug 2020 03:12:33 -0400
X-MC-Unique: z3wLqnbnMyG6zUUz4TPm9w-1
Received: by mail-wm1-f72.google.com with SMTP id z1so1762479wmf.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 00:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JL0Nic4lUYEvTQAyILRqVFTBlq5K5PuaRWhSncRHSwg=;
        b=RtRrwdRWSQyIm8YX14be5sqFNHqIMbiAsZu7JwL+Se0COOJIVqqnKPBnpvrS3CN9Hd
         xB7Cv1MQlYl28yncmIXPwQ84HF9jvI42d90XcZqxzHsDPO8Om8z6e1u94liGWZ4p/3oP
         osO/X97e5B33ypZCsCD0qEpnvo5vKnigIb9Q7EewbLg63JJZ6T9YPXspUswcFHGyCZxo
         TWSksiLV4tX46KsvVOuGKEq3err9SCv24ezOoRnHlPiV8Ru0yPA9xa6O8lCjTFCZMv7j
         WVZO5FTTY3Z1PNeVTGTl8isK3hWQGY5CvXZai2qgnIYBaVWTPpRc3dImnrVGN0SQFxhj
         Bsfg==
X-Gm-Message-State: AOAM531Owu8tH1O2j8BUihoHk0PcCHz/NrZiq/Gy84F3+q9itjBLYUgj
        MgSkjXGt2OwOb2/Fb8YkxDpHGTqGGd/ja5lpkxLDeKsnpJtki62SGkEyARN2K4g80ehue4+AN0N
        aiCIcmYjFPvx+Bvj4CADEHVHbbQ==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr305702wru.46.1598512352242;
        Thu, 27 Aug 2020 00:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUHzxCz2Spgqmv60oYq58isMCoWeEsBIsG0b8y0nTVMsLWHJ63NS9EGPcX3VzzE1QFXWCdbg==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr305672wru.46.1598512351999;
        Thu, 27 Aug 2020 00:12:31 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id h11sm3694657wrb.68.2020.08.27.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:12:31 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:12:27 +0200
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
Subject: Re: [PATCH v4 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <20200827071227.tozlhvidn3iet6xy@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-3-sgarzare@redhat.com>
 <202008261245.245E36654@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008261245.245E36654@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:46:24PM -0700, Kees Cook wrote:
> On Thu, Aug 13, 2020 at 05:32:53PM +0200, Stefano Garzarella wrote:
> > +/*
> > + * io_uring_restriction->opcode values
> > + */
> > +enum {
> > +	/* Allow an io_uring_register(2) opcode */
> > +	IORING_RESTRICTION_REGISTER_OP,
> > +
> > +	/* Allow an sqe opcode */
> > +	IORING_RESTRICTION_SQE_OP,
> > +
> > +	/* Allow sqe flags */
> > +	IORING_RESTRICTION_SQE_FLAGS_ALLOWED,
> > +
> > +	/* Require sqe flags (these flags must be set on each submission) */
> > +	IORING_RESTRICTION_SQE_FLAGS_REQUIRED,
> > +
> > +	IORING_RESTRICTION_LAST
> > +};
> 
> Same thought on enum literals, but otherwise, looks good:

Sure, I'll fix the enum in the next version.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the review,
Stefano

