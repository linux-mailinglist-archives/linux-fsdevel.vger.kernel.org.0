Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901096B0CB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjCHPaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjCHP3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767B80925
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678289345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=+0LcXfzuApIChf/bYZ6JaLLsty8097OdMTZqqjVU8UA=;
        b=UnG0kZS83CwGNhRUvdrkptCQbzLc8CgjMwEcwKbQU+RTOAzNuGtCXfrBo/19CuETGZViqX
        x97XQjI/+r5cwaKWVYzi7smIZfqIqt0Pld14O8kHEuuLS1vL0BYpfjWPNZX6aw6V6aGUck
        1YPG0wWYiv3jV829wffXWxm3X9osbQA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-E8oOf4HpP0eHKGGVSuiJKw-1; Wed, 08 Mar 2023 10:29:04 -0500
X-MC-Unique: E8oOf4HpP0eHKGGVSuiJKw-1
Received: by mail-il1-f200.google.com with SMTP id w8-20020a92db48000000b00322124084f3so3552163ilq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 07:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678289344;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0LcXfzuApIChf/bYZ6JaLLsty8097OdMTZqqjVU8UA=;
        b=cIY6p51Cvvo0A23GyFia61xohqT3KMAEMwiKwh5dMCtPBl0Soxlrf8ZUbH0yaUT/qO
         GBmFHm/fb/a4GKC773cGff1jJrmzTV8W0UC4/PJZ4ieh3wP6khpj0+SF8C1J7xq8g85C
         VITcGaygSXm713SkWt8R6SpFf19li4XbJNDkhoFZOxf4MO5pzVUjSHqzLChOnFnoT4Wx
         kgco4RPYOlT4qEFWyETp+FAs0V1f0bnVMhwG/K60NuVU75Rx9eOgMWqhWtQZkmuPaume
         TVrjGU+KTNX046I84xpIZi8hOw31QwFtMaA1+6eG++1u4m/1r+3gR4ikHs+s7ySsJLxa
         Hmeg==
X-Gm-Message-State: AO0yUKU5xUFULSP4h1iP5Sa08wAO8O9FHBrfxreskCL3F3k8bZCtThk/
        UnnkxreTalP0mniomYUdKd0APcWPqgQdRKF7btCzMhNsOAKkkKGqAprJwnD3MPlxAS2fx11ujDk
        ouKy1HT8zZJK2BAmBwlST5xj9PwwwyrVo0ZJH0wWXzw==
X-Received: by 2002:a6b:ef18:0:b0:745:dfde:ecec with SMTP id k24-20020a6bef18000000b00745dfdeececmr8536748ioh.1.1678289343958;
        Wed, 08 Mar 2023 07:29:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/WVCYzqLPmpgQ6zClEcdMuRUn7JOfTlrBeabEyoosrsZf/PzBA+qDsB1nh2lqJy7B/qVkmwGVgLRRgSonji5U=
X-Received: by 2002:a6b:ef18:0:b0:745:dfde:ecec with SMTP id
 k24-20020a6bef18000000b00745dfdeececmr8536743ioh.1.1678289343739; Wed, 08 Mar
 2023 07:29:03 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 8 Mar 2023 16:28:52 +0100
Message-ID: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
Subject: WIP: verity support for overlayfs
To:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As was recently discussed in the various threads about composefs we
want the ability to specify a fs-verity digest for metacopy files,
such that the lower file used for the data is guaranteed to have the
specified digest.

I wrote an initial version of this here:

  https://github.com/alexlarsson/linux/tree/overlay-verity

I would like some feedback on this approach. Does it make sense?

For context, here is the main commit text:

This adds support for a new overlay xattr "overlay.verity", which
contains a fs-verity digest. This is used for metacopy files, and
whenever the lowerdata file is accessed overlayfs can verify that
the data file fs-verity digest matches the expected one.

By default this is ignored, but if the mount option "verity_policy" is
set to "validate" or "require", then all accesses validate any
specified digest. If you use "require" it additionally fails to access
metacopy file if the verity xattr is missing.

The digest is validated during ovl_open() as well as when the lower file
is copied up. Additionally the overlay.verity xattr is copied to the
upper file during a metacopy operation, in order to later do the validation
of the digest when the copy-up happens.

The primary usecase of this is to use a overlay mount with two lower
directories, the lower being a shared content-addressed-storage
containing fs-verity enabled files, and the upper being a read-only
filesystem (such as erofs) containing metacopy files with the redirect
xattr set pointing into the lower cas storage, as well as the verity
xattr. If this is combined with fs-verity or dm-verify for the
read-only filesystem then the entire mount is validated, even though
the backing files are shared between different images.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

