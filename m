Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7C4B15AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 19:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiBJS7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 13:59:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiBJS7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:59:42 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE5410B7;
        Thu, 10 Feb 2022 10:59:42 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id DE36425C3; Thu, 10 Feb 2022 13:59:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DE36425C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644519581;
        bh=D84/F/FZLYWXYOIKdHvW6nRHJShfXgWMDM82VPYqTP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSRfH2Eg9gfZsNS7M4R0LVi909llUEGSkljO0pyMg378NPwcAfuY1k903zV+7dv4f
         FqG02VjR/2BFanvXO1qN6fDaqLB3A7JSV0I0r6H7mZ32NyEKtUne+rS5VMfBIkmVOO
         sViah9THwl8vD0oVflWn2jT9VHko/3YpX9PHc/x0=
Date:   Thu, 10 Feb 2022 13:59:41 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220210185941.GA24538@fieldses.org>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-4-git-send-email-dai.ngo@oracle.com>
 <20220210151759.GE21434@fieldses.org>
 <20220210163215.GH21434@fieldses.org>
 <2223051F-B8F5-4E59-8A27-735F6A426785@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2223051F-B8F5-4E59-8A27-735F6A426785@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 10, 2022 at 04:52:15PM +0000, Chuck Lever III wrote:
> 
> > On Feb 10, 2022, at 11:32 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > I was standing in the shower thinking....
> > 
> > We're now removing the persistent client record early, after the first
> > lease period expires, instead of waiting till the first lock conflict.
> > 
> > That simplifies conflict handling.
> > 
> > It also means that all clients lose their locks any time a crash or
> > reboot is preceded by a network partition of longer than a lease period.
> > 
> > Which is what happens currently, so it's no regression.
> > 
> > Still, I think it will be a common case that it would be nice to handle:
> > there's a network problem, and as a later consequence of the problem or
> > perhaps a part of addressing it, the server gets rebooted.  There's no
> > real reason to prevent clients recovering in that case.
> > 
> > Seems likely enough that it would be worth a little extra complexity in
> > the code that handles conflicts.
> > 
> > So I'm no longer convinced that it's a good tradeoff to remove the
> > persistent client record early.
> 
> Would it be OK if we make this change after the current work is merged?

Your choice!  I don't have a strong opinion.

--b.
