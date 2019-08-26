Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78249D5A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 20:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfHZSUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 14:20:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfHZSUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H6Iy4cS9pbokPDptk5XJwU50giNafD5gsWbHfd5zlgk=; b=LOJdwjr8RWWuteBa8QXiD1gKJ
        NQIAjR1cOD7EveqteJWMIh3F5Y8hCxoE5yOKgeXd1rLvX2jsezrjf9BsyOkb393qXKFJCqVZlQ2qQ
        jRaN94TGa3SBgYEMZ7WvAbiQxsBQqJY/cysNTZIIylkb37K3APlscmFv4m1MY0njpNKXWup7lRGRC
        ErDEhbJ/avveXEQD4ZW5iNylY7WpWcSkBCH8XAULh3pUrnmxHD2Tuy3swikMmiyf6RJQS+AYJ8uCb
        Aqkx0NN/MFfaTfDr9ZK/p4fQhPYU1g9od2h37b5wO4eXPy877K3v8JscNus4Hfd+fvj5nDt+dR965
        X6c/c2G7g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2JbF-0001HA-7y; Mon, 26 Aug 2019 18:20:17 +0000
Date:   Mon, 26 Aug 2019 11:20:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190826182017.GE15933@bombadil.infradead.org>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826162949.GA9980@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 05:29:49PM +0100, Al Viro wrote:
> On Mon, Aug 26, 2019 at 03:48:38AM +0100, Al Viro wrote:
> 
> > 	We might be able to paper over that mess by doing what /dev/st does -
> > checking that file_count(file) == 1 in ->flush() instance and doing commit
> > there in such case.  It's not entirely reliable, though, and it's definitely
> > not something I'd like to see spreading.
> 
> 	This "not entirely reliable" turns out to be an understatement.
> If you have /proc/*/fdinfo/* being read from at the time of final close(2),
> you'll get file_count(file) > 1 the last time ->flush() is called.  In other
> words, we'd get the data not committed at all.

How about always doing the write in ->flush instead of ->release?
Yes, that means that calling close(dup(fd)) is going to flush the
write, but you shouldn't be doing that.  I think there'll also be
extra flushes done if you fork() during one of these writes ... but,
again, don't do that.  It's not like these are common things.

Why does the prototype of file_operations::release suggest that it can
return an int?  __fput doesn't pay any attention to the return value.
Changing that to return void might help some future programmers avoid
this mistake.
