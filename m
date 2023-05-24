Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE96570EE57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbjEXGp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbjEXGo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:44:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD191FCA;
        Tue, 23 May 2023 23:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x8PYhGTrPAt9NKG8UKKxEtkvRfE8xvv8TBO5S8oegQs=; b=CN4s7kEI5PCARtpXP47dqHFQS/
        vIt1hQeojTucws3q9J4RyMTGKDZau5CMHFMnIbOx47u7ODqLJK73E39uw/C7Cav+B+9ajUvaFaDJm
        rJY3rXUQ/gOZCiDAyoHMyrRJzZ4WWkrjpfoiu60Hbvn45XZk7aX7jsQLTRtzpp+axW7G1qzEbYxzQ
        F9buDGL2mpULh+qnIvHyZkzivfChIZr1eAOUPLPpigx/mk00bl3wWlKpCmBS0vpzEYpqUcOCvRcuW
        C42sBZHTlt6A9noZYQkz1x7PHJapsJ66UrbJniCKf2ecH677bC+z/HgwZudimJiH7NFrzfxP+qsOK
        fhNlGAug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iDc-00CWNR-0L;
        Wed, 24 May 2023 06:43:32 +0000
Date:   Tue, 23 May 2023 23:43:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZG2yFFcpE7w/Glge@infradead.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <ZGzrV5j7OUU6rYij@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzrV5j7OUU6rYij@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 12:35:35PM -0400, Kent Overstreet wrote:
> No, this is fundamentally because userspace controls the ordering of
> locking because the buffer passed to dio can point into any address
> space. You can't solve this by changing the locking heirarchy.
> 
> If you want to be able to have locking around adding things to the
> pagecache so that things that bypass the pagecache can prevent
> inconsistencies (and we do, the big one is fcollapse), and if you want
> dio to be able to use that same locking (because otherwise dio will also
> cause page cache inconsistency), this is the way to do it.

Well, it seems like you are talking about something else than the
existing cases in gfs2 and btrfs, that is you want full consistency
between direct I/O and buffered I/O.  That's something nothing in the
kernel has ever provided, so I'd be curious why you think you need it
and want different semantics from everyone else?
