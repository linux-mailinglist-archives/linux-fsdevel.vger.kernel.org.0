Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322FD497F25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 13:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiAXMTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 07:19:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45108 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiAXMTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:19:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 299042198B;
        Mon, 24 Jan 2022 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643026749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvRHDiYRgIugofka1vlnrZWBXEJ3aLRDAe2/6SUZnek=;
        b=C3iqRMlwb6arMtDpxwNQLg2L9o0Y1ZwUPjcDZ/Agy29ENbxrYb68FM+canxMYvFnp4qZcC
        k1uq01X70B+LhPsWuppzv2BHw+5pm9clF6xCmIgI9uB3hmM/mO/5T78ICM5vPFjfaFdGOk
        XYW03UOno8liwnEe/OmkXghA01VCRbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643026749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvRHDiYRgIugofka1vlnrZWBXEJ3aLRDAe2/6SUZnek=;
        b=DBUtyu0uQV/HBeHT86TXMQynniFXntghYyZ96Wfp8yxmu6Cc3+AeOZRWH8oY1FLjQfqV0n
        zYWgVsC2C82R5gDA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19EBBA3B89;
        Mon, 24 Jan 2022 12:19:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 690DCA05E7; Mon, 24 Jan 2022 13:19:03 +0100 (CET)
Date:   Mon, 24 Jan 2022 13:19:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Message-ID: <20220124121903.fono7exjgqi22ify@quack3.lan>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
 <cde9acbb-ba1f-16ba-40a8-a5b4fdf2d2dc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde9acbb-ba1f-16ba-40a8-a5b4fdf2d2dc@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-01-22 10:38:13, Chaitanya Kulkarni wrote:
> On 1/24/22 2:05 AM, Jan Kara wrote:
> > External email: Use caution opening links or attachments
> > 
> > Hello,
> > 
> > On Sun 23-01-22 23:52:07, John Hubbard wrote:
> >> Background: despite having very little experience in the block and bio
> >> layers, I am attempting to convert the Direct IO parts of them from
> >> using get_user_pages_fast(), to pin_user_pages_fast(). This requires the
> >> use of a corresponding special release call: unpin_user_pages(), instead
> >> of the generic put_page().
> >>
> >> Fortunately, Christoph Hellwig has observed [1] (more than once [2]) that
> >> only "a little" refactoring is required, because it is *almost* true
> >> that bio_release_pages() could just be switched over from calling
> >> put_page(), to unpin_user_page(). The "not quite" part is mainly due to
> >> the zero page. There are a few write paths that pad zeroes, and they use
> >> the zero page.
> >>
> >> That's where I'd like some advice. How to refactor things, so that the
> >> zero page does not end up in the list of pages that bio_release_pages()
> >> acts upon?
> 
> this maybe wrong but thinking out loudly, have you consider adding a 
> ZERO_PAGE() address check since it should have a unique same
> address for each ZERO_PAGE() (unless I'm totally wrong here) and
> using this check you can distinguish between ZERO_PAGE() and
> non ZERO_PAGE() on the bio list in bio_release_pages().

Well, that is another option but it seems a bit ugly and also on some
architectures (e.g. s390 AFAICS) there can be multiple zero pages (due to
coloring) so the test for zero page is not completely trivial (probably we
would have to grow some is_zero_page() checking function implemented
separately for each arch).

> >> To ground this in reality, one of the partial call stacks is:
> >>
> >> do_direct_IO()
> >>      dio_zero_block()
> >>          page = ZERO_PAGE(0); <-- This is a problem
> >>
> >> I'm not sure what to use, instead of that zero page! The zero page
> >> doesn't need to be allocated nor tracked, and so any replacement
> >> approaches would need either other storage, or some horrid scheme that I
> >> won't go so far as to write on the screen. :)
> > 
> > Well, I'm not sure if you consider this ugly but currently we use
> > get_page() in that path exactly so that bio_release_pages() does not have
> > to care about zero page. So now we could grab pin on the zero page instead
> > through try_grab_page() or something like that...
> > 
> >        
> 
> submit_page_section() does call get_page() in that same path 
> irrespective of whether it is ZERO_PAGE() or not, this actually
> makes accounting much easier and we also avoid  any special case
> for ZERO_PAGE().
> 
> dio_zero_block()
>   submit_page_section()
>     get_page()
> 
> 
> That also means that on completion of dio for each bio we also call
> put_page() from bio_release_page() path.

Well, yes. fs/direct-io.c grabs two page references in fact. One is passed
along with the bio and released by bio_release_pages(), the other one is
released directly in fs/direct-io.c after IO is submitted. We need to
somewhat reorganize the code to better define which is which because with
pinning they would be of different kind.

For zero page we currently grab the reference in dio_refill_pages() (this
needs to be converted to try_grab_page()) and we don't do anything in
dio_zero_block() - that code needs to be cleaned up to also call
try_grab_page() and we need to somehow deal with the ref currently grabbed
in submit_page_section()...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
