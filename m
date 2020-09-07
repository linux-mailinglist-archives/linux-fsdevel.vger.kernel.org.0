Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274E225F99A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgIGLf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgIGLdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:33:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399EC061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 04:33:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so15692838ljg.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2020 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mGeUqCmbhz8+N0Ziop9W7/cr7Tt1+iU1uadkks0K72Y=;
        b=mO1cN1q2yJxoaXOdd0DtcHUop5S4k60brHvcorYieV0cP6Kj7m3NS9lza+a027+Q3w
         Zry2an5mQQxfa1/neu3WcVzxRnXSGXPUFDaN10Ztqq88RMDenSN/eBSrmG4uibqQ+18/
         VySEFTqt9cP3PmmfZKfCRNWGq0LvlnP3+5oTu20LmJcAH39DHYD/w4MmyFxKF+KFpsbL
         SBJXnjnsXlCKkgHkSk6op53pySfaNrvXrj9iX3vTH8u32kBkkBnH28uKLgTGqcMWkeuF
         ze526OIVQx6qtEH49VHlpXOPMI02l9fYL3YNoYBfUfHKyjEme4tX807Fi4hRszp+x8T7
         lI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mGeUqCmbhz8+N0Ziop9W7/cr7Tt1+iU1uadkks0K72Y=;
        b=RFraigrMvfKUWaYuCK3kcgtkM8fQOsVrzMRgFpo7dTBWRLr9i58YwxmJ3QKvhdagzh
         8gbC8NNm2bprDPdh4V5quAMdiKXfoxd/kwQE2yXClsHGz3P2ghxQRd8PBpdt7RnRNm85
         9wEnNhEkVIAnSngJOAeE0EeGIWgKtq/Mw+WHf0v/Oo+taJ5k9J4fHMBtDMYgR8GYQt2y
         E04nOoAlRWTzvIClvf2z0Iujy8dRQOzWKuIi/G+ZBdNGLNdaGrhVR/kLRGBl4/0vSQBN
         yr97Lm6ycr7PVOnIvhUIwEUjs1a+nRUTWdMUCBKXDYTsi3SBsXGWjanUYo61Ic7f/E3h
         7lAQ==
X-Gm-Message-State: AOAM532JPC3GSLvxapr7Z/4SJgenlBLAEIkyL3g8BRWDQ+ej8V+anRpP
        I4NjaB5Gw/7BFQUc3MAB0Apqw/kG1b5SDA==
X-Google-Smtp-Source: ABdhPJze8x2PoNOG3NM1iD+Qty/W6bZfyVCXzo+9ShsKGqDLMcJmIKhuHS9SkrU3fYqor4vIpsdudw==
X-Received: by 2002:a2e:9212:: with SMTP id k18mr5106728ljg.241.1599478401181;
        Mon, 07 Sep 2020 04:33:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a192sm7280981lfd.51.2020.09.07.04.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:33:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 50E221034AA; Mon,  7 Sep 2020 14:33:24 +0300 (+03)
Date:   Mon, 7 Sep 2020 14:33:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        david@fromorbit.com, yukuai3@huawei.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Splitting an iomap_page
Message-ID: <20200907113324.2uixo4u5elveoysf@box>
References: <20200821144021.GV17456@casper.infradead.org>
 <20200904033724.GH14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904033724.GH14765@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:37:24AM +0100, Matthew Wilcox wrote:
> Kirill, do I have the handling of split_huge_page() failure correct?
> It seems reasonable to me -- unlock the page and drop the reference,
> hoping that somebody else will not have a reference to the page by the
> next time we try to split it.  Or they will split it for us.  There's a
> livelock opportunity here, but I'm not sure it's worse than the one in
> a holepunch scenario.

The worst case scenario is when the page is referenced (directly or
indirectly) by the caller. It this case we would end up with endless loop.
I'm not sure how we can guarantee that this will never happen.

Maybe it's safer to return -EINTR if the split is failed and let the
syscall (or whatever codepath brings us here) to be restarted from the
scratch? Yes, it's abuse of -EINTR, but should be fine.

-- 
 Kirill A. Shutemov
