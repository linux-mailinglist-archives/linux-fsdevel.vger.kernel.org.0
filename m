Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4B64F001
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiLPRFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 12:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiLPRF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:05:27 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E46BCBD
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 09:05:25 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v3so2187260pgh.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6OCT2ZdbDad/BMX0pnYZXGlc+e0Af4ihyKy0ZnG13g=;
        b=Z0kmH3yeP9Pw0NncQFCv47w2VUJEbyqW6wCtFqkqD35DzlnQjOymTL+UIizo91OQJV
         cb0kZr+GoPvoKk7VIQcBxGOOKum+LwY304gfBuOFvktTcQ6eucNVWmwasTR+x5mrxlVm
         gnkRdOPRq4ruRtwFXXARRsU13Njjzms5ldIpvk3E/COI4DMoiOu9FldaJbUDbM3KPhLC
         3z+O/MQW6suHxTx+ukoHtZAEtChDXTCoe0OOSFcA/TvX6DhappkvNrejJMbPPrqlG0l0
         fhUqJ93Dp6iPHkyFu5Fq51DzpAepYTiuFjdBpvyAIo6b/6LKeUxI04HggIUgvV/nzfNS
         Y8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6OCT2ZdbDad/BMX0pnYZXGlc+e0Af4ihyKy0ZnG13g=;
        b=iKLkrt2QJEioneXCGmOljIwasz5Wul757yQ+2UhGMKqpAYjZ7hZByqYNSsSRFGReWa
         kwq1qs5WuJnfqNpl+bpb7a7CPxB1q9m3TYUndTj16S40uZijXI5f2HI7OXMAxiHy/fBJ
         AmHHXJ+gMLJaeiH8tB9esr7VnLijQinPGyt3jXgRd2ShDA+Vm0PpZxoeNP5W+JRzLSby
         GC9HovKu6ZJyy0RD4cRf7NtN43sH084PbyjqPovBe3/A6TTEPHWMKDF2XYxXEXzv44ea
         NHmVySq+IVSPSPekHZerp4RC5hcnpGnwWZjVQCd65rdeO4I9jmUh4QRPa6lLqL40Ourd
         01xg==
X-Gm-Message-State: ANoB5pmmwFisdidTN2QZklN52M8pcV91rVOqhplKztRED20B48nTIVT8
        SyqN2k4M7OOr/j7TrkroL3iNp4W0LoQniJ0IHfT5
X-Google-Smtp-Source: AA0mqf456SOTI8h5405bjuHYKyboskc6RX/a1Ar+YL3tEroIPWZYM0tvvsDsxRnA/dxrNyn4bb9+vxyTCfLgcpe9goM=
X-Received: by 2002:a63:64c5:0:b0:479:2109:506 with SMTP id
 y188-20020a6364c5000000b0047921090506mr1494989pgb.92.1671210325149; Fri, 16
 Dec 2022 09:05:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670606054.git.rgb@redhat.com> <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
In-Reply-To: <20221216164342.ojcbdifdmafq5njw@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Dec 2022 12:05:14 -0500
Message-ID: <CAHC9VhQCQJ6_0RtHQHuA2FDje-3ick3b3ar8K8NAnuMF=ww2cA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: define struct members to hold response
 decision context
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 12-12-22 09:06:10, Richard Guy Briggs wrote:
> > This patch adds a flag, FAN_INFO and an extensible buffer to provide
> > additional information about response decisions.  The buffer contains
> > one or more headers defining the information type and the length of the
> > following information.  The patch defines one additional information
> > type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
> > allow for the creation of other information types in the future if other
> > users of the API identify different needs.
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> Thanks for the patches. They look very good to me. Just two nits below. I
> can do the small updates on commit if there would be no other changes. But
> I'd like to get some review from audit guys for patch 3/3 before I commit
> this.

It's in my review queue, but it's a bit lower in the pile as my
understanding is that the linux-next folks don't like to see new
things in the next branches until after the merge window closes.

-- 
paul-moore.com
