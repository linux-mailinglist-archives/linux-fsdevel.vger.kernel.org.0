Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918C03DB7E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 13:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhG3LcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 07:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhG3LcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:32:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E4C061765;
        Fri, 30 Jul 2021 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fo7rG3IzaemGxikK31d//HrXgUCmOJhD7lTTEDkw0IA=; b=bGSJapEagljg+1XZOrtOSz7ujo
        i1ToiEcM2ScPF+MFaPRR3HeZ3IW/dy37Pa4Jj0j6ltEQ79bjibz3auCk22w6xuSZ7LAtAT3YNCRVQ
        rnF9Agn5YR1lETsDj+3CGjQRGtz2j9MFIqFb8xgknSIni5IWvBksFDy1aE/QstfGd2VNx7zhFKv9R
        UgeH7Dm5quuqg/LwJPeMInWQfDZRBNmQ9A7vPyT1Q4v0q18aOMhBoJNIxXmYEeMN3rLreXS2P+dBz
        SY+ClNpVao3fQDL4XfZ/slOJ/Vvzg9NTiumO1w8iBGXU2DCe386ppKyzGQ2ovoFwoaMuuL5MxrNVq
        fu62aszQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9QjB-000eGm-VR; Fri, 30 Jul 2021 11:31:26 +0000
Date:   Fri, 30 Jul 2021 12:30:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 01/17] block: Add bio_add_folio()
Message-ID: <YQPi8R+Mjh3MxToC@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-2-willy@infradead.org>
 <YQO3bXpibArh37fH@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQO3bXpibArh37fH@T590>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 04:25:17PM +0800, Ming Lei wrote:
> > +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> > +		size_t off)
> > +{
> > +	if (len > UINT_MAX || off > UINT_MAX)
> > +		return 0;
> 
> The added page shouldn't cross 4G boundary, so just wondering why not
> check 'if (len > UINT_MAX - off)'?

That check is going to be vulnerable to wrapping, eg
	off = 2^32, len = 512

It would be less vulnerable to wrapping if we cast both sides to
signed long.  But at that point, we're firmly into obscuring the
intent of the check.
