Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DB25387B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 21:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHZTqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgHZTq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:46:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92FEC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 12:46:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p11so1559374pfn.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lIC466wcHw5fR4eYEVc57sBZjLUX/gzzPPg8yLp1ZZU=;
        b=WFkrzFpr1SUiFaPbGhhpAKHAmVxv3wzkj4tDR+4PHOR9/MlIRPYJGnmI664QGeO/Cx
         jh56BsF4d4+yUYLb3tteEQtrETtrsW7Vukw+0hQQ46Y1kVm7YzGQ12QR8x1BVWPj5ZyL
         5rDrqojD9sPXkIKEP7O2wCAa1fCxfWjqV9Rc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIC466wcHw5fR4eYEVc57sBZjLUX/gzzPPg8yLp1ZZU=;
        b=q0b77ys/0AlWYzxh4XupmQExLSDBZQW5V27mb9l7eqGeAdadeOskr40nphwILl1MsM
         mL0OYbwJV3LnxGtCa2TXGr011VgsHjI6B/zGXv7HQFoNo0Ziw1rDAo7nS1/j49+PxUq8
         EVY2RGIsx0P70mDyul1+oaRim/E+gslBMIZNo4d3rncEKMGRPS2SPkskwCotOJEKuYZR
         32QJ3pllMZU9EyOoPlBxo1dVmtAyz45rDb1b6yK3ML+ATTPC7pigf7p58Jf+HKZwknti
         HMdwOgc7UwE67nL1nMOI3TQra08KnUry1jff+lTT/pNH0cF1qyyg7pZl/rpBdGYYm2DS
         aeyg==
X-Gm-Message-State: AOAM533r8AoC9H9ejPYprvaV/KyuCSHE5BjWR5S1apDvZ96zKv9GZ70d
        af/Srl3sBOM6MB+/bB2H94lg3g==
X-Google-Smtp-Source: ABdhPJzfdv5XUXwJl1UOhKF/pH+9I5ADCLKzvf0FKe3PbEuFazJPlW1HymFX95ObV8KRL+rwcPkouA==
X-Received: by 2002:a62:5212:: with SMTP id g18mr8576508pfb.8.1598471186120;
        Wed, 26 Aug 2020 12:46:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ds19sm2262912pjb.43.2020.08.26.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 12:46:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:46:24 -0700
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
Subject: Re: [PATCH v4 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <202008261245.245E36654@keescook>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813153254.93731-3-sgarzare@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:32:53PM +0200, Stefano Garzarella wrote:
> +/*
> + * io_uring_restriction->opcode values
> + */
> +enum {
> +	/* Allow an io_uring_register(2) opcode */
> +	IORING_RESTRICTION_REGISTER_OP,
> +
> +	/* Allow an sqe opcode */
> +	IORING_RESTRICTION_SQE_OP,
> +
> +	/* Allow sqe flags */
> +	IORING_RESTRICTION_SQE_FLAGS_ALLOWED,
> +
> +	/* Require sqe flags (these flags must be set on each submission) */
> +	IORING_RESTRICTION_SQE_FLAGS_REQUIRED,
> +
> +	IORING_RESTRICTION_LAST
> +};

Same thought on enum literals, but otherwise, looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
