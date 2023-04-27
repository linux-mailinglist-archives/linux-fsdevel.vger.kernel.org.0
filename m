Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A26F0F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjD0Xs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 19:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbjD0Xs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DA1BF8;
        Thu, 27 Apr 2023 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Id5MRY6csHEAIIsWpDo8U+QRcsMChe0pvKJYUVbkiTw=; b=E4tcX0SO90gvZiDhw+vy7p9mK7
        IVDKsvFI1+xO294jdGE6g3uuZRS9vT9ODrLCSgePm+CAgSNhjxAHQX1Lok2YzWv8yN0WmDDP3FAY3
        TdHn3hQowDzhd2MQaLNe0MNI40WePW2xUr+bGNMkhcYgHlOGM1lT4pVDbwVzgl66yK6lelvYoxq08
        eQln+0WMuJL13DnbinnqclALtKIjb/MkbNu6tO8wjC7Xv3eyic1RHGpnSaiLYJ3MFDwtgnayz1fqH
        aoxQySM3VUVMgmp37tiTy59a/abVnCrvZEJWMqmkFeGRghmnoagtpQjJI9rdRARKyKuLaFVCd1O43
        5WP9Eyrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psBLb-0043WT-N4; Thu, 27 Apr 2023 23:48:23 +0000
Date:   Fri, 28 Apr 2023 00:48:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <ZEsJxwbIeq3jHDBT@casper.infradead.org>
References: <20230406230127.716716-1-jane.chu@oracle.com>
 <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
 <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:36:58PM -0700, Jane Chu wrote:
> > This change results in EHWPOISON leaking to usersapce in the case of
> > read(2), that's not a return code that block I/O applications have ever
> > had to contend with before. Just as badblocks cause EIO to be returned,
> > so should poisoned cachelines for pmem.
> 
> The read(2) man page (https://man.archlinux.org/man/read.2) says
> "On error, -1 is returned, and errno is set to indicate the error. In this
> case, it is left unspecified whether the file position (if any) changes."
> 
> If read(2) users haven't dealt with EHWPOISON before, they may discover that
> with pmem backed dax file, it's possible.

I don't think they should.  While syscalls are allowed to return errnos
other than the ones listed in POSIX, I don't think this is a worthwhile
difference.  We should be abstracting from the user that this is pmem
rather than spinning rust or nand.  So we should convert the EHWPOISON
to EIO as Dan suggests.
