Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D363D0DC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhGUKwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 06:52:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48052 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbhGUKmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:42:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C15141FD4A;
        Wed, 21 Jul 2021 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626866576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wmZc3hU/5jvx4cqOqNXcrhZN3NNBbqBfZfeEhxx8RQo=;
        b=iChYs2bPCerVbHhJtIABHNDHNxLIMvFlL6KYGjtHXfKaC9s3dgGGqenmtffFbJotffIO67
        zeZS/G14JpYM/AqchuTWvV8RDz2Lry2V8ghlqrFulueoO0/EEw4OCTF1QRkmF7pGkNfJu4
        26ZlxQKIOUPh5WvicfW9BZeeRUT+uts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626866576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wmZc3hU/5jvx4cqOqNXcrhZN3NNBbqBfZfeEhxx8RQo=;
        b=3wpq68V053oHIxkwfcd2eyY7/qS54/2hN3D8pEc2I6ml5zFOAArHa4yj3urG19GAqeWSfd
        Fp09MflSRIvHMzAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B8A60A3B81;
        Wed, 21 Jul 2021 11:22:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D59BDA704; Wed, 21 Jul 2021 13:20:15 +0200 (CEST)
Date:   Wed, 21 Jul 2021 13:20:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 6/9] fs: add a filemap_fdatawrite_wbc helper
Message-ID: <20210721112015.GC19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
 <1a353b1b013f616c2798526a8d21bb0cd609c25f.1626288241.git.josef@toxicpanda.com>
 <YO/UfqDrIEizq7Re@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO/UfqDrIEizq7Re@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 07:23:58AM +0100, Christoph Hellwig wrote:
> >  extern int filemap_check_errors(struct address_space *mapping);
> >  extern void __filemap_set_wb_err(struct address_space *mapping, int err);
> > +extern int filemap_fdatawrite_wbc(struct address_space *mapping,
> > +				  struct writeback_control *wbc);
> 
> No need for the extern here.

I'll remove it when applying the patch. There are many externs in the
file but also declaration without it so this one won't stand out.
