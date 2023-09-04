Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378FC791411
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352599AbjIDIz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIDIzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:55:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F8131
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 01:55:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a42d06d02so637957b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693817752; x=1694422552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bv44DxuNITNpd4qmM6vPqTpOEKj8EebxgG2BGExGRc=;
        b=EeQU8Yo8X+gUgkJX6Vkse2oVCtMM1ucFEff2gXeO3iZhBU/+vryJEAgd1u+8QgxLZb
         iuKC7laboqQ4OevO4GqozZmeRyjU7HRYoqKqVI8FQszjC/dveDi7ethKa4c1WP+B9shU
         8Y6Y453shN/uQ1xxADJNmt251AagAGyOQ60SKH4GJRvIxfnnSE5knGJOMl9Vgn6Mrux+
         qy6nk1H6+OUhsH1cVk+yQtbokDIGXNAx10RqlWGHsO8i0IrQprS8Cg/z2Cl69PXcJFLJ
         gwABHz+8a0Rhrb9ha0zXOPOow2oVB71ReJoaJ5jnuZTwnmMArLHrVt60TuzSgyQP0ZE+
         WkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693817752; x=1694422552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bv44DxuNITNpd4qmM6vPqTpOEKj8EebxgG2BGExGRc=;
        b=SBUMhGOpADiGIRho2nhaes6bx4l2dZUwo3PLaK85W+Mp9tV38Ahi4nM3gIupwjEMUQ
         SRX3zHmMuLoh61DSitrv4QW90WkPUxvTcINRRQXxsNC6kbY9jEXIn4hFXMNm/Q0kKoFe
         q9CbuBQSm1Bc2j1RsyL6wJdGJatQZsBLC6vjYtHHZZYYZxAb5WnUGo+bRVhzwNgPVu21
         iDNBM9OEM9+XTlTgINFPNtwKnnVNwRGyyoX9xz4Oqyn87xfg5HYKIL9BpThNfQA81ur2
         NIKaoRcx5MYj1XAiG2mRkLxcSJdpCgUBkiLBNjgmImj49lU9Z4gIk0d2Dro2ltJn/NTw
         G99A==
X-Gm-Message-State: AOJu0YxF7JsTbw1xIypwr9k+SkZKX9bFOzOlhvMbvq8bhyNdUF9MAz1R
        AJDrlR+XNiPALYLvu0+Xlsjv2g==
X-Google-Smtp-Source: AGHT+IHeoMKsRckRtk2mpp27WiGyUYVnjLYXKja/59GxduUL+F6fIrYIlPB5LwoH/z6bxVuWblRoFA==
X-Received: by 2002:a05:6a21:33a1:b0:137:7198:af9b with SMTP id yy33-20020a056a2133a100b001377198af9bmr9168852pzb.56.1693817751696;
        Mon, 04 Sep 2023 01:55:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id c24-20020a62e818000000b006828e49c04csm6870058pfi.75.2023.09.04.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:55:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qd5N6-00Ae83-1u;
        Mon, 04 Sep 2023 18:55:48 +1000
Date:   Mon, 4 Sep 2023 18:55:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <ZPWblP6LFKRcUFcv@dread.disaster.area>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <CAGudoHE_-2765EttOV_6B9EeSuOxqo1MiRCyFP9y=GbSeCMtZg@mail.gmail.com>
 <ZPUSPAnuGLLe3QWH@dread.disaster.area>
 <20230904-beleben-adipositas-ac1ed398927d@brauner>
 <20230904-nashorn-gemeckert-3ca91ef71695@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904-nashorn-gemeckert-3ca91ef71695@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:23:33AM +0200, Christian Brauner wrote:
> > > Which is pretty much the case for all filesystem bug reports from
> 
> I think we should at least consider the option of reducing the number of
> filesystems syzbot tests. Filesystems that are orphaned or that have no
> active maintainers for a long period of time just produce noise.

I wish you good luck in convincing the syzbot maintainers that
testing obsolete, unmaintained and/or deprecated code should be
outside the scope of what syzbot exercises...

> Slapping tags such as [ntfs3?] or [reiserfs?] really don't help to
> reduce the noise.

Yup - they can't be trusted to be correct, so it does nothing to
reduce the noise. There's been two false XFS categorisations
in just the last half a day....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
