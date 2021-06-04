Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0115039C3EC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 01:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhFDXd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 19:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFDXd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:33:27 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD3C061766;
        Fri,  4 Jun 2021 16:31:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t20so8285378qtx.8;
        Fri, 04 Jun 2021 16:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PBin/z5hDFW5Ve3aQTiLIRlzSaeQ8qcQu0zCFdQd6Xk=;
        b=dcMTWnaxBb8HqPgSlERDybmkGVPSERJa5XsZkRkOJKVXEv7XdwyKi3DzPZpyNf40Xo
         quGAkBPx8ZVc/3Bcx+BMyWV9rZJFbs2z/GavWxo2d+THJ78dWVz4nv7KMA/0qgPFYI2P
         dcMn3Lan262LT0207JXa8/U5/tKFy+lFDCb1KwTiFE+sAaWrgHMCHETBkmjJAjOxGQxG
         M5giSsIIVthqiY9y4C/sdi3JoPcugXqpLjEblEM7GCVbADPvNplLK31nWXTs7dN692vV
         mKsjabRpe9KFGbw6Sf+FjBv61ldBmvMN89MN3rxr0vRNv2mDrtahiVuwUAEYQ9RskaB3
         ATiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PBin/z5hDFW5Ve3aQTiLIRlzSaeQ8qcQu0zCFdQd6Xk=;
        b=mV49LB3qyHhejVOreyUJcGY1agIgcNSP9VOrJFlyBDQWAlPdjWN7BhlGKjkhXle+Un
         wEQ1HPB91kBmBg5AEuNRRFV0otLS+8xIW1eOrsERq4+76C6SW9xSbGQUls4nr452XW2o
         n1SRgUANWAsNWc4e2P6+S9ynayFmyd75F/QAXK9BWUk3SlQdOpUyugJZsKyKg18Agymw
         XVA09ttY/GP+TGYWCrWVSG3vl5h2ewdbw6yxv7aNwXBce2Qbi8H9paM5MY2GiE+HpBbQ
         a5Alf6N6rNlJ5pUwtuKIZ03JWm2tvd0McI4Zv9bweVf/oBZ9gmrxFbG2DGiy9RBd0zcz
         YGQw==
X-Gm-Message-State: AOAM530jf3X4gFUYInVJRXuwCaAfzdEDai5skOZN2vAzy3c4JRzFLdt9
        7SoKH+Mb28cb0JhXWwhkXe0XghFjza22VA==
X-Google-Smtp-Source: ABdhPJwLzcLKnmeK6XHbRK8vPlXURJGXvfE1X2WfrGfnVyW8141trKgAjOXLo81aKfbaRBnPaCoQTA==
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr6836726qtq.265.1622849487309;
        Fri, 04 Jun 2021 16:31:27 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id g5sm1904915qth.39.2021.06.04.16.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 16:31:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 19:31:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 0/6] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <YLq3zb4saO9AMYCi@slm.duckdns.org>
References: <20210604013159.3126180-1-guro@fb.com>
 <YLpMXmWvPsIK97ZE@slm.duckdns.org>
 <YLqoJn/FmyqjQs0M@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLqoJn/FmyqjQs0M@carbon.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Fri, Jun 04, 2021 at 03:24:38PM -0700, Roman Gushchin wrote:
> I agree that switching to the nearest ancestor makes sense. If I remember
> correctly, I was doing this in v1 (or at least planned to do), but then
> switched to zeroing the pointer and then to bdi's wb.
>
> I fixed it in v8 and pushed it here: https://github.com/rgushchin/linux/tree/cgwb.8 .
> I'll wait a bit for Jan's and others feedback and will post v8 on Monday.
> Hopefully, it will be the final version.

Sounds great.

> Btw, how are such patches usually routed? Through Jens's tree?

I think the past writeback patches went through -mm.

Thanks.

-- 
tejun
