Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DA6250A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 22:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHXU47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 16:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHXU45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:56:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865FC061574;
        Mon, 24 Aug 2020 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LN+DUOfKEizX8QNr7bOwZ5+JguobMK44E5m8RnNF9Bo=; b=YIumQ8y4HB+kfazl4vAjZnFq5I
        ThgurHTGnN47Ze7FwjQqITnlhn2Ur3gbvUmcmDLFxwPgwqs0GjbJwF5CijWhrftuNbV8gciSlc6IA
        2sVxlIzk3XAnFI3haLRU02ms/eYmP5hYD/+Ez7d45xYoHKe5Km/CYMH/w8I81YgdKlTIH8OC3L7Mk
        VJyuRhAlgCt96qKP5ucvgaMMQN/F0zPKVot4QAraIb+i7suzQtegpxyJXL6K+312IcN6PSbO+2Fc2
        1NAEV4+VcJm/odK74IlYsEUbCQdiKfpktGI4fBo01D4SJQcWXN4RfGs4dw8FAm6TfZKenoUmchtQ6
        8bzl2kuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAJWJ-0001kY-OF; Mon, 24 Aug 2020 20:56:48 +0000
Date:   Mon, 24 Aug 2020 21:56:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, david@fromorbit.com,
        hch@infradead.org, darrick.wong@oracle.com, mhocko@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v6 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20200824205647.GG17456@casper.infradead.org>
References: <20200824014234.7109-1-laoar.shao@gmail.com>
 <20200824014234.7109-3-laoar.shao@gmail.com>
 <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 01:09:25PM -0700, Andrew Morton wrote:
> On Mon, 24 Aug 2020 09:42:34 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
> >  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)	(-EIO)
> >  #endif /* CONFIG_SWAP */
> >  
> > +/* Use the journal_info to indicate current is in a transaction */
> > +static inline bool
> > +fstrans_context_active(void)
> > +{
> > +	return current->journal_info != NULL;
> > +}
> 
> Why choose iomap.h for this?

Because it gets used in iomap/buffered-io.c

I don't think this is necessarily a useful abstraction, to be honest.
I'd just open-code 'if (current->journal_info)' or !current->journal_info,
whichever way round the code is:

fs/btrfs/delalloc-space.c:              if (current->journal_info)
fs/ceph/xattr.c:                if (current->journal_info) {
fs/gfs2/bmap.c:         if (current->journal_info) {
fs/jbd2/transaction.c:  if (WARN_ON(current->journal_info)) {
fs/reiserfs/super.c:    if (!current->journal_info) {

(to pluck a few examples from existing filesystems)
