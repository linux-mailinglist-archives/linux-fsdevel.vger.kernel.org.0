Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C223C91E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhGNUTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 16:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbhGNUT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:19:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923CC061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 13:16:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a18so5712752lfs.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlHm/WzQNtMTs2K3EbF6yImoGudX8KZZjDbB1a1VAPU=;
        b=TJTslZ/O+mclDLyRLs2Na1rFxTJK1Iewbo87ZSvuPcjDK0QE9NyY4zBD1Aa0Nv12/R
         JjTx9SO0K3ry/IAISAwGDN2Yfuz/mSyt9m/7wS+AlmRKGrcQONETWxym1Qs2Mxe+yFgt
         gJqp/XYelzQhWhBoX8LaXPClxypV3t0kVyBbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlHm/WzQNtMTs2K3EbF6yImoGudX8KZZjDbB1a1VAPU=;
        b=DN7KrzBoaqqTtMKooq7tQLe4+H+Me3xQTthCKtTVekBK2jTwEGUbTL3wzuCXDbqIdE
         lgHu2l42g+eCfw3VxxQlhyM+NerXAzdvXbMembZUty1BqAGsJqVRwtD7ar0c2/iSgl4i
         pjcRIULyM1WIpECoy1KRkH62e3B7Oyzc13k8f+uZSvxlYOLYSuOhJDTsXaVKvWXWeKxr
         2Sf6B/A4Up9hLUPOPo9IIzludllreMe2qwA9rsupsz67tm3fMc9S1Ke9CybzrIRcPpdK
         yP3svyCZAI23GXASzbDvBx3WBdYgeR23d8CtMeLP0vkTO9HzbKRlf4/KCLygpfvVwMX2
         MO0A==
X-Gm-Message-State: AOAM531NFXrnOdNBgz19USClaL8EfpbVm86jNldOMcEgPT1XBzbZvomY
        xHN0a5qHfFkTnyziT2hPnyZiimeaYYswteBA
X-Google-Smtp-Source: ABdhPJxJlLa1wCWDv79HAktNkAGlLQ2am1ywJ5gdLW4r+xJtdalaIvTCY7SDbHAQ+ruhIDMfNxxOzQ==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr33852lfh.289.1626293795929;
        Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q10sm238844lfo.128.2021.07.14.13.16.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h4so4028324ljo.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr10417152ljj.411.1626293795142;
 Wed, 14 Jul 2021 13:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <YO8Rw23KxCDjzKeA@infradead.org> <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
In-Reply-To: <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 13:16:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaGVapioim31weBWs4bnzt7+wdyAx8GNFVgrFCLc-YXg@mail.gmail.com>
Message-ID: <CAHk-=wiaGVapioim31weBWs4bnzt7+wdyAx8GNFVgrFCLc-YXg@mail.gmail.com>
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 1:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I hope/think that we always end up checking 'pos' in the VFS layer so
> that this isn't a bug in practice

Yeah, we seem to make sure everything is fine in rw_verify_area().

We do allow negative 'pos' things, but only for files marked with
FMODE_UNSIGNED_OFFSET, which is basically just for variations of
/dev/mem and /proc/<pid>/mem that need the whole 64-bit range.

So it _shouldn't_ be an issue here, but the points about just doing
the legible and safe version stands.

               Linus
