Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65A614B04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 13:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKAMoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAMop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:44:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174B1AF08;
        Tue,  1 Nov 2022 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Odtx5Eky4qVo99zjyx03+MN50lR1ZREXkOzvkAldQk=; b=N9IeZS1uuCWJswLD5FY6EtrHMA
        C7Zo3FTtJf13S+5J5r4M5MoVTv5oZn04v5ipNG9jKL49BWI0XyC/Z2DSRFHpjVALeB7MAuzI+vTay
        Ij3yrKXMRPXEyfhvrzJ/wtkYqDlgfh+OJDTsgFPQQnBZeKj/NKW8XKEk8tZH4SHAe6EtHU0gPR6Sn
        nJaJEK/wRHQAT726kb5wAmLcyP7/HYZaVu6blJcyLKsjlcsRJaDyZWE6QegtHqMhuZrfsinZ00ZU2
        bDyjhFfGRygdMqfuWBp5exEEQfmmRrDkkBG2UW7t/OLmzJW3iO5Ch99diWJizsnvjTzpzm7D8mOFE
        hfE6VEOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opqdI-004bu4-R0; Tue, 01 Nov 2022 12:44:44 +0000
Date:   Tue, 1 Nov 2022 12:44:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     changfengnan <changfengnan@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, djwong@kernel.org, dchinner@redhat.com,
        chandan.babu@oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] mm: remove filemap_fdatawait_keep_errors
Message-ID: <Y2EUvEkz4XqV/Gt1@casper.infradead.org>
References: <20221101093413.5871-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101093413.5871-1-changfengnan@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:34:13PM +0800, changfengnan wrote:
> use filemap_fdatawait_range_keep_errors to instead of
> filemap_fdatawait_keep_errors, no functional change.

I'd rather see a patch which turned filemap_fdatawait_keep_errors()
into

static int filemap_fdatawait_keep_errors(struct address_space *mapping)
{
	return filemap_fdatawait_range_keep_errors(mapping, 0, LLONG_MAX);
}

then the callers get the nice interface they want.
