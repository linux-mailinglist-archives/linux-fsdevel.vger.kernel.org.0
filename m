Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE37B72B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjJCUr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjJCUr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:47:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87613AC
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Wvkh/ttMdcRyu26x0Lnlv/kUHk+nFkH5k65iusbjaA=; b=q34DwuGA9V2x0rp/LS4HfZBGWo
        mmyc+MGZcUg3SMHFYz04v0xQB7Y80/Cqp3ZgFj0tEOFTdDWtQKLUheqX8GbeeprVvimxuDSBVJlUJ
        iUFnpfTNFTYt2TURKsK0lVgLowX2Awldt/Vf+FKo4P6ROwfHue5JZAQoXnPnveAD2RWou47q6hMA6
        cB+FrGg8+NFWiXmrsPnMveCH18casa87VMLcbVeee7vfe41XAS++F9snZfsnL95mtyl6p8liWn1dn
        xRwGkO7PHX5Dr86GSK4IquMne+XyzkBTVHOBQ0ZJruK8T4zhX8pwb7g41xCJp5zp3CCg0ja/awJu5
        m2sh7a3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnmJ3-00FNpf-1u;
        Tue, 03 Oct 2023 20:47:49 +0000
Date:   Tue, 3 Oct 2023 21:47:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 15/15] overlayfs: make use of ->layers safe in rcu
 pathwalk
Message-ID: <20231003204749.GA800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV>
 <20231002023643.GO3389589@ZenIV>
 <20231002023711.GP3389589@ZenIV>
 <CAOQ4uxjAcKVGT03uDTNYiSoG2kSgT9eqbqjBThwTo7pF0jef4g@mail.gmail.com>
 <20231002072332.GV800259@ZenIV>
 <CAOQ4uxgPrfsJc6g6W4Q2b-SRSvNpih7NHrV4vybQzrWFa_4rOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgPrfsJc6g6W4Q2b-SRSvNpih7NHrV4vybQzrWFa_4rOA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:53:23AM +0300, Amir Goldstein wrote:

> I've also considered just allocating the extra space for
> ofs->mounts[] at super creation time rather than on super destruction.
> I just cannot get myself to be bothered with this cleanup code
> because of saving memory of ovl_fs.
> 
> However, looking closer, we have a wasfull layer->name pointer,
> which is only ever used for ovl_show_options() (to print the original
> requested layer path from mount options).
> 
> So I am inclined to move these rarely accessed pointers to
> ofs->layer_names[], which can be used for the temp array for
> kern_unmount_array() because freeing name does not need
> RCU delay AFAICT (?).

AFAICS, it doesn't.  The only user after the setup is done is
->show_options(), i.e. show_vfsmnt() and show_mountinfo().
Anyone who tries to use those without making sure that
struct mount is not going to come apart under them will
have far worse troubles...

FWIW, I'm perfectly fine with having these fixes go through your tree;
they are independent from the rest of the series.
