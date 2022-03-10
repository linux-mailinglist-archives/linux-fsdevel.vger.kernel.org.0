Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BE4D4D25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiCJPJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 10:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbiCJPIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:08:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B78C187E1F;
        Thu, 10 Mar 2022 07:00:58 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7AFBF48FA; Thu, 10 Mar 2022 10:00:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7AFBF48FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646924457;
        bh=NDsbehnK8v6tAXHtzS2gCvglh3+zkeG9XcB9yTyaGbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yyaV1QuC7TA4juQiS0cWbRSmPRNUl5RoB6wEaBOdPYd3DAqaXG+niJh+B8BiWppEZ
         EYG3xehwRoZO8LEz/TUQZTrrtheH2lCA4e8GqGsDWxyQBWlV0P5qEg4S91AkJk9o6g
         sKijx32gRmbgcu0JRkUMZID2X636g6YtoDHFqzPo=
Date:   Thu, 10 Mar 2022 10:00:57 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Message-ID: <20220310150057.GA6862@fieldses.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
 <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
 <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
 <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
 <892A7E1F-2920-47DB-9E15-21CE73093893@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <892A7E1F-2920-47DB-9E15-21CE73093893@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 03:27:58AM +0000, Chuck Lever III wrote:
> 
> > On Mar 9, 2022, at 10:09 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > ﻿
> >> On 3/9/22 12:51 PM, dai.ngo@oracle.com wrote:
> >> 
> >>> On 3/9/22 12:14 PM, Chuck Lever III wrote:
> >>> 
> >>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>> 
> >>>> Update client_info_show to show state of courtesy client and time
> >>>> since last renew.
> >>>> 
> >>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com> ---
> >>>> fs/nfsd/nfs4state.c | 9 ++++++++- 1 file changed, 8
> >>>> insertions(+), 1 deletion(-)
> >>>> 
> >>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c index
> >>>> bced09014e6b..ed14e0b54537 100644 --- a/fs/nfsd/nfs4state.c +++
> >>>> b/fs/nfsd/nfs4state.c @@ -2439,7 +2439,8 @@ static int
> >>>> client_info_show(struct seq_file *m, void *v) { struct inode
> >>>> *inode = m->private; struct nfs4_client *clp; -    u64 clid; +
> >>>> u64 clid, hrs; +    u32 mins, secs;
> >>>> 
> >>>>     clp = get_nfsdfs_clp(inode); if (!clp) @@ -2451,6 +2452,12 @@
> >>>>     static int client_info_show(struct seq_file *m, void *v)
> >>>>     seq_puts(m, "status: confirmed\n"); else seq_puts(m, "status:
> >>>>     unconfirmed\n"); +    seq_printf(m, "courtesy client: %s\n",
> >>>>     +        test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ?
> >>>>     "yes" : "no");
> >>> I'm wondering if it would be more economical to combine this
> >>> output with the status output just before it so we have only one
> >>> of:
> >>> 
> >>>     seq_puts(m, "status: unconfirmed\n");
> >>> 
> >>>     seq_puts(m, "status: confirmed\n");
> >>> 
> >>> or
> >>> 
> >>>     seq_puts(m, "status: courtesy\n");
> >> 
> >> make sense, will fix.
> > 
> > On second thought, I think it's safer to keep this the same since
> > there might be scripts out there that depend on it.
> 
> I agree we should be sensitive to potential users of this information.
> However…
> 
> Without having one or two examples of such scripts in front of us,
> it’s hard to say whether my suggestion (a new keyword after “status:”)
> or your original (a new line in the file) would be more disruptive.
> 
> Also I’m not seeing exactly how the output format is versioned… so
> what’s the safest way to make changes to the output format of this
> file? Anyone?

It's not versioned.  It'd be good to document some rules; nfsd(7) seems
like the logical place to put that, though probably knows about it.
Pointers to it from kernel comments and elsewhere might help?

I suppose the absolute safest option would be adding a new line, but I
like the idea of adding the possibility of "courtesy" to the existing
line as you suggest, and that seems very low risk.

There is one utility, see nfs-utils/tools/nfsdclnt.  I'd forgotten about
it untill I looked just now....

--b.
