Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90ED14EA39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 10:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgAaJoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 04:44:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaJoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F9/A+3g1zfrcOEwdCjm6sHlblNrDMZRWN4eoaSrrx98=; b=C0/qqOzKkzrS2n578TfHr0J3p
        rX+knv8n+W4vD5rToqeieVwGaLN7TApcccjLa8V8jmitkjzuIoh8HT27Ed/Bwsas3xm00ruRLi8R3
        1JNiUcZTuAPREzo1hfAZoh6w45vIWdOz/7ZyP4x16LZ41N9QrcE15LxwIGjApX3lHqMPwj2kaErHx
        IIybWv/gyKlBVYNeWFUh+CqxMPpyMYT95rUs7v8EbTHmY+TYvJGBTRXqP4QTPbkQsPHKHV43Ezl+L
        fJaC1uIREy0XxK/dVq75XYpY+gJ5KwTSH7L2RFT79xY1XMpgtpyJyel/zLLy6AaeT2oDMLILw4tZZ
        a1L9tH53A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixSqY-0002pW-4l; Fri, 31 Jan 2020 09:44:18 +0000
Date:   Fri, 31 Jan 2020 01:44:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: Convert from readpages to readahead
Message-ID: <20200131094418.GA4437@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-13-willy@infradead.org>
 <20200129013839.GL18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129013839.GL18610@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:38:39PM +1100, Dave Chinner wrote:
> On Fri, Jan 24, 2020 at 05:35:53PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Use the new readahead operation in XFS and iomap.
> > +	if (ctx.cur_page && ctx.cur_page_in_bio)
> >  		put_page(ctx.cur_page);
> > -	}
> >  
> > -	/*
> > -	 * Check that we didn't lose a page due to the arcance calling
> > -	 * conventions..
> > -	 */
> > -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> > -	return ret;
> > +	return length / PAGE_SIZE;
> 
> Took me quite some time to get my head around whether this was
> correct or not.

Yes.  Unfortunately, this is the most complex of the conversions ;-(

> I'm still not certain in the cases where block size != page size and
> we've got an extent boundary in the middle of the page and had a
> read error on the second extent in the page. In this case,
> ctx.cur_page_in_bio is true so we drop the readahead reference to
> the page. Also, length is not a multiple of page size, and so the
> nr_pages value returned includes the partial page that we have IO
> underway on.
> 
> That, I think, leads to both a double unlock and a double put_page()
> of the partial page in question.

But C division rounds down.  So we neither unlock, nor put_page() the
page which was in the bio ... do we?
