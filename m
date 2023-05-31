Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDA717F32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjEaLxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjEaLxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:53:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB40172C
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 04:52:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fa4a6a79bso821565166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1685533941; x=1688125941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8yUW6f7zPTfffxLigiRctP+nblSLEZeoMC2WhJm6RA=;
        b=De5afgVQ5HipTyqOVU4mV4u3MwUdsinjVRVvW/7yW2GC6ZphKCcsy3CLQvXNENV4PT
         mG5AJjoIKQNuXK2oiX7ejwA8MvGaSSPHGCnxvr0ubVYKWorbk4yyXnC4PlAYFZ5TTZmE
         7TaWGKDBPRugNvPxN1yvLrPufaPNP3rJEJkq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685533941; x=1688125941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8yUW6f7zPTfffxLigiRctP+nblSLEZeoMC2WhJm6RA=;
        b=BHQgG/VosKFxddjNb1hvjR1nd8DchKkCF2fR7yo93ebsTolzl7tv/pWkIzcwsRoCwZ
         goTDfvqb1zEMFbEeKhrEf0MUirI8goEMUrGIkr/qj5Yeq+D0LdF5fA0zfbj5tkE9ra6A
         bw1u+cFewyah+WmNSVU6B4OsYGPg1E4DzNhG1Po2n9bRnn3RSrPB/zbH5P05jySXW7QP
         sCywVCo4QOgGT5ScZOcAOp2J0ngU8N7fHp2xe1f3goh16II+QnGV23WnYHd/3S4Mnt4z
         leLSyWxUhPAIN8vkukeTTak64UMHhZS8oOxY24r61iIQUEYPUyhjehVwg/XJPXxs789l
         zWCg==
X-Gm-Message-State: AC+VfDypod7jdW69N3jFgjtG6dcpxCFxDFRHwOlNI5kKZR7MAemzeyQ+
        YVrzp8LBxjFfO9Y3PAuqKds+FZvb+CGx3ss7ILvkqA==
X-Google-Smtp-Source: ACHHUZ5gTL+lpHrHWNYIzxWIkb53eDD2bdkr9oH7ynn0ct3h/bgrpPVOBDRWdOPwlUlBo+fjFB6+xQbcYVQsHWFc/2w=
X-Received: by 2002:a17:907:6e15:b0:974:1f6f:111e with SMTP id
 sd21-20020a1709076e1500b009741f6f111emr5374730ejc.23.1685533940926; Wed, 31
 May 2023 04:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230531092643.45607-1-quic_pragalla@quicinc.com>
In-Reply-To: <20230531092643.45607-1-quic_pragalla@quicinc.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 May 2023 13:52:09 +0200
Message-ID: <CAJfpegtr4dZkLzWD_ezAbFgTnbYaGDRq4TR1DUzz4AfFLSLJEA@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: Abort the requests under processing queue with a spin_lock
To:     Pradeep P V K <quic_pragalla@quicinc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 May 2023 at 11:26, Pradeep P V K <quic_pragalla@quicinc.com> wrote:
>
> There is a potential race/timing issue while aborting the
> requests on processing list between fuse_dev_release() and
> fuse_abort_conn(). This is resulting into below warnings
> and can even result into UAF issues.

Okay, but...

>
> [22809.190255][T31644] refcount_t: underflow; use-after-free.
> [22809.190266][T31644] WARNING: CPU: 2 PID: 31644 at lib/refcount.c:28
> refcount_warn_saturate+0x110/0x158
> ...
> [22809.190567][T31644] Call trace:
> [22809.190567][T31644]  refcount_warn_saturate+0x110/0x158
> [22809.190569][T31644]  fuse_file_put+0xfc/0x104

...how can this cause the file refcount to underflow?  That would
imply that fuse_request_end() will be called for the same request
twice.  I can't see how that can happen with or without the locking
change.

Do you have a reproducer?

Thanks,
Miklos
