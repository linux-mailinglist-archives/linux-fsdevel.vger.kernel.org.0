Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42B58DA90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiHIOwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiHIOwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A976015A1A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660056719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vgi0fTJ0b7FwJs6rQF7KjB7lyfCm+3RLPeRFrj9jfRo=;
        b=a72a8q+AyBMqeLWzUTWkRQV1sbcoC4fnquzkuJUdpa3UbAdT9/14zA+ptwfb95NCSJljwr
        lP9JrV2AbfzmdpSKQSHqdFsBBb+UeoStPoGSXcbOPK9gJQ5+LlIMvI3ZHlOECHYkn7FdR1
        /3bQYY/OxGIMLXBjpPOSGALBuqbd99g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-wnMU2gRnMJSGaAfe8YAZDg-1; Tue, 09 Aug 2022 10:51:58 -0400
X-MC-Unique: wnMU2gRnMJSGaAfe8YAZDg-1
Received: by mail-qt1-f198.google.com with SMTP id ff27-20020a05622a4d9b00b0034306b77c08so1602297qtb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 07:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=Vgi0fTJ0b7FwJs6rQF7KjB7lyfCm+3RLPeRFrj9jfRo=;
        b=eURCdp9dhRil0YurkhOEJ4k0unZLU0ucrO4+rKs2nr5XHrFJwsgWQmt4oKiG0/4rOm
         BZx9x5SJihtf+V5ZH08OBdsjywgc7cpi8pVubhJPcU2CUIHlRK+jrrlguJUnK081tzDD
         rHoi3tNmnkVp+VFXRPOfS0yxKYpuhW8QEpA4OZOkWwP/RdDXgVusXVCKcVnlGD5d7s8X
         OLmuluZvbTmk2Oo+yKBvZxV2w90JISIiyBPjQ3WqvRDCnR3Mb1Rojyxir1+tVV4JBeSM
         zJ1FQfLmBPcxs1CY+5UpIWWQ0rRB5RVcXitqYjDTuDME38ElCcGNZWjZZpXJdz01mR4/
         KeLQ==
X-Gm-Message-State: ACgBeo35t4uCSPptQf7NPzO4o27shb2HHuB3qy01AphA+nnIJpGG+i8a
        4slNN7RPaB7G5yVcDbCREdK9zDqUCZ7vnm4FqN3Qrw60p+VAtNQP9UBDMl8zH03NmlQeNSvWdyO
        jsTTr7WjVlxPzPQLnuXcsMTRxtA==
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id a135-20020ae9e88d000000b006b94a0bcea5mr7552267qkg.748.1660056717952;
        Tue, 09 Aug 2022 07:51:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ht1d2UtrHEHqkYrVKiHdtZHjC/M6JbCKxTOnvN8bV9CbFLEewpo0UWYYtDBqkdpBXv00s7g==
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id a135-20020ae9e88d000000b006b94a0bcea5mr7552258qkg.748.1660056717731;
        Tue, 09 Aug 2022 07:51:57 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.152.92])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006b59f02224asm12397244qkp.60.2022.08.09.07.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:51:57 -0700 (PDT)
Message-ID: <469a34bb-e566-fc9c-3367-2c4e4fe1f776@redhat.com>
Date:   Tue, 9 Aug 2022 10:51:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.2 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

In this release there is a two new commands (rpcctl, nfsrahead)
but mostly it is bug fixes and updates to config files
and man pages.

Thank you for everyone who has contributed!

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.2/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.2

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.2/2.6.2-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.2/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

