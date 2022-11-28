Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691D663A8B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiK1MrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 07:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiK1MrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:47:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84C564EF;
        Mon, 28 Nov 2022 04:47:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 739E1CE0EA2;
        Mon, 28 Nov 2022 12:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B84C43470;
        Mon, 28 Nov 2022 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669639617;
        bh=U+TvJnD8x/jDIqAqkOE5wHhUsouSetYjngwRI/CAHlw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pUmTuI0bBsjgWGShD5FSUy3jOHhck0wGWW61TrcuqcL3jVpy539gpMXpRpTushxvx
         A/RVFV+YgJzsSJGIxV3hQo38FBV3dDupxskLKWEjGSV0kjqoOfaWecgO67MqauLbes
         el+8N3wO7njnKM0MhbdkQmRc3A4Vf+4sA/D7LucpYU987j59ydc0XhWn7jWc9OCVZT
         rbTiwCIPuNO8W8uZB4SPg2wu2pBJ9OxadkV78x6BPt5uxHMB98bvQGeXGLc4DK+2Qs
         7Oo+mak9OUaK2BJu3Y7+Zj+6MxbRaacnP4LvLNJi4f9EFLq3CZfeS6heWk5LBV7LzX
         mracYUr1Mh1ww==
Received: by mail-oi1-f172.google.com with SMTP id e205so11367655oif.11;
        Mon, 28 Nov 2022 04:46:57 -0800 (PST)
X-Gm-Message-State: ANoB5pkUlNI++6pT+tqK5gOHHvNdTdAe8ympJDFdtjm/3XKfadJgbYZS
        MiEIONl71r3n8bZyl6e1NjeqsRbxVte5LDp40iE=
X-Google-Smtp-Source: AA0mqf7xqDskPqPexut+11NirlZnMdbiGll/YEs6Hx6MtemVvtY7Luupm8Ao9BjOwBBcf8EWFwFZqNCn9viJPCVbrxA=
X-Received: by 2002:aca:111a:0:b0:34f:63a5:a654 with SMTP id
 26-20020aca111a000000b0034f63a5a654mr14689150oir.257.1669639616668; Mon, 28
 Nov 2022 04:46:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Mon, 28 Nov 2022 04:46:56
 -0800 (PST)
In-Reply-To: <PUZPR04MB631661A405BDD1987B969597810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB631661A405BDD1987B969597810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 28 Nov 2022 21:46:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-1=+2zo2sGQ8sZdJ7xcuOsWBXx+Cf_YromVUt6-thPwg@mail.gmail.com>
Message-ID: <CAKYAXd-1=+2zo2sGQ8sZdJ7xcuOsWBXx+Cf_YromVUt6-thPwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] exfat: move exfat_entry_set_cache from heap to stack
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-24 15:40 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> This patchset reduces the size of exfat_entry_set_cache and moves
> it from heap to stack.
>
> Changes for v2:
>   * [1/5] [5/5]
>     - Rename ES_*_ENTRY to ES_IDX_*
>     - Fix ES_IDX_LAST_FILENAME() to return the index of the last
>       filename entry
>     - Add ES_ENTRY_NUM() MACRO
>
> Yuezhang Mo (5):
>   exfat: reduce the size of exfat_entry_set_cache
>   exfat: support dynamic allocate bh for exfat_entry_set_cache
>   exfat: move exfat_entry_set_cache from heap to stack
>   exfat: rename exfat_free_dentry_set() to exfat_put_dentry_set()
>   exfat: replace magic numbers with Macros
Applied, Thanks for your patches!
