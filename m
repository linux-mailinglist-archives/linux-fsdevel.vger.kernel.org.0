Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A945857299A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 01:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGLXCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 19:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGLXCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:02:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901164E22
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 16:02:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so13154247wrd.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqVZgVm/oPgRMpdnYczwEHWekNVMmXGWtu4J84HH2iw=;
        b=XGmoojUzYK6mpQ4xUVgnnImvyqLoslPHtP0IR78FpxSvIYPR+lWH6WjX0AoHKtpAc/
         zdVORdc2pQ4T/xFLg2XNs/F2C6pofHstTG92Li1tIieBbAAfu/iPp6X25CqAClv34hfu
         ee6+oZkcxtz9IUZeL79GcyNWp5tIBL1QtloqUCEnVmeIquyUXoKpbcF4iVMhMHU3bI7C
         jXwxvZclZowD2ywX47v7QLt5Ja+AAb4msibtGEAqDWnhmT5+S2AwZGF897TwHp4quRgb
         pNHn+dgl5HlxXID7WBx3614MFPBTjSzh1QH9e4ZKH2nASD95eNozeBAKAF6vMOqBBwIP
         Jljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqVZgVm/oPgRMpdnYczwEHWekNVMmXGWtu4J84HH2iw=;
        b=jUlUYi6lxo0SoK1ATGeXX3xHS3bKb/LnG+TuxzswwrnoqsL2VtmEGzOuDhkYKpoQbu
         +zk1vRG9+5d6q9fjSgMFlGlDW4wyatOo071jZCjbDzHiv5r5erOLUJo142jOGCoI30q+
         NoOGYYYIhG06rAZ5rbFFm6bI/ksboymYI7I13y06lHw5q2XqlREua236AWpotHJjf2EA
         9ie3IFcG+bhWtt19hFqFdx3v9aT/Fm9vJ/m+YhzwmseiojyLr3FRxSOCvqIqP0wB6es9
         d4qyJ4UcaRprEW+r3q/Kl4I8wnj7No0nkCcP2Zj6M6mgLxwWYotwMUnWqCvqU6FaY0cQ
         Mmew==
X-Gm-Message-State: AJIora8GENK51RtRbidXZ3ORqmo+aCElANjCFhbn9aQOaSyTeOaBZBLc
        +9B5jkBoUpYP8szSAcrCywCeaz0sW/U=
X-Google-Smtp-Source: AGRyM1t3Sb73n9BGHcpjCbgVMk60e9JelmLXyUOcC8fMOMuTnWoWs7vaVBDDMeEWmlAQshjajGGUag==
X-Received: by 2002:a05:6000:1841:b0:21d:b6ca:2e19 with SMTP id c1-20020a056000184100b0021db6ca2e19mr268941wri.599.1657666965037;
        Tue, 12 Jul 2022 16:02:45 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003a2e278510csm315327wms.15.2022.07.12.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:02:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     David Sterba <dsterba@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] affs: replace kmap_atomic() with kmap_local_page()
Date:   Wed, 13 Jul 2022 01:02:42 +0200
Message-ID: <4727447.GXAFRqVoOG@opensuse>
In-Reply-To: <20220712222744.24783-1-dsterba@suse.com>
References: <20220712222744.24783-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=C3=AC 13 luglio 2022 00:27:44 CEST David Sterba wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. With kmap_local_page(), the mapping is per thread,
> CPU local and not globally visible, like in this case around a simple
> memcpy().
>=20
> CC: Ira Weiny <ira.weiny@intel.com>
> CC: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/affs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index cd00a4c68a12..92754c40c5cd 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -545,9 +545,9 @@ affs_do_readpage_ofs(struct page *page, unsigned to,=
=20
int create)
>  			return PTR_ERR(bh);
>  		tmp =3D min(bsize - boff, to - pos);
>  		BUG_ON(pos + tmp > to || tmp > bsize);
> -		data =3D kmap_atomic(page);
> +		data =3D kmap_local_page(page);
>  		memcpy(data + pos, AFFS_DATA(bh) + boff, tmp);
> -		kunmap_atomic(data);
> +		kunmap_local(data);
>  		affs_brelse(bh);
>  		bidx++;
>  		pos +=3D tmp;
> --=20
> 2.36.1
>=20
It looks good but... what about using memcpy_to_page() instead of open=20
coding kmap_local_page() + memcpy() and delete variable "char *data" since=
=20
it will become unused?

Thanks,

=46abio




