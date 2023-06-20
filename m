Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB336736A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjFTK7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjFTK7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:59:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B06100;
        Tue, 20 Jun 2023 03:59:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988c495f35fso234791366b.1;
        Tue, 20 Jun 2023 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687258784; x=1689850784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UsfpIs8ZbY4FsxMJVdC8ReyTwzdMIzbHG6xjYSNsBro=;
        b=cqx5XtAdAHDm10rjNY3fqjctrT7/AqesiOAO/ipraUwqmaTXxnPHxC+JRlYXU/Aoi2
         67417T9YwBQ7KtG6rvQ8KthI9LPo7T4poZsF5O+hNeU4E6NYhQ1QnGwxvFWF9vjJRWwG
         OBVTH7hgDU/IWyNQ00AnfxFnquSK6YZiNeLKCJ3PuDDKzl5BL40q3UM+Fj3risL5fAJs
         jFKbnizVa4Z7DQgVqNlTGrweW9efdJfmFjUU6plPGU4Mhf8Pr4g44J//OkTbetyD2DPf
         LkyrBduU6eoWEW0CtDCts3etVx/UlLNd4KneOrVcn25eYw2j4d1hzTLtC5swf+wOGb5g
         UOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258784; x=1689850784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsfpIs8ZbY4FsxMJVdC8ReyTwzdMIzbHG6xjYSNsBro=;
        b=bEtcJ5Tzwzc98b5akK5zIHyFE8uoGE5WMdcImMFl8QFqcsWv5tH8rzjTFrBxHXEC1a
         rjnVLuERrz1vCDUsAP+qXkvDgYrp4DT807FVxuWFMxek2signdsKT7v1e13CF+vjRBIy
         AS3j86yc9Gl9ZKOvAGVlpNrygSHGW9mG6TqEn41WuVTX1mAoakLPlEU93OT88E3k/YZt
         LI2eUOaBuDZYHMR42DiEXIw0NNd0KYl6/uzlXu0u0tiFhwyKMVi8SOSSrvnpSRxqsXVY
         5ozNLCgSxmABeLTW6x75RGp0nglNtmUdDchJXblU34Ry67xjB2bVnHaKUiZl8wtkkJwA
         TiwQ==
X-Gm-Message-State: AC+VfDxvB2224Op2HJ47bC+J4JnoULpEhuWgBGYLwXHMKVQ7vmbUVdAK
        mds7k1tnLXsLakRtlSpzF8g=
X-Google-Smtp-Source: ACHHUZ6nF0pp2ZRQkRSb1xXUWjmnMShWCcQHsA6Pbc+opfbPi2zM8yuaVjNg5nq9XYpkTu2Xx6QaAw==
X-Received: by 2002:a17:907:36c5:b0:978:acec:36b1 with SMTP id bj5-20020a17090736c500b00978acec36b1mr10764445ejc.17.1687258784226;
        Tue, 20 Jun 2023 03:59:44 -0700 (PDT)
Received: from [10.176.234.233] ([147.161.245.31])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709063a0900b00988c0c175c6sm1151954eje.189.2023.06.20.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:59:43 -0700 (PDT)
Message-ID: <e30082535f1d7e92692718f1d25a08508f04fe0a.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] ext4: No need to check return value of
 block_commit_write()
From:   Bean Huo <huobean@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>, Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Date:   Tue, 20 Jun 2023 12:59:42 +0200
In-Reply-To: <ZJEvi8CJddmpeluC@infradead.org>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
         <20230619211827.707054-3-beanhuo@iokpp.de> <ZJEvi8CJddmpeluC@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-06-19 at 21:48 -0700, Christoph Hellwig wrote:
> On Mon, Jun 19, 2023 at 11:18:24PM +0200, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > Remove unnecessary check on the return value of
> > block_commit_write(),
> > because it always returns 0.
>=20
> Dropping the error check before the function signature is changes is
> really odd.=C2=A0 I'd suggest to merge this and the following patches int=
o
> a single one.

No problem, I will merge them together, thanks.

Kind regards,
Bean

