Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D9784C5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 23:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHVV4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 17:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHVV4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:56:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098FA8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tWRMiv4ptZMImAbUsn4kGCUcWfbOD2BYs41cfOgr8mM=; b=JlcrDHAtTwqBsAusHWzolldvyI
        M76o+ONNw8ZVWBrMX7r94HYRU5j4LpzVnAlrqN0q05TVmjK/DAqFHEbr1+JfGv+ksL6BuK9etwIe6
        oD7FxSS4G9u62xuVl7zUgetXlwbCzkZWoNKVc/1Qy1XPkArlX7l/PYlnJh1ze6mqFteSs6Dx268Tz
        o5OZZIC20pLazi3LCjKRqe2ZTwXo7kQ7PGt99ByZt0EHviHkGFgJG0u2DX3VQMeyZVdC25eopuAk8
        EL6qGgwSCeRSTS/f+rMGPBU0b/fBQTFreesIY7dO7I2iK4peEtnaSzcHs1jDfj6bZBy6lE8AdGnFu
        3fxF2yDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYZMD-00188s-07; Tue, 22 Aug 2023 21:56:13 +0000
Date:   Tue, 22 Aug 2023 22:56:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <ZOUu/AGuQ8f+SWxU@casper.infradead.org>
References: <20230822200937.159934-1-willy@infradead.org>
 <20230822211720.GA11242@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822211720.GA11242@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:17:20PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 22, 2023 at 09:09:37PM +0100, Matthew Wilcox (Oracle) wrote:
> > Modelled after the loop in iomap_write_iter(), copy larger chunks from
> > userspace if the filesystem has created large folios.
> 
> Hum.  Which filesystems are those?  Is this for the in-memory ones like
> tmpfs?

Alas tmpfs uses its own shmem_file_read_iter() and doesn't call back
into generic_perform_write().  But I was looking at the ramfs aops and
thinking those looked ripe for large folio support, so I thought I'd take
care of this part first since it potentially affects every filesystem
that uses generic_file_write_iter() / __generic_file_write_iter() /
generic_perform_write().

This is also a great opporunity for someone to tell me "Actually I have
plans in this area and ..."

