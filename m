Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B99732526
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 04:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbjFPCT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 22:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbjFPCTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:19:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E842296A
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 19:19:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9e36e5ea8so2325781cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 19:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686881982; x=1689473982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHxDijhNKONt5ruwDIW5g/mmDYU1qwHie9r4lZ/B8p8=;
        b=hHwx34gDeH/y81xDRUltzHwFygdxquZp4Gd4iel8LmqI+VOE9FvXc5WVTOGgoOlvLw
         rDKKX5MpZtqpeZLOXSp8O64Zv1nbBBNzor8pynZM5yK0qPw13jWhijix61Fx+Uxngk3H
         WfjRH4m/CbTnBCCTI+FBUMGfnWt/DiPfNa6fDrwnjqiMHKeb8XB9/XJ6JJmv7gii181x
         N48vbDLtEA5y/9MgB/G9DnePKTiWxMAhxER69kRUI3jPS4tY7m+KE6CAe2wg9xP+A8cb
         ra7Y9rfi3foiNOdQgizZxY7EouWVua6aH0/VftAY9pqPOZRQVs/Pqa2Bp/hdDxrJD5Vw
         cHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686881982; x=1689473982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHxDijhNKONt5ruwDIW5g/mmDYU1qwHie9r4lZ/B8p8=;
        b=X/Dv2U67W8ISdiN5XAEDDakADqLFBx1v5rSBo/HfMvC4Wh3YCKSof84oNRZPhWLldd
         +CAZ57P/1k1IRna+Qc4JjN3x/7bupasev1gnt+GBShSiYhzyn2qUR3nvg1jPk9fhJdz2
         d+I3rrzumHV7kkPVjh7xIXnah9bSTz78bRBZxzqwjciDHZzrFLzQF4rja9AIn8/O2tCS
         LEXLQPZggLOAVlDBtPs8tbxqumOSYpnf4z5RVdz1vAUKKhzz0pvf690QMv8EPr2TQ3Y0
         Ak3thbuGkE1dQ1VrZRymWXSuNLM1tsFn2+86JR3pQRpn5d3r56MMhEDbZGjwsSotnJuT
         mV1g==
X-Gm-Message-State: AC+VfDzyBt0hKvIivlXzwUDIrMcoRWfcWo5Xawuvp6RALHdZgCPDu4nP
        IlwK9fxF+AKyANZs7HpilJiK0A==
X-Google-Smtp-Source: ACHHUZ7VzeSgr6uq5GPR9MvQjIAidnvdg2NG8W6n6A+X2xAOhLAlNW7dxIA8tCEYpeVaXDHpWlViDA==
X-Received: by 2002:ac8:4e4d:0:b0:3f0:a892:3c0e with SMTP id e13-20020ac84e4d000000b003f0a8923c0emr1010275qtw.47.1686881982277;
        Thu, 15 Jun 2023 19:19:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id x23-20020aa784d7000000b0063f0c9eadc7sm2805880pfn.200.2023.06.15.19.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 19:19:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9z3q-00CIkc-2u;
        Fri, 16 Jun 2023 12:19:38 +1000
Date:   Fri, 16 Jun 2023 12:19:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 3/3] fs: Drop wait_unfrozen wait queue
Message-ID: <ZIvGuiORFJuCK2xy@dread.disaster.area>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
 <168688012399.860947.1514236710068241356.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168688012399.860947.1514236710068241356.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:48:44PM -0700, Darrick J. Wong wrote:
> From: Jan Kara <jack@suse.cz>
> 
> wait_unfrozen waitqueue is used only in quota code to wait for
> filesystem to become unfrozen. In that place we can just use
> sb_start_write() - sb_end_write() pair to achieve the same. So just
> remove the waitqueue.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/quota/quota.c   |    5 +++--
>  fs/super.c         |    4 ----
>  include/linux/fs.h |    1 -
>  3 files changed, 3 insertions(+), 7 deletions(-)

Yup, nice simplification.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
