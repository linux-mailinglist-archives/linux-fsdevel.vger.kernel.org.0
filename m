Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1134FCF23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 07:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348444AbiDLFzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiDLFzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:55:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4033E9F;
        Mon, 11 Apr 2022 22:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WmMBTBmYSOXcRl0yo58xO2d5wfgRDKUEN3oOCASblis=; b=N6UxcnHlJpAHN0lTBRRVSCNkg0
        lFemX38l+vnalhDRg/OzWs6JQD3krJ6uPghARdwpDbEypzExCzfD7LX0IwGF3HWmUFEo3TPFu5r6T
        vEbyRpp0HJEwR7J2EjV65DkJTzu1IMLU4H0BGO2JidJCF50kECoHl2AI4JvOKPnnNXYYXtFrCsi67
        dRO0w7S8+DzeM+JjW8F8/SVcaFAtzURNHRj5rpRBVEyB/3oaFV45H75FnGzN8F61oxP7DlRB+/txr
        zXFeaQ3v1aPim2ppBUIemrCErlCUbgbyQNuD5c4DCo4W3ShsIPVdU5an+zC0mPlWn8A9WA0cvtxy3
        hjm7vhGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne9SR-00Bnhz-JA; Tue, 12 Apr 2022 05:52:55 +0000
Date:   Mon, 11 Apr 2022 22:52:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
Message-ID: <YlUTt4ABuzb0iOjb@infradead.org>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
 <YlUQ9fnc+4eP3AE5@infradead.org>
 <CAHk-=wjOiBc3NiMRQJC6EsVosKOWmXiskqb0up6b5MOxCKSCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOiBc3NiMRQJC6EsVosKOWmXiskqb0up6b5MOxCKSCBQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:47:44PM -1000, Linus Torvalds wrote:
> Considering that BLOCK_EXT_MAJOR has been 259 since 2008, and this is
> the first time anybody has hit this, I don't think there's much reason
> to change that major number when the whole error case seems to have
> been largely a mistake to begin with.

Yeah.  If Mikulas still has a problem he could just patch
BLOCK_EXT_MAJOR locally.
