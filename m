Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F257A2C40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbjIPAc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 20:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbjIPAcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:32:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC83196
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso4447534e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824321; x=1695429121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXxPKtz5nN+DfsuKg6sOZlo1Msf7kjZ/mu4lVCkpHMY=;
        b=Q2etY6S6wKtXFJHa27AXeqkuzXd23OkFpret8P3qK3hBJ+UYxb86DQbkQCeEYGmvVw
         mV7QHEP6/lihowvpG7hqAqg8BoW9FC7QAid1ZWcnn7Snmu/RqEOXkrsLrmTMcBzsztaw
         lQSxiJLcHRvrdHaiGNZerJZ1MAUfruogawF2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824321; x=1695429121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXxPKtz5nN+DfsuKg6sOZlo1Msf7kjZ/mu4lVCkpHMY=;
        b=DyfDDf1mLy7M/0DdC4GYbDtvJYJ15aTKWw8hwn711tZBfU5tclmeyBDtZIrxlTQD7z
         4efXYT2KWbe9OJwJV55SG79azSlL5JMUT2y5hmIa8CJOuSHRUDpzKSWJsTpOuwByneFT
         qadGqXu1YuBwt0v2nSrkIjJs3enmwEzAA6kFp19oBu9BGc1hYq63dZZUI/I9gYhwwBOk
         MRPBWLNP2zsnysEY6KKrbcEQCLUzPEA1Lhw+2ot6WwY5/9MljbXQWnEa7ek1PHXMjAdx
         V1uVmSY1SfW7n/jBB+35W1omHjHxYqECqAed5uRlwsQbIqf0COVSQX3sG0X2+aunr2ii
         ligg==
X-Gm-Message-State: AOJu0YzInROipnS1KF4t9Jr44FlvLbG3eJXO3G5By/UPWQtwuIec+F6Y
        mZU3aqQscifyt0q+rFQFxZWAJMHh032ZlCDlkIDnAXA+
X-Google-Smtp-Source: AGHT+IFnTb2EC3j0DNkPoJ3HHnX5nZtpp1X/75HHfMWi/2MQVRoUSr7EdhsDJe4VIoMoekVeIOmjHA==
X-Received: by 2002:a05:6512:3096:b0:502:a46e:257a with SMTP id z22-20020a056512309600b00502a46e257amr3068597lfd.56.1694824321164;
        Fri, 15 Sep 2023 17:32:01 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q9-20020a19a409000000b004fdc0023a47sm789313lfc.238.2023.09.15.17.32.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so42750881fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
X-Received: by 2002:a2e:9084:0:b0:2bb:b626:5044 with SMTP id
 l4-20020a2e9084000000b002bbb6265044mr3003230ljg.6.1694824319872; Fri, 15 Sep
 2023 17:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:31:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU44TsEkoae6HuJi8JcTHMr01JSi_ZhiVTVSwpKvBtXA@mail.gmail.com>
Message-ID: <CAHk-=wjU44TsEkoae6HuJi8JcTHMr01JSi_ZhiVTVSwpKvBtXA@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add folio_end_read
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> I don't have any performance numbers; I'm hoping Nick might provide some
> since PPC seems particularly unhappy with write-after-write hazards.

I suspect you can't see the extra atomic in the IO paths.

The existing trick with bit #7 is because we do a lot of
page_lock/unlock pairs even when there is no actual IO. So it's worth
it because page_unlock() really traditionally shows up quite a bit.
But once you actually do IO, I think the effect is not measurable.

That said, the series doesn't look *wrong*, although I did note a few
things that just made me go "that looks very strange to me" in there.

                      Linus
