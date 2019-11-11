Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC03DF6FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 09:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKIi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 03:38:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKIi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hcAOVMZPSzZPhTPxN9VZMB0WgNghvQiZWyp0y9X3270=; b=OQc6TyHsOO3L0MFE2gFIEh/2u
        TF2lL1nyj+yTZMLy5mmv5imhXqE+V+8CXMch6bDvBXSksYLErJMKs5UeQ299wYUd9B8nHIxHEVJto
        oIAaICc3N5bh9KCeyuArOpH+2jkFiZs3my+rlzQoh446mRASerHynRsMEjNNr3jEEOmhUJm77cUgX
        wk/FlQ4IjZqmfgKz4BAlXdBOaKD/Bw70ADeDWNlkwloksFnyzKrdKRUWu6hTiiyiq0/QgBnvofuRt
        kUcVgQa3G0wvszDfsT+5HqIATdK3Fs68wZIq3NNrDx2qPcxNvMxtjzaP7pFw5NA9ZvA4lCmVMZHAN
        a9vF33p3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iU5DD-0007mS-4J; Mon, 11 Nov 2019 08:38:15 +0000
Date:   Mon, 11 Nov 2019 00:38:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: LTP: diotest4.c:476: read to read-only space. returns 0: Success
Message-ID: <20191111083815.GA29540@infradead.org>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
 <20191111012614.GC6235@magnolia>
 <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:19:40AM -0500, Jan Stancek wrote:
> > > loff_t length,
> > >                 if (pad)
> > >                         iomap_dio_zero(dio, iomap, pos, fs_block_size -
> > >                         pad);
> > >         }
> > > -       return copied ? copied : ret;
> > > +       return copied ? (loff_t) copied : ret;
> > 
> > I'm a little confused on this proposed fix -- why does casting size_t
> > (aka unsigned long) to loff_t (long long) on a 32-bit system change the
> > test outcome?
> 
> Ternary operator has a return type and an attempt is made to convert
> each of operands to the type of the other. So, in this case "ret"
> appears to be converted to type of "copied" first. Both have size of
> 4 bytes on 32-bit x86:

Sounds like we should use a good old if here to avoid that whole problem
spacE:

	if (copied)
		return copied;
	return ret;

> size_t copied = 0;
> int ret = -14;
> long long actor_ret = copied ? copied : ret;
> 
> On x86_64: actor_ret == -14;
> On x86   : actor_ret == 4294967282
> 
> > Does this same diotest4 failure happen with XFS?  I ask
> > because XFS has been using iomap for directio for ages.
> 
> Yes, it fails on XFS too.

Is this a new test?  If not why was this never reported?  Sounds like
we should add this test case to xfstests.
