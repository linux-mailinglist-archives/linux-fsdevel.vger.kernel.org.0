Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E376B2BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 13:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjHALKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjHALJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:09:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871BDEC
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 04:04:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686ea67195dso3918882b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690887859; x=1691492659;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu1AI41ILYHkQJf+DlWW5RsgMTiCNdMy4wtCqqC5kIE=;
        b=H1Q8ShnSg5ptQgyIYcFNeIKPv8mWSuzaSvtPQuABfJMvcOMK6QH3pdeeeqOayF6zv1
         ZYUsdLZ7khgHzq4Jub7FlTPj09IPx2Nha8u9dp4zGKEwm8+NuIp9L6H9yjUU/Nhc29WG
         bOluHGE3/e432LBpueE+EiSiPLQqq8c91IKwYrivkagKj5VdzYaqLOtUfBDjA9/tm6jV
         q5oook4t7jkA0sHpf+jC8p76MGekHNBZwDf8B1dAcB1UTSODCMjd0uQNxb4JtZxDYMU6
         AQ1wCg4EuonZkoa9YxMmZNa3EalYfcj0ZaCyHmQlwx4C4DLUk23Mnfq2CQ3SJuGYY+Rg
         0TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690887859; x=1691492659;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu1AI41ILYHkQJf+DlWW5RsgMTiCNdMy4wtCqqC5kIE=;
        b=Kl5PoDdDzgsH8aKMBcFOQkjUOxl98p9ryPQsGPJ5hPJGSpWzo5j4FY8aBKyJDbjqBL
         PD0FhqvoDE5UDyThyh9yctivMi6uWnKEG0ur7VCRRRzCKw74Kmf0r4UqQkWRYxzeFlle
         597fbt+cxb9Mq2X/smgxjxovrZfORhB8j3X+kX7rqc2Z7K+303A+lM7oOE8Ljo5yDHTt
         6dgD6h5qwYv/nbh96HpiSqPvmS68j2mQwh5e7ZaLSxBW8S2J4dWtA2g85IKpXb9y22nu
         AFba04Q2C8pM/eMQUsymnlcTjnEnmQa4rhu1NDeUiDSqE5SZMYlI7Yx7Jb+dqbYWXXkY
         Yhqw==
X-Gm-Message-State: ABy/qLaj4mSFcD0NPeX4CmWqyT/qQkCtnt8bh31z0g6l1R8SDZr+2j7U
        fGcwE7sIGSOy1QtGtMjMeyU=
X-Google-Smtp-Source: APBJJlHc1HCLNAiJ4s//Yvcms8XJraZIsAuUH92H4ROF9GRgJn/C9sFRyje0A2aewEoqS3MzF5jAUA==
X-Received: by 2002:a05:6a00:2291:b0:687:3110:7fa8 with SMTP id f17-20020a056a00229100b0068731107fa8mr6969703pfe.14.1690887858947;
        Tue, 01 Aug 2023 04:04:18 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0067acbc74977sm9394913pff.96.2023.08.01.04.04.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2023 04:04:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/3] fuse: invalidate page cache pages before direct write
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <16c14e85-f128-e5e8-c271-f03da0e476f7@linux.dev>
Date:   Tue, 1 Aug 2023 19:04:01 +0800
Cc:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B8D1DC4-137B-4F7B-A003-303A3DCCA99D@gmail.com>
References: <20230801080647.357381-1-hao.xu@linux.dev>
 <20230801080647.357381-2-hao.xu@linux.dev>
 <B98453E7-ABF1-426E-A752-553476D390C5@gmail.com>
 <16c14e85-f128-e5e8-c271-f03da0e476f7@linux.dev>
To:     Hao Xu <hao.xu@linux.dev>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 2023=E5=B9=B48=E6=9C=881=E6=97=A5 18:40=EF=BC=8CHao Xu =
<hao.xu@linux.dev> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Alan,
>=20
>=20
> On 8/1/23 18:14, Alan Huang wrote:
>>> 2023=E5=B9=B48=E6=9C=881=E6=97=A5 16:06=EF=BC=8CHao Xu =
<hao.xu@linux.dev> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> From: Hao Xu <howeyxu@tencent.com>
>>>=20
>>> In FOPEN_DIRECT_IO, page cache may still be there for a file since
>>> private mmap is allowed. Direct write should respect that and =
invalidate
>>> the corresponding pages so that page cache readers don't get stale =
data.
>> Do other filesystems also invalidate page cache in this case?
>=20
>=20
> For now all filesystems that use iomap do this invalidation, see: =
__iomap_dio_rw()

Thanks!

>=20
> e.g. ext4, xfs
>=20
>=20
> Regards,
>=20
> Hao
>=20

