Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC836C1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFFGSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 02:18:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U8rF1uP19dnET207DcY9H/fsoaYvyqbT8DVHn5K5oRM=; b=hh3vfV36YrLiF3AZvb2T4/Qsm
        ZGpgeScpxKnNf0aS2baD3ki47trw/uHctB3wKBpv6V6SbCMpk2PfbKUk/5XgM8HNDjclepJ9Zdbz6
        2GcqhtFfRtwgOlRsLz0gTHbH/QD8c0RD1Nwv73lkSzrx4ZW4CsWVtPnTSaYKb7q2DM4NJWtdmuwyk
        Ib935aW8MHP3OauCGnonYIxkH5L3VSyJFRXG0U2YAfTuXHF11OiwL/C6RfAmS9J4JPPN67De362rW
        nJke29YpqUQ+h0Q/HmV6zGVwwZQCpJPnOD1sInPHpqtie3EXgVS+P5THX1FahoL367+4HTT4+qz1H
        qcJ4t2xpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYljA-0005QG-0s; Thu, 06 Jun 2019 06:18:20 +0000
Date:   Wed, 5 Jun 2019 23:18:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 03/10] mm/gup: Pass flags down to __gup_device_huge*
 calls
Message-ID: <20190606061819.GA20520@infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606014544.8339-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606014544.8339-4-ira.weiny@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 05, 2019 at 06:45:36PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order to support checking for a layout lease on a FS DAX inode these
> calls need to know if FOLL_LONGTERM was specified.
> 
> Prepare for this with this patch.

The GUP fast argument passing is a mess.  That is why I've come up
with this as part of the (not ready) get_user_pages_fast_bvec
implementation:

http://git.infradead.org/users/hch/misc.git/commitdiff/c3d019802dbde5a4cc4160e7ec8ccba479b19f97
