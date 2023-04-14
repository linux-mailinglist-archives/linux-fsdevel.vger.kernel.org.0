Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B16E283E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDNQXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDNQXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:23:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B321B26A6;
        Fri, 14 Apr 2023 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=xMEqxWo6EgkWjQXus8eHlvUHmd8S/FwPwJQ561Mq5gQ=; b=uBlB4aseSEvZOnFB+R8Xy40WxX
        Otc41YE02ioPoiJvFZ6fXyK9IRYyDPl6DU5UA3jrYSCSt66vkCkPPte0wtny6Hw80b884Q2AHxNWi
        QSQr+vJXZLy2zMN2qTRnXo3EDYXUV9aLI7cop/ISOB3LmaOZPCXtL3lHg8Loqrpl+DCB3rEBeZQc+
        dvY3CTzWTAsQUcPoZnaKYXixaS6vnLoUrOfVBn6WvwEhk1GMML4rSn1yvIBpGqNQ4wzEYJRTpRE2d
        8ehcigZn5aD/cginq7hhI6C46HxXyQxJiSa2TNQ6HCqkH6/MUsw14rud0NDh5xNxEb6Mvm+Il0VNa
        tnk1aCsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnMCL-0091sL-1R;
        Fri, 14 Apr 2023 16:22:53 +0000
Date:   Fri, 14 Apr 2023 17:22:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeffrey Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414162253.GL3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
 <20230414-leiht-lektion-18f5a7a38306@brauner>
 <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
 <4F4F5C98-AA06-40FB-AE51-79E860CD1D76@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F4F5C98-AA06-40FB-AE51-79E860CD1D76@hammerspace.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:57:34PM +0000, Trond Myklebust wrote:

> > 
> > Being able to convert into an O_PATH descriptor gives you more options than just unmounting. It should allow you to syncfs() before unmounting. It should allow you to call open_tree() so you can manipulate the filesystem that is no longer accessible by path walk (e.g. so you can bind it elsewhere or move it).
> > 
> 
> One more thing it might allow us to do, which I’ve been wanting for a while in NFS: allow us to flip the mount type from being “hard” to “soft” before doing the lazy unmount, so that any application that might still retry I/O after the call to umount_begin() completes will start timing out with an I/O error, and free up the resources it might otherwise hold forever.
> 

s/lazy/forced/, surely?  Confused...

Note, BTW, that hard vs. soft is a property of fs instance; if you have
it present elsewhere in the mount tree, flipping it would affect all
such places.  I don't see any good way to make it a per-mount thing, TBH...
