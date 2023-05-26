Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7457124BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 12:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbjEZKdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjEZKdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 06:33:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653812A;
        Fri, 26 May 2023 03:33:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so503374f8f.1;
        Fri, 26 May 2023 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685097182; x=1687689182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GMIbxSmACC58JY0s4Fx99cZ5L7LdXOL1wbSAxCBBMs=;
        b=KnX4LPdzrVoYh1g88IfS6jHE1lmyQMFjkZHZDfkHT55O6QJ8dLc6GulwVzLk6FrZcL
         BvdKsl+h/EX0Tz4kqo9AU5grM7X9SkoMazJ3QOB3cYYAskQrQIDZkVD6qPRBg7chxwfK
         omg/2SkIDM5bpS0LIiEqW1uSvw0rXYC5/qwl3S7Yc4nGZ6VlpcuHxCr8GWkiNp7EFo+f
         pWfvBGhVt+eCHt7N5/dgbgNVF+FBP2HdcgMHJ+fpJOifYsIMZ8O2QuiDdcckAy3MrdO5
         KLbc9VgwRaGpr7T3aZ42GLGA5GevBLdZy/jLnfXBHFzrZrv/ngbca2LF0G4ZCExz+jwy
         TYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097182; x=1687689182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GMIbxSmACC58JY0s4Fx99cZ5L7LdXOL1wbSAxCBBMs=;
        b=V2EydWafPuamF1ggEaN3pjUGtSsnrafOAdIvkFlOnP5AHiGBvzp4WDL55mLG8cOmrJ
         /pDn8Hka/Up87o8n5EURvvg7mhhYVUoin9Zlt8K0DeD0qfdZmBmC1u7UlNkGIDRfoUKb
         oYoJv59CBDM9sMOauCRYzsaHqCzAX3Wg5gcMZ/Nf4onrC+lIfH2hleps37nhzCdkZwLY
         3HjWjNiES4icX8am4SD1vVmzZOSG2uY7pbTGqvU+6ClGKtZWes6XftvTlS3tBmbGwGN7
         BZGAnzLNVhHW4hXZu8RFP0iOfYe0b9oss99rGUqVVvBqHJCPzbKe+Fjgu4J6qQHhPWrN
         ZGeQ==
X-Gm-Message-State: AC+VfDy7gbxL8E7TJCUncnH803oL9b4tuFUEthKq2WUiylp1jUBIHnl3
        Z4yCj/f2XDLR3dI+s0UP4rBc77uymfQ=
X-Google-Smtp-Source: ACHHUZ62mVkAf+27IkrhdN6EwXoYAVcQ3q16snWYpA3QdQwxIFSSH4LCdtadf7UGwbc/g3pYsQKWjA==
X-Received: by 2002:a5d:6ac4:0:b0:30a:8e6a:3d77 with SMTP id u4-20020a5d6ac4000000b0030a8e6a3d77mr1197818wrw.1.1685097182117;
        Fri, 26 May 2023 03:33:02 -0700 (PDT)
Received: from suse.localnet (host-95-248-204-235.retail.telecomitalia.it. [95.248.204.235])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d618a000000b0030631a599a0sm4647915wru.24.2023.05.26.03.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:33:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Fri, 26 May 2023 12:32:59 +0200
Message-ID: <5939173.lOV4Wx5bFT@suse>
In-Reply-To: <20230525201046.cth6qizdh7lwobxj@quack3>
References: <Y/gugbqq858QXJBY@ZenIV> <3307436.0oRPG1VZx4@suse>
 <20230525201046.cth6qizdh7lwobxj@quack3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 25 maggio 2023 22:10:46 CEST Jan Kara wrote:
> On Mon 27-03-23 12:29:56, Fabio M. De Francesco wrote:
> > On luned=EC 20 marzo 2023 13:47:25 CEST Jan Kara wrote:
> > > On Mon 20-03-23 12:18:38, Fabio M. De Francesco wrote:
> > > > On gioved=EC 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wrote:
> > > > > On gioved=EC 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > > > > > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > > > > > On mercoled=EC 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > [snip]
> >=20
> > > > > > > > I think I've pushed a demo patchset to vfs.git at some point
> > > > > > > > back
> >=20
> > in
> >=20
> > > > > > > > January... Yep - see #work.ext2 in there; completely untest=
ed,
> > > > > > > > though.
> >=20
> > Al,
> >=20
> > I reviewed and tested your patchset (please see below).
> >=20
> > I think that you probably also missed Jan's last message about how you
> > prefer
> > they to be treated.
> >=20
> > Jan asked you whether you will submit these patches or he should just p=
ull
> > your branch into his tree.
> >=20
> > Please look below for my tags and Jan's question.
>=20
> Ok, Al didn't reply

I noticed it...=20

> so I've just pulled the patches from Al's tree,

Thank you very much for doing this :-)

> added
> your Tested-by tag

Did you also notice the Reviewed-by tags?

> and push out the result into linux-next.

Great!
Again thanks,

=46abio

> 							=09
Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



