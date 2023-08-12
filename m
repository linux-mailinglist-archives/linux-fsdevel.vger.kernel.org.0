Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9177A0CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjHLP27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLP26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:28:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628B1706
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 08:29:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1d03e124so369928466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691854140; x=1692458940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pbNQW1MAcVh5LkMzORbrZvwF658G3qR94qScwvqkcGo=;
        b=YTFa4HGI6ZO2VBsskocvIF5PdpiZtMufVeQOnpOMDzAhGfSH+lwbkeYyuQ7NHE/v5s
         8wybBS69xJ+XK9x5oBTyAXc2BNzbZhcuK6ZDOXNMSbQlUBwWHZOMUIeR/b26Yci82Q3R
         nW4H/oRBGn/b3e7imKPwfm3lTalszX7evDcQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691854140; x=1692458940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbNQW1MAcVh5LkMzORbrZvwF658G3qR94qScwvqkcGo=;
        b=jpMSeB+1SxLJZG6qHOUCtL5MdFqrD0ed6DicNxXFLHZcVqhuhhvksNIstZ6AG0kwQH
         3Px758+mT7C+QoKYQL3KyUA+VawZ6aFm7/D4E1TGDf/jjUxfDl5zeUfdJeVZVv8bhlNg
         lReh+zkEM5NIIz8wfkaG7nA+TSfSIBN+sG6N5aSXQ6UCkiAABqGhZ4BW6UsSOnaowYWU
         zP9/24IIFbQo/iSEJXbjBOC6CzXgBrljUWIRQJrSz5jlWQusgD6ZJglKovcoUw6wYOgp
         Q8e1LluX8MoAHJIkHiCAYe0vdMMXbPLV5IOW52tskMBa90vZCi2PHjzzQ/gA3x8wtrAD
         1/Tw==
X-Gm-Message-State: AOJu0YzN3RUtOddnN1SfyR9F6SC6z3phvEH3naFF8qOjH7vBPdo+V9Mj
        hmFap36GMjArckilGFn97iVHfPD721pN+Zm28woaZzRA
X-Google-Smtp-Source: AGHT+IGmv3RZ2LUsbZd/9sl+zdwxreK2V0VpyY2eXfHjH83ZoiBdrQ3Mv34CSbsT1p+pGWtt3UNz3w==
X-Received: by 2002:a17:906:cc10:b0:99d:6ca6:7a8c with SMTP id ml16-20020a170906cc1000b0099d6ca67a8cmr3901636ejb.63.1691854140296;
        Sat, 12 Aug 2023 08:29:00 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a6-20020a17090682c600b0098669cc16b2sm3549989ejy.83.2023.08.12.08.28.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 08:28:59 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso3795221a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 08:28:59 -0700 (PDT)
X-Received: by 2002:aa7:d98e:0:b0:522:59a7:5453 with SMTP id
 u14-20020aa7d98e000000b0052259a75453mr3709223eds.35.1691854139239; Sat, 12
 Aug 2023 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230812123757.1666664-1-mjguzik@gmail.com>
In-Reply-To: <20230812123757.1666664-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Aug 2023 08:28:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFxfLENgUp42RVPKHosy7FNu4U3kZCV=9b0HrXs8hW2A@mail.gmail.com>
Message-ID: <CAHk-=wjFxfLENgUp42RVPKHosy7FNu4U3kZCV=9b0HrXs8hW2A@mail.gmail.com>
Subject: Re: [PATCH] vfs: remove spin_lock_prefetch(&sb->s_inode_list_lock)
 from new_inode
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Sat, 12 Aug 2023 at 05:38, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Also worth nothing is that this was the only remaining consumer.

Send a patch that also includes just removing the definition of that
thing, and I'll happily apply it.

                   Linus
