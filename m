Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F25229A1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgGVO3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 10:29:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52464 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728837AbgGVO3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595428183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpvRfWeKDVYWowGCZPg9akb4cGt+hw0uA1Pjk8EfaPA=;
        b=d+Gnyckc8soOibbPN62EoZ5rKom/gvaE993kwOPqBFOO/kT/FJD18nfYzAPiRzTv3ogMtT
        +GU+BifFPL1MMJDbyUHkRkd1N0QP1u2PHy9BegY3nk5iI25du3RBBSIM9RkgCe5do8c1LO
        ru6mahI8Kg4zJcvvzSSa7oEXEAQYAVY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-Kyk_mQmsNhSJ31xkLzc6Ww-1; Wed, 22 Jul 2020 10:29:40 -0400
X-MC-Unique: Kyk_mQmsNhSJ31xkLzc6Ww-1
Received: by mail-wr1-f70.google.com with SMTP id b8so687454wro.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HpvRfWeKDVYWowGCZPg9akb4cGt+hw0uA1Pjk8EfaPA=;
        b=Mc/GKVPkNoFt417ISO4L3XJG+vzPtOwRcciopaIeRdj89DkZg5mC7tIdamKcv1hB8R
         tyE1XOBzj7v22CpprSK+T5KownHcP2dKJXjnwr2o40C4m3vt0TtzR0IKMlr5cD3JyDw3
         LgbSinaezFSCXUk6567n36z+LMxudTAgM5/HZAz14A5q6PBCBmRdUO0VLLaLUuM7JHu2
         4vWSq/PpbOurc8C6veXJmPK2HwK/Lp6hnTTnY7jubFY8Dn/bslECyXJd11jAbfJlAaTj
         90qpH64NSGOk1uyzKVR0+rHsSBKB1745DURRA1WAtpC99Lj8bHhyLwYPmc6P+6RTs0aa
         4WQw==
X-Gm-Message-State: AOAM530q619mb0OLcuWSySARAZjOgQV1EmF9GwBrCTTV3SiXHsUGDmZv
        S4ntwvP+N+Yrf3ind9h4l1IT4tZuqu8g9/uGWbTX02pCBr3+2dK2uHbEJjPK0exWRCR61t8FVfK
        3NeQocm7t8FGFLbrEhcGmX8a/Rw==
X-Received: by 2002:adf:8024:: with SMTP id 33mr33689231wrk.117.1595428178920;
        Wed, 22 Jul 2020 07:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG8Z8DO7euidMpeOf2ZLbbpnrBtYwH+3mx/ul+4ozsKYbSDmGaA4HHY0n0WQCn79ezmV8nig==
X-Received: by 2002:adf:8024:: with SMTP id 33mr33689200wrk.117.1595428178650;
        Wed, 22 Jul 2020 07:29:38 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id e5sm146181wrc.37.2020.07.22.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 07:29:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 16:29:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS
 opcode
Message-ID: <20200722142933.rmskkqjputefjace@steredhat>
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-3-sgarzare@redhat.com>
 <0fbb0393-c14f-3576-26b1-8bb22d2e0615@kernel.dk>
 <20200721104009.lg626hmls5y6ihdr@steredhat>
 <15f7fcf5-c5bb-7752-fa9a-376c4c7fc147@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f7fcf5-c5bb-7752-fa9a-376c4c7fc147@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:11:17AM -0600, Jens Axboe wrote:
