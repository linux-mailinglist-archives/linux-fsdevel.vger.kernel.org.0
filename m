Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16687248EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHRTqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRTqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:46:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CAC061343
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:46:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so15963pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ylBQHIGj+jC+wMGAW+WiPoCXXWUQK9WgH6fcVkJtSBg=;
        b=TRDwzjpv9nxBnOSNPospJ+g2+lM26x7LrfAWZDm2gvCsnlrIhyGQMvVZ+nN+hu7WkX
         O/oo+OEjbZ2O9PmpH/HltGohEtaT4mQAuhz2mTIFpqD9eXrS0bAzADnlvGV+CZhjlU6D
         56u72kcTdOBo0I+2qXN79Jwyll3yLdhk3jnEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylBQHIGj+jC+wMGAW+WiPoCXXWUQK9WgH6fcVkJtSBg=;
        b=V5qNFBGr4V2AggeyqdWF3+MvDY2XurjXzJ5pJJsVsajjNemWUxftsSNgfgwI2dsJ3W
         vzraktPTMnvOZlEOzjXH1hi+J9bCXVAjRSvJ3Qv1pgT+qrQTKSG9XSk4HdbUxDEHX/XN
         sX3Wgm+4X6VDoNE0McO0YC+DIVWt3uOb3b1QeSxj9pQEgms2uRb7YWlQZNG2gUYvSgYB
         1gPMj5WHgIwzXajDRu7aSxOCZRMJ4fOW6B9P51A6fvWBInzBWfhzX7x/fTC/dpfC4BzE
         bCdbClXbLqWA8DAgMqqoJIC+kKpL9gyrU0KWW5yzP+pm9U+u6+UJA4iTA38byc/a1wUt
         KI0g==
X-Gm-Message-State: AOAM531qdtAN975n7kAx20IuJXtAnDILesrUA+7aUBZM73TjMklDjP0H
        Lyd7HL7M0qEHxeicH71rIA9a9Q==
X-Google-Smtp-Source: ABdhPJxQpoCNUK9oxMIJWJCcBhsLXV3qhwZ1vk6NlnSPUfnJzoewH/BG+Ra1OO11qvGzKQ2Um0GcDw==
X-Received: by 2002:a17:90b:148b:: with SMTP id js11mr1261981pjb.234.1597780003259;
        Tue, 18 Aug 2020 12:46:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5sm25754806pfg.80.2020.08.18.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:46:42 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:46:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/11] x86: remove address space overrides using set_fs()
Message-ID: <202008181246.A03BB9CEA@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-10-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:10AM +0200, Christoph Hellwig wrote:
> Stop providing the possibility to override the address space using
> set_fs() now that there is no need for that any more.  To properly
> handle the TASK_SIZE_MAX checking for 4 vs 5-level page tables on
> x86 a new alternative is introduced, which just like the one in
> entry_64.S has to use the hardcoded virtual address bits to escape
> the fact that TASK_SIZE_MAX isn't actually a constant when 5-level
> page tables are enabled.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Awesome. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
