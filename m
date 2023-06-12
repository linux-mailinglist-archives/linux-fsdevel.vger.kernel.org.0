Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF572C9AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjFLPTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjFLPTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:19:09 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1873119;
        Mon, 12 Jun 2023 08:19:08 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-45eabad43c4so1795910e0c.3;
        Mon, 12 Jun 2023 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686583148; x=1689175148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4014MnYye531nYcnxv56ggVOb/ycAPibhhnDkpmU40E=;
        b=ScxN8PRHphwSNSdor3hmB0jzaF41Y77Gnuf4xUzNAAXmXDoXv3iDfFysKo6beqDASS
         W1Zx3qJ3IA5Uve2YYzatd7tTjZLzFNy+LAAApP9VAS2dvtstUKke8W2BJDl6Eb4PZKpO
         TIbzRZsEjVPDiOwxNE0IyimH3Bc7IPQKW93l4uvED7eB/EW3zDrAI7ggshNLnR0gJK3G
         4FIdHunpItDLNm9ZFE34nvPZjhLGRlhnBQimTfFcZDQSgDmeObnHAQFUpsIce30Za4aY
         7Re8k+ZtQbNcYkbXgjCb3kD3XY0zAJXHZgIloWKFKnd1+vidRvA7w06GyWHKtvpOQX21
         YPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583148; x=1689175148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4014MnYye531nYcnxv56ggVOb/ycAPibhhnDkpmU40E=;
        b=f6m1IKvSrIVmCgtKGUazzpnjLevSWXivp2UHZGpUwB4wqNw91y14sqHWHC9ZxTTkUy
         0OxtdBD4NThglaS21tA4D6EpxOBjbPaubpisIRSNzWt6OwiLTvk2n0/CYRsEKy/uK5//
         Ymq6DEc/KRPmczCxvGkZJguFcGrC16TbeNRsbUvTnreG43YPY1VJ63hNMTmKBThpOQTt
         VI6rUAb5bbOMAz7WdW8aF/YLXu2waqZ54iuqLed0LkUcBIg7soUWwobmDHzAQwBkG8Tg
         /26AzdqlTxYYd98V9h2tUCaND57CM0F1fOkq6kDIp/LvMopIykOoM3knlSPjJW6GvTCD
         Ea5A==
X-Gm-Message-State: AC+VfDyqOx1ZS1wigFXbbzoiC7F2DfHPR3HPIfbHHjLnM8NiXtVpUV7r
        KTeYESwoFViauMpTV+BxlbAoKjA6whlAjOzROAA=
X-Google-Smtp-Source: ACHHUZ4d9sJs3BhbyaKvzqafXPdFnfFv8IdeOWtNjWhG0tuo4dqK2qnvo79j8sOIpt1DgtVLMqhOTKMMTTNejP6RnBA=
X-Received: by 2002:a67:ead1:0:b0:43b:4b0a:1349 with SMTP id
 s17-20020a67ead1000000b0043b4b0a1349mr4495847vso.14.1686583147690; Mon, 12
 Jun 2023 08:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230611194706.1583818-1-amir73il@gmail.com>
In-Reply-To: <20230611194706.1583818-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 18:18:56 +0300
Message-ID: <CAOQ4uxhteBXU=3K5CHzgGY30Tiv0qdoVW9d5SFdd1qTn4SBQAA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Handle notifications on overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 10:47=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Miklos,
>
> Third attempt with the eye towards simplifying d_real() interface.
>
> Like v2, most of the vfs code should remain unaffected by this
> expect for the special fsnotify case that we wanted to fix.
>

FYI, I've made some changes based on feedback on v3 from
Christoph and Christian:

- Rename struct file_fake to backing_file
- Rename helpers to open_backing_file(), backing_file_real_path()
- Rename FMODE_FAKE_PATH to FMODE_BACKING
- Separate flag from FMODE_NOACCOUNT
- inline the non-backing branch of f_real_path()

Pushed to:
https://github.com/amir73il/linux/commits/ovl_fake_path

Will wait for your feedback before posting v4.

Thanks,
Amir.

>
> Changes since v2:
> - Restore the file_fake container (Miklos)
> - Re-arrange the v1 helpers (Christian)
>
> Changes since v1:
> - Drop the file_fake container
> - Leave f_path fake and special case only fsnotify
>
> Amir Goldstein (2):
>   fs: use fake_file container for internal files with fake f_path
>   ovl: enable fsnotify events on underlying real files
>
>  fs/cachefiles/namei.c    |  2 +-
>  fs/file_table.c          | 91 +++++++++++++++++++++++++++++++++-------
>  fs/internal.h            |  5 ++-
>  fs/namei.c               | 16 +++----
>  fs/open.c                | 28 ++++++++-----
>  fs/overlayfs/file.c      |  6 +--
>  include/linux/fs.h       | 15 ++++---
>  include/linux/fsnotify.h |  3 +-
>  8 files changed, 121 insertions(+), 45 deletions(-)
>
> --
> 2.34.1
>
