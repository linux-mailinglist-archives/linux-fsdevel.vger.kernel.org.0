Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8D56BC66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiGHOx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiGHOx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:53:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997682A73D;
        Fri,  8 Jul 2022 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9/lkeRcGIhHu6UVP5xYmV7mYlWFVVjg4XhlUmR+XakU=; b=u/hJU81hiwYxXnG04A+ldFArw5
        FTQjbsTDMajhXO2rUfAsuJI5/r3v1zr7iPeLiKDX6NrmpYwS8sf/5S306VLzRoZFaBIwztvkTEkXm
        eUm4v4oYRwLM561NqYLJA1JF3xrDFVyWq9meyhaNJYzbINN0H+pDxN8ehYUW/hUtRd3BomZ6BuHhx
        w1GKs/7ZEFQf3u8WfpHzqdV2N1ch2jMDqeEICZKZfgnuXpbopkkQqToE1231YgyyF7abGsJNymMS4
        rwxXRjkK5P4E5oT7IseYLrsfKCYMu4F76TCxKwWUCnUBPhXutUNM7GduKN+ZeGdWwcUOKY0ynubE/
        IYEil3TQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9pMc-003a34-EH; Fri, 08 Jul 2022 14:53:50 +0000
Date:   Fri, 8 Jul 2022 15:53:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <YshE/pwSUBPAeybU@casper.infradead.org>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
 <20220705232159.2218958-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705232159.2218958-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> The main issue I see with this is defining devm_xa_init() in device.h.
> This makes sense because a device is required to use the call.  However,
> I'm worried about if users will find the call there vs including it in
> xarray.h?

Honestly, I don't want users to find it.  This only makes sense if you're
already bought in to the devm cult.  I worry people will think that
they don't need to do anything else; that everything will be magically
freed for them, and we'll leak the objects pointed to from the xarray.
I don't even like having xa_destroy() in the API, because of exactly this.

