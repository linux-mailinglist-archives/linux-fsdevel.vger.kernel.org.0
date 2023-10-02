Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4781E7B59C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjJBSJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjJBSJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:09:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F19E
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TqQMSgyuHcEnmTjAdstrfVHxseHFdEsVC1X1Qo8nytE=; b=u8T6nMz35Xwq+ZAPEyguD78+x8
        VR/QG25AGNgkbaZbJnaWHmluPu7JPNPzA2pjkT3x+1XfKBMZ5dnkrilFRR/2SjA1YrX1PQLq+UZiv
        P8Vz4Evg0JH34VoHNBeIYlXdDfXIs44u4u5+KYIdwDXp2cktfiOdX+Y67DSMMiQ5ObaS45GPkxqWe
        LthgO+Y3RIZJ0UUDRls3OnqpoMjUeKE4NyeEpqPtRDjUAUE7KS0rYnxRXQXix3hblPZIdzqrdFUa/
        jZ/Ce3S1btiohRvErfsNvFXi0A3x+OYtG3Ra8IYcioI230/VS1yYlJTmDFQXB+leq6T9fi0fN+ejT
        jcVzJGYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnNMD-00Ebf8-0q;
        Mon, 02 Oct 2023 18:09:25 +0000
Date:   Mon, 2 Oct 2023 19:09:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 04/15] hfsplus: switch to rcu-delayed unloading of nls
 and freeing ->s_fs_info
Message-ID: <20231002180925.GZ800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023125.GE3389589@ZenIV>
 <20231002064912.GA2013@lst.de>
 <20231002071401.GT800259@ZenIV>
 <20231002072143.GU800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002072143.GU800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:21:43AM +0100, Al Viro wrote:
> On Mon, Oct 02, 2023 at 08:14:01AM +0100, Al Viro wrote:
> > On Mon, Oct 02, 2023 at 08:49:12AM +0200, Christoph Hellwig wrote:
> > > Instead of all this duplicatio in the file system, can we please just
> > > add a
> > > 
> > > 	struct nls_table *s_nls;
> > > 
> > > to struct super_block and RCU free it in common code and drop all the
> > > code in the file systems?
> > 
> > It makes no sense for most of the filesystems, for one thing (note that
> > any use in ->lookup() does not warrant rcu delays).  What's more,
> > how do you formulate the rules for what goes in that field when filesystem
> > uses more than one nls_table?
> 
> Consider e.g. HFS; two separate nls_table (nls_disk, nls_io), neither needs
> RCU delays of any sort.  On VFAT, for that matter - again, two tables,
> one needs RCU delay, another doesn't (both get dropped from the same
> helper, so both get it).

BTW, is there any reason not to have synchronize_rcu() in delete_module(2),
just before calling ->exit()?

It's not a hot path, unless something really weird is going on, and it
would get rid of the need to delay unload_nls() calls...
