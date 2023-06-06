Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4635723F4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 12:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjFFKXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjFFKWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:22:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49510CC
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 03:22:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9768fd99c0cso753219866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686046970; x=1688638970;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3UkVcH45LJKdwWEhnZc1GF+uVpa9YNPFKCaEecYHlk=;
        b=IVodTB6IywPa+UfWhUmqMJM9kyF/JPX4UdaOD3tuFUuLDDR4oW18Jfl1ZQH0902SdB
         Xt5sJLXrB2po6kDvd+Jc5FC8j8F9cLqBaoPdVIGu366rG0iwkt+j8hkkzyRCoMfFpy1D
         tZQmqCtruInuOCo3cxDE2tto1P2MD1QXZJZVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686046970; x=1688638970;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3UkVcH45LJKdwWEhnZc1GF+uVpa9YNPFKCaEecYHlk=;
        b=XajfM3jHBmN0QVHfeg9gi5sCQ5f+an/Hm89lmH4o/gUbEq8eCEerIiMfWgdYSdkWww
         nNObAhoixZZJp6J10iQSeck3Khri6tOjcCPMk+YLJDcC96xlAO2+8jzD178IklnjJA8y
         qjNt23z52a03hngiAUz6Oy2Y/pMTBgkuTQY5Gbf9GL4Nt1SCdYUtavQl9OuIxUaaIrkz
         TOe7JFjojqksH9hAPkkOPPahXlYPC9nhHwMBHumL3i1cNSWTzelm7Abhm21midYO7nER
         qRmnH1G1WoWmr5jz89V4wxd54B/IbIV0jhRndkd+UIIZ8HIg5hemdvJMi/UMMAv8klIz
         pcFg==
X-Gm-Message-State: AC+VfDzmlTMIov42HTnSBl0hg83Mxph6fx+JFi7ncNN35Ktj8YV/L5jw
        Xs8X3vIhU0EOikZnF5yGdjr9yK5fIDn4VYykVtODfw==
X-Received: by 2002:a17:907:8a05:b0:974:623c:f129 with SMTP id
 sc5-20020a1709078a0500b00974623cf129mt8545295ejc.15.1686046970609; Tue, 06
 Jun 2023 03:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-11-amir73il@gmail.com>
In-Reply-To: <20230519125705.598234-11-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 12:22:39 +0200
Message-ID: <CAJfpegv3sBfw2OKWaxDe+zEEbq5Q6vBDixLd6OYzeguZgGZ_fA@mail.gmail.com>
Subject: Fwd: [PATCH v13 10/10] fuse: setup a passthrough fd without a
 permanent backing id
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> WIP
>
> Add an ioctl to associate a FUSE server open fd with a request.
> A later response to this request get use the FOPEN_PASSTHROUGH flag
> to request passthrough to the associated backing file.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> After implementing refcounted backing files, I started to think how
> to limit the server from mapping too many files.
>
> I wanted to limit the backing files mappings to the number of open fuse
> files to simplify backing files accounting (i.e. open files are
> effectively accounted to clients).
>
> It occured to me that creatig a 1-to-1 mapping between fuse files and
> backing file ids is quite futile if there is no need to manage 1-to-many
> backing file mappings.
>
> If only 1-to-1 mapping is desired, the proposed ioctl associates a
> backing file with a pending request.  The backing file will be kept
> open for as long the request lives, or until its refcount is handed
> over to the client, which can then use it to setup passthough to the
> backing file without the intermediate idr array.

I think I understand what the patch does, but what I don't understand
is how this is going to solve the resource accounting problem.

Can you elaborate?

Thanks,
Miklos
