Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB1758C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 06:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjGSEIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 00:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSEIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:08:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DB186;
        Tue, 18 Jul 2023 21:08:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56fff21c2ebso66164867b3.3;
        Tue, 18 Jul 2023 21:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689739689; x=1692331689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSpR33MkMFVo0HDEbifHOHIAy9DSs04x6Yf0f9lEG7M=;
        b=jzKgMM/KTVIcRhePK7+HhcBBIv/hqF30YmMEQS7cPNgkBro8RADtI6PTrz89Lsoezl
         z0pJ5YSRl03Lp63r0AzeF8RBKclyKg723k2ea0nQOF402cRsRKI3WnPGVIYiftE08/cU
         vg+3Bd4fO6B2BQXXHzkTc3cVDaa3pBbbGQSnCCo6JJnA8epUrSRWai/7G4FnLFXqu/wH
         xpXCqcd24Ud/x7tFOtm1oZEDiIHbnLbWi6SRLz+rgkyA1GKThZkj5rRJ+7H7Ro8Epiht
         u1EKtcsB/xfrqfViEJeFQid4yNMQTJcnLhZnGjge3HMRFBlYEdVU8mT2lqj0ntLg4Dmw
         0esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689739689; x=1692331689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSpR33MkMFVo0HDEbifHOHIAy9DSs04x6Yf0f9lEG7M=;
        b=Ddga9/gkBGcwRhA+76m2XHB3F/blQF8zVvzMw/ipryKo3NadLkcOJ+GuEt8TxOYVKP
         ek2pGAiMUVCybZJ84jWLydeaLNLglT4j0CiCz47uGzC40c206LdnUyADrvW8KmqTgewl
         1aByMcj4tlkQFN80jILTgFtU3qHPNSQAGNfNuFD313RRsExXJ/sd5enLfuWyj86I7IdW
         taj94cP7Cd9kyodU26Zww86gs41iYkirnEVdbmDuXLOB8P9Ka7n6AKnYJ0qXZ4+rN1/B
         4KOGrmVeObArMPXHpDnvoK4BNIM2VPzs2DzUWA3VlbpYGU4yZkvDyv2Fuc0dG20ElhCw
         EUtQ==
X-Gm-Message-State: ABy/qLY5Sd5TWXudV5fqp4C0i2iHkXAor8+TIwE9Bt0ZBRZTkpgl0rYQ
        MG/HVsAaPR/TWiSyva+3GG0=
X-Google-Smtp-Source: APBJJlGvARg5Fhi/6CMrWWiAUB1EfTtlAM3RwOSFjdJfBmwQf0ikzp4wfIA8wpB4Dq5g8T18e08Dhg==
X-Received: by 2002:a0d:c341:0:b0:562:1060:f2c9 with SMTP id f62-20020a0dc341000000b005621060f2c9mr19548939ywd.13.1689739688797;
        Tue, 18 Jul 2023 21:08:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2-20020a0dda02000000b005619cfb1b88sm834317ywe.52.2023.07.18.21.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 21:08:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 21:08:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bill O'Donnell <billodo@redhat.com>
Cc:     Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLcOcr6N+Ty59rBD@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:13:06PM -0500, Bill O'Donnell wrote:
> On Tue, Jul 18, 2023 at 09:45:40PM +0000, Rob Barnes wrote:
> > emergency_sync forces a filesystem sync in emergency situations.
> > Export this function so it can be used by modules.
> > 
> > Signed-off-by: Rob Barnes <robbarnes@google.com>
> 
> Example of an emergency situation?

An example from existing code in
drivers/firmware/arm_scmi/scmi_power_control.c:

static inline void
scmi_request_forceful_transition(struct scmi_syspower_conf *sc)
{
        dev_dbg(sc->dev, "Serving forceful request:%d\n",
                sc->required_transition);

#ifndef MODULE
        emergency_sync();
#endif

Arguably emergency_sync() should also be called if the file is built
as module.

Either case, I think it would make sense to add an example to the commit
description.

Thanks,
Guenter
