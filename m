Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800227294F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbjFIJZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFIJY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50746EA2;
        Fri,  9 Jun 2023 02:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 852ED618EA;
        Fri,  9 Jun 2023 09:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4493C4339C;
        Fri,  9 Jun 2023 09:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686302272;
        bh=RQisGjj9KL7kg1igwwGHNm1IZaL2rbAG8kSrlm0JzKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b8qzhMu/qygDwv+U5QLA/usX5K3ECwj+MWUgaKKeHU1A6jDPzwgU3fjQTHoJIcRQ2
         vpNZP+VrZ90ThxS166jMfUrT+QZKtm1KBvowVFfbmzSS0ZpEBL4QomvUjcGt0b52Tl
         Vt/rs9HHyHQ8dLhU3gGj0OEBMcgAa+y35a7SmaLQgtKrg33rNDWaZIuKcmpotThwN1
         fu5DkvO1vw/WNMbn33yxhtRaPCasPjOvUKIM3fRdHCT2l22iUWVnMcE5Y8vhK9LjcW
         H16WBbKojs/cJ4E/ye6mdTIzDmYUTtUdX5j7GNSY8Zb/7OM7u+VmMpIdu95ff+AI7s
         ZYsiksFxpfitw==
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso11218805e9.3;
        Fri, 09 Jun 2023 02:17:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDwq/ZcmRaLstf5k5+DGAm73+mrYqlxspWg7ufDrlMRKjd2j+4ub
        MDFeMhDN/92vaVJV4STVSg2VkUrdk3Oyt4z0aQM=
X-Google-Smtp-Source: ACHHUZ70M63/s5OAb5SuDf8GVqAjthMUYLs718VlOe6y2HvimEHtOeklfwr9dXNjNX4PdOTUT/IHiblpHj8LQ8LvlE4=
X-Received: by 2002:a7b:c8d7:0:b0:3f4:2cb2:a6cf with SMTP id
 f23-20020a7bc8d7000000b003f42cb2a6cfmr423308wml.10.1686302271124; Fri, 09 Jun
 2023 02:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230608032404.1887046-1-mcgrof@kernel.org> <20230608032404.1887046-5-mcgrof@kernel.org>
 <ZIHZngefNAtYtg7L@casper.infradead.org> <ZIHcl8epO0h3z1TO@infradead.org>
 <ZIITpjDXyupKom+N@bombadil.infradead.org> <ZIKofhpTXREOR3ec@infradead.org>
In-Reply-To: <ZIKofhpTXREOR3ec@infradead.org>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 9 Jun 2023 02:17:39 -0700
X-Gmail-Original-Message-ID: <CAB=NE6V-w+NWTZ0tZaUNhOH2uW7T3EEYKt-+YhkDX6tZZ8BccA@mail.gmail.com>
Message-ID: <CAB=NE6V-w+NWTZ0tZaUNhOH2uW7T3EEYKt-+YhkDX6tZZ8BccA@mail.gmail.com>
Subject: Re: [RFC 4/4] bdev: extend bdev inode with it's own super_block
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, djwong@kernel.org,
        dchinner@redhat.com, kbusch@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, corbet@lwn.net, jake@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 8, 2023 at 9:20=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
> Again, every non-trivial file system right now has more than one set
> of aops per superblock.  I'm not sure what problem you are trying to
> solve here.

Alright, a 2 liner does indeed let it co-exist and replace this mess, thank=
s.

  Luis
