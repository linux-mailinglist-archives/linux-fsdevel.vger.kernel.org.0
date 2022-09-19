Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF255BCBD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiISMa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiISMaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:30:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99740167CA;
        Mon, 19 Sep 2022 05:30:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f20so36559401edf.6;
        Mon, 19 Sep 2022 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sCPGjCblCxozW3fTqQ6tvR8NMyzYPs8zVXxVwmmZEGY=;
        b=qcJaSM0FVy1xQ4bUYi6j+61IoL91fS7rTNcrIt/+TiDPxYjiMITF7EPedl7PaPSGe6
         gpgbLhcaaqRIIyaN0FjU3Urgls8+a/XgteZOCWH64b9fd43i8YpiL2I8olc2p5Hsbhkk
         DfDGiWiOpBX1/66+h/gQQu/vYtVVyyeNBXAZdsj10tDctPo1asRcAcE0t9kZE7Dcl+Va
         kAdWFyTUSbYikT+qRTUOwxWGzSCzO52LsYQEDc1rRfZvYbIWC2v8nrucEWKsw8z11VGq
         GK8+2qwIrDxo3oQglZVHRbcZ8/gj0ERTtHMprcA3tJbTp986nncU2LHdkXCR05VOPNII
         2ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sCPGjCblCxozW3fTqQ6tvR8NMyzYPs8zVXxVwmmZEGY=;
        b=RBZg2UOaoqHSh7n9uibNq6/2V0XwJjnlBDaXIBk3w7Yw98EIpBpAL0ZCO74XfvdZOx
         OMvjhiyiJ5P+NqdYupSO1XH++6xqayM7j+0MK1k2gE9LU3YwK4TSbwc8k63XSkoooyaY
         MXP6i51FyMGSRBORRP+vDgZ6OehXusW4UH54nH6pILAtHGmUV/QtLr5JNUUHE5Cl//t2
         J+bXahYOJudrsM8SqrjR5s1D89RgeOu5uY6DBZPqJNyvC+xJjDLDoWPcEr85/STXfp5H
         fR2ED32YJZVQ4Yjmv3or6aOWgIEYBG6CiAIzX142SpshrPcaCbfIVrxuo2QVG4Pz3JOy
         wZvQ==
X-Gm-Message-State: ACrzQf13pai9VRaCKdD4pVcYOxwq8ufv0wRWUB2sdHP4oHi/vw6aoBEj
        S5dd7b36s+9yG92gy25FrA==
X-Google-Smtp-Source: AMsMyM5zGLCCc4WmVWGeGVpxFUDEtWV6q7CvqjikWwqu7EIAlv9chC5B750JHZkpM3JAW3TUMqkuIw==
X-Received: by 2002:aa7:cb83:0:b0:443:3f15:84fe with SMTP id r3-20020aa7cb83000000b004433f1584femr15590426edt.17.1663590623084;
        Mon, 19 Sep 2022 05:30:23 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.91])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0077a7c01f263sm15239758ejf.88.2022.09.19.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:30:22 -0700 (PDT)
Date:   Mon, 19 Sep 2022 15:30:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
Message-ID: <Yyhg3L3S0e3zvnP5@localhost.localdomain>
References: <20220916230853.49056-1-ivan@cloudflare.com>
 <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
 <YyV0AZ9+Zz4aopq4@localhost.localdomain>
 <CABWYdi1LX5n1DdL1B7s+=TVK=5JDMVyp91d3yRDA0_GW4Xy8wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABWYdi1LX5n1DdL1B7s+=TVK=5JDMVyp91d3yRDA0_GW4Xy8wg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 17, 2022 at 11:32:02AM -0700, Ivan Babrou wrote:
> > > > * Make fd count acces O(1) and expose it in /proc/pid/status
> >
> > This is doable, next to FDSize.
> 
> It feels like a better solution, but maybe I'm missing some context
> here. Let me know whether this is preferred.

I don't know. I'd put it in st_size as you did initially.
/proc/*/status should be slow.
