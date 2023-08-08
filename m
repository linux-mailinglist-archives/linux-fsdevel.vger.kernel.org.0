Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C022D774AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjHHUgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHHUfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864D5F850;
        Tue,  8 Aug 2023 10:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAAD62295;
        Tue,  8 Aug 2023 17:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D10C433C7;
        Tue,  8 Aug 2023 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691514424;
        bh=KcSu63J+E+ZlhZNxwguVgo1Hd/r2+m/xtZgmoRqmCqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R13vTjZxCC7WvaZTeyjJ5vozhI6s68r6NcOCv/Ev1Ahyg2dRyfxTkByz/s13IdNiZ
         2iJS8IbxvbpGe4cjlCmx9oPepA7STNbpKyaELq5aF9VzC/L4ra7G+fTdtoE/4EguH+
         EyAGOkoJEU38ySO2W7zrAGCPDxC2zyCQDo6ybOM14fmNDula1ZLoDjY1AyfEaim9yW
         fR4e0tETdKDTIQUfon2m9Zvfv4WkAbtICeNnGJda1oNtAK6IugGX7/YOvx7UXN9bQx
         ZT7HAb4u3e+8tGuBWUHU3ZaRbBcgVlQzMasHtm6JaOq9ibTfWhoi10owVAop6h8zdW
         rdlOE6MGqDagA==
Date:   Tue, 8 Aug 2023 19:06:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
Message-ID: <20230808-eidesstattlich-bandbreite-0a02b6b3ec83@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner>
 <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner>
 <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
 <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com>
 <20230808-lebst-vorgibt-75c3010b4e54@brauner>
 <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:05:20AM -0700, Linus Torvalds wrote:
> On Tue, 8 Aug 2023 at 09:30, Christian Brauner <brauner@kernel.org> wrote:
> >
> > At least make this really dumb and obvious and keep the ugliness to
> > internal.h and open.c
> 
> See the patch I just sent out.

Yeah, I saw.
