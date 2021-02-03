Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8430730E350
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 20:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhBCTcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBCTcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:32:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B3FC0613D6;
        Wed,  3 Feb 2021 11:32:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v24so848565lfr.7;
        Wed, 03 Feb 2021 11:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tcLZknCefIdroLnvwaZu4BA8cKkKANxIH89d6baPmQU=;
        b=KqrMrj7EbDc5JQQ8mfnTpsd7o6+bi6L3ZQtKF2kLlEw3S1GICznZFnGdtJOQBP2Uco
         Ks3hwsLM8JmQs4TJzBE/ar/ueC8bhEnzly25SH8iLnlBr8CI+wOkeY10fPOMccqU8kG+
         YK1EBHKxaceT+WcbiSq2S1MKVfw8O/W9kPVx87vlVr1r4TlSvSa6IoVREPPntmp3EcPi
         +MHveAbdqCAvWDl5BjVixnUykJ87z5citpPoMvUy7pJzo8p0Te3cE7NY8GRBHMB+65pK
         IuuMPquQDv6ys8CZZQmMr6hr7UP6pmUCRRzco1Z9sl8ks88TBxMXnIg7U95JPPfYhDGo
         NaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcLZknCefIdroLnvwaZu4BA8cKkKANxIH89d6baPmQU=;
        b=kdjL/0g3B1rhjWw6/Id8oPRedfRV0uLV+jfIq5HtUcPC4iED95dHiR/RMmcC8fRF9q
         LzDuqcoCQFYp4vSdGNQ2LvpHTT6ijlolXU7VF3kk0Uss+APdKSoBAeUHjOAaOpgxUMJl
         fTjrax5xiA/bXCORBhlptZ3KJNEmsux1UnLL31ZCcG79809I7yDQwiNOT+zgR7qYjIGk
         wJ1TJ+R77PNGXsyXRcM43iJgg/S0bRntU4NZNdCZo8NNfHXvVLem6oTjYR3mohTegOVU
         62X62QRFDN+niNrJsmS7IkX17Ul3gAwYReVF8lqwkKFa3xHJrDRK1Z5Dt9VOKgWioJNL
         q9Gw==
X-Gm-Message-State: AOAM5316B8T+WRaXQw9xI+id3KA2QeZagdh/KDFHJG8nN+as/ZDRLWMV
        r2pmmQhYdnbcMQyWMYoVgic=
X-Google-Smtp-Source: ABdhPJwiYWGj38qtddXaIiGsYvx1xPDYihRPJHwBvM44yGxFuSwgoGfoEzlG6F9wqambmBJ4n4FFfQ==
X-Received: by 2002:a19:22cb:: with SMTP id i194mr2616917lfi.25.1612380723483;
        Wed, 03 Feb 2021 11:32:03 -0800 (PST)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q190sm348257ljb.8.2021.02.03.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:32:02 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 77B8F560088; Wed,  3 Feb 2021 22:32:01 +0300 (MSK)
Date:   Wed, 3 Feb 2021 22:32:01 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
Message-ID: <20210203193201.GD2172@grain>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:41:56PM +0300, Pavel Tikhomirov wrote:
> Currently there is no way to differentiate the file with alive owner
> from the file with dead owner but pid of the owner reused. That's why
> CRIU can't actually know if it needs to restore file owner or not,
> because if it restores owner but actual owner was dead, this can
> introduce unexpected signals to the "false"-owner (which reused the
> pid).

Hi! Thanks for the patch. You know I manage to forget the fowner internals.
Could you please enlighten me -- when owner is set with some pid we do

f_setown_ex
  __f_setown
    f_modown
      filp->f_owner.pid = get_pid(pid);

Thus pid get refcount incremented. Then the owner exits but refcounter
should be still up and running and pid should not be reused, no? Or
I miss something obvious?

The patch itself looks ok on a first glance.
