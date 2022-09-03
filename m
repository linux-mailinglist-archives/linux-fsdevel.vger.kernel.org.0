Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF75AC029
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiICRim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiICRiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:38:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2A5723B;
        Sat,  3 Sep 2022 10:38:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z29so7504798lfb.13;
        Sat, 03 Sep 2022 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=umA9pNWUzA7jidUk20/rQkICnueDyRo/bSzQh0Un5OQ=;
        b=VyzRNIPerqW7I2eLeisbraYtMw+0LYm0zIpPAVWdKSSdHWT/xCWCsp0zWPwXoLJMh+
         goWZU++QcdZPHEow/EbE3MCighBvzGVxClxj+OzcDeg7qVl++yunpPXNQ01tMimk9Nil
         o3xjyWbouw8GEZ5rtVXpCeuyeOvZfUYvXih1iKUWZYS4B5zyr0rs+Qp7tMJsvv3NWnl0
         0RaduV6sEHzrfBKsAnk/xWQvV3uUa4x+tn9f+zR5jX+WCCz3OtcEGQuCgvqQ1qtwV+4e
         nsp1bSuMMrGMJHCG5Ru+yZt8lscOgM/sAHrlB6rqDFjTbCZDBlJetndoMkX0Uq4SD0cg
         qr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=umA9pNWUzA7jidUk20/rQkICnueDyRo/bSzQh0Un5OQ=;
        b=dyl0MFsHz5WG1oEZjx+USnQNvwj3dbD40tLZnPe8DEM9qBXGAOR1NhZ3AWbDydVzI5
         z6sn7iNcExGFPj5LoOHe/i6hdjsyquzegt1KEdqoVUnGMBoIutXWtTtpRBBopnvEYpH8
         pcJqiIXQVj5oDxZ2NNnuA87PpqF+20k7+klDO5dpn3qKEno/gms/ORDeg3It3VCCKMhY
         Bo8LeQjwq565SszVJFniIlPYZfzUPTfO+BP+/RmODCAvNS5i6PAEIGzYVRSOKIoJg+xd
         K61oBupFRu0ChY1W81gDiRhvUG6JC0Xh+EnwtMHxuL4/eolzwYrMLu3swPpjogP2AZTe
         CKjw==
X-Gm-Message-State: ACgBeo3hmnw0GTYvZPoiFrI6Nn1K3fdmnMn/A5qjrfdIrPym6DR1/dAR
        wVTTW00VNmkWlmv+E/ny52ImwXLxWLJwXyhWKT2J4vA/1hqSbQ==
X-Google-Smtp-Source: AA6agR7Hs/+xwEowwLQe+sf+am2LMCCYbskcPVWg25l+bwBfAQC13YuN5kobnm2fSunCnRskcOjFYam9DiwtSafspBg=
X-Received: by 2002:ac2:5510:0:b0:495:3773:f9fe with SMTP id
 j16-20020ac25510000000b004953773f9femr748646lfk.65.1662226686593; Sat, 03 Sep
 2022 10:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220901220138.182896-1-vishal.moola@gmail.com> <20220901220138.182896-21-vishal.moola@gmail.com>
In-Reply-To: <20220901220138.182896-21-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 4 Sep 2022 02:37:49 +0900
Message-ID: <CAKFNMo=TxJf=47DCnsscu7ZZuDNVi1LDoDHYZo_XscOSzOfi_g@mail.gmail.com>
Subject: Re: [PATCH 20/23] nilfs2: Convert nilfs_btree_lookup_dirty_buffers()
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

On Fri, Sep 2, 2022 at 7:06 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/btree.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
