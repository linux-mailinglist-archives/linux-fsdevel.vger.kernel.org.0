Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395575A032
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 22:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGSUva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 16:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGSUva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:51:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657481FC0;
        Wed, 19 Jul 2023 13:51:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666ecb21f86so31040b3a.3;
        Wed, 19 Jul 2023 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689799889; x=1692391889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeFcT+TmB1PU3c4M66SVVnoK0FoGJP0C1NlH4Bok8b0=;
        b=Iq7RMyqJRfa7gPuU/R1wWbzxMA8OuGh21/F5FD3PUudVL2NOCR+rlaW+XgBRl+45jz
         zQnlo2qLVRs54AM1MxeDBzLmISW6nDHfaonk9RILxZKNNGbircRWwiMrd0I9bEA1dBUK
         CXh/F1eCFNE0mN72TL4rCYsATBzFXOMdEyWKAGIW1M7Scdz3orBz4t+yOk9G3F7JXS+E
         56WILMYmrLo8A1x6QYv0Z92rzOZKs9QyjIjeyQG7JjujuiYRGkPkj4rObfNJ+GvEmi5c
         VY0YSN6pAN7mTZkQuigqkw8RF0CCWPQxIRiq720CILYgH5dSmqLhSByXgJ1aatvzT7/2
         UWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689799889; x=1692391889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeFcT+TmB1PU3c4M66SVVnoK0FoGJP0C1NlH4Bok8b0=;
        b=hld6inpaokXS16fQzPOnVFaqncSZcmPVzz678Xe7he5cKcdwrXfnnpAwdzS9arGBgE
         y2zkT2iYsSaju7x0/qzyRRuGQdK5GFOKyA9T2IYapWPY1ny9BzzI4yv3VxYEFqezPNQN
         VPWrOwgiHYvRedsKgamrdl6pPQFadeYHlDQWitOfHbExK6ITD20Mxs1OJ63r4Wdd4GEK
         /9iAnVVFAJiIsdn6qqiNQjIXE8Q8aAiDvGvp2Xu/7Svr1HyjE6jLK40Efy54eOWs+vm0
         LmAtniMo1GwGeXCV13YLVEEQKFJSVl30Ag2GKptutvSrj8T4wNWGEv4sF9OLF/v+dCOo
         7Xow==
X-Gm-Message-State: ABy/qLYx0bERuo0TYDvmXjAVnXv2jo0/rLtZ6RO2valGyJpX+QNSc4GQ
        NW9jdDn2/IPIVCTPbjs1H50=
X-Google-Smtp-Source: APBJJlHAQ2SAchgOyphGB+hAUxP3+o0ddivXmU2p6dSlD2OEk+KirS72+emiiTyWfwUopZ/codqmhQ==
X-Received: by 2002:a05:6a20:914f:b0:133:83b5:c3cd with SMTP id x15-20020a056a20914f00b0013383b5c3cdmr618748pzc.53.1689799888710;
        Wed, 19 Jul 2023 13:51:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e754:74d1:c368:67a2])
        by smtp.gmail.com with ESMTPSA id n5-20020a62e505000000b00682b2fbd20fsm3675644pff.31.2023.07.19.13.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:51:28 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:51:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bill O'Donnell <billodo@redhat.com>,
        Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <ZLhMzQWUS0htHEdb@google.com>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
 <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
 <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
 <ZLeDVcQrFft8FYle@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLeDVcQrFft8FYle@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:31:49PM -0700, Christoph Hellwig wrote:
> On Wed, Jul 19, 2023 at 07:53:32AM +0200, Christian Brauner wrote:
> > On vacation until next. Please add a proper rationale why and who this
> > export is needed by in the commit message. As right now it looks like
> > someone thought it would be good to have which is not enough for
> > something to become an export.
> 
> emergency_sync is a relaly bad idea and has all kinds of issues.
> It should go away and not grow more users outside of core code,
> and the one Guenther points to should never have been added.
> 
> If we want to allow emergency shutdowns it needs a proper interface
> and not a remount read-only ignoring some rules that tends to make
> things worse and instad of better, and even for that I'm not sure
> I want modules to be able to drive it.

I am not sure why you would not want modules to use it - in the case we
have here we detect a catastrophic failure in a critical system
component (embedded controller crashed) and would like to have as much
of the logs saved as possible. It is a module because this kind of EC
may not be present on every system, but when it is present it is very
much a core component.

Thanks.

-- 
Dmitry
