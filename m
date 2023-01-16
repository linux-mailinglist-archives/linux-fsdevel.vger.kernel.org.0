Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11CC66D0BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 22:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjAPVK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 16:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjAPVKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:10:51 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCE1CAE3;
        Mon, 16 Jan 2023 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tbJsb8AeSzDDqs11g0B47Rm8rooKmyn09jFAV9Yw+ew=; b=rB+0N5Qm4HfhKlL4v0qpenMM2+
        67T5hKcBYGeI52VwfnVNg1ANcL+Btun64b00eWQRlxmZqHICgaw6yjD2QraBkrEyE5NCsYYXJ/kuI
        P7lqVK6Gnctzh4QCJnCQmUrItL79nOT6o3Iq0PgrCBkZnpKtVqA4ZGSp9sm3ujPCfEoY6d5sRY5Gk
        huy65ZOZB5v4haRjmSJjvFFdQEopBgxt1svDD+Sq5KIjA0tuydi3etiMLlvWurqZAM66HtjVjrrvB
        t/Ggk/bkpkxFvVf521svqtcQciC3n+kITFPVMQnP7SjNAqFy78HivTk1XV/+yt9jxJsv68av3TdUI
        rL9Ch4Ug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pHWkX-002Ejr-2z;
        Mon, 16 Jan 2023 21:10:37 +0000
Date:   Mon, 16 Jan 2023 21:10:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     maobibo <maobibo@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y8W9TR5ifZmRADLB@ZenIV>
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
 <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
 <Y8TUqcSO5VrbYfcM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8TUqcSO5VrbYfcM@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:38:01AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 16, 2023 at 11:16:13AM +0800, maobibo wrote:
> > Hongchen,
> > 
> > I have a glance with this patch, it simply replaces with
> > spinlock_irqsave with mutex lock. There may be performance
> > improvement with two processes competing with pipe, however
> > for N processes, there will be complex context switches
> > and ipi interruptts.
> > 
> > Can you find some cases with more than 2 processes competing
> > pipe, rather than only unixbench?
> 
> What real applications have pipes with more than 1 writer & 1 reader?
> I'm OK with slowing down the weird cases if the common cases go faster.

From commit 0ddad21d3e99c743a3aa473121dc5561679e26bb:
    While this isn't a common occurrence in the traditional "use a pipe as a
    data transport" case, where you typically only have a single reader and
    a single writer process, there is one common special case: using a pipe
    as a source of "locking tokens" rather than for data communication.
    
    In particular, the GNU make jobserver code ends up using a pipe as a way
    to limit parallelism, where each job consumes a token by reading a byte
    from the jobserver pipe, and releases the token by writing a byte back
    to the pipe.
