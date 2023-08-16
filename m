Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1255B77DEB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbjHPKab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243709AbjHPK37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:29:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078BC1BD4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 03:29:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1f6f3884so865073766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692181795; x=1692786595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/QG6usf4L37YyX1qY4KRTADIdC0gk2Q7xhSAfGwyo4Q=;
        b=nUyP1taHhshrkficwsbzrjDHXEN68zDbTdGTgOq/+J2RWskGpHnwgQGlQhDJmYuaN7
         fcg0+IiADybB6pOVCodDgPXPwr5ZUNlEhZ8Mj9V3F8Jp5W/XSrE8uMrrW1/DYshGcPhn
         ahpRwaSnRevAzBOpq/fNglUDuGaWt8lazQvnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181795; x=1692786595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QG6usf4L37YyX1qY4KRTADIdC0gk2Q7xhSAfGwyo4Q=;
        b=EEpAE7tHuyqRGnhn0ay8Y7iydMPTyrMKDHWsfAIGt1aSGDKbm4DuIorneOuTj7h6FQ
         yZi6IrAibtm5OUt+/aebSBPoYZuSeSqwG4bS+Mbu+vztgICenFNI3sbBwX8AOPCYH2yF
         4DmteSsrHo/hxTvqN/EvxtK5kIXl8DXYLjQEHbBYXhPtxOHYm9l8Tb/9aOheDL9eJhr9
         mfmq6UrWfDt0WxIb/IKx/kIZ1X3r89nTSL0YzkgzZd5uRnzZLXImJrL4smNG3ODBG4GN
         QTHjoT3k0k/ywnDYCI1nAen1IpKogjzqNJxmshMm29Ih3Md58KPUrk4QJsbWh5uW60D3
         WrxQ==
X-Gm-Message-State: AOJu0YxaN+CGVxFmeAw+wgFhyph6zYL6xTQLwYd06o3Bq3fcYZeawgV5
        SusAcV2u+hEcQNLecToVCoqiJkMJ5zcA336v7R9Xmg==
X-Google-Smtp-Source: AGHT+IFA1mSYNdEHZR5Y149zEvaar9cJgoPNYLKnRT9WER+v4iDh+tkxXno46hY+8Nw/1BuChAtYzi3qtjXmsx1hPME=
X-Received: by 2002:a17:907:a0c7:b0:993:f4cd:34b5 with SMTP id
 hw7-20020a170907a0c700b00993f4cd34b5mr964427ejc.29.1692181795398; Wed, 16 Aug
 2023 03:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230801080647.357381-1-hao.xu@linux.dev>
In-Reply-To: <20230801080647.357381-1-hao.xu@linux.dev>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Aug 2023 12:29:43 +0200
Message-ID: <CAJfpegt9-JbxfTL6NtPzFfn1kMFSd+WCm6ZC+-PVs2Bcw=Y_jA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fuse: add a new fuse init flag to relax
 restrictions in no cache mode
To:     Hao Xu <hao.xu@linux.dev>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Aug 2023 at 10:07, Hao Xu <hao.xu@linux.dev> wrote:
>
> From: Hao Xu <howeyxu@tencent.com>
>
> Patch 1 is a fix for private mmap in FOPEN_DIRECT_IO mode
>   This is added here together since the later two depends on it.
> Patch 2 is the main dish
> Patch 3 is to maintain direct io logic for shared mmap in FOPEN_DIRECT_IO mode

Applied, thanks.

Miklos
