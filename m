Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB2139822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 18:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAMRyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 12:54:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMRyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v68KOmmFCgojskPM3niSU92RDz2UGXctd3aEcUGr1z0=; b=JoDbgk3KvfTL3TCtvdKWEkP2I
        GGxzbOkOAhh4bu+x8KEXH765FH6bbPxzLnlxNd6Vo1qGp7Oy+ocl7praB1F0ZFFcPrF1w4l3JDfmS
        8NNXB5UE4oCt32dAVbZ+aRCpZK+jRuCX+K1o7Fy8T2Y/G4a2OoPFm+NoHeyjkZjj+QNZP6pSCUgHA
        f87JzB4e8x3h1MUsbJlOKaBJykMaZG2/khdlcFQWa1y209JIWtvajJF/+U3lPa++T0SsC6yec7F+p
        ElANtlsCvb30WH6eXo3R/reXUHHDy2TjhScLZ5srtYZIy+l34p4/NOd+9IOt6kJhbPr11njpxo1+r
        ABzvCY8BA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir3vA-0006y8-8w; Mon, 13 Jan 2020 17:54:36 +0000
Date:   Mon, 13 Jan 2020 09:54:36 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Message-ID: <20200113175436.GC332@bombadil.infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:42:10PM +0000, Chris Mason wrote:
> Btrfs basically does this now, honestly iomap isn't that far away.  
> Given how sensible iomap is for this, I'd rather see us pile into that 
> abstraction than try to pass pagevecs for large ranges.  Otherwise, if 

I completely misread this at first and thought you were proposing we
pass a bio_vec to ->readahead.  Initially, this is a layering violation,
completely unnecessary to have all these extra offset/size fields being
allocated and passed around.  But ... the bio_vec and the skb_frag_t are
now the same data structure, so both block and network use it.  It may
make sense to have this as the common data structure for 'unit of IO'.
The bio supports having the bi_vec allocated externally to the data
structure while the skbuff would need to copy the array.

Maybe we need a more neutral name than bio_vec so as to not upset people.
page_frag, perhaps [1].

[1] Yes, I know about the one in include/linux/mm_types_task.h
