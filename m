Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A75517AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfFXPvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 11:51:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFXPvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=inpoRmTcnHGLH8DDnCxUFGoSuHYKxhpxrWGM6xtOym4=; b=JRNT9yvQjDEL6j3d/GuuHP1L1
        9BiLg4o+XeDUgwieTNdPKVKU5k70GPN5XZszqhG9rnavqDfFq8bL5IRMhhbowodT6ZBghJ2SO+B+m
        4npH+mU6dxMi7K7k4Andv/MV72IQY33lPuW5ESk/BEOjkkSHGxByQ8tTo2nNkSNNBANTDBOA/NQ03
        owGGYlBzH8vBXaDukMX49lasJFwdNJYILSKI+jpgOgDOiANCE2N8x4m8VdhwXZuVK90S65KRTPo4Q
        hoHpmCMD5U88f4tGIRDICeAqqhHdu+CV3Rxn2ZxI6OzdCb6yYGb3IW2jayZtyvSL3V1ieuer0+2jx
        q1mh1yzxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfRFp-0005yf-J1; Mon, 24 Jun 2019 15:51:37 +0000
Date:   Mon, 24 Jun 2019 08:51:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] list.h: add a list_pop helper
Message-ID: <20190624155137.GO32656@bombadil.infradead.org>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-2-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:42AM +0200, Christoph Hellwig wrote:
> +/**
> + * list_pop - delete the first entry from a list and return it
> + * @list:	the list to take the element from.
> + * @type:	the type of the struct this is embedded in.
> + * @member:	the name of the list_head within the struct.
> + *
> + * Note that if the list is empty, it returns NULL.
> + */
> +#define list_pop(list, type, member) 				\

The usual convention in list.h is that list_foo uses the list head and
list_foo_entry uses the container type.  So I think this should be
renamed to list_pop_entry() at least.  Do we also want:

static inline struct list_head *list_pop(struct list_head *head)
{
	struct list_head *first = READ_ONCE(head->next);

	if (first == head)
		return NULL;
	__list_del(head, first->next);
	return first;
}

we also seem to prefer using inline functions over #defines in this
header file.
