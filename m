Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06C81C6443
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgEEXB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:01:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgEEXB2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:01:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00B3BAC52;
        Tue,  5 May 2020 23:01:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07E43DA7AD; Wed,  6 May 2020 01:00:37 +0200 (CEST)
Date:   Wed, 6 May 2020 01:00:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Richard Weinberger <richard@nod.at>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505230037.GB18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>, Sascha Hauer <s.hauer@pengutronix.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 11:59:16PM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Johannes Thumshirn" <jth@kernel.org>
> > An: "David Sterba" <dsterba@suse.cz>
> > CC: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-btrfs" <linux-btrfs@vger.kernel.org>, "Eric Biggers"
> > <ebiggers@google.com>, "richard" <richard@nod.at>, "Johannes Thumshirn" <johannes.thumshirn@wdc.com>, "Johannes
> > Thumshirn" <jthumshirn@suse.de>
> > Gesendet: Dienstag, 28. April 2020 12:58:58
> > Betreff: [PATCH v2 1/2] btrfs: add authentication support
> 
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Add authentication support for a BTRFS file-system.
> > 
> > This works, because in BTRFS every meta-data block as well as every
> > data-block has a own checksum. For meta-data the checksum is in the
> > meta-data node itself. For data blocks, the checksums are stored in the
> > checksum tree.
> 
> Eric already raised doubts, let me ask more directly.
> Does the checksum tree really cover all moving parts of BTRFS?
> 
> I'm a little surprised how small your patch is.
> Getting all this done for UBIFS was not easy and given that UBIFS is truly
> copy-on-write it was still less work than it would be for other filesystems.

The patch is small because the amount if cross-referencing between the
structures and "noise" in the structures is assumed to be sufficient so
just the calculation of the new checksum needs to be added.

Using 'assumed' must naturally raise eyebrows, what we all want is a
proof that it is so, and I believe this is the core of the work here but
it's missing so we unfortunatelly have to take the rounds in this thread
and actually dig out the details. The hmac support won't be merged
without making things clear and documented.
