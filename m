Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5586F5AF966
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 03:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIGBeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 21:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGBeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:34:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409497CB75
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 18:34:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m1so17504622edb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Sep 2022 18:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ac8yS0SddIsqaM/j9lZmF3W375WH6cu2YA3ZST5+LMI=;
        b=cx8FOSLBOX1L/sTNHNB4FRAlBIqIOj/uT5l6CJeiKD3Z+8OykBIy/IOE8qjt2jlhmk
         xwoiNC4hmrWg2YdumFmU5KNI/MZ/MP4UQnyknpDvoPfiNlxeiEKyF8MUvuY1vnpxhzt+
         MSbqoA6yveJ+tPmuyY60tUGpd0uY3FlIdMkNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ac8yS0SddIsqaM/j9lZmF3W375WH6cu2YA3ZST5+LMI=;
        b=EzQ96gW3yhS7NZcRgd3gFEKwXOT7MyA0RvfpAaiqW8TPAznUPkdNKsxQoEnXWuelZe
         EKIlIG/Gob1cMFz6dBrz+5J6G3YT9sunpOkDNSa+18xBiwTpet5DjXf/MnH7DkjUIJ7x
         OCVVofFzqptmNLg5jGhH8JgNpCBx1h5po893EPhMdLAJc85Qn04OcJFj2PKCVRAyNQLf
         65D73eP9VbOJI9mE6iCvFdGjqKTjLBGqEmMHDX6kwxW8pyXwENouk7SqT8AdzuwMs9/L
         B3DWkKKqwuqHSxy7rO2eic9TRbzGq37s97aZ51uGLSO4BsZJv0oXsatcH5Zm+LZaZzgk
         +g8Q==
X-Gm-Message-State: ACgBeo1XSBoA4N7q+DGyEvH316P46Nc4BYDnWjMPc2gkh5tmvbrOQaNL
        Wi3Xn0UvRZG0d/fPpqrtc+MB61whOwBZ3upD
X-Google-Smtp-Source: AA6agR76/rgQA1vwqBX9uLGMvp91hX3wf3NZmAmmz2skMJwxgkBUS/XMvQd8bKFwb7fhfiFvLC++KA==
X-Received: by 2002:aa7:ca50:0:b0:44e:973b:461e with SMTP id j16-20020aa7ca50000000b0044e973b461emr1076992edt.414.1662514443384;
        Tue, 06 Sep 2022 18:34:03 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b0044dbecdcd29sm6584078edb.12.2022.09.06.18.34.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 18:34:02 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso10783667wmh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Sep 2022 18:34:02 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr558950wmj.38.1662514442190; Tue, 06 Sep
 2022 18:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <391.1662498551@warthog.procyon.org.uk>
In-Reply-To: <391.1662498551@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Sep 2022 21:33:45 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj4t2xmo3+AUJX6qs2+QegL1KGpsMH8NUcb7vnq3WGSxA@mail.gmail.com>
Message-ID: <CAHk-=wj4t2xmo3+AUJX6qs2+QegL1KGpsMH8NUcb7vnq3WGSxA@mail.gmail.com>
Subject: Re: [PATCH] afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked
To:     David Howells <dhowells@redhat.com>
Cc:     marc.dionne@auristor.com, jaltman@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:09 PM David Howells <dhowells@redhat.com> wrote:
>
> Can you apply this please?

Done.

             Linus
