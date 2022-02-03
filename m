Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0554A83CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 13:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiBCM0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 07:26:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49486 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBCM0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:26:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1AA4D1F440;
        Thu,  3 Feb 2022 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643891160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=juIxieDbjH1PYuli4PdRWdOgnr2+ISrjEig2JKm3Nhw=;
        b=XRutn9JxZG1/CR+daZ9dX6VBrpfujr27BvSJHISIc7aQIUoY/1OVCAkrjIIMfKuO5nzrNl
        v6MKFX670X7rQ9eH7i+f7O3L6/xqZvzztaDSGeyMKpJse/4gQCQBTjxMzIrPMqTzQOXpsr
        JJ8Om10d4JOgfmJXTOJqvWv6ya6qiWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643891160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=juIxieDbjH1PYuli4PdRWdOgnr2+ISrjEig2JKm3Nhw=;
        b=69IWpUmIPWALn+S9hK/GM+swpuSPnZJOkt9BkL3zKdSeoFgO41EWh6rJei/aajbtPLMkZH
        0zagUBsl5Ly2u2CA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 90C1DA3B84;
        Thu,  3 Feb 2022 12:25:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCEA8A05B6; Thu,  3 Feb 2022 13:25:55 +0100 (CET)
Date:   Thu, 3 Feb 2022 13:25:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <20220203122555.cqnvnbur43zrfqfa@quack3.lan>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <YfiXkk9HJpatFxnd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfiXkk9HJpatFxnd@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 01-02-22 02:14:42, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> > Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
> > We already have a few filesystems with their own generic netlink
> > families, so not sure if this is a good argument against this.
> > 
> > mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family fs
> > fs/cifs/netlink.c:      ret = genl_register_family(&cifs_genl_family);
> > fs/dlm/netlink.c:       return genl_register_family(&family);
> > fs/ksmbd/transport_ipc.c:       ret = genl_register_family(&ksmbd_genl_family);
> > fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family) != 0)
> 
> I'm not sure these are good arguments in favour ... other than quota,
> these are all network filesystems, which aren't much use without
> CONFIG_NET.
> 
> > mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family drivers/block
> > drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {
> 
> The, er, _network_ block device, right?

Yep, and even for the quota what you'll lose with the netlink family are
the fancy out-of-band notifications about users going over their quotas.
Not a big loss. So I don't by this argument.

OTOH these days when even a lightbulb is connected to a network, I don't
personally think CONFIG_NET dependency is a real problem...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
