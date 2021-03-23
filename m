Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95207345612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 04:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhCWDOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 23:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCWDOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:14:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B8C061574;
        Mon, 22 Mar 2021 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s59nlgoQExnRs58MAE4XKiro2mmvCFvZh1detE2d+44=; b=cx5wxKcOV+4X2IxxHN24EjLhH0
        zuPs/xqbmzPar0ojnPsVATmPdRORybTp8e3+4TLfzzYT47Qgz2KpxjArk59zN6FSXF9H6PFux5BNn
        eBataK48F/FSe4d6/TmHQvBF2yYg6jNlZnp2NilL6DFconyti5g+7Z0o9TicE+KVlBRCURUivWEW+
        K0y1Lii/bih6pW3XmwUD+ZuBeUX8g96C+bybmBLls7+D5dUe9j7fwR2thJ3u/gKXgrLDMgOdiGz9N
        ARyipYG3uBw2+vAMz4ezM6VidT8gbkp1cscvipZUlfbp1wUX+5jQozfHNKpRCPDoak7G7pyWgLXXQ
        QxDNhyvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOXTG-009SBo-II; Tue, 23 Mar 2021 03:12:58 +0000
Date:   Tue, 23 Mar 2021 03:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        'Sergey Senozhatsky' <sergey.senozhatsky@gmail.com>,
        'Steve French' <stfrench@microsoft.com>
Subject: Re: [PATCH 1/5] cifsd: add server handler and tranport layers
Message-ID: <20210323031242.GA1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7@epcas1p1.samsung.com>
 <20210322051344.1706-2-namjae.jeon@samsung.com>
 <20210322221816.GW1719932@casper.infradead.org>
 <00d901d71f90$cdfd24f0$69f76ed0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d901d71f90$cdfd24f0$69f76ed0$@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:01:22PM +0900, Namjae Jeon wrote:
> > On Mon, Mar 22, 2021 at 02:13:40PM +0900, Namjae Jeon wrote:
> > > +#define RESPONSE_BUF(w)		((void *)(w)->response_buf)
> > > +#define REQUEST_BUF(w)		((void *)(w)->request_buf)
> > 
> > Why do you do this obfuscation?
> I don't remember exactly, but back then, It looked easier...
> > 
> > > +#define RESPONSE_BUF_NEXT(w)	\
> > > +	((void *)((w)->response_buf + (w)->next_smb2_rsp_hdr_off))
> > > +#define REQUEST_BUF_NEXT(w)	\
> > > +	((void *)((w)->request_buf + (w)->next_smb2_rcv_hdr_off))
> > 
> > These obfuscations aren't even used; delete them
> They are used in many place.

Oh, argh.  patch 2/5 was too big, so it didn't make it into the mailing
list archive I was using to try to review this series.  Please break it
up into smaller pieces for next time!

