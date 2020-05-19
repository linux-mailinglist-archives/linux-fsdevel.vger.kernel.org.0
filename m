Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E771D9CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgESQdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgESQdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 12:33:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1AFC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 09:33:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z6so357697ljm.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FsHvUk8dZh0ajzB3TiumDfxSGd35hr/R1OCXsEMaZA=;
        b=OuDq+uZ2QpYJRvb/GeO+A1uwQ5ZGVdYpPQNakARsRaC0tVz+Y2WhHx7QO92kh4zmEo
         hat1wqnZozmWrQqBpNGDXrYSjHetfvdRerSP00yzpoJpdWsHDdybi1TPyV469jMT2/Bw
         w//6XEQgmwhX2rpK8Bf14xhWiiSsMzArs41dJIB6inPZ7k1okxBmAkm0cZzYn+8s0AtU
         ISUd/6VByWUaIMiDlQ9ds+3/hneGNiP/6Ef4pq7a7WYas/7HaOxqm7ITPmJ30VyOO4SE
         4cgiZVpPS9Y9QZcQhRloXVF0GMXP0p/5dX55Zve9rXXG/f4/yxiZvpTshzXuKEgWJSTA
         +jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FsHvUk8dZh0ajzB3TiumDfxSGd35hr/R1OCXsEMaZA=;
        b=RMYvWEVtlm9GNvT5IUXOC3cV1TCzBHL1+svQGwlY0Dmqk/+5R8PqgUuK77l2uVo+0c
         Tt1CuexNgtNBLLvQWxPsiJyBeBiqOdG5DBvYyRJJOLbPOiaIQnbZFEFPLCEk4HoOuxv0
         uhZZ9H1GLGqY3H84Tx79GHt/of8UBypt7yeAzlq9zzIOCbD8kPMfZ2YZ007IYegu7RIu
         ug0d9H3JQHQ4rKPP5jLQCOtGPdurzQWF/wQK8YS5bRs5a0XKimNlGRpYLkj4lHxH/05i
         X86NcBdkRvFg71EEumsE0ImuiBdueDr+Yo8jUdsx+hJYt8Nz8U0MIYSjsWJfvZWXODNc
         e1CQ==
X-Gm-Message-State: AOAM532CqiJiB2es1/qJYSNcJ1N9oZHPqh6NIUpZIxiVMDYp/8FRwv8v
        7AecG7pw69VeszcSST4JhQwPkf8yY3xJ/sCUP9aAuQ==
X-Google-Smtp-Source: ABdhPJwPMZ+B//q1l+gspCxSvYAD5mGiFN9/ycCKeAsnEVod6dS23lZ1SlsTQnf1ToCfRRMuXDUo8D2W9i0it03SfwM=
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr179097ljp.138.1589906002547;
 Tue, 19 May 2020 09:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200515204141.251098-1-ebiggers@kernel.org>
In-Reply-To: <20200515204141.251098-1-ebiggers@kernel.org>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Tue, 19 May 2020 09:33:11 -0700
Message-ID: <CA+_SqcB09GJJoTBm-U7ZwyTjuumyp4QwhLyxj8wbObd47qJOWw@mail.gmail.com>
Subject: Re: [PATCH] fscrypt: add support for IV_INO_LBLK_32 policies
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-mmc@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 May 2020 at 13:50, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> The eMMC inline crypto standard will only specify 32 DUN bits (a.k.a. IV
> bits), unlike UFS's 64.  IV_INO_LBLK_64 is therefore not applicable, but
> an encryption format which uses one key per policy and permits the
> moving of encrypted file contents (as f2fs's garbage collector requires)
> is still desirable.
>
> To support such hardware, add a new encryption format IV_INO_LBLK_32
> that makes the best use of the 32 bits: the IV is set to
> 'SipHash-2-4(inode_number) + file_logical_block_number mod 2^32', where
> the SipHash key is derived from the fscrypt master key.  We hash only
> the inode number and not also the block number, because we need to
> maintain contiguity of DUNs to merge bios.

Reviewed-by: Paul Crowley <paulcrowley@google.com>

This is the best that can be done cryptographically on such hardware.
