Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9134DA89A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353335AbiCPCuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353331AbiCPCuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:50:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F8513FBD
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:48:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z16so2004099pfh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c0M/K+1eFLxLow4mbMiKmCtwBH2b7Lm5/YgoYLc2Jig=;
        b=ccnR7riMJqNwgZKJTM2DdghxvC0pBG+VaqFAgWWSVY3XbJo1wzpiYHpMGXq6otq1N5
         iV8gtOwV9NKjqsLy/hqESzwgOkqPUwSvvHuU1SEZFxe1rNeyGRIg+UIJQLfaOLdcICtO
         tv3bmG2kU2UvPdFt56vzYO6xr5RC+UdbajNEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0M/K+1eFLxLow4mbMiKmCtwBH2b7Lm5/YgoYLc2Jig=;
        b=uOcrNu6FVprz+Uh1tC7+dHEqApb/cZCmRu9QOp6UgPy4eNZeBAxdrCjFJPWLjX10sZ
         3r5gXSZJgyM4I8j+DdlJvyKEos5DSXXcHtJGfJtvs3dWtmVhG5wtR+8p1k7CO68sjP2F
         v+yHSaSJt5zVfWcbRaE22M4k1YuT2UqyiO8nx7va0Y43r0RyDrjRwATQWKkHdyQ7ksVR
         3OFZh1LuZjwVQnb5UKC4uSvbCJfwAFbCTC2AfLoK76nd4HfcmI1APKmcxU9veXra8X6r
         1Va1IftHQeNch9Jtfc2br5AFOoc5XZFpcpFyrPaJFkearGy903hjR6DbL0CC3AqQJNqh
         AVoQ==
X-Gm-Message-State: AOAM533mPI3dk45syhfW0Zc2z1w2fkDOPvOZnxjU/Ezw+gLJ3B/kXGrn
        CTeZaUIH/E77f1SqeP6SbZYEpQ==
X-Google-Smtp-Source: ABdhPJzVMfVBFpio8c9aEyIZlnXkq8spdnH7j/vo6Y0rcslj0Xy3iCQRbPgKW1yb2pCz+OY5DqegAg==
X-Received: by 2002:a05:6a00:1350:b0:4f7:8c4f:cfca with SMTP id k16-20020a056a00135000b004f78c4fcfcamr24609313pfu.45.1647398933483;
        Tue, 15 Mar 2022 19:48:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3-20020a056a00168300b004f7e60da26csm503648pfc.182.2022.03.15.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:48:53 -0700 (PDT)
Date:   Tue, 15 Mar 2022 19:48:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Message-ID: <202203151948.E5076F4BB@keescook>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
 <20220315201706.7576-2-rick.p.edgecombe@intel.com>
 <202203151340.7447F75BDC@keescook>
 <fe7ce2ae1011b240e3a6ee8b0425ff3e2c675b6d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7ce2ae1011b240e3a6ee8b0425ff3e2c675b6d.camel@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:53:13PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-03-15 at 13:41 -0700, Kees Cook wrote:
> > Have you verified there's no binary difference in machine code
> > output?
> 
> There actually was a different in the binaries. I investigated a bit,
> and it seemed at least part of it was due to the line numbers changing
> the WARN_ON()s. But otherwise, I assumed some compiler optimization
> must have been bumped.

Right, you can ignore all the debugging line number changes.
"diffoscope" should help see the difference by section. As long as the
actual object code isn't changing, you should be good.

-- 
Kees Cook
