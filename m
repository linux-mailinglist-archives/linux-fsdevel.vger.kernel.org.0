Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629A16A6763
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 06:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCAFiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 00:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAFiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:38:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E6113F5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 21:38:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kb15so12232540pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 21:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBlxtFh5BBKwPKPovq7gYLLJCbU77EmUd2AKQdAifag=;
        b=cnL/dqnqRktkB9mB4aoz5wUwMAKDnhbJ6l9Vk92Rl2RuVcRVA1y4Vw0HI8AXLcBFC3
         oTPXHCv4f7YHoimiV+X7rblkgS73h7a1gOq0/7j15jKxO07aQp3IvEq0/mn3GWWGkSjk
         AXUxFyU9Mn5Axg79YrPJb16S73IppnLLuDdCBOEYjdSusZxER7Hw5LJCEpMYDKXrVBT7
         KfXi/jUzaChWUz0ipfnQIvnvgkMyt3tsc0XWWxvpRhz55vgNo8VfqFPlx7y1O5kfDIpf
         ej8iIEASLGzb3HDMeUnU2baeCRsIj9+43M4oa6PBoHMHdEIoWMN/0gxPEyaNt3teQhN/
         syOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBlxtFh5BBKwPKPovq7gYLLJCbU77EmUd2AKQdAifag=;
        b=lwSSHKaZEP91S2ZTn1uPcZD93eSRuslSW1szr9PkjLZ6Cpy9W7JfXGyVtSQim20MR2
         QM2Lf3Xn0ale2zqxDVfjqeQWgmx0TS/dGd8FfugtpqknYvipVxrPqIXPj0SC1+LUUG/N
         UuI4aIdWrVZyNcmkiR7cohdRaTmhJxrGaZqh1RrIAXjC96CuHDguVLXllLrbqDXbycQr
         NenH0JDbX0w/RxI5qGxGWmmIyU9Lnran4UonauCrspnsaBMD3GVs/8KcacOX1YMGeYjY
         9bdp0uIh4dZ+8DHbcxNQ0rOhKS5MiWCbUhvUC70rOAcE8EEYRiXJPpoMmahkVrGcSK2I
         zQiQ==
X-Gm-Message-State: AO0yUKXIP5Tl4BiL2GtVEwoSL8Bd15MSZyuVPu9y3/uWamUuxsrBsVcg
        FbzZ/LtiepPYBjdMNil9p/4lZt7/X9OhRFdx
X-Google-Smtp-Source: AK7set+PbTP/DpNq0+X7zRQq1TJUtpsmRxxtPfp3gjq9iFww/Fg/1KSSAZVnkcuATb9P6uzRlAfkhg==
X-Received: by 2002:a17:90b:4c4d:b0:232:f974:c532 with SMTP id np13-20020a17090b4c4d00b00232f974c532mr6279290pjb.19.1677649097520;
        Tue, 28 Feb 2023 21:38:17 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a3e4200b00230befd3b2csm8982894pjm.6.2023.02.28.21.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 21:38:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pXF9w-003PaZ-Aw; Wed, 01 Mar 2023 16:37:48 +1100
Date:   Wed, 1 Mar 2023 16:37:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem backporting to stable
Message-ID: <20230301053748.GL2825702@dread.disaster.area>
References: <CACzhbgSZUCn-az1e9uCh0+AO314+yq6MJTTbFt0Hj8SGCiaWjw@mail.gmail.com>
 <Y/6u5ylrN2OdJm0B@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/6u5ylrN2OdJm0B@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:48:23PM -0800, Darrick J. Wong wrote:
> Another knot that I think we need to slice through is the question of
> what to do when support for LTS kernels becomes sparse.  Case in point:
> 
> Oracle produces a kernel based on 5.4 and 5.15.  We're not going to
> introduce one based on 5.10.  If Amir stops supporting 5.10, what do we
> do about 5.4?  If a bugfix appears that needs to be applied to 5.4-6.1,
> Greg will not let Chandan backport it to 5.4 until Chandan either takes
> responsibility for 5.10, or tricks someone else into do it.

And this is soon going to become a much bigger problem with 6.1-lts
in the near future will start gating fixes flowing back to 5.15,
5.10 and 5.4....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
