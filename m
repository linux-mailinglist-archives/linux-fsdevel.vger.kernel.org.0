Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1310674C03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 06:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjATFT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 00:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjATFTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:19:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F154203
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 21:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69F6DB82108
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 09:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24526C433EF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 09:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674119334;
        bh=qejyfDvgC0h4X76jJioTD2pH6biUEpZhXPfnY9HRh8Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=toEzO9Fxw5+Dd5h/vu8kx8Ojr1ojQOjCWg7Kjxy8EcJ02DBqVzKjmfAPuuK/RgfbA
         Qeh/9BpQNj+1H70y5CcZ9uI3ko4Ai0i8hxm+HVzpSekwmP14nzw1HHPGqBvwjimq5S
         05yS3je+BzJYvTkl2Rl29MbdipvdbkLqptSiHMezagW3dOTCqXiUx5wAeHihu6Sa31
         VvNuo1QKthtz0cfu2TAPRfY0sbqxiUbJKEG5aVXNnCOITUtsEAtaexYHNtlbIq0jgn
         lswBjneX+NJtzeRjVTVoUh2E6V6lcwPceyREt/oBmy8sMdRsuxhGjpvej9kBRjTlOg
         i41ZItAf8zyjA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-15f97c478a8so1774580fac.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 01:08:54 -0800 (PST)
X-Gm-Message-State: AFqh2krNN05L2DJXwyL9ySQD59/isEMSd26H4t82h7Jabon1KgA+oZXs
        ZyZkMKFrheR5JD2p0joxBr77I1iE00FcJsx59u0=
X-Google-Smtp-Source: AMrXdXsCmSpoil0k8Lwu5L1J1QGh1Gcm0plkvEtynZqhGj4iE99y0JptFH2TtJIzbHj44GA5wLX3wqIyPO7XHw7J2oU=
X-Received: by 2002:a05:6870:280e:b0:15f:1a6a:4010 with SMTP id
 gz14-20020a056870280e00b0015f1a6a4010mr798911oab.215.1674119333276; Thu, 19
 Jan 2023 01:08:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:195:b0:49c:ff2e:6ecb with HTTP; Thu, 19 Jan 2023
 01:08:52 -0800 (PST)
In-Reply-To: <PUZPR04MB63168725D434A4FB60D6A03381C49@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230114041900.4458-1-linkinjeon@kernel.org> <PUZPR04MB63168725D434A4FB60D6A03381C49@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 19 Jan 2023 18:08:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9-i5Cypow4v4RRMDgvxBXxm3r6Mhc89BWCjM2NUzCHxQ@mail.gmail.com>
Message-ID: <CAKYAXd9-i5Cypow4v4RRMDgvxBXxm3r6Mhc89BWCjM2NUzCHxQ@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: handle unreconized benign secondary entries
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        =?UTF-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-01-19 17:31 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied. Thanks for your review!
>
