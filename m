Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7668A1E438A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbgE0NZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 09:25:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387479AbgE0NZ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 09:25:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2477AC77;
        Wed, 27 May 2020 13:25:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1A244DA72D; Wed, 27 May 2020 15:24:29 +0200 (CEST)
Date:   Wed, 27 May 2020 15:24:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 2/3] btrfs: add authentication support
Message-ID: <20200527132428.GE18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-3-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514092415.5389-3-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 11:24:14AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Example usage:
> Create a file-system with authentication key 0123456
> mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk
> 
> Add the key to the kernel's keyring as keyid 'btrfs:foo'
> keyctl add logon btrfs:foo 0123456 @u
> 
> Mount the fs using the 'btrfs:foo' key
> mount -o auth_key=btrfs:foo,auth_hash_name="hmac(sha256)" /dev/disk /mnt/point

I tried to follow the example but the filesystem does not mount. But
what almost shocked me was the way the key is specified on the userspace
side.

$ mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk

"0123456" are the raw bytes of the key? Seriously?

And how it's passed to the hmac code:

 gcry_mac_hd_t mac;
 gcry_mac_open(&mac, GCRY_MAC_HMAC_SHA256, 0, NULL);
 gcry_mac_setkey(mac, fs_info->auth_key, strlen(fs_info->auth_key));
 gcry_mac_write(mac, buf, length);
 gcry_mac_read(mac, out, &length);

Strlen means the key must avoid char 0 and I don't think we want do any
decoding from ascii-hex format, when there's the whole keyctl
infrastructure.

The key for all userspace commands needs to be specified the same way as
for kernel, ie. "--auth-key btrfs:foo" and use the appropriate ioctls to
read the key bytes.
