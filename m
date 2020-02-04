Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EA151DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBDQHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 11:07:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgBDQHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:07:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4A04AC65;
        Tue,  4 Feb 2020 16:07:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A66E31E0BAA; Tue,  4 Feb 2020 17:07:03 +0100 (CET)
Date:   Tue, 4 Feb 2020 17:07:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Mainz, Roland" <R.Mainz@eckelmann.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jan Kara <jack@suse.com>
Subject: Re: Implementing quota support on Linux without block device as
 backing store ? / was: RE: [PATCH 1/8] quota: Allow to pass mount path to
 quotactl
Message-ID: <20200204160703.GG2388@quack2.suse.cz>
References: <db98497119d542b88e0cfc76d9b0921b@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db98497119d542b88e0cfc76d9b0921b@eckelmann.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-02-20 15:07:31, Mainz, Roland wrote:
> Sascha Hauer wrote:
> > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > When given, the path given in the special argument to quotactl will be the
> > mount path where the filesystem is mounted, instead of a path to the block
> > device.
> > This is necessary for filesystems which do not have a block device as backing
> > store. Particularly this is done for upcoming UBIFS support.
> 
> Just curious: Did you check how NFSv4 (also a filesystem without block
> device as backing store...)  implemented quota support ? Maybe there is
> already a solution...

Well, NFS does not really implement quota support. It relies on the server
(i.e., a local filesystem on the server) for quota tracking and enforcement
and the NFS client just gets the EDQUOT error the server got from the
filesystem. And for quota querrying (e.g. quota(1) command) there is a
special sideband rpc protocol handled by the quota tools. With NFSv4 there
is some support in the protocol itself for quota reporting but in Linux
this is not really supported because it does not map well to how Linux does
quotas.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
