Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF1712246
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbjEZIeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbjEZIeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:34:20 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D612C
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 01:34:18 -0700 (PDT)
Date:   Fri, 26 May 2023 04:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685090056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1+k8geEgB3EI42+JJ+lx1nGKMJgJ9cIZX0cMtf11v8=;
        b=YmHfcSlC6Hj1py8HMz8oTzzq+ZfEqeBn9Pz/Ed/IQtvrF6RfexPzvh/A/8AYkicbAz78LB
        o9z8e2ts1pjbylZmZNsPRSHfTV8H+Il0z8tQSYR9//uxbgsPVnS9Fvo4aqt9a7iMtin30f
        oNKadLj96+v5lfZsEVRpmAnphhg6I7Y=
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
Message-ID: <ZHBvA9uy8A0YdK1p@moria.home.lan>
References: <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <ZGzrV5j7OUU6rYij@moria.home.lan>
 <ZG2yFFcpE7w/Glge@infradead.org>
 <ZG3GHoNnJJW4xX2H@moria.home.lan>
 <ZG8jJRcwtx3JQf6Q@infradead.org>
 <ZG/KH9cQluA5e30N@moria.home.lan>
 <ZHBolpHP5JAmt65V@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBolpHP5JAmt65V@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 01:06:46AM -0700, Christoph Hellwig wrote:
> On Thu, May 25, 2023 at 04:50:39PM -0400, Kent Overstreet wrote:
> > A cache that isn't actually consistent is a _bug_. You're being
> > Obsequious. And any time this has come up in previous discussions
> > (including at LSF), that was never up for debate, the only question has
> > been whether it was even possible to practically fix it.
> 
> That is not my impression.  But again, if you think it is useful,
> go ahead and seel people on the idea.  But please prepare a series
> that includes the rationale, performance tradeoffs and real live
> implications for it.  And do it on the existing code that people use
> and not just your shiny new thing.

When I'm ready to lift this to the VFS level I will; it should simplify
locking overall and it'll be one less thing for people to worry about.

(i.e. the fact that even _readahead_ can pull in pages a dio is
invalidating is a really nice footgun if not worked around).

Right now though I've got more than enough on my plate just trying to
finally get bcachefs merged, I'm happy to explain what this is for but
I'm not ready for additional headaches or projects yet.
