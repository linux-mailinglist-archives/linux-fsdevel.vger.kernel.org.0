Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B484A479154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbhLQQUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 11:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhLQQUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:20:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB89C061574;
        Fri, 17 Dec 2021 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yHF3VWnW4rZABeXM9Y5F9Xrqzvs0hWQXlFpZX+lD3a0=; b=bCn9oKruVGSB4B0ftB2r6ZYU2S
        UOiZf5f01purfvE9yOBa3q8d9i7kko98pta+KraPAF89P0pm1BAPgIy03HNijmT5nHz6teIeF74vf
        +pAS9cxh2HNpvifLlTxMej6FAH57Fxi3/uB5jBBW2EEExnSQfjXhjE2iuY7ZBp37gm5fBypUY97Qp
        /ocmsyYKmLKzuMhjm6koBYHSAk7R4uhLNNe6EpZHFnuFUIK4PgDFf19RvBj9YZ8WFESlg1a66SmPz
        M+nEL1y/3H7Oa23oWBjFYwii+/KegM1/m8SCCsQ2TTYAppyBcNeSK4HFtRzLCaEIffS6/yNY0Dzdo
        uqiupEkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myFxg-00GrtW-H7; Fri, 17 Dec 2021 16:20:00 +0000
Date:   Fri, 17 Dec 2021 16:20:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, ceph-devel@vger.kernel.org, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ceph: Uninline the data on a file opened for
 writing
Message-ID: <Yby4sKDALDXHAbdT@casper.infradead.org>
References: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 03:29:45PM +0000, David Howells wrote:
> If a ceph file is made up of inline data, uninline that in the ceph_open()
> rather than in ceph_page_mkwrite(), ceph_write_iter(), ceph_fallocate() or
> ceph_write_begin().

I don't think this is the right approach.  Just opening a file with
O_RDWR shouldn't take it out of inline mode; an actual write (or fault)
should be required to uninline it.

> This makes it easier to convert to using the netfs library for VM write
> hooks.

I don't understand.  You're talking about the fault path?  Surely
the filesystem gets called with the vm_fault parameter only, then
calls into the netfs code, passing vmf and the operations struct?
And ceph could uninline there.

