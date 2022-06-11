Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096D154779A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 22:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiFKUyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiFKUyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:54:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44137340F3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jun 2022 13:54:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq6so4128352ejb.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jun 2022 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jd7TZkA7lybh5B4uGr3K0a+i9m897gef1MV3s/kY0MM=;
        b=ZKtc6ITWcmXElVEp6qLBUlUlxN4QCWWpTIcgoe928nfmImWDbRwEkCBMQw1ZehvMPL
         hbGFsMyz6TVPb23UsQxg2jH8TW6UuovjvODgmvtsRe35LVd4bFB/ikjDYwuVdIK3/McG
         ++b781QwMlGiazIwReCrubG7sfXZP5PqT/0fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jd7TZkA7lybh5B4uGr3K0a+i9m897gef1MV3s/kY0MM=;
        b=MzQr8k0GiNAORZxolGqes99zZaxykBxl0zhO46I0THt9R+IuIFFGFfkv+nWMNMjyBu
         UCNPg02EAE6owiqurG3pqkdAm8QRVy+lTMHoKGpjWQ8s9pr4cbxPsRwkRyuTAWVAqVJD
         eCzHBRB2RZV6rs0Gp76fccEZ1p0z86+mpmprK1AeCjOcHPL47rbcnUW+sXOxOAZv+Pgt
         D77sr0cKZ/EWFDUVL1+LQRBoct5SnSkIJ8cia1TbK4fIy0lNK+SRSbpZLTRLa0Vz+Aor
         ymq4NF5G9yjkFDtq8U9bjBa049AITIvw9LT93dltlhJcqVfoV7YOLEcAJ/9MgDn+AAte
         E2IQ==
X-Gm-Message-State: AOAM531wv4qjS4o+sfFER2UCaH422wmiIZaHGdW3+cIMYhSeTs5mXqOC
        xYyrNasaU7oyDFeVBB70N9iftB/neYh2Buy2
X-Google-Smtp-Source: ABdhPJy5xnJ80NPtG1uJXusvYfEaFalBNxINEvxThqD4YBAlJ8J6bJjy47NY5S7odtwyksZQJmw6nQ==
X-Received: by 2002:a17:907:608b:b0:711:f36c:847f with SMTP id ht11-20020a170907608b00b00711f36c847fmr18604425ejc.558.1654980860616;
        Sat, 11 Jun 2022 13:54:20 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7dad8000000b0042dd482d0c4sm1987324eds.80.2022.06.11.13.54.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 13:54:20 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id q15so2613965wrc.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jun 2022 13:54:19 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr50015896wrf.193.1654980859591; Sat, 11
 Jun 2022 13:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <YqT8fYe1PqP9rCRs@zeniv-ca.linux.org.uk>
In-Reply-To: <YqT8fYe1PqP9rCRs@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Jun 2022 13:54:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD0MoRivXBF=YDZV_E=aEHOsduPXV9mKaETwqJxtV6Sg@mail.gmail.com>
Message-ID: <CAHk-=wjD0MoRivXBF=YDZV_E=aEHOsduPXV9mKaETwqJxtV6Sg@mail.gmail.com>
Subject: Re: [git pull] build fix
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 1:35 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   fix warnings on 32bit caused by ITER_XARRAY fix (2022-06-11 12:43:21 -0400)

I already fixed this in my tree (identically to your fix) earlier
today, since I was cc'd on the same report from Sudhip..

Commit 1c27f1fc1549 ("iov_iter: fix build issue due to possible type mis-match")

            Linus
