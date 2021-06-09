Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7473A11AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhFIKzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbhFIKze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:55:34 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA54C061574;
        Wed,  9 Jun 2021 03:53:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id e18so12509069qvm.10;
        Wed, 09 Jun 2021 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=0YVz+Tp9c/+BLdLLg/dEk8hVG2/4HLSUp+VXgepDnM0=;
        b=pf8nagyssHGUxyRjUvhABlSHergN77+RWaufZevQ2p17UnOXHE69CPPhR31vtc84sw
         WY5huLOmWveUt3LadLXtF34q/Q1CCQk0Q7x0PIw50J3+KuJUKlg9WGLrCgjVFzq6KIbZ
         XyuRt523PBVclEE3MKoU67oIXabWh2iGyC2Pm9DOHaOvusEy4LJtcAuQUZ4Yin9dnCeY
         LbGWTuSz9X5wQkaQZIiLPtpd0+f/vievjZT2nLfHxj7SPgoKQI0TVfRXeWM5BTKuvwWv
         ixn8BZRxbfGxvR/WZ3iDcC5wsa5yybvAnbzMrhYj1xVTsxbKlubyB0jrU/OBJp7YPuvc
         8qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=0YVz+Tp9c/+BLdLLg/dEk8hVG2/4HLSUp+VXgepDnM0=;
        b=DeeMYR2UTA3UlRVXuWeuy6uVmGOgin+Lu+W/yGyjy8fN8TR04p0Y3jHpQFKtVuqa6o
         Uvjd4/nTVSstg6Y5f9Ugq1dZKpiL8sTrteJaXo72NB56Kx6IaYDid1m0jivGLCrKSuzr
         SagrxatjXfNw+pz9JVxqbcy8o5Sm7xKQxj8RKp9aAKvp1F8bx0UHR1AgNyi8RUeBU8Wz
         r6WdwRCtVPmR4Z21C6TlD/1Vdfp7h6pG6dB/vSLrAcenjaI44GT1GNi6W6aTfSi4rwnX
         K0e0BipUFmAQoqkZKbcpjxf/7QnLQgWU/J0Ok6EG40jUzAXZVvH1hkVwAv7/6taHeMp7
         p2QQ==
X-Gm-Message-State: AOAM530/rzZYLKpus0I7kgp8JYRAtVFrWxHCN3xYYkm7PGoA2cigBXyG
        wqiFDg+FeAQpetGwMqO7IMzv7fIVSnmwbg==
X-Google-Smtp-Source: ABdhPJwtZMHelbQEQM4fDC9UawbdbSF72e8Udsuo0J0026QmwPoeJr/GjVYT4nkOd+EDafShg6WIkA==
X-Received: by 2002:a0c:d784:: with SMTP id z4mr5162868qvi.27.1623236009982;
        Wed, 09 Jun 2021 03:53:29 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-195-35.bstnma.fios.verizon.net. [173.48.195.35])
        by smtp.gmail.com with ESMTPSA id z2sm4794746qke.23.2021.06.09.03.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:53:29 -0700 (PDT)
To:     lsf-pc@lists.linux-foundation.org
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
From:   Ric Wheeler <ricwheeler@gmail.com>
Subject: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Message-ID: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
Date:   Wed, 9 Jun 2021 06:53:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Consumer devices are pushed to use the highest capacity emmc class devices, but 
they have horrible write durability.

At the same time, we layer on top of these devices our normal stack - device 
mapper and ext4 or f2fs are common configurations today - which causes write 
amplification and can burn out storage even faster. I think it would be useful 
to discuss how we can minimize the write amplification when we need to run on 
these low end parts & see where the stack needs updating.

Great background paper which inspired me to spend time tormenting emmc parts is:

http://www.cs.unc.edu/~porter/pubs/hotos17-final29.pdf


