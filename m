Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47CE6B7869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCMNHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCMNHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:07:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E46A056
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:40 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 232BA3F1F2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678712859;
        bh=8xKukcOEpEg45PGBEMg25CUAUUinsxoVbA7uPjUp2qI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kD8t3zjYzPT7vqPkXW3tCbqNeJFDCcqApeXpHCXOiXL2kv9VU7Fhf5A20Yd0xJzWU
         Ir73fejnsqI5MEEoOmoDMVOc4FxEa9glPKrtBG0AKWT9Vy+Q17Q6L069zNZ7U4g2ek
         PmwEGaQbGkLBczoNbqJWdMUHZWjC/MkHm95PuZYip5HCmFyegGZKYYsD0yZ3i/VuXF
         fn4lyrJ5YRTGeH4mAb0fU+a0HRwPg5XEtKZfNhfd3gQksgLXB/pDmRReqE4KBPTCX4
         WcBwFv2NXhzYLwLUfzctqp0epXKNgBIQ1qONWQ/l1erM8MbvG+BLXvLAlXDxVMw/EA
         zFgs0PDbs4q5w==
Received: by mail-ed1-f70.google.com with SMTP id w6-20020a05640234c600b004fc0e5b4433so4310482edc.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xKukcOEpEg45PGBEMg25CUAUUinsxoVbA7uPjUp2qI=;
        b=lTnuHp9Jb84dv6wMW18sWqU5mtS3gwsmGrlsTVjq55SdiGMqOktwYifSBEBdxIsnjO
         +0BrAtPuzes3ESRSVvs52G46xTun9RoqTtbA+7/1TOOGRteZGJ/SKXtexmjsFicz5WV1
         8fEcD8atKbwN2jFGV8u427o0Sw7YZ0VKsEH2ULQHA7NAjVu94cWyK72KdAYznukEjJeQ
         KO6E8IpFLaRDmUbemBrlML2Ic4uXuanQukUVA9IqVAyANOYyedYHT03clCKJTPtsxXa9
         SyPqc6GMqnxuPJMeHS7sLBRDBXxI1FddIRZhs4ToQgpxisDRzeygmZhsF0vsPlE8XZ+x
         OlTQ==
X-Gm-Message-State: AO0yUKXv5dvfdBtFhz27rqJmEBnABEtszCLrGzIxPAWyrsFQ962TWiWd
        J2+8kOw8a6kQU9J0ZbK79awg4WX4fmIEH7p18OJtuMaJKmP7Rbb86eAy56+/HyPlDL1ByP5Ptaj
        OfBL8fKntMYntjbvyC30uEyZAOoTd46N1VEINAubf0j0=
X-Received: by 2002:a17:907:1c0e:b0:8b1:78b6:4b3c with SMTP id nc14-20020a1709071c0e00b008b178b64b3cmr43238417ejc.73.1678712858729;
        Mon, 13 Mar 2023 06:07:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set85ckbj0cOHjM+X8NByK8/kJwhZyXdYAuzIu2h+APwfyBAqsaXdc1vkgh3m2Q8dfPu0vaIVkA==
X-Received: by 2002:a17:907:1c0e:b0:8b1:78b6:4b3c with SMTP id nc14-20020a1709071c0e00b008b178b64b3cmr43238388ejc.73.1678712858508;
        Mon, 13 Mar 2023 06:07:38 -0700 (PDT)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:c91d:59c1:64e:937b])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b00926f89e2213sm1711388ejc.190.2023.03.13.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:07:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     corbet@lwn.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] docs: actualize file_system_type and super_operations descriptions
Date:   Mon, 13 Mar 2023 14:07:16 +0100
Message-Id: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current descriptions are from 2.6.* times, let's update them.

I've noticed that during my work on fuse recovery API.

v2:
- fixed commit messages according to Jonathan's advice

v3:
- removed direct kernel version specification as Eric proposed

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

Alexander Mikhalitsyn (2):
  docs: filesystems: vfs: actualize struct file_system_type description
  docs: filesystems: vfs: actualize struct super_operations description

 Documentation/filesystems/vfs.rst | 105 ++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 19 deletions(-)

-- 
2.34.1

