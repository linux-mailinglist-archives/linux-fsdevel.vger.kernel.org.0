Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7C6ED75C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjDXWBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjDXWBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:01:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF13C2B
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f3df30043so776011266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682373702; x=1684965702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Boc+4cJxgn/c5mI/silLMJUPupCybFpIBrGZbLP33Vs=;
        b=ajUEPxYdb5cnkv/QkqS887ot1XXgKeRnHhs9EpDNItHST29l2mjSwjveeJB3Kk9XLI
         yeKIW8AdVoQMY18V6MhgTeKgp1K+xgmF/1+Y0zdPUnPYmhFSOSO8m5R0RMpeMJyaPcGg
         VAKfyAWB3SLtYv4z462LsW2JMQPxRQJaO1qso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373702; x=1684965702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Boc+4cJxgn/c5mI/silLMJUPupCybFpIBrGZbLP33Vs=;
        b=c10s3DtJ5t2CG2LwrSCnx69+XsCwuqzeebSeYbwB6Zgk8gl561H7R9X+v1y2srIx6m
         dDr4605k5EvJ10TMzmKegtltD5otpIdQZEbXZcfD1ljXkiByPdXDzpp3H7QIL4iPDO4m
         31x6TZ0sljkN2WBIaq9Prb36Ev1eYJNVUOgeveeCa8aF3z4OjPt8LTW3gq04NTt/We4j
         BU6B01v+1TVud7MqVy6ssLDwDOiAEcCx6TJoM58QG+9X9TJhPc7x048PLh3DidyU6/Zw
         zDAYDEGUvvVrXuZFcsR4Mi+lBHksk6U3q+DALciUlOt7216TMxjV32L00l+AeR26J6Ph
         nG7w==
X-Gm-Message-State: AAQBX9c9UhjOpX2JzBUjgqw49faTrZDdqCxF+jsrE3zaeAg3zq571sXG
        3NUAn/r3vE+sRwvtcGgs5bthRFZuFZGAxBRCoxh3ecv1
X-Google-Smtp-Source: AKy350YsGkdTcCxM7z+lC/LzCpSSNS7ZlFE37d5k0CRiXF7xnQ4gJ/weLaPnHsr7f5WA12QLQgVpyw==
X-Received: by 2002:a50:eb43:0:b0:504:b64d:759c with SMTP id z3-20020a50eb43000000b00504b64d759cmr13560842edp.35.1682373701972;
        Mon, 24 Apr 2023 15:01:41 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402032300b004af6c5f1805sm5026025edw.52.2023.04.24.15.01.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:01:41 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso7287249a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:41 -0700 (PDT)
X-Received: by 2002:a05:6402:31f3:b0:4fb:aa0a:5b72 with SMTP id
 dy19-20020a05640231f300b004fbaa0a5b72mr12425701edb.5.1682373701099; Mon, 24
 Apr 2023 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
 <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com> <874jp5lzb2.fsf@meer.lwn.net>
In-Reply-To: <874jp5lzb2.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 15:01:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2NiwU-SPNnFvuZ9-LNk5J_iW-SvQHJdbSu_spT5Oq_A@mail.gmail.com>
Message-ID: <CAHk-=wi2NiwU-SPNnFvuZ9-LNk5J_iW-SvQHJdbSu_spT5Oq_A@mail.gmail.com>
Subject: Re: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:56=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> The paywall goes away on Thursday, so this is a short-lived problem.

Sounds good, thanks.

               Linus
