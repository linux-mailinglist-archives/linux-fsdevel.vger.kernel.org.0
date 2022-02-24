Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682CB4C3589
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 20:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiBXTQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 14:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiBXTQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:16:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E12335D6;
        Thu, 24 Feb 2022 11:16:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A42CC1F37C;
        Thu, 24 Feb 2022 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645730169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/qYj42IWPg1EIJcZSoOTTjxfm/LidHsmqfB0h6TcE4=;
        b=veoksgys4tsVIdq5kbFBMT2KIipQgUJSXlidILNyb7OHVWBmX3KfSiszjXrdcQBejeskio
        PbPMYu1gFxhsH+GVVsFIdFpDgyr3HzrTXutSYUmtJvEvlI/Pn7fl8zpPOvmJhsmsIVvitl
        jHlhaoJBgCCv5oxV5q9OuOHtOj/+6iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645730169;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/qYj42IWPg1EIJcZSoOTTjxfm/LidHsmqfB0h6TcE4=;
        b=xEzndh8aQy7PwTeALUaFFAzIhtFFMMUvAcuS3Qwii6YQZnn57b2Q36m0BnkiRQtAbJpNHW
        AbE0wtWQxpTpYWAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 56FD4A3B84;
        Thu, 24 Feb 2022 19:16:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61476DA818; Thu, 24 Feb 2022 20:12:20 +0100 (CET)
Date:   Thu, 24 Feb 2022 20:12:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Message-ID: <20220224191220.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
References: <cover.1645157220.git.naohiro.aota@wdc.com>
 <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
 <20220223103107.GM12643@twin.jikos.cz>
 <20220224021558.eubg4agqnkkodkd6@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224021558.eubg4agqnkkodkd6@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 02:15:58AM +0000, Naohiro Aota wrote:
> On Wed, Feb 23, 2022 at 11:31:07AM +0100, David Sterba wrote:
> > On Fri, Feb 18, 2022 at 01:14:19PM +0900, Naohiro Aota wrote:
> > [ 2927.114871] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 131072 csum 0x7e797e3e expected csum 0x8941f998 mirror 2
> > [ 2927.115469]  btrfs_balance+0x4ed/0x7e0 [btrfs]
> > [ 2927.118802] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 139264 csum 0x27df6522 expected csum 0x8941f998 mirror 2
> > [ 2927.119691]  ? btrfs_balance+0x7e0/0x7e0 [btrfs]
> > [ 2927.123158] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 143360 csum 0x9f144c35 expected csum 0x8941f998 mirror 2
> > [ 2927.123965]  balance_kthread+0x37/0x50 [btrfs]
> 
> It looks like this occurs when the balance is resumed. We also need
> sb_{start,end}_write around btrfs_balance() in balance_kthred().

Sounds plausible.

> I guess we can cause a hang if we resume the balance and freeze the FS
> at the same time.

The background balance starts only when the filesystem is mounted for
write, so right after the sb_rdonly check in open_ctree, but I think
you're right that freeze during that can lead to a hang.
