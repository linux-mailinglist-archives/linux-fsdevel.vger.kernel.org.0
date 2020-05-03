Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17501C2F01
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 22:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgECUGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgECUGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 16:06:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B764C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2020 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BBreALKgCLeb13Lr+1Xfk9Bo8eivWzA2o/3JfL8rEuU=; b=ii9wxfu94miWRrD5GaIfWQLcbH
        ShHZTteB9JL0+r0hCyc7Q27GdAHWDMXlxgQQXgyjhcIz1oVPCco9mcsS4KMaPc/3ZUXS7cLBc45jU
        58xYIuZnshwdGhiPw31TgrMWN+Wrwqz4FSti/LGSHpwXobZ9HOOMBt4j//3QBiJfApVUPxOW0P6OT
        Gg8Lm2MAEPaeU2eLUBvTFdfhqSxn/HiGi00Kh1VFarmI3D5mE1ow7yr8lk51DReWN1QXgXfV03M06
        Rq4YIAKuIeHZ3H60Pt0AEVDnKulvVnXq9k4Isk3dkR+OThraFWLVZhMcR/kveE/e+qac7J1HKE1d7
        CdjMrrZg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVKsS-000729-0g; Sun, 03 May 2020 20:06:16 +0000
Date:   Sun, 3 May 2020 13:06:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
Message-ID: <20200503200615.GA16070@bombadil.infradead.org>
References: <87a72qtaqk.fsf@vostro.rath.org>
 <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org>
 <87368hz9vm.fsf@vostro.rath.org>
 <20200503102742.GF29705@bombadil.infradead.org>
 <85d07kkh4d.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d07kkh4d.fsf@collabora.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 03, 2020 at 02:28:34PM -0400, Gabriel Krisman Bertazi wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
> > flags has 'waiters' set, which is not in the allowed list.  I don't
> > know the internals of FUSE, so I don't know why that is.
> 
> Hi
> 
> On the first message, Nikolaus sent the following line:
> 
> >> [ 2333.009937] fuse: page=00000000dd1750e3 index=2022240 flags=17ffffc0000097, count=1,
> >> mapcount=0, mapping=00000000125079ad
> 
> It should be noted that on the second run, where we got the dump_page
> log, it indeed had a null mapping, which is similar to what Nikolaus
> asked on the previous thread he linked to, but looks like this wasn't
> the case on at least some of the reproductions of the issue.  On the
> line above, the condition that triggered the warning was page->mapping
> != NULL.  I don't know what to do with this information, though.

I don't see anything in upstream which will print "NULL" for a null
pointer passed to pointer().  ptr_to_id() doesn't check for NULL, nor
does __ptr_to_hashval().

I think we _should_, along with the ERR_PTR values and values less
than 4096.  But that patch isn't upstream.
