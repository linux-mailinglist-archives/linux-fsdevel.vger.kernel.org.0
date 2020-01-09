Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEA1353A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 08:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgAIHRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 02:17:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgAIHRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QiGddIdznuWpaK7y0GhGRJ+SVWaUTsy0jZCxFwhuX10=; b=b/atrdTv7mTla8rMm5os8qR0f
        xlx3bPLebE+cRT2xapyhAqh5XtlEwbso2AIXRqJHaNMt1Qxl2UzsLsYiOKhqLu8ZJ8goRpKw2Rji8
        Wui2E6GzrlCEQCH652U27E57x2zdbA/K58n+RRc7c/lTak1zYj2B4RuBQUnBeZFwa4gpIFo2vzXwx
        IwGxS1NC3SBaC2wjRzEmdks9rxLY2K5wuJzl5HQlTUX6gpUVYDS8seZZNIGSPS4YdSE50vt2AR1Uu
        C/iIPAipbWYc6EbkVkh24BtzWdM+T8MxcGXo0lhkbE+448tKoWYjCjGgYOf0kgcp5zJbU8csKk3iw
        NrO8vBYAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipS4Z-0000Gl-7c; Thu, 09 Jan 2020 07:17:39 +0000
Date:   Wed, 8 Jan 2020 23:17:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
Subject: Re: [PATCH V2] block: add bio_truncate to fix guard_bio_eod
Message-ID: <20200109071739.GB32217@infradead.org>
References: <20191227230548.20079-1-ming.lei@redhat.com>
 <20200108133735.GB4455@infradead.org>
 <20200109020524.GD9655@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109020524.GD9655@ming.t460p>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:05:24AM +0800, Ming Lei wrote:
> OK, will do that.
> 
> > 
> > > +	if (bio_data_dir(bio) != READ)
> > > +		goto exit;
> > 
> > This really should check the passed in op for REQ_OP_READ directly instead
> > of just the direction on the potentially not fully set up bio.
> 
> It has been addressed in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=802ca0381befe29ba0783e08e3369f9e87ef9d0d

Well, it fixes the bug introduced.  But it still uses bio_data_dir
instead of the explicit REQ_OP_READ check, and still uses a calling
convention that leads to such errors.
