Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1EBCAC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409774AbfIXPBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 11:01:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45631 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbfIXPBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:01:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so2046455qkb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOa/V+VntQaxe6cyhiD9mxNSODNZG0ZUXo9TwH3+2Fg=;
        b=B2mD1wnwbao8ORe3QLXAZhyWVogsJryfQS182d+JA+tox4LubIZ8Qn39tT+620T97E
         gx17H9QKkmTA5FP3mScCfjlNm+Cn44dUbmH+DJe7J45ubNMzVHQxlxwDUwmBeME/MSJd
         QvsSUP28Esvumu0AqFvpso9ychH0BM4CGj2ZHfx11QxTGksBXSm4Ru9V1BoN+wyFaSKM
         ged6EwjhZnTH4dr1v7pTxPkUxtuudMsyaITrZfU5WySMq/vcAIvVu7ks//IuvJZOQ+f0
         ObyxeIk+Zq0Er9pGwW04Q1zw9e5uW2iHa5gOpw4a1R9oLh1WsBIL6UX9F7q2+TpYm4q2
         38XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOa/V+VntQaxe6cyhiD9mxNSODNZG0ZUXo9TwH3+2Fg=;
        b=cUxKazccTNpiHEP8fH8YVyvyU9X320dKxidN12yovKBAwTfgHV3v8txqa9BoR09F59
         HRXaYSFWMEpDybhfdzJtqCMu8k23kj3xkj2EvKXnN4o4kutbEthygq7nyiOeYWAflB03
         jUr3n4BkHV8anidG8aiCh30x58WsX1j8vNfoBfZDJN9M+VQLj5THcAnQg1xf0xvIE2iC
         7EjlN9usP0sEzeUSRoBNo1Ia6FzVJyRCkcNEIkokxFXRc4Htn9EnfeLSNtmv6Ox2cwut
         nwAQNmS5Kdy735DIFnHzFQYjEKPzQ/vunelxLsS6947ceobx3q/PKIIgiNkxOP9mYbCo
         F4Jg==
X-Gm-Message-State: APjAAAVBJfRZnNc+SWxVSGwoItk620gAv4MXHxMaIkv2/GoyP1mbiYYq
        shUA2oGq8J3zBGTyYsaQV0P/4Q==
X-Google-Smtp-Source: APXvYqyHeKUl7f12o9qYxa/ZDC1DpFuyhKwYgAvs9sdcn4F04bu5aNvO7sGNU8cOA2gAqaY36wTRVQ==
X-Received: by 2002:a37:714:: with SMTP id 20mr2905542qkh.32.1569337307456;
        Tue, 24 Sep 2019 08:01:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id z5sm1096672qtb.49.2019.09.24.08.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:01:46 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:01:45 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, linux-btrfs@vger.kernel.org,
        "Yan, Zheng" <zyan@redhat.com>, linux-cifs@vger.kernel.org,
        Steve French <sfrench@us.ibm.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190924150144.6yqukmzwc3xlnfql@macbook-pro-91.dhcp.thefacebook.com>
References: <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <20190924025215.GA9941@ZenIV.linux.org.uk>
 <20190924133025.jeh7ond2svm3lsub@macbook-pro-91.dhcp.thefacebook.com>
 <20190924145104.GE26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924145104.GE26530@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 03:51:04PM +0100, Al Viro wrote:
> On Tue, Sep 24, 2019 at 09:30:26AM -0400, Josef Bacik wrote:
> 
> > > We pass next->d_name.name to dir_emit() (i.e. potentially to
> > > copy_to_user()).  And we have no warranty that it's not a long
> > > (== separately allocated) name, that will be freed while
> > > copy_to_user() is in progress.  Sure, it'll get an RCU delay
> > > before freeing, but that doesn't help us at all.
> > > 
> > > I'm not familiar with those areas in btrfs or cifs; could somebody
> > > explain what's going on there and can we indeed end up finding aliases
> > > to those suckers?
> > 
> > We can't for the btrfs case.  This is used for the case where we have a link to
> > a subvolume but the root has disappeared already, so we add in that dummy inode.
> > We completely drop the dcache from that root downards when we drop the
> > subvolume, so we're not going to find aliases underneath those things.  Is that
> > what you're asking?  Thanks,
> 
> Umm...  Completely drop, you say?  What happens if something had been opened
> in there at that time?
> 
> Could you give a bit more background?  How much of that subvolume remains
> and what does btrfs_lookup() have to work with?

Sorry I mis-read the code a little bit.  This is purely for the subvolume link
directories.  We haven't wandered down into this directory yet.  If the
subvolume is being deleted and we still have the fake directory entry for it
then we just populate it with this dummy inode and then we can't lookup anything
underneath it.  Thanks,

Josef
