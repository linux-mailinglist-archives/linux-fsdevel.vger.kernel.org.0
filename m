Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CD6803C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 03:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjA3CQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 21:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjA3CQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:16:00 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9382B12593;
        Sun, 29 Jan 2023 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=VUKkxOPVexeiOjL1SwDi/VTAaFCwLQcis/ITIft8mAs=; b=WQ5VRDYbPPNR7mazbzXFURKCqb
        /oiZgBvOVBXp93JfiQTmVQeKhU2wPMr4KdRjWA94RzfnrZDQEommDZK84jRLJtHGiDJ5epM/fHWpy
        Z+C9XXXo2NHvSQ2khZwuJd0xfN/I+sQkFlAQOujROHspzZTHpWfEfT1+OpMCAQOgqAdn5yok7r15q
        7JE1OV+bKIj+ie6wkgsLT9OU7g4rbO8T7sZ5F9UHyUPN4jm8nrnqHNTHNInAgyfRMz0DEV+YMbguo
        GkXjDnDGkmp9PQdJx95HXXMTG/S7TpGgmy9caco9WLOC48eRP0544FopgHtAqlwpDb6MTMSmMtaVR
        T4d7D5Ug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pMJi4-004w5f-24;
        Mon, 30 Jan 2023 02:15:52 +0000
Date:   Mon, 30 Jan 2023 02:15:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Richard Weinberger <richard@nod.at>
Cc:     chuck lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, anna <anna@kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        raven <raven@themaw.net>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>, benmaynard <benmaynard@google.com>
Subject: Re: [PATCH 2/3] namei: Allow follow_down() to uncover auto mounts
Message-ID: <Y9coWGadefHY6ZEJ@ZenIV>
References: <20221207084309.8499-1-richard@nod.at>
 <20221207084309.8499-3-richard@nod.at>
 <EAE9AF79-93B8-4366-8672-20D407694E7E@oracle.com>
 <68008696.79813.1675006959005.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68008696.79813.1675006959005.JavaMail.zimbra@nod.at>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_ABUSE_SURBL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 29, 2023 at 04:42:39PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "chuck lever" <chuck.lever@oracle.com>
> >> On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
> >> 
> >> This function is only used by NFSD to cross mount points.
> >> If a mount point is of type auto mount, follow_down() will
> >> not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
> >> to have ->d_automount() called when NFSD walks down the
> >> mount tree.
> >> 
> >> Signed-off-by: Richard Weinberger <richard@nod.at>
> > 
> > Hello Al, you are top of the maintainers listed for fs/namei.c.
> > I'd like to take this series for v6.3 via the nfsd tree. Can
> > I get your Acked-by: for this one?
> 
> ping?

modulo clumsy wording ("mount point is of type auto mount")

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

Commit message sounds as if it refered to autofs, rather than NFS referrals
et.al. and AFAICS those are the cases it's really about...
