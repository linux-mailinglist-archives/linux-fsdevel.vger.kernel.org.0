Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF16F25469E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgH0OQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:16:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbgH0OI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598537286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvdhiPhYSGUOeaIN0B943JFU94tDWV4/UOsJxiz1v3Q=;
        b=UHFEckN0fYgnuf0GwXFpAGG704V7cLk2XESvYIhi1FmDM97lxaCznwl7e1KQJY6oYHp+5B
        3PV8HRqkZbjh8TWBxG4DGuecjHFGIK6wLvRrTb5612eEd8yD2A0fSfXHqhKu0/3X72jwLw
        HC39wgLNGXic7MvJJ7nNmvoQmgC1grQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-PP3rtvx_O-6jymp5o0ZQBg-1; Thu, 27 Aug 2020 10:08:05 -0400
X-MC-Unique: PP3rtvx_O-6jymp5o0ZQBg-1
Received: by mail-wm1-f71.google.com with SMTP id c198so2174702wme.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CvdhiPhYSGUOeaIN0B943JFU94tDWV4/UOsJxiz1v3Q=;
        b=LRZvmnZe4xoOD25SNvdZGcpIaNPz9xd2HJ1Ffg2ixkaJRL709hgIRhD3jWeMZ14JtH
         w1J53jy+qIoee/mm6VzaN+gBuKBP8nDp1/A5zhgyqAFXfG4E6fgng0S7kMPgYztKrd2/
         1x4yu8kZrNZ8Ga8b7zg9HwADZA2lTc6D4Mebe6X7Zw2YSVuLtt6N1OQ7jiG0bgpqCIZZ
         AAcaCSIPtWfcWfFzZX99NKOXIaUx8N5exwSQ2/jofKc1WfC5nMBsDKepWkF343rFZFQ+
         xDNnO4c/vtDTbph9IQyXFTRj8Sm13UtZTkWj/LiXKIP4LSn3Xi4uiAEYbdzZtU3kDpGK
         8jkQ==
X-Gm-Message-State: AOAM530xkhIe5MVPp8R/74UAydFjgyUSvauxfut7I3f4h0Ax4tAJ75WR
        Oi/cr2Ixx9+DIA5wcSQDKVX9tuFyDHr1sjIC+wbPdKmOh959ub8odbUlyDWWMCUnsV8wUfMRfuu
        s2EH9OK6IfHmvk1Mp1PW1EA8SlA==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr19971173wrw.8.1598537283953;
        Thu, 27 Aug 2020 07:08:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWw4gY+gfT3ioYFr28ZoapW9vPXQZrcRf4b8LhwoAGjeKf6Sd713KoEGCbzoU3U0KCeejqiw==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr19971132wrw.8.1598537283631;
        Thu, 27 Aug 2020 07:08:03 -0700 (PDT)
Received: from steredhat.lan ([5.171.209.212])
        by smtp.gmail.com with ESMTPSA id t14sm7282780wrg.38.2020.08.27.07.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:08:03 -0700 (PDT)
Date:   Thu, 27 Aug 2020 16:07:58 +0200
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
Subject: Re: [PATCH v5 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <20200827140758.mboc7z2us2yqp356@steredhat.lan>
References: <20200827134044.82821-1-sgarzare@redhat.com>
 <20200827134044.82821-3-sgarzare@redhat.com>
 <206a32b6-ba20-fc91-1906-e6bf377798ae@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206a32b6-ba20-fc91-1906-e6bf377798ae@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:49:45AM -0600, Jens Axboe wrote:
> On 8/27/20 7:40 AM, Stefano Garzarella wrote:
> > @@ -6414,6 +6425,19 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
> >  	if (unlikely(sqe_flags & ~SQE_VALID_FLAGS))
> >  		return -EINVAL;
> >  
> > +	if (unlikely(ctx->restricted)) {
> > +		if (!test_bit(req->opcode, ctx->restrictions.sqe_op))
> > +			return -EACCES;
> > +
> > +		if ((sqe_flags & ctx->restrictions.sqe_flags_required) !=
> > +		    ctx->restrictions.sqe_flags_required)
> > +			return -EACCES;
> > +
> > +		if (sqe_flags & ~(ctx->restrictions.sqe_flags_allowed |
> > +				  ctx->restrictions.sqe_flags_required))
> > +			return -EACCES;
> > +	}
> > +
> 
> This should be a separate function, ala:
> 
> if (unlikely(ctx->restricted)) {
> 	ret = io_check_restriction(ctx, req);
> 	if (ret)
> 		return ret;
> }
> 
> to move it totally out of the (very) hot path.

I'll fix.

> 
> >  	if ((sqe_flags & IOSQE_BUFFER_SELECT) &&
> >  	    !io_op_defs[req->opcode].buffer_select)
> >  		return -EOPNOTSUPP;
> > @@ -8714,6 +8738,71 @@ static int io_unregister_personality(struct io_ring_ctx *ctx, unsigned id)
> >  	return -EINVAL;
> >  }
> >  
> > +static int io_register_restrictions(struct io_ring_ctx *ctx, void __user *arg,
> > +				    unsigned int nr_args)
> > +{
> > +	struct io_uring_restriction *res;
> > +	size_t size;
> > +	int i, ret;
> > +
> > +	/* We allow only a single restrictions registration */
> > +	if (ctx->restricted)
> > +		return -EBUSY;
> > +
> > +	if (!arg || nr_args > IORING_MAX_RESTRICTIONS)
> > +		return -EINVAL;
> > +
> > +	size = array_size(nr_args, sizeof(*res));
> > +	if (size == SIZE_MAX)
> > +		return -EOVERFLOW;
> > +
> > +	res = memdup_user(arg, size);
> > +	if (IS_ERR(res))
> > +		return PTR_ERR(res);
> > +
> > +	for (i = 0; i < nr_args; i++) {
> > +		switch (res[i].opcode) {
> > +		case IORING_RESTRICTION_REGISTER_OP:
> > +			if (res[i].register_op >= IORING_REGISTER_LAST) {
> > +				ret = -EINVAL;
> > +				goto out;
> > +			}
> > +
> > +			__set_bit(res[i].register_op,
> > +				  ctx->restrictions.register_op);
> > +			break;
> > +		case IORING_RESTRICTION_SQE_OP:
> > +			if (res[i].sqe_op >= IORING_OP_LAST) {
> > +				ret = -EINVAL;
> > +				goto out;
> > +			}
> > +
> > +			__set_bit(res[i].sqe_op, ctx->restrictions.sqe_op);
> > +			break;
> > +		case IORING_RESTRICTION_SQE_FLAGS_ALLOWED:
> > +			ctx->restrictions.sqe_flags_allowed = res[i].sqe_flags;
> > +			break;
> > +		case IORING_RESTRICTION_SQE_FLAGS_REQUIRED:
> > +			ctx->restrictions.sqe_flags_required = res[i].sqe_flags;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	ctx->restricted = 1;
> > +
> > +	ret = 0;
> 
> I'd set ret = 0 above the switch, that's the usual idiom - start at
> zero, have someone set it to -ERROR if something fails.

Yes, it is better. I'll fix it.

Thanks,
Stefano

