Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0FED312
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 12:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfKCLRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 06:17:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfKCLRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nz7EeA/pso7yMSwd3q6jsDYEXyDCyd3V9F+OMmOTChs=; b=LXy92CR4HL0oTq7JTykoQQLtE
        SGKVsKAzYb1PwV3Gq8PdfuHGciDSvKRaKgcR4X1HQB5/fzRUDPXomELSZWlsNNRV1WbDs7ja9giZH
        M1U7NSDBiii9QO30HFuBwZWLjPZ99JMe3D3inERtfrJAEtylGMsZpvcBapUSGlgN4u3nyLJCwJPzH
        QO1Y2mZLzcarwVPeHpqfulMSNhddMrG/NenKwf6FMxdJD/LNwHkNoRqlhtRajtx9Y8zEOCchc9ro5
        83AEKUmFAj2E6lRkfs9QlCpL1c6FUvQAYI+iHVsqsTkpkrCOfFimTNRv3w3D3Bs12V1BBF1F9eJ7a
        LtHFoEpPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRDt5-0008GJ-2Z; Sun, 03 Nov 2019 11:17:39 +0000
Date:   Sun, 3 Nov 2019 03:17:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
Message-ID: <20191103111738.GC15832@bombadil.infradead.org>
References: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
 <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <24075.1572533871@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24075.1572533871@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:57:51PM +0000, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > It's shorter and more obvious to just write
> > 
> >    pipe->head = head;
> > 
> > than it is to write
> > 
> >    pipe_commit_write(pipe, head);
> 
> But easier to find the latter.  But whatever.

May I suggest that you use a name that's easier to grep for?

$ git grep -cw p_tail
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:9
$ git grep -cw p_head
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:3

