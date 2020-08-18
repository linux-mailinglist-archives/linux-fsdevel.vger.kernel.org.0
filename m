Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9430248F5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 22:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHRUIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:08:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E95C061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so10259691pgh.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L5rgvljds/G/gY7M0g3ZdQCzMRXyD0pLsTTaDQidR0w=;
        b=GgEG9rX0CVa7+ePbq5nMU/CNYUi+2BFK3ShbA/WmzDeaqQmywgCc13epPFdB6FGzJj
         PvUunIk9PF/5CUEYbmg6f4sOwcmkbKu9OxYlJ6LaNwke2x+fD6sLSkFRzNClnnjeBX38
         8Rgdk2DtkxLnI2lh1JKe4qna0fjXUs9peD4gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5rgvljds/G/gY7M0g3ZdQCzMRXyD0pLsTTaDQidR0w=;
        b=d9uspvL9u5RVPE6KEm8d9t3Cfq7GOyvoDrZ38JftRlC+mZz0K8daSdHDBw5/JGEWCp
         8ny74nWsLbJnDfv7NKGnf63Mdbl9JIcoNJTEkMZItcO297QxFkDaky4njIFKIuDgdLFK
         b76BmWQmXNoUZNwZXigznlET8iS4p1Q5dLtD/dcaJ7vQB9gqrjHV9MEKkaBgtjDUr1xL
         rgF7WEL7YBLdAWmDcishEajFn4GroCqBkfMSUgQSjI+TsDVVy22hQSStRrwkZD0o6RdG
         ILQ58fypw+1anthocZGqIDL07F+qkm+gq7C0hulaNhZjJ+YhG96H2hvtFWi4JvtI2g1Q
         AYJw==
X-Gm-Message-State: AOAM531bkid+AR5D1Pqp854iwOjiS8pOkS/QZB+gdrly9A5wcDKQSLnQ
        uGK9pWuwETrYHfgQ9McK9OFmaA==
X-Google-Smtp-Source: ABdhPJyBLGaxMiD9h5m7lNfe0Fp88P8FDv0Rv1bI+H6lZvwzTGY3m5NIOU4EVZdC+BdDYxt8ElPefQ==
X-Received: by 2002:a62:aa05:: with SMTP id e5mr16597138pff.159.1597781310313;
        Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m62sm738843pje.18.2020.08.18.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 13:08:29 -0700 (PDT)
Date:   Tue, 18 Aug 2020 13:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <202008181308.A4A6674@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-9-hch@lst.de>
 <202008181244.BBDA7DAB@keescook>
 <20200818195539.GB32691@lst.de>
 <202008181258.CEC4B8B3@keescook>
 <20200818200016.GA681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818200016.GA681@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:00:16PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:59:05PM -0700, Kees Cook wrote:
> > > I didn't see a problem bisecting, do you have something particular in
> > > mind?
> > 
> > Oh, I misunderstood this patch to be a fix for compilation. Is this just
> > a correctness fix?
> 
> It prepares for using the definition from assembly, which is done in
> the next patch.

Ah! Okay; thanks.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
