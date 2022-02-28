Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A424C7050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiB1PKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 10:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiB1PJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:09:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB59954BD5;
        Mon, 28 Feb 2022 07:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B41i1sGCjiiiIsAwEwhmVSLh8Tk5XtiAj6Nrs4bu+FY=; b=aBdjVGqDdeEk2ubVAtqsVPvOaQ
        uUAt1MgV7EnCqS2fcD3AcKMcJ+4Z+Umrl7v+eha0Xcfzx8wjY1X3CAZ7Ruv0JtJQxi4MIu2e2tp9l
        FQscogjfgf5noU+/bDQjxR670debH45UGQM3B4mcOucbTBU7tCvAtJ+B2pc9CThk2LoCOYm5jIwxq
        HTy0wLVPH1uyY18Uv+Z12NGmfYXHw8XWyn4a3yxbY6HGPtRPd4k1awjhaRdsJqb8Vs8aZ/BMngc9C
        BAwYQGw79MQrnLWWyoVMuJ/4/8srzVu9v+9o6vuOznMGdYkbiaBNZld7/ovmnttvKgGZcNUnB9CRs
        z8ixPLuQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOhe0-00D4pD-Qd; Mon, 28 Feb 2022 15:09:00 +0000
Date:   Mon, 28 Feb 2022 07:09:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: optimize exactly register one ctl_table
Message-ID: <YhzljEnznlZjw53K@bombadil.infradead.org>
References: <20220224093201.12440-1-tangmeng@uniontech.com>
 <YhvsgZesRNQmfkIB@bombadil.infradead.org>
 <f8820396-ff02-7589-a2f0-be542fbc2c3d@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8820396-ff02-7589-a2f0-be542fbc2c3d@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:42:19AM +0800, tangmeng wrote:
> 
> 
> On 2022/2/28 05:26, Luis Chamberlain wrote:
> 
> > 
> > This effort is trying to save space. But now you are adding a new bool
> > for every single struct ctl_table.... So doesn't the math work out
> > against us if you do a build size comparison?
> > 
> Currently,

You mean after your patch.

> the definition of the ctl_table structure and the size of the
> members are as follows.
> /* In 64-bit system*/
> struct ctl_table {
...
>         bool register_one;               /* 1 bytes */
...
> } __randomize_layout;
> 
> Before 

Before it the bool was not there. How can it be you are not increasing
the size?

> > Can you just instead add a new helper which deals with one entry?
> > Perhaps then make the other caller which loops use that? That way
> > we don't bloat the kernel with an extra bool per ctl_table?
> > 
> I have considered add a new helper which deals with one entry. But
> considered that the code will be similar to array,

That's fine, if we have tons of these.

> > Or can you add a new parameter which specififes the size of the array?
> > 
> When I considered add a new parameter which specififes the size of the
> array. I have encountered the following difficulties.
> 
> The current status is that during the ctl_table registration process, the
> method of traversing the table is implemented by a movement of the pointer
> entry pointing to the struct ctl_table. When entry->procname is empty, it
> considers table traversal.
> 
> This leads to that when the ctl_tables have child tables in the table, it is
> not possible to get the child table's size by ARRAY_SIZE(*entry), so
> transmitting the Child Table Size becomes very difficult.

I see.

A simple routine for dealing with single entries might be best then.
And while at it, see if you can add a DECLARE_SYSCTL_SINGLE or something
which will wrap up all the ugly stuff.

  Luis
