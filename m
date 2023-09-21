Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D982E7A9AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjIUSvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjIUSum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:50:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A5153ED4
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:35:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c135cf2459so9417211fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695321347; x=1695926147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWavBDyxylEytVPWq6uJBi+qcXGSJxVZ8qten9oG6oA=;
        b=CWHU8+d4Y3WSTH2G8qFM7TafxFSLY77YkVTs2g1RcGXxAqbKdZfskCyjR1LEu7H64/
         fETU5+T22W7EgKmxB7a6s6VQEZnB/M+7tw1xgr2jSz3UxXJeLfeXEZNhY3zH0dCs4NCT
         FvXgXNdYbhXF+g6ylOtRzXou9GqInCvdgsfq1LoXUu0WLI5pasvG7onG+OKsVdiIRoHG
         xBoHNvlhCNgcDHMkcP/N4TVc0U4SB+22fVtkzWGfdri09YhA8jkXpFAcvfAsl94tx1Es
         HuEHtm0UDlPf1rve6bO234Q0K96RlEi8Mxiaels8ZnffaA8U6IWXVmoiMlUvXyZhPJhS
         AouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321347; x=1695926147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWavBDyxylEytVPWq6uJBi+qcXGSJxVZ8qten9oG6oA=;
        b=HBt6m0ZjS5kauwyuad8pd61CL/ee0Taq3xbryx7nfWNWwhK/iDppMeVfi76BjWoEdn
         JxRK/yeVgrue8F6/aqBUk/k8QwsemR4tHX+bQVVfEsInkT4PtjEHVNkKeyWg6xp4QbOV
         tOYjpZdFhtCtK0x8BS7WlXqygoOIINL9nQx0djwxjRBGm8jc6GNw/fRwtk8T1blzWOUo
         kfqs2fobrxCp+EQYFG+quEt35nN8UbZ6DfQJHFWqTAkXkowcWYLHLyshu2dunTSL6q5E
         wUblCCXHI2UL3PFc69Fm2oP6ksnKLTPvcvT360xIZiqXQ+c0QX/7np6SeGQwJIgB8AB6
         0bsQ==
X-Gm-Message-State: AOJu0YxO/0O0FLFs/AlpoacgBJLoN7ANGM3i4XVt5NzXJVrjS3tMVEiF
        RsO1eEKWoMpKCQeN4nCpRsstoBzT5NYn1YMKZwpTZU8wE37+c33LmoQ=
X-Google-Smtp-Source: AGHT+IFc7DcqkuN4xwTnOSgXmuYaEniCijOkBOdnXhK/IfL5jCOdZjUH7q7DqDTBphBVCelLSM7bRRk18GwtOCjiWi8=
X-Received: by 2002:a2e:9090:0:b0:2bf:f5d4:6b5a with SMTP id
 l16-20020a2e9090000000b002bff5d46b5amr4368995ljg.41.1695281304283; Thu, 21
 Sep 2023 00:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner>
In-Reply-To: <20230920-macht-rupfen-96240ce98330@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Thu, 21 Sep 2023 09:28:13 +0200
Message-ID: <CAKPOu+_Ebj6-YXPd4HWqG7TokZDvw26uM4xuJGL7k0gg+tHeyw@mail.gmail.com>
Subject: Re: When to lock pipe->rd_wait.lock?
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Afaict, the mutex is sufficient protection unless you're using
> watchqueues which use post_one_notification() that cannot acquire the
> pipe mutex. Since splice operations aren't supported on such kernel
> notification pipes - see get_pipe_info() - it should be unproblematic.

I had another look at this, and something's fishy with the code or
with your explanation (or I still don't get it). If there is a
watch_queue, pipe_write() fails early with EXDEV - writing to such a
pipe is simply forbidden, the code is not reachable in the presence of
a watch_queue, therefore locking just because there might be a
wait_queue does not appear to make sense?
