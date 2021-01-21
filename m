Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9B2FF639
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 21:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbhAUUpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 15:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbhAUUpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:45:02 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F782C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:44:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c1so2620643qtc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJ5PGzGmiLLUrzTi1u+PWslzt/cE4FGIGC3QTg4GyNU=;
        b=XEexdU25vzlHX3yTNVNzHMDCFhMAUHi0vHqq4srg310OpkDzUMqIMQosp76W9eriKq
         K9WdGHf0i2fo+5ydgoMD1zCkBRDxshw/C96HIx0vh+MJqsiXANwLVeIuvxdCC2kGGRbh
         LCUle2LeLtQzg/wP3aqbFAjL+rGOZ5XSjZPMhEJg7THs81mGHvzOAnUTwaDnOoGvKUfD
         S8SxZwBjwPxb6qcZN5TVWQwm3zeRVRyq/Z6mYQSWvIwUdgGaPrLhNKZAE4+RXiX27EZV
         AaPhYYUB23m+NhNaDvZc3ioHaW7WlGjKCjapKaKC8H5kAGk5+RS3+oW1ZhG+1+Irihyi
         M+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJ5PGzGmiLLUrzTi1u+PWslzt/cE4FGIGC3QTg4GyNU=;
        b=pVqHmIqPWU7idJx5AW4iOhVXmdM20GjUEg03K7SpS/rCioXjbIocmS4Gr5sTQu/oRT
         d096/4sKccRe/HunoBFLxcdE953qru9BD7grttgHYx5XNYTIyk1GDWN1xNTqs0x9ZBHO
         /dQwZluVxpPDfedDu13zQF9lb1MTJ+A1PRTmAi3gxr/flSqwyvJOkxJao2GSPIFibrck
         qRR/535cE11BHRTnrygiEGYoM7mdYpTB04C41SJTYVI/rt3mKtyIRrIyhq7vxChsVMhL
         1AYBhlD8vDjTE1pvyGdUuzSqVty4N1JQmPWxW9oOI4uxtC6M1u+fxJnb2ocBg7Iwlt7F
         GXXw==
X-Gm-Message-State: AOAM533uMMrLGGleyXQRPcWCmb8K8I4X7tf5fmQIS2UTnXqcrVw9Urg7
        K4aHUZRXmam6gMJV1D7ZN5Hp/w==
X-Google-Smtp-Source: ABdhPJzJp8jl31mPFjPI2gRRVkFEDO5aKL9LMCYtxQ+I4Cn4WNfvBbp1XuW8P/En/rtFBsqUQr0fig==
X-Received: by 2002:ac8:7b42:: with SMTP id m2mr1435255qtu.304.1611261861619;
        Thu, 21 Jan 2021 12:44:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id i27sm4610509qkk.15.2021.01.21.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:44:20 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:44:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 2/4] mm: Stop accounting shadow entries
Message-ID: <YAnnoydGwtXwPMHL@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:18:47PM +0000, Matthew Wilcox (Oracle) wrote:
> We no longer need to keep track of how many shadow entries are
> present in a mapping.  This saves a few writes to the inode and
> memory barriers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
