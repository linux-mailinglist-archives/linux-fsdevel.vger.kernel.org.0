Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AD248EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHRTeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRTeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:34:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D53C061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:34:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so6828pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tc2Y/7wRUGR7GO4HI5D5o1JOg/02jGLqqiMyiLuhQfs=;
        b=l2ujWwd6BMG71uJ+lE/u8hWi1z2UCA7KAWMpdnE1WzCwTe07wkyg50hoJQMVi/k5vS
         10b1jlIwnAAB1jWtkPfeKBvqJMoyZBbScKD9sht7QrmX7W7SSdxi+jcaauUGkGBX0fzB
         CHA2p5bBmBuY5K3LiVDClVPuHglS30NtSusnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tc2Y/7wRUGR7GO4HI5D5o1JOg/02jGLqqiMyiLuhQfs=;
        b=EVwGPmPVxT7fQ4gUwwKCmJTmro12MwbUW5ESgt8RRsrABieER02of+l38A3JBRuAi2
         BA+wy0rIMBzy+raNbDFjM0UrAvNBmOLLFtZFl9mHK7S3E/uY2AVt6J2ih6WB5D/MG1kV
         1manycJR8g7U3ctK/rPj3fF0s0U2Wx7MI3+ZDy98yRFLi7y3XKkOzvs/+SJP+nNeJFIL
         QDAlzd1ssp2vBW0iFzx7Aa3gNShGP03+SIlLaFzvJoAiLwKh8rM73zqtRy4jY/uO34zk
         sbfOSZrR8syZPyyoO7XRzvV/8UI5OoerYAl8fm/+EN1c/uOivzK2fbgKDrIS8BpaMTmI
         L6mg==
X-Gm-Message-State: AOAM531YVp+rDkxS++2frcI5Px688g2NtsOW7OApIDgqyrIWXxDGeH0H
        6QKlyyK4D/TFYYnxKLcb8ukc2g==
X-Google-Smtp-Source: ABdhPJyRtGUPEH8hQB3PYbEreefecpWhQ0b3Q4RWm7821VkslhtwepOtRIsUHn68CV2l8iU1xIwP+A==
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr16598513plq.158.1597779263268;
        Tue, 18 Aug 2020 12:34:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm22549273pgl.0.2020.08.18.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:34:22 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:34:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/11] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <202008181234.B1D9572C@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-3-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:03AM +0200, Christoph Hellwig wrote:
> Don't allow calling ->read or ->write with set_fs as a preparation for
> killing off set_fs.  All the instances that we use kernel_read/write on
> are using the iter ops already.
> 
> If a file has both the regular ->read/->write methods and the iter
> variants those could have different semantics for messed up enough
> drivers.  Also fails the kernel access to them in that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
