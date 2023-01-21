Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CC67687C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 20:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjAUT2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 14:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjAUT2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:28:00 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4B2A176;
        Sat, 21 Jan 2023 11:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZErTABo/SBODU1OWSG2QbWD8zbMwylRd+dHspExDIU=; b=TPbgRb4Z8Y0H6bStBI39xxYki9
        fZKFXz5ZpdFkdoUdCuWwgxRXZjvmm6eOa6TktlEwgK3KlZMSL9iEw2amlmrFUEDEpcWa/1Zj7Z+cL
        tPR6Uz7dX6BVqN8cTXuesTwVGt10d5/iEuhUiysi1ZW41+EH2oAuyz6K4WoRQvl5uQiAYcyeLnIoD
        3mf1wVbOGFYI5nALAFN3clv9m3vrkBuROzhNY/QOiutfppFTITFyuo9SvoWLjy0T6kmBJ05KeEXSU
        DQjzJn2mBSNjNNLflGAnLi0AK5t3udcXXA6puJn00PSXnOeIj/+GZxNW+BlHz4L8pYQFrb3mS7EYL
        2EkHM6Wg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pJJVw-003Jrq-2Z;
        Sat, 21 Jan 2023 19:26:56 +0000
Date:   Sat, 21 Jan 2023 19:26:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Helge Deller <deller@gmx.de>, Matthew Wilcox <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8w8gJZBCNqKaYXs@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org>
 <Y8ocXbztTPbxu3bq@ZenIV>
 <Y8oem+z9SN487MIm@casper.infradead.org>
 <Y8ohpDtqI8bPAgRn@ZenIV>
 <Y8os8QR1pRXyu4N8@ZenIV>
 <99978295-6643-0cf2-8760-43e097f20dad@gmx.de>
 <63cb9ce63db7e_c68ad29473@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cb9ce63db7e_c68ad29473@iweiny-mobl.notmuch>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:05:58AM -0800, Ira Weiny wrote:

> First, arn't PAGE_ALIGN_DOWN(addr) and PTR_ALIGN_DOWN(addr, PAGE_SIZE) the
> same?
> 
> align.h
> #define PTR_ALIGN_DOWN(p, a)    ((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
> 
> mm.h:
> #define PAGE_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PAGE_SIZE)

... and ALIGN_DOWN ends up with doing bitwise and on the first argument.
Which doesn't work for pointers, thus the separate variant for those
and typecast to unsigned long in it...
