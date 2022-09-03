Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5C5AC01D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiICRi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiICRiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:38:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A5957563;
        Sat,  3 Sep 2022 10:38:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b26so5206040ljk.12;
        Sat, 03 Sep 2022 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T9PB00G8n49mkQ5GqTry0cp+XpHMmRJWkRcveZs969s=;
        b=fIOMCu7AITN9Pt+nFN8BJTaa3K5P3d8RThC1MmB5xW6+aCOf4ziM11dh3PVY8ChogI
         2In7ghfavyCyWtgzUXJdWJbLcoFt8im2w1QA4Z8PA+4nH1IpLvWqzc4K3XXoKDtzZut+
         zrPXw4Xgu7XAc/zA8NHyqWGScGc/Vw+ZfkvXQsEFQsWc2nQpj9tj4wlMemyYzJexkbQZ
         tGfwIBaPTWxhz6U3HENtbDZhuNci6vVbLotA4cnZW4d6tLzMaxSeSrJVmoSXVaGAym04
         0TdYH9bByMpa7AqY2/rQEU0ONx3kmD/re/WCnYtxpF1wiZp12OHS1//jc0Wu8MCo7ffF
         I/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T9PB00G8n49mkQ5GqTry0cp+XpHMmRJWkRcveZs969s=;
        b=5CDKYqN4J/Gh96GYEZ7AcH68OQzLn8jRvdp1+V46vkcRtkuYllzKmKVZ+A/pD3XUeF
         47Ocy0h5uy1EmuayaW3j330TjYTJ+9BRN/sJ1w+Op6zjLP1jZFwNPVvFT18QrdBC/SW9
         06Cz8NxR5+4M1XEd5gS8w6t83Jb2rH22AEnvW1LQbkycUIfPgl433M02D51XTnlJJvaK
         /Zzc8loR3+CiSN7zi/be9FybW1UyfFINRkOSWuy56KQEsEL7LEJkeZwaKWr1Srgp+YCQ
         dtUxLr8BjIJSGbLzGf2i8YyjwTS6AlfuLZZSrrYdHyCCRyje0cD8J3CWfuKskGQQGMoZ
         782Q==
X-Gm-Message-State: ACgBeo16TUzEuuVhRFUF/Lr3nRrFi2W4CVITuaeUSD8qGtwrrxhQc77W
        8FPCfpG/Ky8kHvP+dKE3lVop0ZZ3xwDfKk3Kwm5lhpQ9jb8MMg==
X-Google-Smtp-Source: AA6agR70Jzdv99OIWtBI+Fq39YHvU0oO+xeoqhKJN9rejAsxAabkcRwmiauhY/c5RKQZKtQjTgpBf1Dezn5qMhA8Xac=
X-Received: by 2002:a2e:8541:0:b0:261:b44b:1a8b with SMTP id
 u1-20020a2e8541000000b00261b44b1a8bmr13288406ljj.46.1662226680495; Sat, 03
 Sep 2022 10:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220901220138.182896-1-vishal.moola@gmail.com> <20220901220138.182896-20-vishal.moola@gmail.com>
In-Reply-To: <20220901220138.182896-20-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 4 Sep 2022 02:37:43 +0900
Message-ID: <CAKFNMon3fuhwv32mtP_yV1agLUQkOePOfAN0yBH2X669YgonCA@mail.gmail.com>
Subject: Re: [PATCH 19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers()
 to use filemap_get_folios_tag()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 2, 2022 at 7:07 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/segment.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
