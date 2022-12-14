Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CA64C187
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 01:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiLNAxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 19:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiLNAxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:53:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA02035B
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 16:53:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s7so1722560plk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 16:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FPkAv72GYYparyOjopC4+0TyiONk3xjxwzE/01pbQw=;
        b=xcLF+nYK5jvQlV8/BNLBVSVxdyf+dQlZPWF9D1ueXEfpI6r76ImwZPCVWJef3joDZO
         IV4pusV0rpl1j/Bqvt1NMYqVAUo/Vl+F6W1i5bCgXw0lnp0ycVBjIfiH5PK66eQsuEfv
         fxjnn1/TFfpPC9GZ287CMc4KzkvDaYhP9gz0FHxW36aRjJw0syK0yTk8+Vb0BZnPNbJj
         TVl+hndk1fZuw+mK9GlkjOEHsyDQS0MmpijeRzNfD22khR0POP8gqwm0iSNp13gDY08f
         J9yfIBSC/Xn8KaVkDNBow9bjJI/ypkrNtG/yBLGVa1LbujVA7VHFD55CrxQgO2mIecEU
         vj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FPkAv72GYYparyOjopC4+0TyiONk3xjxwzE/01pbQw=;
        b=Uom+1Uu34xBILUkotl6ePEadPWtgMLDQIOx6inFXH3WzrbPBkhXA6ZaVn679QH0l51
         Ncy5iGx24EBsCTbvrLZ6h16z20WFtmu+wU65/ebdpLITlZVgRkf+yUS3L6yxeKZ580Rn
         LMbFWxvQySqyagVJ/zjOAeur67UNsOYALRix022NGfl3Q3TQp9MjsefZ3ltVHw3rzAVM
         kEK7rSSKWrqSnHv9ZQ9OB5t4HpKvoIdC/g2OGVzabToIh3CxNgHg66oNsET5Qocl6JgJ
         ahzczUafsPgH1APpqJSPAw2gbD2m0CzC1mlRHUVlHTuZxDI5IGLbUPwN5HjTI8hq3rZD
         L5yw==
X-Gm-Message-State: ANoB5pmCpok47ky8CjLOV/m84ZuRkE4ACSFdpyQvJjxzb4956RRpxza/
        tIbi6wRB4Xs0uX2TfkzgNaT04Q==
X-Google-Smtp-Source: AA0mqf5BbaixKSd/wkuwLlznlJvzmAnqWjKT5bPkY326ZcTQF/FFoDINZHMs8V9tKIrF+2fxLNy+yg==
X-Received: by 2002:a17:903:40ce:b0:189:c83f:d5 with SMTP id t14-20020a17090340ce00b00189c83f00d5mr24619081pld.52.1670979225273;
        Tue, 13 Dec 2022 16:53:45 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709027e4f00b0018b61ecf36fsm441258pln.287.2022.12.13.16.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 16:53:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5G1m-0089IT-Au; Wed, 14 Dec 2022 11:53:42 +1100
Date:   Wed, 14 Dec 2022 11:53:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] xfs: enable large folios in xfs_setup_inode()
Message-ID: <20221214005342.GB3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-2-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-2-aalbersh@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:25PM +0100, Andrey Albershteyn wrote:
> This is more appropriate place to set large folios flag as other
> mapping's flags are set here. This will also allow to conditionally
> enable large folios based on inode's diflags (e.g. fs-verity).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_icache.c | 2 --
>  fs/xfs/xfs_iops.c   | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)

LGTM.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
