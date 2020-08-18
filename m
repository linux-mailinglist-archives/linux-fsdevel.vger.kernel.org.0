Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6930248EDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHRTnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRTnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:43:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BFC061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:43:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so112504pje.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=07d8bMVK8nskANdMOYMjUqMmsVvTMTJi5HKNDrCq6hQ=;
        b=gNipVl2c+/nOxG5DyICzsidC3YlLij/C0CSl9peKhMSGPdUxsXnT2I6jx1kAORkjSM
         C4tUBV/kkenul4r6W7N5KQ16Bh0uIaoVMq7cUDJ6zjUKb+A1eOTZL2eQQRD/BSFPFViq
         XVn0GEFQYbcbug0N+pnDa6t3XX6fNZsvlwQbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=07d8bMVK8nskANdMOYMjUqMmsVvTMTJi5HKNDrCq6hQ=;
        b=XrSbNnAx45W4LAeNIHUQc02I+a7Wz8KfI4ZitWLYmtaqwa9N/i8iEzFiaGndCpqROJ
         tX58KuWEEz/qNcbBhfWiNbrG66Ubm5SJmEZ86rLQ74gQ0aIFZf5ubx5K7uLv+uNhMRbH
         yqermc56I3hjgAF74hxyyn+sSqot0IWA+P7U/q7X0RiPEW1Mx/uCISnx97m0FbR0Q4fU
         Q7nXExO9Qu/T3ox1SJJTvnhwvfK2vjPv5AlNGfQhnWu5a08OaaqZwgwKUrGahbfFnEhn
         2cCn9sKMQpyJ1jsFkiSZoTOEqUQgLPyd0IQ61P3ZWzg+JmN+U60ZV+17dtPgXXkK7DR+
         UmJg==
X-Gm-Message-State: AOAM530woZPIzu21A4R2yuEvuUYGSNP60jCtSfWOWiYrVVR4dBAtrBf3
        AldtspX+Gc0jlDFStOHMBXL6IA==
X-Google-Smtp-Source: ABdhPJy2gMhr8aECJvzZ3Ns6OMWEcvMDndJrwdoYkKTN1hLvIYEOowwCdxTiZwMiBrBTpO1TDIVE1g==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr1102634pjh.221.1597779829365;
        Tue, 18 Aug 2020 12:43:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm27334312pfr.207.2020.08.18.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:43:48 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:43:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/11] test_bitmap: skip user bitmap tests for
 !CONFIG_SET_FS
Message-ID: <202008181243.162DE4D@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-6-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:06AM +0200, Christoph Hellwig wrote:
> We can't run the tests for userspace bitmap parsing if set_fs() doesn't
> exist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