> On 7/21/20 4:40 AM, Stefano Garzarella wrote:
> > On Thu, Jul 16, 2020 at 03:26:51PM -0600, Jens Axboe wrote:
> >> On 7/16/20 6:48 AM, Stefano Garzarella wrote:
> >>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> >>> index efc50bd0af34..0774d5382c65 100644
> >>> --- a/include/uapi/linux/io_uring.h
> >>> +++ b/include/uapi/linux/io_uring.h
> >>> @@ -265,6 +265,7 @@ enum {
> >>>  	IORING_REGISTER_PROBE,
> >>>  	IORING_REGISTER_PERSONALITY,
> >>>  	IORING_UNREGISTER_PERSONALITY,
> >>> +	IORING_REGISTER_RESTRICTIONS,
> >>>  
> >>>  	/* this goes last */
> >>>  	IORING_REGISTER_LAST
> >>> @@ -293,4 +294,30 @@ struct io_uring_probe {
> >>>  	struct io_uring_probe_op ops[0];
> >>>  };
> >>>  
> >>> +struct io_uring_restriction {
> >>> +	__u16 opcode;
> >>> +	union {
> >>> +		__u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
> >>> +		__u8 sqe_op;      /* IORING_RESTRICTION_SQE_OP */
> >>> +	};
> >>> +	__u8 resv;
> >>> +	__u32 resv2[3];
> >>> +};
> >>> +
> >>> +/*
> >>> + * io_uring_restriction->opcode values
> >>> + */
> >>> +enum {
> >>> +	/* Allow an io_uring_register(2) opcode */
> >>> +	IORING_RESTRICTION_REGISTER_OP,
> >>> +
> >>> +	/* Allow an sqe opcode */
> >>> +	IORING_RESTRICTION_SQE_OP,
> >>> +
> >>> +	/* Only allow fixed files */
> >>> +	IORING_RESTRICTION_FIXED_FILES_ONLY,
> >>> +
> >>> +	IORING_RESTRICTION_LAST
> >>> +};
> >>> +
> >>
> >> Not sure I totally love this API. Maybe it'd be cleaner to have separate
> >> ops for this, instead of muxing it like this. One for registering op
> >> code restrictions, and one for disallowing other parts (like fixed
> >> files, etc).
> >>
> >> I think that would look a lot cleaner than the above.
> >>
> > 
> > Talking with Stefan, an alternative, maybe more near to your suggestion,
> > would be to remove the 'struct io_uring_restriction' and add the
> > following register ops:
> > 
> >     /* Allow an sqe opcode */
> >     IORING_REGISTER_RESTRICTION_SQE_OP
> > 
> >     /* Allow an io_uring_register(2) opcode */
> >     IORING_REGISTER_RESTRICTION_REG_OP
> > 
> >     /* Register IORING_RESTRICTION_*  */
> >     IORING_REGISTER_RESTRICTION_OP
> > 
> > 
> >     enum {
> >         /* Only allow fixed files */
> >         IORING_RESTRICTION_FIXED_FILES_ONLY,
> > 
> >         IORING_RESTRICTION_LAST
> >     })
> > 
> > 
> > We can also enable restriction only when the rings started, to avoid to
> > register IORING_REGISTER_ENABLE_RINGS opcode. Once rings are started,
> > the restrictions cannot be changed or disabled.
> 
> My concerns are largely:
> 
> 1) An API that's straight forward to use
> 2) Something that'll work with future changes
> 
> The "allow these opcodes" is straightforward, and ditto for the register
> opcodes. The fixed file I guess is the odd one out. So if we need to
> disallow things in the future, we'll need to add a new restriction
> sub-op. Should this perhaps be "these flags must be set", and that could
> easily be augmented with "these flags must not be set"?

Okay, now I get it, and I think that's a good point. I'm going to change that
to restrict SQE flags.

About the registration of restrictions, what do you think is the best solution
among them?
1. a single register op (e.g. IORING_REGISTER_RESTRICTIONS) which has an array
   of restrictions as a parameter.
2. a register op for each restriction (sqe ops, register ops, sqe flags, etc.),
   that requires multiple io_uring_register() calls to register all the
   restrictions.

I'd go for the first one (basically as it's implemented in this RFC) because
it seems more extensible and manageable to me, but I'd like to have your
opinion.

Thanks for your suggestions,
Stefano

