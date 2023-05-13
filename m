Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF88701709
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjEMN0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 May 2023 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjEMNZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 May 2023 09:25:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE9F9;
        Sat, 13 May 2023 06:25:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so26475525e9.2;
        Sat, 13 May 2023 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683984353; x=1686576353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ9suH3ysp93knG+LU0uGT9RZVnxtGwdUs21az4sbeY=;
        b=LLWWTC34vSI3jpNT/zyl5RqzF/v1bIiGvyiYvrtMN8jjjzdEzIai/eiOraHQrauYam
         erId9ONSYr708J/L2MRSkt0ge+0hLyJr/N/u8r/cKralLyhjFzlX/6ki7aodxs7m7ZZG
         3i7L/UK1r63y2DwYaHzCi4MKpkFoGA05F5gX/ji8gZuFn0ROx1bVlAs0foZWqb5BA6wn
         YvOT7j8Pz/zcfm0KXgYAuZQ81xmQTKOtAsjxWjFC9uH4oOvEhIlu8Hdk87BIfGe090t8
         CpafDsH+CiRZ56wKFwMCQ+n19YJ0ZMUdYeC2F1Bd8gNmcAyC/gXUvAdIo6mb3m28mz8N
         KaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683984353; x=1686576353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ9suH3ysp93knG+LU0uGT9RZVnxtGwdUs21az4sbeY=;
        b=JTM91b2HZpOlPfOhJDIqW6A41ngglEucfdn3nWhmhC2CNS6eR/Ou6T4bz9TyhQ0AQg
         qCF0agqL2ZCSWzNAkr0uBmGju3wnIsi7G/6PddDcdmD2pzGgj3W+wqu/103xc4m8Mb1q
         u05HXvAgS/tQGmoDS2j0yuiNMpfm5g4SfBi2SquOQbL27GeQf3zQT3nbBp/UJnVmKuS7
         60Rnxe2LZGx/4b0qgc6nos5/UHuF6w8lMm5O79SNfWDKv/4nhs3maedW+NX/PekzhGEf
         DH47XObylKnxk22MR+6OMqx0s0bSuRP03792wMvnDWFykXC77CONNegDyNeEGTOtiU7f
         +prg==
X-Gm-Message-State: AC+VfDzqEzeoIXFrD9+wzli6UBDWLIC8MXrQsso3exCSL+MRwovadiAa
        Ls5K5pDVvkLXUZTZlhqoJZY=
X-Google-Smtp-Source: ACHHUZ4Fz/9yo2Vm9Z/ZjMqmZaOp0EPZjKnAs/L7EDiSodi1OfaqFtGjEb2oM/fg3JKfA96SeGDvPQ==
X-Received: by 2002:a05:600c:c6:b0:3f4:28db:f5ff with SMTP id u6-20020a05600c00c600b003f428dbf5ffmr13378158wmm.35.1683984352479;
        Sat, 13 May 2023 06:25:52 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id e3-20020a05600c218300b003f421979398sm20316940wme.26.2023.05.13.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 06:25:51 -0700 (PDT)
Date:   Sat, 13 May 2023 14:25:50 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <8f76b8c2-f59d-43fc-9613-bb094e53fb16@lucifer.local>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFq3SdSBJ_LWsOgd@murray>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 02:12:41PM -0700, Lorenzo Stoakes wrote:
> On Tue, May 09, 2023 at 01:46:09PM -0700, Christoph Hellwig wrote:
> > On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > >
> > > This is needed for bcachefs, which dynamically generates per-btree node
> > > unpack functions.
> >
> > No, we will never add back a way for random code allocating executable
> > memory in kernel space.
>
> Yeah I think I glossed over this aspect a bit as it looks ostensibly like simply
> reinstating a helper function because the code is now used in more than one
> place (at lsf/mm so a little distracted :)
>
> But it being exported is a problem. Perhaps there's another way of acheving the
> same aim without having to do so?

Just to be abundantly clear, my original ack was a mistake (I overlooked
the _exporting_ of the function being as significant as it is and assumed
in an LSF/MM haze that it was simply a refactoring of _already available_
functionality rather than newly providing a means to allocate directly
executable kernel memory).

Exporting this is horrible for the numerous reasons expounded on in this
thread, we need a different solution.

Nacked-by: Lorenzo Stoakes <lstoakes@gmail.com>
