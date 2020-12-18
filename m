Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC142DE53F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgLRPAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 10:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLRPAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:00:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1DC0617B0;
        Fri, 18 Dec 2020 06:59:43 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id i67so2155089qkf.11;
        Fri, 18 Dec 2020 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=btTFe9SQJ12UsM8X01XRMs1GCaQg0iWb0+ZNquj0Yho=;
        b=e4txPl7w1XfT0AF9f9WIr694+OCREoNz2aoMqbtbBWuGj4WqmSno11qRfiOxyIYfAP
         pQOvE/5DaDl7dwc/TdNY3eGa1xUmxEz1rFlefvLY/wK1Zcg4S5jjtwsJj/sSuR1OxHqQ
         8FgoQY7tq3utNH9sDFqGDURPi9fkjpoT5AvRmRLbWbW8Et2DUz/MEINM8z2ACRzDkK6y
         pUHyLLcWXdDeA/NnV/lx5G3v1Ld2x6fHThU1XRiYSeCSk5Sfr08p2HXHV48atgZrcaeJ
         MnxvomDQxBsudSzDpdeQ5FSyJQkcIKe5e/jChNMPiHBhQCpJof68XQgX0RADrRZcsOqU
         w2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=btTFe9SQJ12UsM8X01XRMs1GCaQg0iWb0+ZNquj0Yho=;
        b=MfVY0D2K/n80FOGaYiiZcRyw6nXg3qH7WmTa8AyJlNxVrjzFWjeOMDdteCB/hoHA1d
         ZMf5AxBfj3IKckIj0o/Yu08ZTsIPPXptSJ9VE9g+wgDetkScI1XkDEFVqVK3NVy+dy3n
         7l2XodkqPz/XkWc/314Zk3ixKHM5jQ4Wkb2qShtUDn6EzZliflPM7XJyHjKG8KodY2qz
         UVWjbOutziMMjVtqjUrpjtbO+HREkpb62dx6txGCB0aKn71pbOqjWgxm5luIoXJu+sif
         +x0iNFeI1biFhsINJmKCttVY8O23PZO60W/h+fME1han0S60qmPB5lrh2QWa/obWjBgV
         gqmA==
X-Gm-Message-State: AOAM532rU+UN6PBJdMKVcQvKB9MIiKvnUQZwWmsYagrTBfzlKtEMhGe3
        ktZBmal3+hcy2J43O0RTwGU=
X-Google-Smtp-Source: ABdhPJwaHLdTGSrENguGze1yXBIkNLF8wP/RHMekAKxikbNXyIEErjFzKuRPIKoM+wyg1LyWwA536A==
X-Received: by 2002:a05:620a:158e:: with SMTP id d14mr5001846qkk.358.1608303582534;
        Fri, 18 Dec 2020 06:59:42 -0800 (PST)
Received: from localhost ([2600:380:bc52:ed25:f121:8f09:67ad:9838])
        by smtp.gmail.com with ESMTPSA id d25sm5675018qkl.97.2020.12.18.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:59:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 18 Dec 2020 09:59:07 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <X9zDu15MvJP3NU8K@mtj.duckdns.org>
References: <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
 <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
 <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
 <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
 <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
 <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
 <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
 <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
 <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
 <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Fri, Dec 18, 2020 at 03:36:21PM +0800, Ian Kent wrote:
> Sounds like your saying it would be ok to add a lock to the
> attrs structure, am I correct?

Yeah, adding a lock to attrs is a lot less of a problem and it looks like
it's gonna have to be either that or hashed locks, which might actually make
sense if we're worried about the size of attrs (I don't think we need to).

Thanks.

-- 
tejun
