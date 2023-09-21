Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3967A9C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjIUS7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIUS7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:59:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D9E79602
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:53:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-404314388ceso14727185e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695322407; x=1695927207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjpohqpGWsGF7UEP8XCU6bGpHO7U8jCY9qzMZeRWAOE=;
        b=CXZQZsGQnqmRrTl31EjcbUfSMkJ6jdlnTO8LdwCKCUZl3KiCq8v8AWrDCGyBO/r10F
         5Oj587vEQmyE7NI2TQrscxQyaJYwezIgiJEcXrQauz7ixSzVh6k0wHlVWQsN4el3NR+/
         Ykuwd/PNDefcl98NP7fS+3/5xUGcBElxW6mPC+/IOAqLMINHJRXqKLAOWCqokR3H4X9K
         ZdCgPu8qivzwW327Y4SXBQTFKRkvLMkQDwoT4A6r9P/NYPVCIRfCaPDVI0pW3qTYZxaX
         RO8D9cPh9RjH4j/YgfZPoFXWwdBGXO15BbIWJCzh2MV4gB7SWfjYD/BdOgBJ5dVgOaFU
         TtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322407; x=1695927207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjpohqpGWsGF7UEP8XCU6bGpHO7U8jCY9qzMZeRWAOE=;
        b=EP6RZeeREzYxnyr+fAR920llxc+4jDXyxNQ+/EO9w2qHspfEgcJ6RSsIrg7hOG8apO
         I4ReW8MYU366UCYuhtpHOwr0nMQmMZLLU2FplkWhKWNeBc2nI/VHZ2g4wIeMvA7yWrSG
         bpKs8M/iwoksI6g+O7Ax49ODxy1YdwfpFJNEtB/fMX+CHOt7Djcxm3jWzi4hg02u7zBF
         /+o6G1p7Jvk402pSwVlt1hDdSHjsYwU/zsUPmo023j1yZdaBD2QiEwBSyW0rbUzwOTBn
         /mHwVZk62jhRzqNilhtXf4b44P7YoByC5I5I6oaRKqEjq0N8AldghhqZTE5oCiGCKNkp
         sgpQ==
X-Gm-Message-State: AOJu0Yzhphmvz3XbvC/GLq4kCiI/4n8V/3PR5IS+D6lr4LrEiGCP1qJ3
        U3pWausk4nE2SQfLOM7gW66dQaURlW7DLczZbtiaMBN7wT+/Wqxx
X-Google-Smtp-Source: AGHT+IEtJfcurJ8v5iqMzIYnVrR/BRfAqKoj5UOcoMqhJUXPGMtUmFQtJ5mmaBVfxj6cnrm1IlFg6mjYWRRAqy05LMw=
X-Received: by 2002:a2e:920f:0:b0:2bc:cff6:f506 with SMTP id
 k15-20020a2e920f000000b002bccff6f506mr4311395ljg.0.1695289099816; Thu, 21 Sep
 2023 02:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner> <CAKPOu+_Ebj6-YXPd4HWqG7TokZDvw26uM4xuJGL7k0gg+tHeyw@mail.gmail.com>
 <CAKPOu+9RC6XCKh0a0HNEFmjPCn8n=BvGwRHk13hJKWD2N_+OcQ@mail.gmail.com> <20230921-nahen-ausklammern-aa91c8f49a1c@brauner>
In-Reply-To: <20230921-nahen-ausklammern-aa91c8f49a1c@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Thu, 21 Sep 2023 11:38:08 +0200
Message-ID: <CAKPOu+8k__Og1e1q3vGu+09eD=GiCYL7BR4xD4b1O08VhhgtJw@mail.gmail.com>
Subject: Re: When to lock pipe->rd_wait.lock?
To:     Christian Brauner <brauner@kernel.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:18=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> For pipe_write() it isn't we still need it for pipe_read().

Agree. My patch set removes the spinlock from pipe_write(); the next
patch makes it optional for pipe_read(), eliminating the spinlock for
the most common case.
