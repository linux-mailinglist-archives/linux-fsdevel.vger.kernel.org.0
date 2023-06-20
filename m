Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8AE736A0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjFTK50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjFTK5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:57:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C1100;
        Tue, 20 Jun 2023 03:57:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-988c495f35fso234512366b.1;
        Tue, 20 Jun 2023 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687258633; x=1689850633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3O+Bnjxxx0szcdEOMgNn8iZcHNEXXIsPlro4HGaBB6o=;
        b=aIWa1nXGNFgmtzFIBA1RqWdd8m52b+jvDm3A4V/u+05m/hAmX/0tZU9iyWAHFDN5Hb
         BspNl1+bwRjG2f60MjkRD81qMsjE1kSoD0f7dN8XBOrNrG69sa5B4WxtCkv/eQX9wAwE
         KRfuAoub+Wf3wXYRhtHk/C238QnAmSnzinmq/g8NlaagE3zegKs5TbJVUYTfZ1O5MVz/
         qBFtkHw30Uc5D+rWEPL+kLodz3ZS845mn6y2K8rkJQ/9xwv7ySEVZ4lmkEyIqR5JYLaS
         jo/ginTbyVqH/CCSG0kYljwrLR4SpSGmUtJtI//LGkaPnrg2P65yv3cIdd3h4Z0kYQFf
         EqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258633; x=1689850633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3O+Bnjxxx0szcdEOMgNn8iZcHNEXXIsPlro4HGaBB6o=;
        b=RxqpjDSBYj2TQFLyyqMu+FWZsvFS/bnQAbbf3k2Ytl1rlJnpHL8uKlBagBhA37k1ZO
         GaW7lJ0C8ZBuhlCUvK9CoX7ksRk+5moixT035AlLFhiWsWSeyl1gCO0rSkqqUkyVp9C9
         Js8z2LrYoPTLePqpqe3wNbPgY3VmazEEl7hBdOlAnY2IRNyNxf11RJc1aQhVhmg7Hz1P
         26+UzQX2U8QWREbFcAxKh98AblnMeBScJvQVTA4qfUgwSsrZwWGnEf3CvXUpWoLl3rn5
         XjVkSjLtRDvysNdgthPE3MRy1X7EkeaoLvxfTie/zlFcy7r64yI0bKdzB1h3p4Cd1a+C
         UE9A==
X-Gm-Message-State: AC+VfDyAEBJOCSyRKWmLVhZUZ/z53iDuYjzu6KhTUTZCTfC/vc/4bjSu
        PkVZ0LNRJDAkpmKQXVqpgtE=
X-Google-Smtp-Source: ACHHUZ7/IxL+j4tMhMmtnE6mA76gQ7qCMC3vtfvWh/rIklR4GzXcN84K4iRqi4lH0JifLvzTy8Mh7g==
X-Received: by 2002:a17:907:1c9c:b0:965:6aff:4f02 with SMTP id nb28-20020a1709071c9c00b009656aff4f02mr12375780ejc.41.1687258633089;
        Tue, 20 Jun 2023 03:57:13 -0700 (PDT)
Received: from [10.176.234.233] ([147.161.245.31])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090605c400b009663582a90bsm1187627ejt.19.2023.06.20.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:57:12 -0700 (PDT)
Message-ID: <9513017b07522373d9e886478f889867b7cae54d.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] fs/buffer: clean up block_commit_write
From:   Bean Huo <huobean@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>, Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Date:   Tue, 20 Jun 2023 12:57:11 +0200
In-Reply-To: <ZJE6Nf6XmeHIlFJI@casper.infradead.org>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
         <20230619211827.707054-2-beanhuo@iokpp.de>
         <ZJE6Nf6XmeHIlFJI@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 06:33 +0100, Matthew Wilcox wrote:
> You're going to need to redo these patches, I'm afraid.=C2=A0 A series of
> patches I wrote just went in that convert __block_commit_write (but
> not block_commit_write) to take a folio instead of a page.

Do you know which git repo merged with your patches?=20
