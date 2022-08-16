Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3FF59634F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiHPTmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiHPTm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:42:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181B8981A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:42:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k26so20825575ejx.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=j6C9lf7JhzlxE1F6ouy9UeQqCIuaLiW4edqmr70l3os=;
        b=gy/irX4iIF4tgnkELB1IcuP4tGk8YBjcODGsbsYD7RqExJGVHo0bL8amAC7w81Itx8
         OpF7//aWC3ven/odaxRytaZW3ncs7O1Yu47hkFJEsxNY5Z4kL04QnQ89seNTpfsiSHIy
         USuzpUUCp1KxFjMUb6L17sYt1B4yXRFEatTC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=j6C9lf7JhzlxE1F6ouy9UeQqCIuaLiW4edqmr70l3os=;
        b=H0yKjTfrlGM6jx2QlcpT1bQz1KW2pRIJpJ1ZnhU75w9QIyGP0P1Xl0rhn3fqkFkHPD
         1Pa4CECMk2Bd8lRDXyJZyHbQO1Lz3lfd5nam4bFo+tgsnwpkGdAfa9CpRIAs8bGQCFH9
         KcpKQ4F9ut9XZ5ad/GK+mlk7DvXJFjQ0sY1W1Dcwm/jTFQ46ifRGe2vd4HKvFFwwGdDV
         bHUSBukLcl8Gh4oe2KbXpY5GpGi44iaNadg/kYJ7oxQESTY7dp6FvEfSRzC7AefG0935
         qqHPGNrv8ESqw8sCOancn5IFoUU+lRLWnLiPEp+JNVy4GsV7pSJ86p6WGo+65n+vEkml
         UN4Q==
X-Gm-Message-State: ACgBeo1I4OvNFvHvFDhxq41vLKfhEvjcItamMv9XHbYgRRQssWhWVa/A
        y5WYzX0RBlaNLQHIycg/HGV6LvZ8PgSg9fjXh0o=
X-Google-Smtp-Source: AA6agR5KE7psI4U0TrUGqpnuAPTuF00pGUvhSEx4LVcVLZ3OdCYlMOmcWBfDTrG9F7avINfONW80kQ==
X-Received: by 2002:a17:907:7617:b0:730:e317:d0e9 with SMTP id jx23-20020a170907761700b00730e317d0e9mr14336634ejc.736.1660678946316;
        Tue, 16 Aug 2022 12:42:26 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id u4-20020a50eac4000000b0043ba7df7a42sm9054489edp.26.2022.08.16.12.42.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 12:42:25 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so1933308wms.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:42:25 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr71425wmm.68.1660678944697; Tue, 16 Aug
 2022 12:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
 <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com> <CA+G9fYuLvTmVbyEpU3vrw58QaWfN=Eg8VdrdRei_jmu2Y2OzOg@mail.gmail.com>
In-Reply-To: <CA+G9fYuLvTmVbyEpU3vrw58QaWfN=Eg8VdrdRei_jmu2Y2OzOg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 12:42:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxpMiMj0M7rvz-zsd4G+LB=kcUrM-3VPTt5EauER4iyA@mail.gmail.com>
Message-ID: <CAHk-=whxpMiMj0M7rvz-zsd4G+LB=kcUrM-3VPTt5EauER4iyA@mail.gmail.com>
Subject: Re: [next] arm64: kernel BUG at fs/inode.c:622 - Internal error: Oops
 - BUG: 0 - pc : clear_inode
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
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

On Tue, Aug 16, 2022 at 12:39 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> This is a physical hardware db410c device.
> Following VIRTIO configs enabled.

Yeah, it's not enough to just enable the VIRTIO support, it actually
needs to run in a virt environment, and with a hypervisor that gets
confused by the virtio changes.

Plus:

> > Do you see the same issue with plain v6.0-rc1?
>
> Nope. I do not notice reported BUG on v6.0-rc1.

Ok, so definitely not related to the google cloud issue we had in rc1.

               Linus
