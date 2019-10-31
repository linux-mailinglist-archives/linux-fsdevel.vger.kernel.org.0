Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FEEA9C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 04:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfJaDsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 23:48:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJaDsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:48:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id c7so3245446pfo.12;
        Wed, 30 Oct 2019 20:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p2PeV58d4yctU+jAVSTHiC69cEMtADehYCoieHlRJZE=;
        b=eDg5UPzYS099qljAxt+kAgzZCmV3uWjnLZn1xy2q/vPRpf7n+zS0v5/ZJaI61BAv2x
         sWqSBOtwqIuRexlJErOjuk7Xt/wMj90TfumKStFM3kZIeyYCBTTbpH0GPhbIOgopJjFC
         FGfZeaL0BphssufGilTvVfDtRAeUmWbMnjFnjTE0bTXbOSNBeAMNjI8zJvLGs6GIoXaR
         1AQPM2HaskvPQdv6oJiumCUYFE5A3mKYvyDhfPdc84zjbQw8TYvBCTHVm8EXbRMmCuYX
         8MHVhZt+zRcVblYqz02LQX5J/3KzMMnoa2+q4vMGIv1E2qn9bWOSb6fOY3KhAG7JH5Vt
         /2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p2PeV58d4yctU+jAVSTHiC69cEMtADehYCoieHlRJZE=;
        b=b3FsN6eOhW0+DmmNiGqSnz38mSYyJEyga6BxHzhIhOCjF5YZkj6RV6lD5/yks7p8sU
         vjHMA+4f//9LQgwfKeMZBKFfNDb6rdlrDTEPYv23NEqYFDHW7jG+iCkLMskxiCDhNoe3
         ZXMf9+bGchlTrxBm8W6xLBKaPA3YxaVaArji3cRsR0ooQp3P6Q4Ay8ddl34mzK9Kpo+Q
         9brwfBV0jxtgvy4WnlSUd4bhbA9G3oz14V6hUaZv8h0gn8Ak6peiEoGxcUWw0okhIoQV
         84fmYuMr4APaakDRYZmbT7/TAycJaPLfyPfQ37htl5vQ1zOTDgL2ejNiIQ7vdbEfjDMV
         dcuw==
X-Gm-Message-State: APjAAAWm3gMQ8Lybqk2Y7xVqL5Lv/5rWtV7Y1WFHAKaAzsQhgk0ueuuP
        mHx4ufdeKkskJ4bVq9fzXh2kRZg=
X-Google-Smtp-Source: APXvYqxlk03vdtAdBkTuOEUe0INg64+OpyIjKjXpLMXKzfaVg0PFXLhvP2Xq/5a1fNya+WCHE2lxcg==
X-Received: by 2002:a63:c405:: with SMTP id h5mr3653316pgd.60.1572493697798;
        Wed, 30 Oct 2019 20:48:17 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z18sm1316313pgv.90.2019.10.30.20.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 20:48:17 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:48:08 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/log: protect the logging content under xc_ctx_lock
Message-ID: <20191031034808.GA479@mypc>
References: <20191030133327.GA29340@mypc>
 <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
 <20191030164825.GJ15222@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030164825.GJ15222@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:48:25AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 30, 2019 at 09:37:11PM +0800, Pingfan Liu wrote:
> > xc_cil_lock is not enough to protect the integrity of a trans logging.
> > Taking the scenario:
> >   cpuA                                 cpuB                          cpuC
> > 
> >   xlog_cil_insert_format_items()
> > 
> >   spin_lock(&cil->xc_cil_lock)
> >   link transA's items to xc_cil,
> >      including item1
> >   spin_unlock(&cil->xc_cil_lock)
> >                                                                       xlog_cil_push() fetches transA's item under xc_cil_lock
> >                                        issue transB, modify item1
> >                                                                       xlog_write(), but now, item1 contains content from transB and we have a broken transA
> > 
> > Survive this race issue by putting under the protection of xc_ctx_lock.
> > Meanwhile the xc_cil_lock can be dropped as xc_ctx_lock does it against
> > xlog_cil_insert_items()
> 
> How did you trigger this race?  Is there a test case to reproduce, or
> did you figure this out via code inspection?
> 
Via code inspection. To hit this bug, the condition is hard to meet:
a broken transA is written to disk, then system encounters a failure before
transB is written. Only if this happens, the recovery will bring us to a
broken context.

Regards,
	Pingfan
