Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BED4A79DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 21:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbiBBU5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 15:57:46 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:43740 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBBU5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:57:45 -0500
Received: by mail-wm1-f41.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso422530wms.2;
        Wed, 02 Feb 2022 12:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oIyPxiDfzVDRtE7UMRXVR4ajUxUuMcTHsY89cmsysY0=;
        b=BpwShtm8hs4A7Hi8JEeIFE4yYRbnr+Z6KCeRqwB5AutsLZNBKbEnyYscj2eDNiFvn2
         GnHgPEMZr2pQk9PH0QEjC5R8waOvGQxU4knwKu0oNsmrshgRH4Ec/NNKU++tr0cs9dvR
         Pxe/01tXespX94bMHaFKjU2KU4QQvM9Uu9Vhyy2cX0WeANYnvl9H+MGt5rzuA7TnrOnQ
         +vWiL0a51Yfl8KEBvNmcCLBD1XcsFaKDJ2bOXb4PtWW8U57ztsxsbrmO/4mUxlKZ4b7t
         zz/gILoEj1DAio1TEVT0/+yUDy1xGH5hdXzzImYCT8I31GdQ4HKaP+v6fYt3Xp+9rPop
         o4RQ==
X-Gm-Message-State: AOAM5307LAbfwTZuiDnqtRmhZc5lgpzNtknKkujYw6vEd+nU3JHKmMoL
        RgbcKPySwsyrl1ldYofQY/FkBv1OLR8=
X-Google-Smtp-Source: ABdhPJy1hTjgBquVbH7T+1Pchv+xCOouM5FJq4sGB5simcA3jH1shtiSVCxikRUxKMCs36j8SgHk+A==
X-Received: by 2002:a05:600c:4e4a:: with SMTP id e10mr7762089wmq.113.1643835464462;
        Wed, 02 Feb 2022 12:57:44 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id h4sm21701817wre.0.2022.02.02.12.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 12:57:43 -0800 (PST)
Message-ID: <2640b631-f8ac-ab4b-5ff1-884972f25334@grimberg.me>
Date:   Wed, 2 Feb 2022 22:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel
 consumers
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Hi all,
> 
> nvme-over-tcp has the option to utilize TLS for encrypted traffic, but 
> due to the internal design of the nvme-over-fabrics stack we cannot 
> initiate the TLS connection from userspace (as the current in-kernel TLS 
> implementation is designed).
> 
> This leaves us with two options:
> 1) Put TLS handshake into the kernel (which will be quite some
>    discussion as it's arguably a userspace configuration)
> 2) Pass an in-kernel socket to userspace and have a userspace
>    application to run the TLS handshake.
> 
> None of these options are quiet clear cut, as we will be have to put
> quite some complexity into the kernel to do full TLS handshake (if we
> were to go with option 1) or will have to design a mechanism to pass
> an in-kernel socket to userspace as we don't do that currently (if we 
> were going with option 2).
> 
> We have been discussing some ideas on how to implement option 2 
> (together with Chuck Lever and the NFS crowd), but so far haven't been 
> able to come up with a decent design.
> 
> So I would like to discuss with interested parties on how TLS handshake 
> could be facilitated, and what would be the best design options here.
> 
> The proposed configd would be an option, but then we don't have that, 
> either :-)
> 
> Required attendees:
> 
> Chuck Lever
> James Bottomley
> Sagi Grimberg

I'd be interested to discuss this.

One other item with TLS besides the handshake part is that
nfs/cifs/nvme-tcp are all tcp ulps like tls itself, which at
the currently cannot be stacked IIRC (all use sk callbacks,
including tls).

Is anyone looking into enabling stacking tcp ulps on top of tls?
