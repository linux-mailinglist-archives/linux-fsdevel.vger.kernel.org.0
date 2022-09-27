Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E85EC757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiI0PNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiI0PNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:13:44 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C978115A67;
        Tue, 27 Sep 2022 08:13:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8F9B940355;
        Tue, 27 Sep 2022 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received
        :received; s=mta-01; t=1664291620; x=1666106021; bh=pxm0swS28gLH
        pgdYF3S4Vmr6d+161ywTaiLccywugbM=; b=KlZud3yWQh72L/P3lz8vI9bBAsRU
        iB9l5E/9TlmHyvSppykpCdUBIE7apkOGiL02mUp6+2UWcrvYRtOIz/6JBuS4YrQp
        uDuSSiRADIsRBaPR3EsSgM/nVPaqX2rH4aUbI+u2fHQbNZVRpqS2k16RSc0Bynby
        M7uuMGk8qg/vGa4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id An4g0pvpQUWU; Tue, 27 Sep 2022 18:13:40 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8699A40311;
        Tue, 27 Sep 2022 18:13:39 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 27 Sep 2022 18:13:39 +0300
Received: from yadro.com (10.199.23.254) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 27 Sep
 2022 18:13:37 +0300
Date:   Tue, 27 Sep 2022 18:13:35 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <patches@lists.linux.dev>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
Message-ID: <YzMTH1v9yZQcujLa@yadro.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-9-ojeda@kernel.org>
 <YzL/9mlOHemaey2n@yadro.com>
 <CANiq72kDPMKd0qLAMVrd2A3n9aAWhh2ps5DvKos58L=_V2-XwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kDPMKd0qLAMVrd2A3n9aAWhh2ps5DvKos58L=_V2-XwQ@mail.gmail.com>
X-Originating-IP: [10.199.23.254]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 04:06:43PM +0200, Miguel Ojeda wrote:
> «Внимание! Данное письмо от внешнего адресата!»
> 
> On Tue, Sep 27, 2022 at 3:52 PM Konstantin Shelekhin
> <k.shelekhin@yadro.com> wrote:
> >
> > Not being able to pass GFP flags here kinda limits the scope of Rust in
> > kernel. I think that it must be supported in the final version that gets
> > in.
> 
> Flags will be supported one way or the other in the future, but I was
> requested to do v10 as a v9 with the last nits resolved.
> 
> Please see the cover letter for details.

Sorry, my bad.
