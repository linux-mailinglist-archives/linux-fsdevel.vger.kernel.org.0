Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A0248ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHRTkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRTka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:40:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0088C061342
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:40:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so10461454pfp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ch3OV58IkPdZykabiTW5C4mVF3OzlaCKDtp5K191NwI=;
        b=DYnvUd31Yol0xDsMTII443AXD5SBZUHRBPBVSKFnIfKxZq5cSp3Bc8ihWc7X9kOoer
         7YDPAJt6p40V7jNKuO+C2ZaQryG9rD13tlWTVI20PKG6f1fpvlxWiKoBvHQpXsv8E/02
         XACxvcZsnlIs6M370bs+/dJJCxnJ/K0R1dBCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ch3OV58IkPdZykabiTW5C4mVF3OzlaCKDtp5K191NwI=;
        b=W1GlVBf1sPRkZtLnpI3jJlPZP1ywUk3P4zRZ9TwoP71qn4bMUbaj048DpsMUatHnHa
         SvhiVGmQ2SdFLOlLDpUZZVI6uxP6amUX5usy5wqXsCPJeoQ/K/1eoNBgqjH8j0jvBxQ9
         VsJR8QovxCv4zgosK1rRI3bkxKe0S+MWsuWCb8fD1W/JUJjD6ycwg3aje+nJpLv3rhNN
         fzyUgYudvA0Zh07NQm4mQBQHN59kNt62SvlngahloBVo4rYArZADPBe3P5huPVkoGJHe
         jUpRcCqy5z91jlznczJPSByK6rF/gXGmfAciFoSKXgbEg2LbLhDWJH8tSMXt1gBGTuVW
         EdKg==
X-Gm-Message-State: AOAM531tgxD7U0aQ+ugmOBxzsuHU0nXfAtonW3Y/7GWcn+RxrNrF6iIt
        Ot1MP7EdhtTd9JT7Suqx49fdEA==
X-Google-Smtp-Source: ABdhPJzFD2QepABnrJdmhmbyKfy6j0eIjoXbjXujD4lPLNrelLvSz1BFbjW5ovNHdN12KmA5WLvucQ==
X-Received: by 2002:aa7:9d85:: with SMTP id f5mr16545592pfq.218.1597779629499;
        Tue, 18 Aug 2020 12:40:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mr21sm620205pjb.57.2020.08.18.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:40:28 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:40:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/11] uaccess: add infrastructure for kernel builds with
 set_fs()
Message-ID: <202008181240.0B31CD9@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-5-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:05AM +0200, Christoph Hellwig wrote:
> Add a CONFIG_SET_FS option that is selected by architecturess that
> implement set_fs, which is all of them initially.  If the option is not
> set stubs for routines related to overriding the address space are
> provided so that architectures can start to opt out of providing set_fs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
