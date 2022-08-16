Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1E5961FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiHPSHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiHPSHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:07:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104085A84
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:07:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so7918192otd.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=d0m60EF3//eKo2IN5iUoxeKt55+ftv5e0TstrzQ8KGk=;
        b=eCRFJaRCwO+OHD0MqvYU8x607Fp5hOx3w01AdYygfBuU6jBYRk/cjUI0cAZdiMrv1T
         t/qB5AR+hwxGFsFKTlhlbvJZj7LExgV4xH8eLkcinhfipdKSHNZ7dxwfoVn/QQbkn5EF
         +qRG91rBlXCMVphP8xqWv6e3goxQ9gCTtUNWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=d0m60EF3//eKo2IN5iUoxeKt55+ftv5e0TstrzQ8KGk=;
        b=Oq7SxPwKWCATmBbpzSmB8hdZEig1iSYZ0JczEzJVpwPNP/uHW/ENhlndsretIkRM06
         Ko8B4fZtcXcp6lHbi7W9UGJ0txlVoaAdhH3D3r4Wf6mNdFxL0+G06mH2W2g915AfNVkw
         HWeq4THMPm4gazy/HFlcXNY1M7m2Igx4P/yuBV8SuUZwN/VyIyH8RmD+oDihJiaPrx/R
         vmA3VWnSxNpnEJdzxrIOp57vHx/EF+ZNXFJyvr1WeWoHdc9e2ZOh/dcViUZkQnbiAgI5
         zGjSQqr30D9XpOsq4e7MmArBNkpJy2HYElR2I4TYT1fA2DXh9i/UGVWuWvvJq1uBLJfz
         UpKA==
X-Gm-Message-State: ACgBeo0IYagpbr5saq4/R+ju+XHkd8tP2S5ESygLGqxYBDUegkwo8otF
        MOmZpOLrO+cp5ccHktYuV+NZdc08IylOLg==
X-Google-Smtp-Source: AA6agR7nqWPUhTza3GdkAEq7XZMBlfCbwBKbDD8RNqbqcUNgF3B+R1i72u87BwJIPYWzuS2Dd6RydA==
X-Received: by 2002:a9d:284:0:b0:61d:13ea:ce21 with SMTP id 4-20020a9d0284000000b0061d13eace21mr8545564otl.317.1660673238599;
        Tue, 16 Aug 2022 11:07:18 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:aba6:cb35:e58f:e338])
        by smtp.gmail.com with ESMTPSA id m24-20020a4ae3d8000000b00425678b9c4bsm2503970oov.0.2022.08.16.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:18 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:07:17 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: require CAP_SYS_ADMIN in target namespace for
 idmapped mounts
Message-ID: <Yvvc1V07auH4icgv@do-x1extreme>
References: <20220816164752.2595240-1-sforshee@digitalocean.com>
 <20220816170751.wdpzqff345voonyq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816170751.wdpzqff345voonyq@wittgenstein>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:07:51PM +0200, Christian Brauner wrote:
> On Tue, Aug 16, 2022 at 11:47:52AM -0500, Seth Forshee wrote:
> > Idmapped mounts should not allow a user to map file ownsership into a
> > range of ids which is not under the control of that user. However, we
> > currently don't check whether the mounter is privileged wrt to the
> > target user namespace.
> > 
> > Currently no FS_USERNS_MOUNT filesystems support idmapped mounts, thus
> > this is not a problem as only CAP_SYS_ADMIN in init_user_ns is allowed
> > to set up idmapped mounts. But this could change in the future, so add a
> > check to refuse to create idmapped mounts when the mounter does not have
> > CAP_SYS_ADMIN in the target user namespace.
> > 
> > Fixes: bd303368b776 ("fs: support mapped mounts of mapped filesystems")
> > Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
> > ---
> 
> Fwiw, I think we can probably move the check into build_mount_idmapped()
> right before we setup kattr->mnt_userns so we don't end up calling this
> multiple times for each mount. But no need to resend for this. I can
> move this. In general that seems like a good idea and good future
> proofing,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

That makes sense. Thanks!
