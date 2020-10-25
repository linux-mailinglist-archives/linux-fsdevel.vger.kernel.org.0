Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A44298340
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 19:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418338AbgJYS6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Oct 2020 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418312AbgJYS6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:58:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA048C061755;
        Sun, 25 Oct 2020 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BhHV6xzeRpM+tH1/4inm6h0bxgiy8Ua01rxlHPdZz98=; b=GixbHggnqEi6MDk38VnmM0zBsy
        O6sJO4Dm2WB6iNWP/XFxaMSxurCwlTPzHOvIXP0NxQTOMXXka6gAFuswPlvsa2GLFeGUAWG3yO1lo
        4I+qdhxpxPSo3Fh999qZ8IsWYsSKEAFbkfyiiZsY9puOa5szukEGcOTj+lSmxRON+8aFYNisR9LuO
        yY1+Ysl3cnMqyEMlcR1gB2HCaPxJUQ3COszJ1mEm7EWnlaF4RY7BzDj8puZ2h5uMZeBWblw0TclK2
        3e5IHMEOHEbVX4KUl8452QEflEwsVTojymYaK8MaO3YygbIgDBZPxMaLB9oSMQqpUzrMqG5xGJeff
        mdx1Mfzw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWlE9-00020f-2W; Sun, 25 Oct 2020 18:58:49 +0000
Date:   Sun, 25 Oct 2020 18:58:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Removing b_end_io
Message-ID: <20201025185849.GJ20115@casper.infradead.org>
References: <20201025044438.GI20115@casper.infradead.org>
 <20201025155652.GB5691@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025155652.GB5691@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 25, 2020 at 11:56:52AM -0400, Theodore Y. Ts'o wrote:
> On Sun, Oct 25, 2020 at 04:44:38AM +0000, Matthew Wilcox wrote:
> > @@ -3068,6 +3069,12 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> >  	}
> >  
> >  	submit_bio(bio);
> > +}
> > +
> > +static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> > +			 enum rw_hint write_hint, struct writeback_control *wbc)
> > +{
> > +	__bh_submit(bh, op | op_flags, write_hint, wbc, end_bio_bh_io_sync);
> >  	return 0;
> >  }
> >
> 
> I believe this will break use cases where the file system sets
> bh->b_end_io and then calls submit_bh(), which then calls
> submit_bh_wbc().  That's because with this change, calls to
> submit_bh_wbc() --- include submit_bh() --- ignores bh->b_end_io and
> results in end_bio_bh_io_sync getting used.

I think you're confused between the two end_ios.  The final argument
to bh_submit() and __bh_submit() is a bio_end_io_t.  end_bio_bh_io_sync()
calls bh->b_end_io.

