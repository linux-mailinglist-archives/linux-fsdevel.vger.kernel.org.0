Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7426E62ED24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 06:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiKRFTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 00:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiKRFTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:19:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC056E561;
        Thu, 17 Nov 2022 21:19:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m14so3588531pji.0;
        Thu, 17 Nov 2022 21:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcIuQcLCsjnhf/p1ZLkRf0dV0hj0p3rtvP+Km7ohZPk=;
        b=NCnguB2tMVp++4PdGsvAVu/CFkIDb5K7XdPl+FXdgXQ3dyhlu5aACP3FOeC8Lodnkj
         VrhUZDDuLc3In5spyOuJRbPKQPSrFG6XWkMUx0V3oVD37yC7yOYKgxxNAcHB0JmWQRf5
         WGDpDs+Y+g6iIOCxvO630CYN0kdNL+rjF37D5vnbC8wGkRkEL592q+zNtETdlaPmXVqu
         LPt1fiyK/PHFbsNVtya671UdEnRkF5l22xSrs+KdwOOdl/oCpSJj/DsR7cskxOFNEgrl
         +4nA7nznIuyQJA+jOE5SX/7lVFuSnqUZKR4RDqaqWRPrNMe9fPVH9/gGy3qg5pTuhcdi
         rCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcIuQcLCsjnhf/p1ZLkRf0dV0hj0p3rtvP+Km7ohZPk=;
        b=it40hiYyP/zZ9ym1rAuiseBwi6ruRSBjhPNkGTOcSOFHUL0y3vOjBwXAsgdZm9ysJp
         6BRvF8xnWz+Bl+fZwz3GXjUTuG6eSac3SJUTg/zRv49hQzOmLh4Vy3VFR2dXict6wq9n
         DKXGw/BObb68XdGmR7oB4v2gCZH/fIrk4mWOU6+/1kdzC8rGTkDmIgvTw+92GK+w3TLn
         xEqxzDWHkWCxeQObD4C0dwWA7IgOVKWPXqVOZSiG6Rz0z9MvU+9hd7sblBSlYnuWZFWh
         fcODlY2bzd3dq2nbvPFXLe4u5Y9JLL6rQk3TTKk30VFBrndaCQtLinJAIJ0TOVvJIvU9
         /RgA==
X-Gm-Message-State: ANoB5pnRlr1Ht09HzH5Y/w2LpNHWeysjq1CdPDLwU3MKJqFXFVlYHn7W
        hQ9fyI63f+m//cUWI5Z71gk=
X-Google-Smtp-Source: AA0mqf7qgaXHWqhBXtVgEUPTJ4k7xN1n2fC6NGm8mmPNSXvBEuindVJw9xJrAvNjk6PcFFzGPaQKIA==
X-Received: by 2002:a17:902:edcd:b0:186:c3b2:56d1 with SMTP id q13-20020a170902edcd00b00186c3b256d1mr6031620plk.15.1668748786076;
        Thu, 17 Nov 2022 21:19:46 -0800 (PST)
Received: from smtpclient.apple ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b00186a8085382sm1220711plb.43.2022.11.17.21.19.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 21:19:45 -0800 (PST)
From:   Gmail <liuj97@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Feature proposal: support file content integrity verification based
 on fs-verity
Message-Id: <D3AF9D1E-12E1-434F-AEA4-5892E8BC66AB@gmail.com>
Date:   Fri, 18 Nov 2022 13:19:38 +0800
To:     Eric Biggers <ebiggers@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, fuse-devel@lists.sourceforge.net
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello fuse-devel,

The fs-verity framework provides file content integrity verification =
services for filesystems. Currently ext4/btrfs/f2fs has enabled support =
for fs-verity. Here I would like to propose implementing FUSE file =
content integrity verification based on fs-verity.

Our current main use case is to support integrity verification for =
confidential containers using virtio-fs. With the new integrity =
verification feature, we can ensure that files from virtio-fs are =
trusted and fs-verity root digests are available for remote attestation. =
The integrity verification feature can also be used to support other =
FUSE based solutions.

Fs-verity supports generating and verifying file content hash values. =
For the sake of simplicity, we may only support hash value verification =
of file content in the first stage, and enable support for hash value =
generation in the later stage.

The following FUSE protocol changes are therefore proposed to support =
fs-verity:
1) add flag =E2=80=9CFUSE_FS_VERITY=E2=80=9D to negotiate fs-verity =
support=20
2) add flag =E2=80=9CFUSE_ATTR_FSVERITY=E2=80=9D for fuse servers to =
mark that inodes have associated fs-verity meta data.=20
3) add op =E2=80=9CFUSE_FSVERITY=E2=80=9D to get/set fs-verity =
descriptor and hash values.

The FUSE protocol does not specify how fuse servers store fs-verity =
metadata. The fuse server can store fs-verity metadata in its own ways.

I did a quick prototype and the changes seems moderate, about 250 lines =
of code changes.

Would love to hear about your feedback:)

Thanks,
Gerry

