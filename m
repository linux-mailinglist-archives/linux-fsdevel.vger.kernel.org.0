Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E5248EBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHRTd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgHRTd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:33:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA647C061343
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:33:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k18so10453004pfp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjCq1W/1ioetJhu5FHe+zUUPMY/5mkoypyjvkRYOOfI=;
        b=ZSp9xat0/L8E2JVKpikkiQOwo0KeBmvsVfi9JDqEgHeRPRqFmz600t++sn4j3SFFY3
         ndk5omuHlIeXZrNCWrkauqAodAEhIoDLZbD8a8lERELeNddkhRwwm/2YDnNCQrECafWm
         6jDrYIP1mV/4iOszVnpmhjBo268Q0ew3+tDbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjCq1W/1ioetJhu5FHe+zUUPMY/5mkoypyjvkRYOOfI=;
        b=QRS8zZIsJZ5s+fIDRjSemhRubhNZJ6TaF2AZEVgYzEwcuEB9l0kxqW0bgzUl+XRHNc
         FF6Uu4Ffbrb9TurgroSxBWZ+XvGNpC0XhHMvRfXHmdRtGSqkJ2zqQ8p+h33Ytgj2hXDj
         L3Sbke3YAXMsoa5iFc1PbnCvr18JBsx7VAFOMXCMgXEcbde4Q9+HOej3BdniFwcSi5xF
         a0pF8GpgKt6OzyJ9c0S9MY5VYypI0DrImbCLOtZecMODnhxzSHNZLACOxoLzAMoOAzf2
         ey+PXSijKVExC/oITZssIAql0zZhX8L3BT8XcJAPxajtT23rv7wvt7aDwH3xXmeMutS2
         El5w==
X-Gm-Message-State: AOAM5322umfCHvD2HXjDvC1ZzHbLyRJPNjLmehyG52VCFfG09hDoiBxe
        JY9e7OWwqP+gWbw5AmewAC96Y26s95OdQw==
X-Google-Smtp-Source: ABdhPJyzAIpq3Hy05Z4M9rRxg2PdfbbOqwxy85fIgRk/eDuHmAJ2FVfGWVokgW9E7diZdhjU8k0T+g==
X-Received: by 2002:a63:7707:: with SMTP id s7mr14086242pgc.407.1597779207531;
        Tue, 18 Aug 2020 12:33:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l8sm683551pjb.14.2020.08.18.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:33:26 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:33:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] mem: remove duplicate ops for /dev/zero and
 /dev/null
Message-ID: <202008181233.1506BFFD3F@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-2-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:02AM +0200, Christoph Hellwig wrote:
> There is no good reason to implement both the traditional ->read and
> ->write as well as the iter based ops.  So implement just the iter
> based ones.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
