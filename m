Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BB16F0A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 21:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgBYUxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 15:53:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgBYUxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0nIut/TecVaZsuHVmLbUyjVdlBhfWH56z72PpkYyH98=; b=HBvYBNsDTr9+FUVJVQUVxq/OqU
        Ud9jyuqW9J/D1v90ZliQbd4Lk0nN6wXxl8Po84ngJ9W7ilUdcLllAZ33NNbNlcERx6u5ASsJGvOUA
        htzO4FNw04/6DfNGG4TOS3R7YB+q0LVQdwAuOuFWNYjDSGNY7JQ9NIgJndphNL8kTzETxiv3eNDIw
        qsPpY8L9zwRsWMHntYbjMf/l3PL8+IyqV0zK4kdFshac192EdwZCRSAGxPB7ht0qodrrWy2C/MIM/
        d6XkpjeA94drQYvJgNB+P7XskG1WldKAjE1E+6zXbBNXRvjGY2RIya/WAgnsIV2clYvvZIrSmrwiv
        V55Qsz8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6hD4-0004he-P4; Tue, 25 Feb 2020 20:53:42 +0000
Date:   Tue, 25 Feb 2020 12:53:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200225205342.GA12066@infradead.org>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:21:04AM +0530, Ritesh Harjani wrote:
> >   		if (dio->error) {
> >   			iov_iter_revert(dio->submit.iter, copied);
> > -			copied = ret = 0;
> > +			ret = 0;
> >   			goto out;
> >   		}
> 
> But if I am seeing this correctly, even after there was a dio->error
> if you return copied > 0, then the loop in iomap_dio_rw will continue
> for next iteration as well. Until the second time it won't copy
> anything since dio->error is set and from there I guess it may return
> 0 which will break the loop.

In addition to that copied is also iov_iter_reexpand call.  We don't
really need the re-expand in case of errors, and in fact we also
have the iov_iter_revert call before jumping out, so this will
need a little bit more of an audit and properly documented in the
commit log.

> 
> Is this the correct flow? Shouldn't the while loop doing
> iomap_apply in iomap_dio_rw should also break in case of
> dio->error? Or did I miss anything?

We'd need something there iff we care about a good number of written
in case of the error.  Goldwyn, can you explain what you need this
number for in btrfs?  Maybe with a pointer to the current code base?
