Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB82E0D30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgLVQTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 11:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgLVQTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:19:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F6CC061793;
        Tue, 22 Dec 2020 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQR/YgBWhGYrRRqTF0BOEXEvKg/409uuplzpqhvAfKE=; b=c4UFcqjSsnoRISaP7DnxM5hrVx
        /cVdi2XikxsfNoGUsy/3QVJ1u39j5POoDySKkAQbFURDUvtcF8ZYPFkABcM7RlGWcfa19hUCNipf1
        hBMcwE/UFQpFOQwhLB1Gbk4Ws524uMAsmB6yQj5aMZAadQChx5dFCtko6GAZuec9PvO5ACjnwAQOW
        PyFb/KAhWeXBH9LcI8SHlyQoRHNCbTVz9AiphEBQ75b1BhaKpEoOYG6tfqrNEorqlmvUYufjoZtLp
        Kx5jAFYiDPLDIfOwgsec8E4dWWQQ/DRPd47IIk8FyZw+3tHi+TbKU80PFKIfQp8NN6b49B4JJBL3N
        k8Nd684A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krkNI-0004VE-TL; Tue, 22 Dec 2020 16:19:00 +0000
Date:   Tue, 22 Dec 2020 16:19:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 2/3] vfs: Add a super block operation to check for
 writeback errors
Message-ID: <20201222161900.GI874@casper.infradead.org>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221195055.35295-3-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 02:50:54PM -0500, Vivek Goyal wrote:
> -	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> +	if (sb->s_op->errseq_check_advance)
> +		ret2 = sb->s_op->errseq_check_advance(sb, f.file);

What a terrible name for an fs operation.  You don't seem to be able
to distinguish between semantics and implementation.  How about
check_error()?

