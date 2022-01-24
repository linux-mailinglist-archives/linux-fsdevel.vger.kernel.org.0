Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21DD497CB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiAXKFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 05:05:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiAXKFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:05:02 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A290A21123;
        Mon, 24 Jan 2022 10:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643018701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCvhr19vzplzpMM05SVgMboCmOhXfyuz/+7pRxrwQjA=;
        b=J+biOZ4YkbC2iRlj8BljTq6UAzswbQ5b+5WgmK3a68BRtb3nsfovpCStpktaAOl3+cVrs/
        2NlJRHC/6iBVRocvG061zrFW9GjufMNj9ZROjAe2QN6/m23Q9hGLFfwEc3MTaRhWOGddNF
        exs5HgUdmjAIM8cdCbmztm++zzOH18E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643018701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCvhr19vzplzpMM05SVgMboCmOhXfyuz/+7pRxrwQjA=;
        b=Xs0qDN8EcVGbUMKs50D1g63BwpLbufvEdDR/87d1BnvNtI3sqncgmYjuDcElA7uUxRaBOK
        LlxmCoD0SIuVr9Dw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94D7CA3BEB;
        Mon, 24 Jan 2022 10:05:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5245CA05E7; Mon, 24 Jan 2022 11:05:01 +0100 (CET)
Date:   Mon, 24 Jan 2022 11:05:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Message-ID: <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sun 23-01-22 23:52:07, John Hubbard wrote:
> Background: despite having very little experience in the block and bio
> layers, I am attempting to convert the Direct IO parts of them from
> using get_user_pages_fast(), to pin_user_pages_fast(). This requires the
> use of a corresponding special release call: unpin_user_pages(), instead
> of the generic put_page().
> 
> Fortunately, Christoph Hellwig has observed [1] (more than once [2]) that
> only "a little" refactoring is required, because it is *almost* true
> that bio_release_pages() could just be switched over from calling
> put_page(), to unpin_user_page(). The "not quite" part is mainly due to
> the zero page. There are a few write paths that pad zeroes, and they use
> the zero page.
> 
> That's where I'd like some advice. How to refactor things, so that the
> zero page does not end up in the list of pages that bio_release_pages()
> acts upon?
> 
> To ground this in reality, one of the partial call stacks is:
> 
> do_direct_IO()
>     dio_zero_block()
>         page = ZERO_PAGE(0); <-- This is a problem
> 
> I'm not sure what to use, instead of that zero page! The zero page
> doesn't need to be allocated nor tracked, and so any replacement
> approaches would need either other storage, or some horrid scheme that I
> won't go so far as to write on the screen. :)

Well, I'm not sure if you consider this ugly but currently we use
get_page() in that path exactly so that bio_release_pages() does not have
to care about zero page. So now we could grab pin on the zero page instead
through try_grab_page() or something like that...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
