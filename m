Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A826EDA38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjDYCY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDYCY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:24:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB23A253
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 19:24:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so743166966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682389464; x=1684981464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOVclYKRWNV3JGuq2gLOY6hCBQpyxUe3mzcJx3TTPwU=;
        b=a0elG3YFwWJIvXEqchJXO39RR9pnx5UzsJ0iyHEreb4o2DoYKPIwJ1w/yPJ1TJDLFZ
         g42+s4At/tL+mWfVqjZzK39m4HeFwAi2GyenUZ+yBBAm9grOMYahxkIxkKTBJxKJV7/6
         pMxGxcI2mNtdEfEMIMM5jjTne/wmXnIhQboqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682389464; x=1684981464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOVclYKRWNV3JGuq2gLOY6hCBQpyxUe3mzcJx3TTPwU=;
        b=Arnv5MQxWbLKZS1MLdtv2vARTiJ8j9X41t56xHxGPf+cAfSo0clQev+Z83jTh7pL9g
         /CQK5uQ5dTPZj/SHQ5ddDfnMy7prGDwaAsmHYSRFHl7it/AEfsb4uySkSC5wvUQVjfgN
         sAD0ZNDYHVL70Jf6nEnDISo6ZF6VcGKP9Ws8fvE11eReiOuBjKs4UHiVPG8yEpSsgsci
         ZlpEELY7PCVwm4/+YPB/2DthQbG7bENT4DtgzCd1FdbbSi8SUiBs/Vk/OKlEQJ0QBB/b
         Y67Hn03B523xTPEjF8FsAnqzGSKI0JWp62Sl9DpInmKh48Abl8jm7vKf+30FPracjPs5
         CD3g==
X-Gm-Message-State: AAQBX9c9HLPZETBoACwd7cIygmiWma0vyv+WAwhP1wHw2vOqNnNOASWn
        4tITBRc0hrvHEUWhvM+iadHrwHv6OzXnriQhMgtEmTQN
X-Google-Smtp-Source: AKy350a8bRF18do5jd4eF43ycrflClba8NGpENI17nMfRo2eGFW5JIdC9F0ZsZBnFAKsKxq4YzO7Bw==
X-Received: by 2002:a17:906:9f07:b0:959:99bb:8cc2 with SMTP id fy7-20020a1709069f0700b0095999bb8cc2mr5206152ejc.34.1682389463851;
        Mon, 24 Apr 2023 19:24:23 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id mb17-20020a170906eb1100b00932fa67b48fsm6073828ejb.183.2023.04.24.19.24.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 19:24:23 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so7944826a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 19:24:23 -0700 (PDT)
X-Received: by 2002:a50:ee86:0:b0:506:a446:b926 with SMTP id
 f6-20020a50ee86000000b00506a446b926mr14495282edr.19.1682389462745; Mon, 24
 Apr 2023 19:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230424042638.GJ3390869@ZenIV>
In-Reply-To: <20230424042638.GJ3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 19:24:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
Message-ID: <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
Subject: Re: [git pull] the rest of write_one_page() series
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 23, 2023 at 9:26=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> write_one_page series

Hmm. These pull requests really could have done with better descriptions.

Yes, I see what it's doing, but I'd really like to have better merge
messages from the pull request.

                 Linus
