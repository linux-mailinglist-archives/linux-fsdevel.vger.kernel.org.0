Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9F1EA5FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAOfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 10:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFAOfP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:35:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 165A5AD5D;
        Mon,  1 Jun 2020 14:35:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED0DADA79B; Mon,  1 Jun 2020 16:35:10 +0200 (CEST)
Date:   Mon, 1 Jun 2020 16:35:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 2/3] btrfs: add authentication support
Message-ID: <20200601143510.GU18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-3-jth@kernel.org>
 <20200527132428.GE18421@twin.jikos.cz>
 <SN4PR0401MB3598E973D98DB9A0363BD3C29BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598E973D98DB9A0363BD3C29BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 06:04:57PM +0000, Johannes Thumshirn wrote:
> On 27/05/2020 15:25, David Sterba wrote:
> > The key for all userspace commands needs to be specified the same way as
> > for kernel, ie. "--auth-key btrfs:foo" and use the appropriate ioctls to
> > read the key bytes.
> 
> Up to now I haven't been able to add a key to the kernel's keyring which 
> can be read back to user-space.

I was researching a possibility to use libkcapi, the API to use kernel
crypto implementaion, in order to avoid passing the raw key to userspace
completely. Basically, setting up what hash and key to use, pass the
buffer and get back the hash. API-wise it's just one more line to
specify the key -- by the numerical id. But no such interface is there,
only the raw bytes translating the request to the .setkey callback.
