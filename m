Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D763CDEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 04:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiK3DlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 22:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiK3DlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:41:05 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB0C70DE7;
        Tue, 29 Nov 2022 19:41:05 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h10so11155801qvq.7;
        Tue, 29 Nov 2022 19:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoKwaxsoBTuq6caiMH51+e7OBBLm1ZQwP+caQE5Hz20=;
        b=MzAwN7oBWwvha7Zlwgs6liSVdb1KbBAyeKIDEaNZaOdDjbIgac4GcW5KTBGkjpQE3f
         pYo3whXLEgbbB47IomRI1kyqGdJ9zlDAzon5JQ2R3ZUAhcxgEHcp0ghwbPSV0BD1Nu+P
         Wb4c+WZi/9GaflpFa3xEeRR7nkwH7Z4NurCHByL55Ld/F/iOOJna/4u1D3OKhJf3hEsf
         zPlUcoIfCU937f9VtpNjbGzxVzwt7OzPi++BHenfPBrqLpgXr2F7mvZXM91ruNVE+mls
         rucFXZNSYawLiBUujtS+6CuSH0wvrCxLWhoU23zk/yLBxXTMJ4PbdY5eB1PjoqYtlD9B
         wQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoKwaxsoBTuq6caiMH51+e7OBBLm1ZQwP+caQE5Hz20=;
        b=TKuZJs20wfaF3o7kiAmVVubvBll2bq5TWrQ5XzXih9dIv4aEoJsVGMmDC3OQiS8Xww
         cvQ8DWCSmCGQcaNhvRO+4ulW3siC0sa9vPo0wM7FT/cnMcOB21qpub1WqwXJoKinWW6w
         Zh4PoVZWbPdujOYaS/Huh18M97bRngm1zw1xMSlB23cBH86Ffv/7hzK0tZcuE99WZzWE
         gpx+3tjTrbkVOEQD2xGVr+5rLfBRQ0sFmqtcxqNVhc8t+vQuyDKNTZtAhQXqMGw7SY2w
         OBIoJFG2QI0FIC0o4bu085gzLk2S1JMoUnOOBVmwwNmemCumoQlbgUCaCZP1tPZ2i4ga
         PRXg==
X-Gm-Message-State: ANoB5plhiL1AEHjIpeDEuxjwBaCksBqZRD+PiJ5jVPc9yEu44yB3+0k9
        zMTZzvA5cIfwhjf8fwQDFLdDOxz7pg==
X-Google-Smtp-Source: AA0mqf7tlkWerd5rkQoMPHDrUNDmPDiFf+gKXZLcaMuERvq8N5JAav7JnU5BULtTFecNTLUzycGrBw==
X-Received: by 2002:ad4:5291:0:b0:4c6:e1ba:b1c with SMTP id v17-20020ad45291000000b004c6e1ba0b1cmr25609989qvr.73.1669779664172;
        Tue, 29 Nov 2022 19:41:04 -0800 (PST)
Received: from bytedance ([130.44.212.155])
        by smtp.gmail.com with ESMTPSA id do33-20020a05620a2b2100b006cdd0939ffbsm209018qkb.86.2022.11.29.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:41:03 -0800 (PST)
Date:   Tue, 29 Nov 2022 19:40:59 -0800
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coredump: Use vmsplice_to_pipe() for pipes in
 dump_emit_page()
Message-ID: <20221130034059.GA2246@bytedance>
References: <20221029005147.2553-1-yepeilin.cs@gmail.com>
 <20221031210349.3346-1-yepeilin.cs@gmail.com>
 <Y3hfmYF6b5T35Xqi@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3hfmYF6b5T35Xqi@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 19, 2022 at 04:46:17AM +0000, Al Viro wrote:
> On Mon, Oct 31, 2022 at 02:03:49PM -0700, Peilin Ye wrote:
> 
> > +	n = vmsplice_to_pipe(file, &iter, 0);
> > +	if (n == -EBADF)
> > +		n = __kernel_write_iter(cprm->file, &iter, &pos);
> 
> Yuck.  If anything, I would rather put a flag into coredump_params
> and check it instead; this check for -EBADF is both unidiomatic and
> brittle.  Suppose someday somebody looks at vmsplice(2) and
> decides that it would make sense to lift the "is it a pipe" check
> into e.g. vmsplice_type().  There's no obvious reasons not to,
> unless one happens to know that coredump relies upon that check done
> in vmsplice_to_pipe().  It's asking for trouble several years down
> the road.
> 
> Make it explicit and independent from details of error checking
> in vmsplice(2).

Thanks for the review!  I was a bit hesitant about introducing a new
field to coredump_params for this optimization.  Will do it in v3.

Peilin Ye

