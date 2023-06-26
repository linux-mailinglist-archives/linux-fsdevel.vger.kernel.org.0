Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1D73E8F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFZSas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjFZSao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:30:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB010D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:30:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d9890f368so1676582a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687804236; x=1690396236;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZcNk5dnSDXU4m2jPSZ7WfsjYlgWRPbt7AFCuwHpRlI=;
        b=A2giA9Bk4mKvzTvcXd56HVsiwY1MA/5G8/WnQQwCVZ8hctrkLzU/3GAMe3NnMn/u8B
         NpZm0LpDjcPa/23jgeGQIE9+BTpAWccBcl3TjuezoPqZW1+4b0j5ZGeDLqOCAv7C7sFp
         JL1OsKBifrdJ+5FxvilZVX+CuvLZqgh9nfxjeUrQSIibUTtYtLSAq8NMoe7UJVmspKbc
         zayiFLsaHpmyUTfrmdmfY4oszU7Hwzf01lVOxLENcx6TrXucpnW4CZIc7ATS2hQTG8AV
         DM5yRTHfOu2nFktjjCgJQS/sBB5iTMR7nsh+3gOGKz/UWQDG0C7k/yYfxmlrBHEzhoG1
         sQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804236; x=1690396236;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZcNk5dnSDXU4m2jPSZ7WfsjYlgWRPbt7AFCuwHpRlI=;
        b=T4lmKNG8J8SlpwSkT+0nc7W+eibnfR6bRArA8cCACgGza/FxXUtslimHU6qiHQjsfU
         19Z07cp7LsPJJcupWJIdzr7SPKDlDfnRiDzNAlqiEkEqSYpRHYid05Oa9pyunDUecwnp
         dPdNDlUSMbpyviBfaOYdUdxA2f24CjZu8CjHJO3Guv7FYnFMvR9xjOT2cLMA8DbXo1pE
         /OET7bBfQ06r5QEMqFZ31EtH1ul4h4/w8OjaRZf4BtcjOgmqmc9nk3i2Os7YgXqQiRGQ
         SApfQ/9PUI/4kSPZkjWEPOTO7Yu7hksAGlNRKmeBmm0FljtlZej0qlKz7zMDebx5OwbZ
         /Iwg==
X-Gm-Message-State: AC+VfDx3SHq649c0QilnhBWtxBmtzMuNXXPRwpsFKga2mKqmRwQJIt9m
        tGbgCHPIPhGTgKkmiGcpxgU/7Q==
X-Google-Smtp-Source: ACHHUZ6xUBxB1HXnuaoz07JtPXm+JO2uwoH+KaAJy3XVZENmrd8PqJ16iMuF32RMJGApdeZ6EoFW/Q==
X-Received: by 2002:a05:6402:7d3:b0:51d:a01d:afd3 with SMTP id u19-20020a05640207d300b0051da01dafd3mr1548108edy.22.1687804236266;
        Mon, 26 Jun 2023 11:30:36 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm3099746edw.87.2023.06.26.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:30:35 -0700 (PDT)
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <02730282-88b0-572e-439c-719cfef379bb@wdc.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Date:   Mon, 26 Jun 2023 20:23:48 +0200
In-reply-to: <02730282-88b0-572e-439c-719cfef379bb@wdc.com>
Message-ID: <87r0pygjp1.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:

> On 26.06.23 18:47, Andreas Hindborg wrote:
>> From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
>>=20
>> Zonefs will try to use `zonefs_file_dio_append()` for direct sync writes=
 even if
>> device `max_zone_append_sectors` is zero. This will cause the IO to fail=
 as the
>> io vector is truncated to zero. It also causes a call to
>> `invalidate_inode_pages2_range()` with end set to UINT_MAX, which is pro=
bably
>> not intentional. Thus, do not use append when device does not support it.
>>=20
>
> I'm sorry but I think it has been stated often enough that for Linux Zone=
 Append
> is a mandatory feature for a Zoned Block Device. Therefore this path is e=
ssentially
> dead code as max_zone_append_sectors will always be greater than zero.
>
> So this is a clear NAK from my side.

OK, thanks for clarifying =F0=9F=91=8D I came across this bugging out while
playing around with zone append for ublk. The code makes sense if the
stack expects append to always be present.

I didn't follow the discussion, could you reiterate why the policy is
that zoned devices _must_ support append?

Best regards,
Andreas

