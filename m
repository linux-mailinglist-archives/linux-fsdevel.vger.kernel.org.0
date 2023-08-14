Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31A77AF14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 03:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjHNBCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjHNBC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 21:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B659C;
        Sun, 13 Aug 2023 18:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A343761DBC;
        Mon, 14 Aug 2023 01:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02487C433C9;
        Mon, 14 Aug 2023 01:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691974946;
        bh=JEEY10hBYz8RwhXPPVD6zF4+YQYQsXCRSg8FIpcrlVY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FOB/qY/PpdgHCtif2jsnF7NTFxHEmFbrI3NnLit3qzbbEwG0sHPOCAfEhTpS58s2i
         7zrZcLz9cA8dfipUEWmWoJb6euJQ4aIjWtG1Sof3Ho+0SREVOR0PINgxS/mhpwuPQI
         rE5ggXMCOD/e6KwTLUByfD0d6tLgZ+JNkip6wF1jenLYVMO7zXpSYFKgeqZ2z8nFEg
         2wKesPUUbsPrtaP76RRB4nZrB5W+FPUgMAWNBgl6zoeZ8fWe9NnL5aLs0q6auiTwEL
         IbWzHcbEyKtJXyDyigng30ra7xZpMpckRBQtSebqarla6TJdx/pJrXvn2S1g7kRRbn
         0Y9UEJMKiA5dg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1c4cd0f6cb2so738516fac.0;
        Sun, 13 Aug 2023 18:02:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtpBxBPp5+d99YnB001BMoegYaIm93UgtDKBUfxZHAJ0LxdQab
        nuxHiO5CCdDg1vmT7lAN4qdLucsquQGhuADIsOU=
X-Google-Smtp-Source: AGHT+IEZBAOsoH5R9sMuTJ0tT6LAbfT4e8g0Coz08nyYUPTnQN4yEKjF5zsRrsRYGnMLm7X+87vqmfeDUsDdJWyaSG8=
X-Received: by 2002:a05:6870:e985:b0:19f:e5a8:7525 with SMTP id
 r5-20020a056870e98500b0019fe5a87525mr7150030oao.12.1691974945110; Sun, 13 Aug
 2023 18:02:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:14c:0:b0:4e8:f6ff:2aab with HTTP; Sun, 13 Aug 2023
 18:02:24 -0700 (PDT)
In-Reply-To: <20230813055948.12513-1-ghandatmanas@gmail.com>
References: <20230813055948.12513-1-ghandatmanas@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 14 Aug 2023 10:02:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8A9+Zcg=8wLV0h4fdcvybp=BB-a0yRKSTHmk0sQi26_A@mail.gmail.com>
Message-ID: <CAKYAXd8A9+Zcg=8wLV0h4fdcvybp=BB-a0yRKSTHmk0sQi26_A@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget
To:     Manas Ghandat <ghandatmanas@gmail.com>, anton@tuxera.com
Cc:     gregkh@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-08-13 14:59 GMT+09:00, Manas Ghandat <ghandatmanas@gmail.com>:
Hi,
> Currently there is not check for ni->itype.compressed.block_size when
> a->data.non_resident.compression_unit is present and NInoSparse(ni) is
> true. Added the required check to calculation of block size.
>
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
> Fix-commit-ID: upstream f40ddce88593482919761f74910f42f4b84c004b
> ---
> V3 -> V4: Fix description
> V2 -> V3: Fix patching issue.
> V1 -> V2: Cleaned up coding style.
>
>  fs/ntfs/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 6c3f38d66579..a657322874ed 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1077,6 +1077,15 @@ static int ntfs_read_locked_inode(struct inode *vi)
>  					goto unm_err_out;
>  				}
>  				if (a->data.non_resident.compression_unit) {
> +					if (a->data.non_resident.compression_unit +
> +					vol->cluster_size_bits > 32) {
> +						ntfs_error(vi->i_sb,
> +						"Found non-standard compression unit (%u).   Cannot handle this.",
> +						a->data.non_resident.compression_unit
> +						);
> +						err = -EOPNOTSUPP;
> +						goto unm_err_out;
> +					}
compression_unit seems to be used when the ntfs inode is compressed.
And it should be either 0 or 4 value. So, I think we can set related
compression block variables of ntfs inode only when ni is
NInoCompressed like this... Anton, Am I missing something ?

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index efe0602b4e51..e5a7d81d575b 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1076,7 +1076,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
                                        err = -EOPNOTSUPP;
                                        goto unm_err_out;
                                }
-                               if (a->data.non_resident.compression_unit) {
+                               if (NInoCompressed(ni) &&
+                                   a->data.non_resident.compression_unit) {
                                        ni->itype.compressed.block_size = 1U <<
                                                        (a->data.non_resident.
                                                        compression_unit +

>  					ni->itype.compressed.block_size = 1U <<
>  							(a->data.non_resident.
>  							compression_unit +
> --
> 2.37.2
>
>
