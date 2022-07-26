Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFF5819DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 20:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiGZSkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiGZSkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:40:40 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EDF2D1DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 11:40:37 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10e49d9a59bso662356fac.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b9+BQ8qqgihfRoMkfRd6ua/4LQsUTbbkzxxG9vujCrE=;
        b=O/g1ZVBT2ZRypDc1OOhVjX7Wvy0bDwafku96EXJYhZjIUogC/Lla0b7Ybk030zxfRo
         S1QqE0WMQPiIvFLIJrOBnosA7rsi8SQUKjgiHWdonRHFQkdkABGjKEFuGJQMQoUnziKV
         yJsgEhk82TU03SWTT/PL4G4d0SQbLGABYlw6UcC8xr/rCtaOZ0HpIkS2M7e4DhjVgyQN
         tjN0meuWEsRiPKD27YzCsIPqp7kGt3wga733l3JfLG9IVRHv6+wS6UKjWACm/s98+Uyh
         r21PXw8oMjbuakYmpkMbfmdrP5+y0MkDTq1wkjx5kn9nPB3OuuM0LnyXfvuDe75+0xkf
         6EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b9+BQ8qqgihfRoMkfRd6ua/4LQsUTbbkzxxG9vujCrE=;
        b=NnSOWQH6ffYFjWK1SUiabZiaP0noZj6+nqElXpuRE2scQsDcpjpLEfzDtIGxiuyuLZ
         /+5sVj40MkonYSLKfd5+m9Saaqt67l5SXOUqSHyllyT3uIXWCH2S1k8ftqR/nStHUThW
         Kk9qdVXd0BbtqzsxV/71QUI8WZ+/eS+ESEtnmOfKifqFUcaTiJcgYaikN1AvQxBFjyVJ
         fO2T1hXA3EPHVZLGS4zxJhM6giKNhxfO+i5t9otTCWgMoHDL016SsyDcAPVy5Puo9PqB
         ubI993pW6rdwl9l/YQtj2IRUMtHQtuAFkUy7474/ULdGBoQ7bCbEtao/dPMF00w6PT4D
         +HOw==
X-Gm-Message-State: AJIora8kc7avLyYp8s8Us8OnF9StbuUosDpbzWkeGnwTRfH3oELo8QlE
        PXyemNMyvSaxqL2l/MPvnWrZKg==
X-Google-Smtp-Source: AGRyM1us+cig45gAfxXWkggXYxDvMCUrkqFpz9IG7+U7KbUZjkUwzSgUJJaa9utRE+gcgWJBj18BTw==
X-Received: by 2002:a05:6870:1601:b0:108:2d92:5494 with SMTP id b1-20020a056870160100b001082d925494mr273866oae.109.1658860836915;
        Tue, 26 Jul 2022 11:40:36 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:70f5:f079:a10:1915])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568301e8800b0061c530ec022sm6417204otr.79.2022.07.26.11.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:40:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <Yt7Y6so92vXTOI+Q@casper.infradead.org>
Date:   Tue, 26 Jul 2022 11:40:29 -0700
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5834FD23-A333-40B7-9678-43E61986512E@dubeyko.com>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com>
 <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
 <Yt7Y6so92vXTOI+Q@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 25, 2022, at 10:54 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Mon, Jul 25, 2022 at 10:17:13AM -0700, Viacheslav Dubeyko wrote:
>> Looks good. Maybe, it makes sense to combine all kmap() related =
modifications in HFS+ into
>> one patchset?
>=20
> For bisection, I'd think it best to leave them separate?

I am OK with any way. My point that it will be good to have patchset to =
see all modified places together, from logical point of view. Even if we =
have some issue with kmap() change on kmap_local_page(), then, as far as =
I can see, the root of issue should be kmap_local_page() but not HFS+ =
code. Oppositely, if it=E2=80=99s some undiscovered HFS+ issue, then =
again kmap_local_page() changes nothing. But I am OK if it is separate =
patches too.

Thanks,
Slava.=
