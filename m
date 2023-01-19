Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5553E674447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 22:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjASVYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjASVWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C209FDC2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y8twyfwh84c4dgge2UqdCfG48N/yPn3P76O0d8rOMcg=;
        b=XZgV8o4AKg8ILwAsd4e1N8Hu8Dlarwz3guX8Dubl6v8zYp7G/IQdhKQRDNYpPOUhGbnHG2
        53UCCfvi4DDAPpRxkR+kxh5NyfE6FZR5qpA8jYkk+Kc4ldTXO5xSa2twzeZ4rzLCVJzLZ1
        B0O28pzwZdlhhJ5k4UBsgxzCtWfqycU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-rWniLHwtPNuXFdBHonsczA-1; Thu, 19 Jan 2023 16:15:24 -0500
X-MC-Unique: rWniLHwtPNuXFdBHonsczA-1
Received: by mail-qk1-f198.google.com with SMTP id j11-20020a05620a410b00b007066f45a99aso2132490qko.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8twyfwh84c4dgge2UqdCfG48N/yPn3P76O0d8rOMcg=;
        b=F6koEauN3cIkc9uWT9wdPZoOyw2jb8nK6AWetnVuV5IYrWp2Q/zOwyj3+x/Y0gA/I5
         +ZRa+kUrtdu8S6jSX4cyS7uVd+eChk2UEcK7Uc5TIl7SO92OojB6wcOD2DzpQrgTWOFj
         Osc+2n40WypS9BiBe3RJokxyL3FldjBlMT/MFCtu+DnCmqfqKQl+N7yOSNm2qY97p5nV
         geDTxbWoCAO0UZ2C7M5/Qva65zRnzO1kPz9sBP1p+zPsaCaIUmhhxtF4yge7mW1dC5Zd
         EfyVx+1oEHMes3MJ/6LLH9PIL5Zz+2m/kUL+z1IoSUD1nidOWHLBLXf9m+ym17pN2XmD
         6IXg==
X-Gm-Message-State: AFqh2kopO5rU0c+4VAnjlBV0mr4mePI3jx3QipB89oU//FSy1613cpNE
        0hWMcqd4IfSbNmL/77OFALlEHkPSAgiytDa+y3axkGvuT1rju24IZRJanIn84he4G8JZs4yzR4w
        ju3OmZH/oRK5MUyFB10tt4txrMw==
X-Received: by 2002:ac8:6f09:0:b0:3a7:e271:fc05 with SMTP id bs9-20020ac86f09000000b003a7e271fc05mr20033786qtb.3.1674162924087;
        Thu, 19 Jan 2023 13:15:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt5lIz4aB4qsJoQg4L49XLKtqNPp0FBDtcmmb+e3C878DYLR74rp358T2jlf3lHOQTUY+nZ/w==
X-Received: by 2002:ac8:6f09:0:b0:3a7:e271:fc05 with SMTP id bs9-20020ac86f09000000b003a7e271fc05mr20033758qtb.3.1674162923829;
        Thu, 19 Jan 2023 13:15:23 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id t20-20020ac865d4000000b003ab7aee56a0sm3081504qto.39.2023.01.19.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:15:23 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH RESEND 0/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 16:14:54 -0500
Message-Id: <20230119211455.498968-1-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We noticed significant slow down when running containers on an Aarch64 system
with the RT patch set using the following test:
# mkdir -p "rootfs/bin"
# printf "int main(){return 0;}" | gcc  -x c - -static -o rootfs/bin/sh
# crun spec
# perf stat -r 10 --table --null -- crun run test

 Performance counter stats for 'crun run test' (10 runs):

            # Table of individual measurements:
            0.3902 (-0.1941) ##########
            0.5791 (-0.0053) #
            0.5785 (-0.0058) #
            0.5891 (+0.0047) #
            0.6682 (+0.0839) ###
            0.5507 (-0.0337) ##
            0.5888 (+0.0044) #
            0.5797 (-0.0047) #
            0.5977 (+0.0133) #
            0.7217 (+0.1374) ####

            # Final result:
            0.5844 +- 0.0269 seconds time elapsed  ( +-  4.60% )

A 6.2 non-RT kernel results on the same hardware for comparison:

 Performance counter stats for 'crun run test' (10 runs):

            # Table of individual measurements:
            0.1680 (+0.1375) #################
            0.0074 (-0.0231) ###############################################################
            0.0073 (-0.0232) ################################################################
            0.0070 (-0.0235) ####################################################################
            0.0072 (-0.0233) #################################################################
            0.0794 (+0.0489) #############
            0.0078 (-0.0227) ##########################################################
            0.0070 (-0.0235) ###################################################################
            0.0070 (-0.0235) ####################################################################
            0.0068 (-0.0237) ######################################################################

            # Final result:
            0.0305 +- 0.0169 seconds time elapsed  ( +- 55.33% )

It looks like there is one bottleneck in:
-> do_umount 
 -> namespace_unlock
  -> synchronize_rcu_expedited

With the following patch, namespace_unlock will queue up the resources that
needs to be released and defer the operation through call_rcu to return without
waiting for the grace period.

Alexander Larsson (1):
  fs/namespace: defer free_mount from namespace_unlock

 fs/namespace.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
2.39.0

