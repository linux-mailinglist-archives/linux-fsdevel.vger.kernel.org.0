Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708268C2C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjBFQOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 11:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjBFQOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:14:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7792FCC9
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 08:13:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ee13so5592843edb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaaFjZoa42Ja79jXUWSIIIkDl/uB+0HXTqjNFaP/4Tg=;
        b=PHXmHsjX/NlR5cDMN2RZXkRFI2ufJcL6W7Vdt00g//qPDvm0Ro9mRustABPxwIlsoI
         iYj03Nk1C2e7fP70gphUwsvAh6mPa87Z1tLjcubJHCeAJslgTFnHdzgEgo3Oz2O7gJeP
         4gRLHbLZh2629Wkou7J5BkkeWj+LlCUf8bVD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaaFjZoa42Ja79jXUWSIIIkDl/uB+0HXTqjNFaP/4Tg=;
        b=WPzxJqcaneONTx8O1FOVOCf0ffnaLhIoxjZ7ywe9o3T0r3p4WE7lER2d2DLobCS70e
         1kCt2PXmrblN3ChXbuLI+jZJo0jXm6XTqSUet3C8smuMEdi6fmcx7nV426gS1f2V7rdK
         UWyNHWTrWTEe1Y0+2k91a+9eUE/MB57wDKWhRpTfTVASHjtAbORZNIKz4GQDy+N0mhlE
         +xGWJ1+ijLrzVWpxKtHmYrr/+4JJSbVbc1B9M9QwGepqWTkETtLj5AGVQrVDHfL/1GqS
         D98gsVbNcOG3/otxsyR8y69x/QGLlbjRMUPqRhn6JMKngUaCvDS9RDB2MvCy69MWZnQn
         keCA==
X-Gm-Message-State: AO0yUKW0K49ve7pwvn4v84qI6eCHZLJNXkCMVOdB+uf8GxVb2nfHIn98
        ACYRobKTEVnZdqkZo9Tj+OH1tk/ReHF6il9EZeA=
X-Google-Smtp-Source: AK7set/TOyQwGBewfvttixGq04TfXxdVZTnmexHVxzdhGJujO7jodHxCQHjMIlgPYT5g2S/CjP06uw==
X-Received: by 2002:a05:6402:2550:b0:4a3:43c1:8437 with SMTP id l16-20020a056402255000b004a343c18437mr12638789edb.11.1675700029384;
        Mon, 06 Feb 2023 08:13:49 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id fg10-20020a056402548a00b004a23558f01fsm5252907edb.43.2023.02.06.08.13.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:13:49 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id ml19so35822596ejb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 08:13:49 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr5133989eje.78.1675699644119; Mon, 06
 Feb 2023 08:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com> <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
In-Reply-To: <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Feb 2023 08:07:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=6amjgu3UiJX8HcNN9z-jqCRg=P=T4ZytFap2fgAdgw@mail.gmail.com>
Message-ID: <CAHk-=wg=6amjgu3UiJX8HcNN9z-jqCRg=P=T4ZytFap2fgAdgw@mail.gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 7:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> As for Linus' point about us needing to avoid sleep under RCU +
> spinlock, curious if we can capture *existing* bad users of that with
> Coccinelle SmPL.

Well, we have it dynamically with the "might_sleep()" debugging. But
that obviously only triggers if that is enabled and when those
particular paths are run.

It would be lovely to have a static checker for "sleep under spinlock
or in RCU" (or any of the other situations: preemption disabled either
explicitly or due to get_cpu() and similar).

But I suspect it would be quite hard to do.

               Linus
