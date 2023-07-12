Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA30751167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjGLTkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGLTkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:40:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A41FD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:40:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eec46206so6572234b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689190850; x=1691782850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oKkVuxbSi0CUL6FUPjiEUvcs0jSwNv6Pa5wNqVjCz+o=;
        b=U10sdQCf25tsKjhtnvKdjSo5c9fUt5hUc+oLBU7wWgEfHdXHZAOnAg9GP6Ms+vxI3I
         K3uPAG6uqamlpHDr66P/WPjdX1Ya538Ku+wwaygboVCNWSczkLolW+EDR628t++wSHI9
         XgiGOMr3wpxGXMmJULfHiq3n3iJyaJk6c6f5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190850; x=1691782850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKkVuxbSi0CUL6FUPjiEUvcs0jSwNv6Pa5wNqVjCz+o=;
        b=Cau1RXGY4HCm+dK6qf2T+gwIgiX4EjqTLjsuNMw5rtJfdojy8T5bDzS5qYV4f2JyRv
         YebMBEKcAm7gLlESM86qJ36huSFHqWMt+krvUskawuj5Z49ZgM8AExGcnNB05Rzkeq26
         acH/7/aX7zf6Wj5wqpzylKl337MUuiVmQg64s9Kbe8NSu6gV760NYxiWKmlKQ+XHhwvy
         IuZiHbzJYeAapqIzr2/SMOWV7nzamrkmcw/+XCTo1tdXu3xWqRI+enOmo5OSaorVYVOv
         BgDMuyzShhpSlNuj9u1EupWMMZB7ETaganbO1TgqYJVLyCZUB7ivd79v4joaAPUi0fNd
         GbHQ==
X-Gm-Message-State: ABy/qLa2ZeSMvULQ1PgxNsaLzzD79BLpEm6vIrPvFKo76fE2N4bwpWGl
        jMo6JZa4dosCeHZkkVwNdjaRNA==
X-Google-Smtp-Source: APBJJlGVIRoSzhnTlb+O3s1gI1yV1DmH1e3TpCnR9JeXgMT/R1cYIfQBaDbBHqYvIcVdnyAZgSbwwg==
X-Received: by 2002:a05:6a20:5483:b0:127:3c6e:fc83 with SMTP id i3-20020a056a20548300b001273c6efc83mr25019305pzk.42.1689190850429;
        Wed, 12 Jul 2023 12:40:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b00640dbbd7830sm4102091pfm.18.2023.07.12.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:40:49 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:40:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Norbert Lange <nolange79@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, jan.kiszka@siemens.com,
        jannh@google.com, avagin@gmail.com, dima@arista.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <202307121239.1EB4D324@keescook>
References: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
 <20230630083852.3988-1-norbert.lange@andritz.com>
 <e8161622-beb0-d8d5-6501-f0bee76a372d@vivier.eu>
 <20230630-hufen-herzallerliebst-fde8e7aecba0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630-hufen-herzallerliebst-fde8e7aecba0@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:06:59AM +0200, Christian Brauner wrote:
> On Fri, Jun 30, 2023 at 10:52:22AM +0200, Laurent Vivier wrote:
> > Hi Norbert,
> > 
> > Le 30/06/2023 à 10:38, Norbert Lange a écrit :
> > > Any news on this? What remains to be done, who needs to be harrassed?
> > > 
> > > Regards, Norbert
> > 
> > Christian was working on a new version but there is no update for 1 year.
> > 
> > [PATCH v2 1/2] binfmt_misc: cleanup on filesystem umount
> > https://lkml.org/lkml/2021/12/16/406
> > [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
> > https://lkml.org/lkml/2021/12/16/407
> > 
> > And personally I don't have the time to work on this.
> 
> I've actually rebased this a few weeks ago:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.binfmt_misc
> It has Acks, it's done. The only thing back then was Kees had wanted to
> take this but never did. I'll ping him.

Hi! Can you resend this now that the merge window is closed? I looked at
it in your tree and it seems okay. I remain a bit nervous about exposing
it to unpriv access, but I'd like to give it a try. It'd be very useful!

-Kees

-- 
Kees Cook
