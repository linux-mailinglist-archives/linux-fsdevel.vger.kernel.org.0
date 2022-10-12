Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044DA5FC6D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJLN4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJLNz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:55:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5462E9C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:55:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d26so31047393eje.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4qmg4vqSADnDgrGWjzGtMB0dXMibbS/jTOGbXaTfhk=;
        b=eP3yKhkTx83pG0oJnpkevbeYhtYHm702dxsr1Hh4yY8HZ/6PO90vrBcCoGDGwhh9Eh
         fAEY8HyE4dwBRMmHcfZZ+j9DoHY544bV0Y+LTqXB1CVOr5gV92xQpHK1w0KInzBwDbxc
         S7LlpET9CD1/ANCJuTEBaiJBF//abbGbzpZ28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4qmg4vqSADnDgrGWjzGtMB0dXMibbS/jTOGbXaTfhk=;
        b=L/4JiiGU+FB9B0ov26B0qkSsFNWEIUJ371WEDTcc1rDaIU/2/6j4R8TiX7EGR4wv+H
         XPZx7VO3cSWn9T7BxwWfpv/JzdAxYsKLBoT6cvr1MTfB+Kx4i+08VtLPtB95PJxWrotw
         MfNA1N/zuZ7X/nk254nAUOnlA0jzLniPR4DBfP9PkTt34n82yl1PdAdZv96rIinJ6o69
         nOVS4Ipf7rNqC1SX9RGxf7s0XiCgMAJIxTGvb/Nbrs/5olEJf3McFR20GHK1xr4nr60Y
         rWFpxfnf9qYCzM3a2092u2aHqWvZYO5+FGaL/bRjOBIKqTjU+lwiF+sBk41gVt5jTS6b
         F/xw==
X-Gm-Message-State: ACrzQf3EayICJ3QcDi4D5qxIwZKC0r8ElNfG9MpqaDd2zZ2jrI/Y3t1J
        AqWDTCDR0jOxLJFwkfOB+gejkIxx7KvpvxevhQubpUr1i/g=
X-Google-Smtp-Source: AMsMyM6Rhk22TOsHC75PuwTvUm9EtuCGTq71dmCa1Az/CQOw+7iobZkWf+WVhiEbpDbUuwt43PfcFs8kUyk9Wu618Wc=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr22070092ejc.255.1665582955646; Wed, 12
 Oct 2022 06:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221012112323.23283-1-fmdefrancesco@gmail.com>
In-Reply-To: <20221012112323.23283-1-fmdefrancesco@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:55:44 +0200
Message-ID: <CAJfpegut1su1PR1gBBPS3Gs8NJD=V7_pH2FGOJ6V1deWa1Z=Ew@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: Replace kmap() with kmap_local_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Oct 2022 at 13:38, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> The use of kmap() is being deprecated in favor of kmap_local_page().
>
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>
> Therefore, replace kmap() with kmap_local_page() in fuse_readdir_cached()=
,
> it being the only call site of kmap() currently left in fs/fuse.
>
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Applied, thanks.

Miklos
