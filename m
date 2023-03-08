Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118396AFAFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 01:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCHATl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 19:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCHATi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:19:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279DE9662E
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 16:19:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so594276pjh.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678234772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrG09L05M9EBlQiWqOgywzhEQRS9MUPa7vpXQr9PyHM=;
        b=pnsOcbmzSNRTouMJ7mFkVXby9nI6vzDhuV4e504zpFlvKvOLzPBfIQKIydDHefiPBg
         B13Y6VRGScieH0V3MAAMDV2hIFjZKvSe3NqMv7osC/c68PWJ69s+y4K1jlx1Lc8Cjl5I
         WZ80XQBtu+cfR2HYyzfLIO4TfRB7uSPtzF7txMYeeXxvA+/O5VekzIMYP53f6LmPFNuZ
         qQNQyvpS651yHvYq+/ZfYmN+KYKVyrR5TokfJEwNpjgKLnUPqFaDT6VXOO8tAh2nFvgb
         E9cZdGlskeihL0FA0Q8gVXRr0pLizYKgkdzk/9Br1C/LZpeiq3m6whjncBtizwckAcV3
         Li2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrG09L05M9EBlQiWqOgywzhEQRS9MUPa7vpXQr9PyHM=;
        b=pcg/4e5AYi1tb9Cox7Mk7L3hBly5QZdztI8NCXzFqvxDtYe8uQMIBFXcCMOxatmiLV
         Vaa3Hi37UFpkMVTjri0o9JQzGEqTNZ4U3q99tBDeOLuU1GiRw327I8rXRmu24UVpeU/t
         HQh+aQbMkow+6iq0IkM4ImoCcXnQKzqUiN3OUy3C30cMg4u758jxCo0ErBX18DsYKKVa
         cpRO9EFFHuVuV9roH82y4R6wklNKQjs9O/KJ5qdQVt9SdcEqs1M1PAQ5I8v9QRbDfKbA
         /i6ibcpDwLcLGvgmN2jztj3gXjB6zN6IAHLFThp5pUa8DNd3Gr3ZPXCgSsnZMyOnROOZ
         MlTA==
X-Gm-Message-State: AO0yUKUgBJqJiNxd4U4dJNt0zRdYVEg3QPQV1THfZxoKnIX1/xEd/bcS
        svTGoGs1lW8sji5mtEqFKngtp/TfS/mzXbb9czI=
X-Google-Smtp-Source: AK7set8Lu+zS7nBY2Dd7OUlaPC8qY/Sbp6zZOOVpKYkUcFEg2LArcK6BBsqEGTfJqx/RfCowUmE+3g==
X-Received: by 2002:a17:903:41c3:b0:19c:e449:bbaa with SMTP id u3-20020a17090341c300b0019ce449bbaamr19656084ple.28.1678234772595;
        Tue, 07 Mar 2023 16:19:32 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b0019906c4c9dcsm8879507plh.98.2023.03.07.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:19:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pZhWj-0065Ra-AC; Wed, 08 Mar 2023 11:19:29 +1100
Date:   Wed, 8 Mar 2023 11:19:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org
Subject: Re: [PATCHSET for-next 0/2] Make pipe honor IOCB_NOWAIT
Message-ID: <20230308001929.GS2825702@dread.disaster.area>
References: <20230307154533.11164-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307154533.11164-1-axboe@kernel.dk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 08:45:31AM -0700, Jens Axboe wrote:
> Hi,
> 
> File types that implement read_iter/write_iter should check for
> IOCB_NOWAIT

Since when? If so, what's the point of setting FMODE_NOWAIT when the
struct file is opened to indicate the file has comprehensive
IOCB_NOWAIT support in the underlying IO path?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
