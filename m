Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2F1C652F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 02:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgEFAow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 20:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgEFAow (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 20:44:52 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2808206A5;
        Wed,  6 May 2020 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588725891;
        bh=XrIP/iQtrVNDC7+2iSYII2TtGU6ooaAuOS+idwUV/Jo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CguLqAYKPH/E+Okp8Sxx4mCzonafOEdr0qNaSWlY4aph/+8KMx9GBq95Oyq7RC1iP
         UeJ3FLwr77yGMhyZDa77zbru5PKflRqzykPVJwKZtgu4eJM1mWvatDjbLhmL5I/tvy
         5yy26NJhpvohbvRvYnt8KSdD6Ml6+kCNNAdvqer8=
Date:   Tue, 5 May 2020 17:44:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200506004450.GF128280@sol.localdomain>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <20200505221448.GW18421@twin.jikos.cz>
 <20200505223120.GC128280@sol.localdomain>
 <20200505224611.GA18421@twin.jikos.cz>
 <20200505233110.GE128280@sol.localdomain>
 <20200506002947.GF18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506002947.GF18421@twin.jikos.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 06, 2020 at 02:29:48AM +0200, David Sterba wrote:
> Back to the example. The problem with deprecation hasn't been brought up
> so far but I probably lack imagination _how_ can an attacker choose the
> algorithm in the context of the filesystem.

They just set the field on-disk that specifies the authentication algorithm.

> If some algorithm is found to be broken and unsuitable for
> authentication it will be a big thing. Users will be sure told to stop
> using it but the existing deployments can't be saved. The support from
> mkfs can be removed, kernel will warn or refuse to mount the
> filesystems, etc. but what else can be done from the design point of
> view?

Require that the authentication algorithm be passed as a mount option, and
validate that it matches what's on-disk.

- Eric
