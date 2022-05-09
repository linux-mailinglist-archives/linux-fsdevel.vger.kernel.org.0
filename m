Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96315205DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 22:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiEIUbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiEIUbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 16:31:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA9229FF3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 13:16:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 249KGJZF007232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 16:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652127381; bh=pDjglm7gBrnce1329F79m7J6Qbin1XWih64sCwqJXK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Gf0hKTxBHQ3AxOu/KWfmMF1Ng8LBgEWotOsU/DmYR8EZGQAasVSgGKsOn+1NjglxD
         WVMAlNLLiPh1wjKAN7jNyTrpRDMIAEQKpATa8exWDTx3+GZScpPUg+dZT5BbbXzJSz
         9QwjxtG1ZkkB35//2OgI91VDSLr8yJomY/qCqaHJGFS6BqMYzAbM9XWLJScA7R4Nat
         N/aoNxi5mekandUILpOqSC66khEyJDl8OcgbxzXWEoWPol5gsZVgQ0dIfZkonnB4P1
         ksC3qH094TUSYRI2IWrgQ4aV3JTHLCH3TkxEzfc/VO/2t3l+JGbYYvoxuNOFf35Cu1
         y7WrY/NuC/Crg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AF55515C3F0A; Mon,  9 May 2022 16:16:19 -0400 (EDT)
Date:   Mon, 9 May 2022 16:16:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/37] ext4: Convert ext4 to read_folio
Message-ID: <Ynl2k7FNEBB0awNs@mit.edu>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
 <20220508203131.667959-19-willy@infradead.org>
 <YnkXjPZMSC+yYGOe@mit.edu>
 <YnkgGJdQpT6UZtI3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnkgGJdQpT6UZtI3@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 03:07:20PM +0100, Matthew Wilcox wrote:
> 
> I'm probably answering these emails out of order,

No worries, I've been reviewing these patches out of order myself.
:-)

> but the page
> cache is absolutely not supposed to be creating large folios for
> filesystems that haven't indicated their support for such by calling
> mapping_set_large_folios().

I think my concern is that at some point in the future, ext4 probably
*will* want to enable large folios --- and we may want to do so
selectively.  e.g., just on the read-path, and assume that someone
will break apart large folios to individual pages on the write path,
for example.

The question is when do we add all of these sanity check asserts ---
at the point when ext4 starts making the transition from large folio
unaware, to large folio kind-of-aware, and hope we don't miss any of
these interfaces?  Or add those sanity check asserts now, so we get
reminded that some of these functions may need fixing up when we start
adding large folio support to the file system?

Also, what's the intent for when the MM layer would call
aops->read_folio() with the intent to fill a huge folio, versus
calling aops->readahead()?  After all, when we take a page fault,
it'll be either a 4k page, right?  We currently don't support
file-backed huge pages; is there a plan to change this?

		    	  	    	    - Ted

P.S.  On a somewhat unrelated issue, if we have a really large folio
caused by a 4MB readahead because CIFS really wanted a huge readahead
size because of the network setup overhead --- and then a single 4k
page gets dirtied, I imagine the VM subsystem *want* to break apart
that 4MB folio so that we know that only that single 4k page was
dirtied, and not require writing back a huge amount of clean 4k pages
just because we didn't track dirtiness at the right granularity,
right?
