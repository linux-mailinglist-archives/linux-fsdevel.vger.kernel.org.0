Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C7737243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFTRF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFTRF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:05:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFB10D0;
        Tue, 20 Jun 2023 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7t0yCtklu7dcKbRDLlcm/F8iSnhf9vNHGW7kJ98+ijg=; b=JCLIgzHF25CkwrefXaVLUdy0uy
        iuWI9Lxna/dv3i02JTOmbhRFm2Ou8dZGbJStETfXOyITasuUNJ/SNXkOr4iA4fJ53Ah3elhKtodun
        j6Qe72jCN5UPnEPI/8xcfE9ewUlma+JtYW70K4uh97wc6TXEW1UCPOSmPcQ0S83Kyjr7CADu1/9fu
        JrJAUOIhcKxjzJkeVDDyyxcNjEikiUXJG3FK2LlvDtJir+r+41+Y01h6k5UB0YF8riRcMdW2GJC2z
        QjR3s2BUDmGSEsk5889V1JnlvOCLz/noACPY6fhQNL8Z8qiLlIjl9uzIoN0qxe7tP+028bc/443Vf
        lHJXj8Rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBen9-00DKRn-QG; Tue, 20 Jun 2023 17:05:19 +0000
Date:   Tue, 20 Jun 2023 18:05:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     stsp <stsp2@yandex.ru>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Message-ID: <ZJHcT9DPGWVlTsHg@casper.infradead.org>
References: <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <ZJGtmrej8LraEsjj@casper.infradead.org>
 <cb88d464-30d8-810e-f3c4-35432d12a32d@yandex.ru>
 <ZJG5ZOK8HKl/eWmM@casper.infradead.org>
 <08612562-d2d7-a931-0c40-c401fff772c7@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08612562-d2d7-a931-0c40-c401fff772c7@yandex.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:45:21PM +0500, stsp wrote:
> 
> 20.06.2023 19:36, Matthew Wilcox пишет:
> > On Tue, Jun 20, 2023 at 06:47:31PM +0500, stsp wrote:
> > > 20.06.2023 18:46, Matthew Wilcox пишет:
> > > > On Tue, Jun 20, 2023 at 06:39:07PM +0500, stsp wrote:
> > > > > Though it will, for sure, represent the
> > > > > task that _owns_ the lock.
> > > > No, it *DOESN'T*.  I can open a file, SCM_RIGHTS pass it to another task
> > > > and then exit.  Now the only owner of that lock is the recipient ...
> > > Won't I get the recipient's pid in an
> > > l_pid then?
> > You snipped the part where I pointed out that at times there can be
> > _no_ task that owns it.  open a fd, set the lock, pass the fd to another
> > task, exit.  until that task calls recvmsg(), no task owns it.
> Hmm, interesting case.
> So at least it seems if recipient also exits,
> then the untransferred fd gets closed.

yes, pretty sure this is done by garbage collection in the unix socket
handling code, though i've never looked at it.  it's done that way
because annoying people can do things like open two sockets and send the
fd of each to the other, then exit.

> Does this mean, by any chance, that the
> recipient actually owns an fd before
> recvmsg() is done?

no, it's not in their fd table.  they don't own it.
