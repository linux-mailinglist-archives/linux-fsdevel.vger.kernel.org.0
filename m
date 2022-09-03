Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6355AC02D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiICRis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiICRiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:38:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C857264;
        Sat,  3 Sep 2022 10:38:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m7so7552773lfq.8;
        Sat, 03 Sep 2022 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z1VGvcyPcxaVL7OhRrzeu9KO4THMsdUZs/+YFm2RijY=;
        b=g2fHdxzAoAeKP5KVAxV0TRt4CMGPzwaKPOq9K1H43TxNUN7qx6e0EdQEhdSUX0KIc/
         PpkV40H2pdOzFZnrqtKl4asBbiyXnCA0QTU2nPuVzDQwe0jpO9Mw2gtRAlz9nkilCH3H
         LBi0okNtFk16pYaBWEvWGrtSqewJMJW6wgbC1J0MUYzwS7ZvZ/2k7Q4lrL9SnMad9f76
         UEkIZPl1ryQa14KkcuS1lcJNfw0IHIDy+p5smTJlhOf/snvD8ouqd53byOlS4Cq1iDaw
         bQ5BJS9c/ErnJpwhjKL4/aBwe6A1eIEcPPtQjNzPIchP1ouZInif6Qgxq7x1Z77qSIBE
         rEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z1VGvcyPcxaVL7OhRrzeu9KO4THMsdUZs/+YFm2RijY=;
        b=xyHsbeWoQE3bjb5ZT5tqHWJhEh/EDKBQrsqaN1agmtWJoBU1Dru+mWV+82cjn640/A
         RYtTVzmRA0OwqA2npAG4tCLUNAqk1a1WlrVlqkFVwZiMClhfPmaun5lYCy7e29YHF9m0
         n9m4BGhQYJi8O6/5vEc/4GQO4flbKSOdpdUNeZ0L80Te8bQ3X9MmQvcruWRRCeEUaE0z
         6yJh9DV/K956hX2MddAWO80T8LxlmLH1VZKe1heMdU7JPpkRpQNvdtvEq1y1EvrZ13Z6
         OL+ujPi+xoE5HcnRfwXoDowGjT9wvYaS/m+09Tyl6kBXkDgSDrzoRumvHEngdgTBdEWE
         tnUA==
X-Gm-Message-State: ACgBeo1dY076TBuhSsZRL5XGOen2rX1THN5CPpYn5jw7Yj3gA/eX4TfU
        I+ldNaAkz4On2TKryio16J68WUwH2e3YuHuDkQE=
X-Google-Smtp-Source: AA6agR4lrNoGuI5rw96XeRPams7GLmC/xZVLf7HmyQGlHcfkfepnxT7a1h01PJ6LedVQXetRHT81hCJoOKKkAxZqFXI=
X-Received: by 2002:a05:6512:1395:b0:48d:81b:4955 with SMTP id
 p21-20020a056512139500b0048d081b4955mr13309674lfa.307.1662226690740; Sat, 03
 Sep 2022 10:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220901220138.182896-1-vishal.moola@gmail.com> <20220901220138.182896-22-vishal.moola@gmail.com>
In-Reply-To: <20220901220138.182896-22-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 4 Sep 2022 02:37:53 +0900
Message-ID: <CAKFNMok9qtqHkHzCGW2jckej3ZO47dvU2x+EQ1mJNwVHFHuzvw@mail.gmail.com>
Subject: Re: [PATCH 21/23] nilfs2: Convert nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
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

On Fri, Sep 2, 2022 at 7:18 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/page.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
