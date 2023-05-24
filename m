Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD270F03C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjEXIJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbjEXIJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 04:09:23 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D419D
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 01:09:09 -0700 (PDT)
Date:   Wed, 24 May 2023 04:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684915747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkhXh/TNyeXnNZOI/g5bdL7/bZLBDieBo7l7auFehJY=;
        b=OXVDS+r2p27nxKKqRkqENlViSIEfqtZGoYc3kUZAvrLrMCsgBoAWydyq7TCQCOP9ytJb4X
        X21tXArPk8LIe/Q4J2B9PVtUETWXb4sqWXRQ4bSH/XBnuRWF2Venmm+l0ZxUIhayGx1DEF
        Ej6hv4vtmZ0eemIzKCYqV1JLFVorz/I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, cluster-devel@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZG3GHoNnJJW4xX2H@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <ZGzrV5j7OUU6rYij@moria.home.lan>
 <ZG2yFFcpE7w/Glge@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG2yFFcpE7w/Glge@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 11:43:32PM -0700, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 12:35:35PM -0400, Kent Overstreet wrote:
> > No, this is fundamentally because userspace controls the ordering of
> > locking because the buffer passed to dio can point into any address
> > space. You can't solve this by changing the locking heirarchy.
> > 
> > If you want to be able to have locking around adding things to the
> > pagecache so that things that bypass the pagecache can prevent
> > inconsistencies (and we do, the big one is fcollapse), and if you want
> > dio to be able to use that same locking (because otherwise dio will also
> > cause page cache inconsistency), this is the way to do it.
> 
> Well, it seems like you are talking about something else than the
> existing cases in gfs2 and btrfs, that is you want full consistency
> between direct I/O and buffered I/O.  That's something nothing in the
> kernel has ever provided, so I'd be curious why you think you need it
> and want different semantics from everyone else?

Because I like code that is correct.
