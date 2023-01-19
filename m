Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1743C674435
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjASVWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 16:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjASVV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7F9F3B3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iHY1JhHo7sNRnq5TCZlVvfIFAGkKRvvynfD4YQ8b9Q=;
        b=DRcAqwNV4HxukkKMUGswPaSzi+x1SaoxCy/O2R/GGie7oCD3P6QuDM8spIQMIkCGzY9V3q
        kkf0FwMoeDCVcA4jgzdoVhgvHB9YPU0oxGselaiWu9YUdv3QLnl7hBv1HF4Q/zPYeJ0wcR
        qxr3oO5SBSsjuCIVmK/N2MGtohZ77VQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-mdqu-pZaOjeAcZnVBVo3FA-1; Thu, 19 Jan 2023 16:14:15 -0500
X-MC-Unique: mdqu-pZaOjeAcZnVBVo3FA-1
Received: by mail-qv1-f70.google.com with SMTP id t13-20020a056214118d00b00535360c0b52so1588653qvv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iHY1JhHo7sNRnq5TCZlVvfIFAGkKRvvynfD4YQ8b9Q=;
        b=yDm2SLfthHK4xVrbB5IucVp303Cm3Lyqv3x8pfCbT5A0sucEr9KV6VXdij5CpJDlXw
         eFwNa74cZdWFoLBrZ2LWGxGtG49/qjAf5ByAc6zxVjJrvrRkikNCjk7gjP5Q2lS3aSsk
         9jqLtTwWMgZ1+CcCVWZseHiK1qJTwI8/Zfdt284Tfjt43pGyyB8xvmYA7PBCIfwbDo84
         dbgnoYG6oA1Q+d39eYtYhQJ5IGLMX50MtJtGzAo37MiNzmbrwJ0pK7P2bzrMicALDykb
         wcuHA+2HAAHfhqkCmqn8VTSHvcGeeFVA6oYAkK2RmPvbmI6e4n6hTob1OWw9HSeBkbbf
         Q4kg==
X-Gm-Message-State: AFqh2kr/R7HAVzhPrG03ZXNDUpogpOJP4mF4dLFAHz6CxgvMuXUvPdJ0
        UF6e1swPT0yn8xPWLI4nvBXoiQPeaaZv//CkQ/vSjHiyEK0Tc3gRKUI+OONJefMYyjug8s2+Q9b
        f2UIDivt+JMS0GxUyLgcNmAkqng==
X-Received: by 2002:ad4:424f:0:b0:535:5a09:8312 with SMTP id l15-20020ad4424f000000b005355a098312mr3170021qvq.34.1674162855301;
        Thu, 19 Jan 2023 13:14:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt2pAh2PbL6ofFXjhTL8NCW+Ds/0+z/BXxNI16rcaTPJz1b1RTgCytbMYeE0N9f5zuezGPMrg==
X-Received: by 2002:ad4:424f:0:b0:535:5a09:8312 with SMTP id l15-20020ad4424f000000b005355a098312mr3169995qvq.34.1674162855013;
        Thu, 19 Jan 2023 13:14:15 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id q44-20020a05620a2a6c00b006fc9fe67e34sm10705407qkp.81.2023.01.19.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:14:14 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:14:14 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [RFC PATCH 0/1] fs/namespace: defer free_mount from
 namespace_unlock
Message-ID: <20230119211414.qfkh3hrmupcynrrb@echanude>
References: <20230119205521.497401-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119205521.497401-1-echanude@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:55:20PM -0500, Eric Chanudet wrote:
> We noticed a significant slow down when running a containers on an
> Aarch64 system with the RT patch set using the following test:
> [...]
> With the following patch, namespace_unlock will queue up the resources
> that needs to be released and defer the operation through call_rcu to
> return without waiting for the grace period.

I did not CC:linux-rt-users. Resending with them included, my apologies.

-- 
Eric Chanudet

