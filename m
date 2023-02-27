Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E26A3E42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjB0JYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0JYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4901FC6
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 01:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677489754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vo8mhK1MbLnTZEqNS3aMzCOGYAA/lhv7Cj3z7Kmtpns=;
        b=ShmkDX4BlJ55Z3wBIAxxVly+sE3JrGZo9mW5tuF6Mxef4xQMdayPYm4EAGvayBok0Hw7m8
        Yk7I21Qrb6+6pDiCugJSBy3DVjZPFt8joCJivoWS2yoqNh5vS8TSUUY48XQcCJ2gk7k6Zw
        NhGweGxLBD/XTgJYO7BrSXFdV+sZ/zw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-t3pZ8LsvNGKlGAaFfuJmDQ-1; Mon, 27 Feb 2023 04:22:32 -0500
X-MC-Unique: t3pZ8LsvNGKlGAaFfuJmDQ-1
Received: by mail-lj1-f198.google.com with SMTP id o17-20020a05651c051100b0029099954a31so1408441ljp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 01:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vo8mhK1MbLnTZEqNS3aMzCOGYAA/lhv7Cj3z7Kmtpns=;
        b=ntYIoZ9wMJSPkuvQJSUfxxkUBY0Hz0dC1YkYsPncDj7Ebp4elFbX1eRgb1Hx53bAKw
         onxZmAPAi/2kRJy1yCxQAD3C/NpR38v5DAgTz7ovrMlkr0q2hVJ4JrSnx7QxgPF6o3V3
         XrCLreXVI0ddRD4FU2n7tjkL9dRJi/+u6ATVkswVc37JyWdbXQKMZdaguPZIg7qmWVKA
         S37svOpCDApaC5Gd+rsEOep3CUQ7kaVaOWUdB0FLJLeGFw+08rlWw6iR/5qfp9qTRF5U
         h74IXp9kp3zjd/fzlTduJtBKVnuyZ54MuI91VH+kOhJ1Gznokr5PF+JS73xkwoQkZcSI
         aeaA==
X-Gm-Message-State: AO0yUKU5y2xIHSqbeJjG320gaQlEjYXOjFzoc+CJbXkM5hE5vKGfVn7i
        dWFRm/YoAM6kLLlMU5NXL68MOe+/xs378Nnc3PF0FLz8QwcMG11g+VrjhgXo0v6rg6sD2kvHji0
        E4ZVOGpHPqdHndq7BfRm+b2MBQxLJJ/ZDCw==
X-Received: by 2002:a2e:964f:0:b0:294:712a:5190 with SMTP id z15-20020a2e964f000000b00294712a5190mr8392869ljh.28.1677489750926;
        Mon, 27 Feb 2023 01:22:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8ln7Y2eAwP1lmxnF6aDntYo3LragSpJo0KiOsQ0jjatuXfP6dIRSx0+E1o8di5FESj0NYrmA==
X-Received: by 2002:a2e:964f:0:b0:294:712a:5190 with SMTP id z15-20020a2e964f000000b00294712a5190mr8392864ljh.28.1677489750639;
        Mon, 27 Feb 2023 01:22:30 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id a7-20020a2eb547000000b00290716d65dcsm651571ljn.136.2023.02.27.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:22:29 -0800 (PST)
Message-ID: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
Subject: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
From:   Alexander Larsson <alexl@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Date:   Mon, 27 Feb 2023 10:22:29 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
Composefs filesystem. It is an opportunistically sharing, validating
image-based filesystem, targeting usecases like validated ostree
rootfs:es, validated container images that share common files, as well
as other image based usecases.

During the discussions in the composefs proposal (as seen on LWN[3])
is has been proposed that (with some changes to overlayfs), similar
behaviour can be achieved by combining the overlayfs
"overlay.redirect" xattr with an read-only filesystem such as erofs.

There are pros and cons to both these approaches, and the discussion
about their respective value has sometimes been heated. We would like
to have an in-person discussion at the summit, ideally also involving
more of the filesystem development community, so that we can reach
some consensus on what is the best apporach.

Good participants would be at least: Alexander Larsson, Giuseppe
Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
Jingbo Xu.

[1] https://github.com/containers/composefs
[2] https://lore.kernel.org/lkml/cover.1674227308.git.alexl@redhat.com/
[3] https://lwn.net/SubscriberLink/922851/45ed93154f336f73/

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a lounge-singing crooked cowboy on his last day in the job. She's
a=20
psychotic nymphomaniac single mother prone to fits of savage,=20
blood-crazed rage. They fight crime!=20

