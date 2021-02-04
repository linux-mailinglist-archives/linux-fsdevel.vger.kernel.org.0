Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA14930ED74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 08:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhBDHfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 02:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhBDHfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:35:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75294C061786;
        Wed,  3 Feb 2021 23:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j1kpXURjn61beaZACs444oPTRgteMVTAE7uewxPoWWI=; b=gUXXygg9mr5a+bqnfdf29rxDdo
        DgHENm0/vDLbyy2oc4B5RZ9VtsI70pG0vMXSE2iDxN7pcrK4+qk3FaXtnekN7CO65HtApHtnae/Ul
        BROrnz0O3DuA03UyGSx6ADw7eBxH0eOrCtoR1x725nHFkFabqo3VqqnQyq27uqHKdjAPuLyDtwCC9
        3g93/jHNfgolnzXxT1QusxsbR6YKYDRRzPS/p7Sw4IFwOOxJcWIf44zFPpTYC5i8dReyC7/uDAVbY
        60I1ISMHU1QxWwZ6IAqdCRU0WSI+h0vAOb6lCLFkVERZntsJAVlu8EfSZpCuTK06wCxNs3yx4sPaC
        U8JmGCXg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Z9a-000X7T-Bq; Thu, 04 Feb 2021 07:34:15 +0000
Date:   Thu, 4 Feb 2021 07:34:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210204073414.GA126863@infradead.org>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
 <20210128141713.25223-2-s.hauer@pengutronix.de>
 <20210128143552.GA2042235@infradead.org>
 <20210202180241.GE17147@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202180241.GE17147@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 07:02:41PM +0100, Jan Kara wrote:
> Hum, let me think out loud. The path we pass to Q_QUOTAON is a path to
> quota file - unless the filesystem stores quota in hidden files in which
> case this argument is just ignored. You're right we could require that
> specifically for Q_QUOTAON, the mountpoint path would actually need to
> point to the quota file if it is relevant, otherwise anywhere in the
> appropriate filesystem. We don't allow quota file to reside on a different
> filesystem (for a past decade or so) so it should work fine.
> 
> So the only problem I have is whether requiring the mountpoint argument to
> point quota file for Q_QUOTAON isn't going to be somewhat confusing to
> users. At the very least it would require some careful explanation in the
> manpage to explain the difference between quotactl_path() and quotactl()
> in this regard. But is saving the second path for Q_QUOTAON really worth the
> bother?

I find the doubled path argument a really horrible API, so I'd pretty
strongly prefer to avoid that.

> > Given how cheap quotactl_cmd_onoff and quotactl_cmd_write are we
> > could probably simplify this down do:
> > 
> > 	if (quotactl_cmd_write(cmd)) {
> 
> This needs to be (quotactl_cmd_write(cmd) || quotactl_cmd_onoff(cmd)).
> Otherwise I agree what you suggest is somewhat more readable given how
> small the function is.

The way I read quotactl_cmd_write, it only special cases a few commands
and returns 0 there, so we should not need the extra quotactl_cmd_onoff
call, as all those commands are not explicitly listed.
