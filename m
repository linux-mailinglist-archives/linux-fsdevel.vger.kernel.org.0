Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EDA77FB15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353290AbjHQPoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353315AbjHQPoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:44:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436530D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:44:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bd0a0a6766so5506a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692287082; x=1692891882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOXN+Y289hCGSaT2rNyDPaBI6ZKa1H8F70fxdrUid2c=;
        b=0AF5UoDN94Wz8RzQKFUWrCMiv6J8/uzadm+qLJE1+7eOnKUU5bAVKPoDZBIX7G2d6O
         Ii0Eg+EuRrhFQ3zBBfuHSMxMmrjrKzIZ1pU2yGZBu+829LfNGAV5PW7jOfIOXeLlyZBN
         /Hi26PzLcfrsdcDXeF56407H+d1BnV9SeehxIsrssb3q/oaZfrn9Lp/k5v59AaiUd15n
         ZFV08mMiXnzJ4SPp2N5hgtkT166Dw/CLBAV54FdgxCd5TZWpibpTBEFRWtxXucYO8P9J
         vfz4VeA/oUIO6bEDBaFFo06JS8ET5e3u69xSStNls9R8NZ/NCSyYc9/hIXtr1A6ynUME
         4nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287082; x=1692891882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOXN+Y289hCGSaT2rNyDPaBI6ZKa1H8F70fxdrUid2c=;
        b=PnhBqtotlPnDxBUmhJOD2og9FXtvpWHmty1YX8l93m1ibw4bUetYvvqN7ZH2VpiSEY
         QBHEyjhov+L+JUCS2oGUAutjMaGEpmA560tRjmiFKjNm4zqkmbnAuk16/KmkFyfYy1S0
         3E6zNnLDamWt2a5LC+DmjQ8VtLIb0TAOiiV1vMeI/IUz/zjeQjzi1F0NJEqrzwX8ixc0
         GLmqMF8lbdSvCiOfR06dBGx7Lyap0JBWAeFNXM7AXumAGllLDmWuD3K0VoCMHrk/ETcz
         46/foE0wu04pi0Vm+y5HuKnj215dVjL8DrOl4VnFzrttB7+dZk6nnLZ1m9/1YHumoqRx
         EW6w==
X-Gm-Message-State: AOJu0YwycDtqtieIpO64Tw8HxeYuODw4woZcBYCfxBsIbp5CRd88i+ZD
        na4GbGNBF9YuDXEw/yAXFck7hQ==
X-Google-Smtp-Source: AGHT+IFkHMgRMQ547CFusgPr7mqJDCT+fI+lspeX9w8wUIpDd9+iczu1doq1MMqAvHpLz1XHr8yh+g==
X-Received: by 2002:a05:6358:6f81:b0:134:d467:b751 with SMTP id s1-20020a0563586f8100b00134d467b751mr5344171rwn.21.1692287082505;
        Thu, 17 Aug 2023 08:44:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o16-20020a0dcc10000000b00577139f85dfsm751833ywd.22.2023.08.17.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:44:42 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:44:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH 3/3] btrfs: Add parameter to force devices behave as
 single-dev ones
Message-ID: <20230817154441.GC2934386@perftesting>
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-4-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803154453.1488248-4-gpiccoli@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:43:41PM -0300, Guilherme G. Piccoli wrote:
> Devices with the single-dev feature enabled in their superblock are
> allowed to be mounted regardless of their fsid being already present
> in the system - the goal of such feature is to have the device in a
> single mode with no advanced features, like RAID; it is a compat_ro
> feature present since kernel v6.5.
> 
> The thing is that such feature comes in the form of a superblock flag,
> so devices that doesn't have it set, can't use the feature of course.
> The Steam Deck console aims to have block-based updates in its
> RO rootfs, and given its A/B partition nature, both block devices are
> required to be the same for their hash to match, so it's not possible
> to compare two images if one has this feature set in the superblock,
> while the other has not. So if we end-up having two old images, we
> couldn't make use of the single-dev feature to mount both at same time,
> or if we set the flag in one of them to enable the feature, we break
> the block-based hash comparison.
> 
> We propose here a module parameter approach to allow forcing any given
> path (to a device holding a btrfs filesystem) behaving as a single-dev
> device. That would useful for cases like the Steam Deck one, or for
> debug purposes. If the filesystem already has the compat_ro flag set
> in its superblock, the parameter is no-op.
> 

Now this one I'm not a fan of.  For old file systems you can simply btrfstune
them to have your new flag.  Is there a reason why that wouldn't be an option?

If it is indeed required, which is a huge if, I'd rather this be accomplished a
mount option.  I have a strong dislike for new mount options, but I think that's
a cleaner way to accomplish this than a module option.  Thanks,

Josef
